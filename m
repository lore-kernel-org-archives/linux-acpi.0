From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 4/7] ACPI: thinkpad-acpi: prefer standard ACPI backlight level control
Date: Tue, 30 Oct 2007 17:46:22 -0200
Message-ID: <1193773585-17202-5-git-send-email-hmh@hmh.eng.br>
References: <1193773585-17202-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33904 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756768AbXJ3Tqf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2007 15:46:35 -0400
In-Reply-To: <1193773585-17202-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Newer Lenovo BIOSes support the standard ACPI backlight brightness
interface (_BCM, _BQC, _BCL).  It should be used instead of the native
thinkpad backlight brightness control interface when possible.

This patch disables the native brightness support in the driver by default
when we detect that the standard ACPI interface is available.  The local
admin can still enable it using the module parameter "brightness_enable".

Note that we need to detect the standard ACPI backlight interface only in
boxes for which we would load the native backlight interface in the first
place, and that no ThinkPad BIOS has _BCL but misses the other methods, so
the detection routines can be really simple.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 Documentation/thinkpad-acpi.txt |    8 ++++++--
 drivers/misc/thinkpad_acpi.c    |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index f877c13..bb1c7a6 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -942,11 +942,15 @@ and CMOS.  The driver tries to autodetect which interface to use.
 
 When display backlight brightness controls are available through the
 standard ACPI interface, it is best to use it instead of this direct
-ThinkPad-specific interface.
+ThinkPad-specific interface.  The driver will disable its native
+backlight brightness control interface if it detects that the standard
+ACPI interface is available in the ThinkPad.
 
 The brightness_enable module parameter can be used to control whether
 the LCD brightness control feature will be enabled when available.
-brightness_enable=0 forces it to be disabled.
+brightness_enable=0 forces it to be disabled.  brightness_enable=1
+forces it to be enabled when available, even if the standard ACPI
+interface is also available.
 
 Procfs notes:
 
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 56a21e6..109bd27 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -3174,6 +3174,39 @@ static int __init brightness_check_levels(void)
 	return (ACPI_SUCCESS(status) && found_node != NULL);
 }
 
+static acpi_status __init brightness_find_bcl(acpi_handle handle, u32 lvl,
+					void *context, void **rv)
+{
+	char name[ACPI_PATH_SEGMENT_LENGTH];
+	struct acpi_buffer buffer = { sizeof(name), &name };
+
+	if (ACPI_SUCCESS(acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer)) &&
+	    !strncmp("_BCL", name, sizeof(name) - 1)) {
+		*rv = handle;
+		return AE_CTRL_TERMINATE;
+	} else {
+		return AE_OK;
+	}
+}
+
+static int __init brightness_check_std_acpi_support(void)
+{
+	int status;
+	void *found_node = NULL;
+
+	if (!vid_handle) {
+		IBM_ACPIHANDLE_INIT(vid);
+	}
+	if (!vid_handle)
+		return 0;
+
+	/* Search for a _BCL method, but don't execute it */
+	status = acpi_walk_namespace(ACPI_TYPE_METHOD, vid_handle, 3,
+	                             brightness_find_bcl, NULL, &found_node);
+
+	return (ACPI_SUCCESS(status) && found_node != NULL);
+}
+
 static int __init brightness_init(struct ibm_init_struct *iibm)
 {
 	int b;
@@ -3186,6 +3219,12 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 		dbg_printk(TPACPI_DBG_INIT,
 		           "brightness support disabled by module parameter\n");
 		return 1;
+	} else if (brightness_enable > 1) {
+		if (brightness_check_std_acpi_support()) {
+			printk(IBM_NOTICE
+			       "standard ACPI backlight interface available, not loading native one...\n");
+			return 1;
+		}
 	}
 
 	if (!brightness_mode) {
-- 
1.5.3.4

