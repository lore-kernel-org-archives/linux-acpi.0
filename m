From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/3] ACPI: Add sysfs ABI documentation
Date: Thu, 20 Jun 2013 08:02:44 +0800
Message-ID: <9af01fbaf905481edd4d9dc64482d570ce570519.1371619148.git.lv.zheng@intel.com>
References: <1364824711-5193-1-git-send-email-rui.zhang@intel.com> <cover.1371619148.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19809 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934604Ab3FTADD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Jun 2013 20:03:03 -0400
In-Reply-To: <cover.1371619148.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, Lance Ortiz <lance.ortiz@hp.com>, Patrick Mochel <mochel@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Thomas Renninger <trenn@suse.de>, Zhang Rui <rui.zhang@intel.com>

Add initial ABI documentation for ACPI devices' sysfs interfaces.
Contacts information fields are filled with current ACPI maintainer and the
relevant authors are carbon copied.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Lance Ortiz <lance.ortiz@hp.com>
Cc: Lv Zheng <lv.zheng@intel.com>
Cc: Patrick Mochel <mochel@osdl.org>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Thomas Renninger <trenn@suse.de>
Cc: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-acpi    |   58 +++++++++++++++++++++++++++
 Documentation/ABI/testing/sysfs-devices-sun |    2 +-
 MAINTAINERS                                 |    1 +
 3 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-acpi

diff --git a/Documentation/ABI/testing/sysfs-bus-acpi b/Documentation/ABI/testing/sysfs-bus-acpi
new file mode 100644
index 0000000..c8942e9
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-acpi
@@ -0,0 +1,58 @@
+What:		/sys/bus/acpi/devices/.../path
+Date:		December 2006
+Contact:	Rafael J. Wysocki <rjw@sisk.pl>
+Description:
+		This attribute indicates the full path of ACPI namespace
+		object associated with the device object.  For example,
+		\_SB_.PCI0.
+		This file is not present for device objects representing
+		fixed ACPI hardware features (like power and sleep
+		buttons).
+
+What:		/sys/bus/acpi/devices/.../modalias
+Date:		July 2007
+Contact:	Rafael J. Wysocki <rjw@sisk.pl>
+Description:
+		This attribute indicates the PNP IDs of the device object.
+		That is acpi:HHHHHHHH:[CCCCCCC:].  Where each HHHHHHHH or
+		CCCCCCCC contains device object's PNPID (_HID or _CID).
+
+What:		/sys/bus/acpi/devices/.../hid
+Date:		April 2005
+Contact:	Rafael J. Wysocki <rjw@sisk.pl>
+Description:
+		This attribute indicates the hardware ID (_HID) of the
+		device object.  For example, PNP0103.
+		This file is present for device objects having the _HID
+		control method.
+
+What:		/sys/bus/acpi/devices/.../description
+Date:		October 2012
+Contact:	Rafael J. Wysocki <rjw@sisk.pl>
+Description:
+		This attribute contains the output of the device object's
+		_STR control method, if present.
+
+What:		/sys/bus/acpi/devices/.../adr
+Date:		October 2012
+Contact:	Rafael J. Wysocki <rjw@sisk.pl>
+Description:
+		This attribute contains the output of the device object's
+		_ADR control method, which is present for ACPI device
+		objects representing devices having standard enumeration
+		algorithms, such as PCI.
+
+What:		/sys/bus/acpi/devices/.../uid
+Date:		October 2012
+Contact:	Rafael J. Wysocki <rjw@sisk.pl>
+Description:
+		This attribute contains the output of the device object's
+		_UID control method, if present.
+
+What:		/sys/bus/acpi/devices/.../eject
+Date:		December 2006
+Contact:	Rafael J. Wysocki <rjw@sisk.pl>
+Description:
+		Writing 1 to this attribute will trigger hot removal of
+		this device object.  This file exists for every device
+		object that has _EJ0 method.
diff --git a/Documentation/ABI/testing/sysfs-devices-sun b/Documentation/ABI/testing/sysfs-devices-sun
index 86be984..625ce4b 100644
--- a/Documentation/ABI/testing/sysfs-devices-sun
+++ b/Documentation/ABI/testing/sysfs-devices-sun
@@ -1,4 +1,4 @@
-Whatt:		/sys/devices/.../sun
+What:		/sys/devices/.../sun
 Date:		October 2012
 Contact:	Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
 Description:
diff --git a/MAINTAINERS b/MAINTAINERS
index 2634a7b..04a5fef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -243,6 +243,7 @@ F:	drivers/pnp/pnpacpi/
 F:	include/linux/acpi.h
 F:	include/acpi/
 F:	Documentation/acpi
+F:	Documentation/ABI/testing/sysfs-bus-acpi
 
 ACPI FAN DRIVER
 M:	Zhang Rui <rui.zhang@intel.com>
-- 
1.7.10

