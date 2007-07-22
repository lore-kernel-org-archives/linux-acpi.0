From: Len Brown <len.brown@intel.com>
Subject: [PATCH 47/77] ACPI: thinkpad-acpi: checkpoint sysfs interface version due to hotkey
Date: Sun, 22 Jul 2007 05:14:32 -0400
Message-ID: <1185095751279-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
 <11850957181201-git-send-email-len.brown@intel.com>
 <11850957192175-git-send-email-len.brown@intel.com>
 <1185095721166-git-send-email-len.brown@intel.com>
 <1185095721760-git-send-email-len.brown@intel.com>
 <11850957232745-git-send-email-len.brown@intel.com>
 <11850957242656-git-send-email-len.brown@intel.com>
 <11850957252722-git-send-email-len.brown@intel.com>
 <11850957262869-git-send-email-len.brown@intel.com>
 <11850957272369-git-send-email-len.brown@intel.com>
 <11850957282082-git-send-email-len.brown@intel.com>
 <11850957292555-git-send-email-len.brown@intel.com>
 <11850957302782-git-send-email-len.brown@intel.com>
 <11850957311269-git-send-email-len.brown@intel.com>
 <11850957323059-git-send-email-len.brown@intel.com>
 <11850957332171-git-send-email-len.brown@intel.com>
 <11850957342584-git-send-email-len.brown@intel.com>
 <11850957362476-git-send-email-len.brown@intel.com>
 <11850957361736-git-send-email-len.brown@intel.com>
 <1185095737422-git-send-email-len.brown@intel.com>
 <11850957384004-git-send-email-len.brown@intel.com>
 <1185095739370-git-send-email-len.brown@intel.com>
 <11850957403722-git-send-email-len.brown@intel.com>
 <11850957413607-git-send-email-len.brown@intel.com>
 <11850957432095-git-send-email-len.brown@intel.com>
 <11850957443711-git-send-email-len.brown@intel.com>
 <11850957451942-git-send-email-len.brown@intel.com>
 <11850957462109-git-send-email-len.brown@intel.com>
 <11850957471828-git-send-email-len.brown@intel.com>
 <11850957482671-git-send-email-len.brown@intel.com>
 <11850957491254-git-send-email-len.brown@intel.com>
 <11850957503243-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53139 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763423AbXGVJPz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:55 -0400
In-Reply-To: <11850957503243-git-send-email-len.brown@intel.com>
Message-Id: <94b08713186cc47a5c367a866cc0a0a762721455.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

The change in the size of the hotkey mask, the hability to report the keys
that use the higher bits, and the addition of the hotkey_radio_sw attribute
are important enough features to warrant increasing the minor field of the
sysfs interface version.

Also, document a bit better how and when the thinkpad-acpi sysfs interface
version will be updated.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/thinkpad-acpi.txt |   17 +++++++++++++++++
 drivers/misc/thinkpad_acpi.c    |    2 +-
 2 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index fe26e50..7a06a27 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -134,6 +134,21 @@ end of this document.  Changes to the sysfs interface done by the kernel
 subsystems are not documented here, nor are they tracked by this
 attribute.
 
+Changes to the thinkpad-acpi sysfs interface are only considered
+non-experimental when they are submitted to Linux mainline, at which
+point the changes in this interface are documented and interface_version
+may be updated.  If you are using any thinkpad-acpi features not yet
+sent to mainline for merging, you do so on your own risk: these features
+may disappear, or be implemented in a different and incompatible way by
+the time they are merged in Linux mainline.
+
+Changes that are backwards-compatible by nature (e.g. the addition of
+attributes that do not change the way the other attributes work) do not
+always warrant an update of interface_version.  Therefore, one must
+expect that an attribute might not be there, and deal with it properly
+(an attribute not being there *is* a valid way to make it clear that a
+feature is not available in sysfs).
+
 Hot keys
 --------
 
@@ -989,3 +1004,5 @@ Sysfs interface changelog:
 
 0x000100:	Initial sysfs support, as a single platform driver and
 		device.
+0x000200:	Hot key support for 32 hot keys, and radio slider switch
+		support.
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 3cf37bb..4d71893 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -22,7 +22,7 @@
  */
 
 #define IBM_VERSION "0.14"
-#define TPACPI_SYSFS_VERSION 0x000100
+#define TPACPI_SYSFS_VERSION 0x000200
 
 /*
  *  Changelog:
-- 
1.5.3.rc2.22.g69a9b
