function getPackages() {
    window.open('/api/packages', '_blank').focus();
}

function getPackage() {
    var packageName = document.getElementById("packagename1").value;
    window.open('/api/packages/' + packageName, '_blank').focus();
}

function getPackageWithVersion() {
    var packageName = document.getElementById("packagename2").value;
    var versionNumber = document.getElementById("versionNumber").value;
    window.open('/api/packages/' + packageName + '/versions/' + versionNumber, '_blank').focus();
}

