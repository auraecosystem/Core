import nox


@nox.session
def tests(session: nox.Session) -> None:
    session.install("pytest")
    session.run("pytest")

@nox.session
def lint(session: nox.Session) -> None:
    session.install("flake8")
    session.run("flake8", "--import-order-style", "google")
