"""
os level dependencies for this project
"""

import platform

packages = [
]

desktop = platform.freedesktop_os_release()
VERSION_ID = desktop["VERSION_ID"]
if VERSION_ID == "24.04":
    packages.append("reserialize")
