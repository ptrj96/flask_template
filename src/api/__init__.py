import connexion

app = connexion.FlaskApp(__name__, specification_dir="../../openapi/")
app.add_api("spec.yml")

if __name__ == "__main__":
    app.run(port=8090)
