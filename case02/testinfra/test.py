def test_passwd_file(host):
    passwd = host.file("/etc/passwd")
    assert passwd.contains("root")
    assert passwd.user == "root"
    assert passwd.group == "root"
    assert passwd.mode == 0o644

def test_package_apache(host):
    httpd = host.package("httpd")
    assert httpd.is_installed
    assert httpd.version.startswith("2.2.15")

def test_service_apache(host):
    httpd = host.service("httpd")
    httpd.is_running
    httpd.is_enabled
