From: Seth Forshee <seth.forshee@canonical.com>
Subject: [PATCH 1/5] ACPICA: Add interface for getting latest Windows version requested via _OSI
Date: Thu,  7 Mar 2013 13:39:36 -0600
Message-ID: <1362685180-7768-1-git-send-email-seth.forshee@canonical.com>
References: <20130307193812.GD24233@thinkpad-t410>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:49277 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932336Ab3CGTjp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Mar 2013 14:39:45 -0500
In-Reply-To: <20130307193812.GD24233@thinkpad-t410>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Ben Jencks <ben@bjencks.net>, joeyli <jlee@suse.com>, Seth Forshee <seth.forshee@canonical.com>

The acpi_video driver needs to know the latest Windows version requested
by the BIOS to work around a buggy backlight implementation which is
specific to Windows 8. Add a new interface named
acpi_osi_windows_version() for retrieving this information.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 drivers/acpi/acpica/aclocal.h |   13 -------------
 drivers/acpi/acpica/utxface.c |   19 +++++++++++++++++++
 include/acpi/acpixf.h         |   18 ++++++++++++++++++
 3 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index ff8bd00..932c3d8 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -926,19 +926,6 @@ struct acpi_bit_register_info {
 
 /* Structs and definitions for _OSI support and I/O port validation */
 
-#define ACPI_OSI_WIN_2000               0x01
-#define ACPI_OSI_WIN_XP                 0x02
-#define ACPI_OSI_WIN_XP_SP1             0x03
-#define ACPI_OSI_WINSRV_2003            0x04
-#define ACPI_OSI_WIN_XP_SP2             0x05
-#define ACPI_OSI_WINSRV_2003_SP1        0x06
-#define ACPI_OSI_WIN_VISTA              0x07
-#define ACPI_OSI_WINSRV_2008            0x08
-#define ACPI_OSI_WIN_VISTA_SP1          0x09
-#define ACPI_OSI_WIN_VISTA_SP2          0x0A
-#define ACPI_OSI_WIN_7                  0x0B
-#define ACPI_OSI_WIN_8                  0x0C
-
 #define ACPI_ALWAYS_ILLEGAL             0x00
 
 struct acpi_interface_info {
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index 390db0c..1531984 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -384,6 +384,25 @@ ACPI_EXPORT_SYMBOL(acpi_install_interface_handler)
 
 /*****************************************************************************
  *
+ * FUNCTION:    acpi_osi_windows_version
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Latest Windows version Windows requested via _OSI
+ *
+ * DESCRIPTION: Returns the latest version of Windows that has been requested
+ *              by the BIOS via _OSI.
+ *
+ ****************************************************************************/
+u8 acpi_osi_windows_version(void)
+{
+	return acpi_gbl_osi_data;
+}
+
+ACPI_EXPORT_SYMBOL(acpi_osi_windows_version)
+
+/*****************************************************************************
+ *
  * FUNCTION:    acpi_check_address_range
  *
  * PARAMETERS:  space_id            - Address space ID
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 3d88395..29a9429 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -73,6 +73,22 @@ extern u8 acpi_gbl_truncate_io_addresses;
 extern u8 acpi_gbl_disable_auto_repair;
 
 /*
+ * Values returned by acpi_osi_windows_version()
+ */
+#define ACPI_OSI_WIN_2000               0x01
+#define ACPI_OSI_WIN_XP                 0x02
+#define ACPI_OSI_WIN_XP_SP1             0x03
+#define ACPI_OSI_WINSRV_2003            0x04
+#define ACPI_OSI_WIN_XP_SP2             0x05
+#define ACPI_OSI_WINSRV_2003_SP1        0x06
+#define ACPI_OSI_WIN_VISTA              0x07
+#define ACPI_OSI_WINSRV_2008            0x08
+#define ACPI_OSI_WIN_VISTA_SP1          0x09
+#define ACPI_OSI_WIN_VISTA_SP2          0x0A
+#define ACPI_OSI_WIN_7                  0x0B
+#define ACPI_OSI_WIN_8                  0x0C
+
+/*
  * Hardware-reduced prototypes. All interfaces that use these macros will
  * be configured out of the ACPICA build if the ACPI_REDUCED_HARDWARE flag
  * is set to TRUE.
@@ -301,6 +317,8 @@ acpi_status acpi_install_notify_handler(acpi_handle device, u32 handler_type,
 					acpi_notify_handler handler,
 					void *context);
 
+u8 acpi_osi_windows_version(void);
+
 acpi_status
 acpi_remove_notify_handler(acpi_handle device,
 			   u32 handler_type, acpi_notify_handler handler);
-- 
1.7.9.5

