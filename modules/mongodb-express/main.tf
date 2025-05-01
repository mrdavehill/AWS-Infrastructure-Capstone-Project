#######################################################
# namespaces
#######################################################
resource "kubectl_manifest" "mongo-namespace" {
    yaml_body = <<YAML
kind: Namespace
apiVersion: v1
metadata:
  name: mongo-namespace
YAML
}

#######################################################
# configmap
#######################################################
resource "kubectl_manifest" "mongodb-configmap" {
    depends_on = [ kubectl_manifest.mongo-namespace
    ] 
    yaml_body  = <<YAML
apiVersion: v1
kind: ConfigMap
metadata:
  name: mongodb-configmap
  namespace: mongo-namespace
data:
  database_url: mongodb-service
YAML
}

#######################################################
# deployments
#######################################################
resource "kubectl_manifest" "mongo-express-deployment" {
    depends_on = [ kubectl_manifest.mongo-namespace
    ] 
    yaml_body  = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mongo-express-deployment
  namespace: mongo-namespace
  labels:
    app: mongo-express
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mongo-express
  template:
    metadata:
      labels:
        app: mongo-express
    spec:
      containers:
      - name: mongo-express
        image: mongo-express
        ports:
        - containerPort: 80
        env:
        - name: ME_CONFIG_MONGODB_ADMINUSERNAME
          valueFrom:
            secretKeyRef:
              name: mongodb-secret
              key: mongodb-root-username
        - name: ME_CONFIG_MONGODB_ADMINPASSWORD
          valueFrom:
            secretKeyRef:
              name: mongodb-secret
              key: mongodb-root-password
        - name: ME_CONFIG_MONGODB_SERVER
          valueFrom:
            configMapKeyRef:
              name: mongodb-configmap
              key: database_url
YAML
}

resource "kubectl_manifest" "mongodb-deployment" {
    depends_on = [ kubectl_manifest.mongo-namespace
    ] 
    yaml_body  = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mongodb-deployment
  namespace: mongo-namespace
  labels:
    app: mongodb
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mongodb
  template:
    metadata:
      labels:
        app: mongodb
    spec:
      containers:
      - name: mongodb
        image: mongo
        ports:
        - containerPort: 27017
        env:
        - name: MONGO_INITDB_ROOT_USERNAME
          valueFrom:
            secretKeyRef:
              name: mongodb-secret
              key: mongodb-root-username
        - name: MONGO_INITDB_ROOT_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mongodb-secret
              key: mongodb-root-password
YAML
}

#######################################################
# services
#######################################################
resource "kubectl_manifest" "mongodb-express-service" {
    depends_on = [ kubectl_manifest.mongo-namespace
    ] 
    yaml_body  = <<YAML
apiVersion: v1
kind: Service
metadata:
  name: mongodb-express-service
  namespace: mongo-namespace
spec:
  selector:
    app: mongo-express
  type: LoadBalancer
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
      nodePort: 30000
YAML
}

resource "kubectl_manifest" "mongodb-service" {
    depends_on = [ kubectl_manifest.mongo-namespace
    ] 
    yaml_body  = <<YAML
apiVersion: v1
kind: Service
metadata:
  name: mongodb-service
  namespace: mongo-namespace
spec:
  selector:
    app: mongodb
  ports:
    - protocol: TCP
      port: 27017
      targetPort: 27017
YAML
}

#######################################################
# secret
#######################################################
resource "kubectl_manifest" "mongodb-secret" {
    depends_on = [ kubectl_manifest.mongo-namespace
    ] 
    yaml_body  = <<YAML
apiVersion: v1
kind: Secret
metadata:
  name: mongodb-secret
  namespace: mongo-namespace
type: Opaque
data:
  mongodb-root-username: dXNlcm5hbWU=
  mongodb-root-password: cGFzc3dvcmQ=
  YAML
}

#######################################################
# ingress
#######################################################
resource "kubectl_manifest" "mongodb-ingressclass" {
    depends_on = [ kubectl_manifest.mongo-namespace
    ] 
    yaml_body  = <<YAML
apiVersion: networking.k8s.io/v1
kind: IngressClass
metadata:
  labels:
    app.kubernetes.io/name: LoadBalancerController
  name: alb
spec:
  controller: eks.amazonaws.com/alb
  YAML
}

resource "kubectl_manifest" "mongodb-ingress" {
    depends_on = [ kubectl_manifest.mongo-namespace
    ] 
    yaml_body  = <<YAML
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  namespace: mongo-namespace
  name: mongo-ingress
  annotations:
    alb.ingress.kubernetes.io/scheme: internet-facing
    alb.ingress.kubernetes.io/target-type: ip
spec:
  ingressClassName: alb
  rules:
    - http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: mongodb-express-service
                port:
                  number: 80
  YAML
}