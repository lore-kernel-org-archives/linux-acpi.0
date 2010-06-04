From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/16] ACPICA: Truncate I/O addresses to 16 bits for Windows
 compatibility
Date: Fri, 04 Jun 2010 15:51:39 -0400
Message-ID: <fcab697b12744a4833938fa09cbad11e9e7ed2c5.1275680880.git.len.brown@intel.com>
References: <1275681106-8450-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:56203 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464Ab0FDTvv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jun 2010 15:51:51 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L3I009F39UEHSR5@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 04 Jun 2010 14:51:51 -0500 (CDT)
In-reply-to: <1275681106-8450-1-git-send-email-lenb@kernel.org>
In-reply-to: <8aa4b14eb023fecaa48d55402e98bdf84b375c4a.1275680880.git.len.brown@intel.com>
References: <8aa4b14eb023fecaa48d55402e98bdf84b375c4a.1275680880.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthew Garrett <mjg@redhat.com>, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Matthew Garrett <mjg@redhat.com>

This feature is optional and is enabled if the BIOS requests any
Windows OSI strings. It can also be enabled by the host OS.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    8 ++++++++
 drivers/acpi/acpica/hwvalid.c  |   12 ++++++++++++
 drivers/acpi/acpica/nsinit.c   |    9 +++++++++
 include/acpi/acpixf.h          |    1 +
 4 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 9070f1f..899d68a 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -125,6 +125,14 @@ u8 ACPI_INIT_GLOBAL(acpi_gbl_enable_aml_debug_object, FALSE);
  */
 u8 ACPI_INIT_GLOBAL(acpi_gbl_copy_dsdt_locally, FALSE);
 
+/*
+ * Optionally truncate I/O addresses to 16 bits. Provides compatibility
+ * with other ACPI implementations. NOTE: During ACPICA initialization,
+ * this value is set to TRUE if any Windows OSI strings have been
+ * requested by the BIOS.
+ */
+u8 ACPI_INIT_GLOBAL(acpi_gbl_truncate_io_addresses, FALSE);
+
 /* acpi_gbl_FADT is a local copy of the FADT, converted to a common format. */
 
 struct acpi_table_fadt acpi_gbl_FADT;
diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
index c10d587..e1d9c77 100644
--- a/drivers/acpi/acpica/hwvalid.c
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -222,6 +222,12 @@ acpi_status acpi_hw_read_port(acpi_io_address address, u32 *value, u32 width)
 	u32 one_byte;
 	u32 i;
 
+	/* Truncate address to 16 bits if requested */
+
+	if (acpi_gbl_truncate_io_addresses) {
+		address &= ACPI_UINT16_MAX;
+	}
+
 	/* Validate the entire request and perform the I/O */
 
 	status = acpi_hw_validate_io_request(address, width);
@@ -279,6 +285,12 @@ acpi_status acpi_hw_write_port(acpi_io_address address, u32 value, u32 width)
 	acpi_status status;
 	u32 i;
 
+	/* Truncate address to 16 bits if requested */
+
+	if (acpi_gbl_truncate_io_addresses) {
+		address &= ACPI_UINT16_MAX;
+	}
+
 	/* Validate the entire request and perform the I/O */
 
 	status = acpi_hw_validate_io_request(address, width);
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index 8009e71..f0e49df 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -193,6 +193,15 @@ acpi_status acpi_ns_initialize_devices(void)
 					acpi_ns_init_one_device, NULL, &info,
 					NULL);
 
+	/*
+	 * Any _OSI requests should be completed by now. If the BIOS has
+	 * requested any Windows OSI strings, we will always truncate
+	 * I/O addresses to 16 bits -- for Windows compatibility.
+	 */
+	if (acpi_gbl_osi_data >= ACPI_OSI_WIN_2000) {
+		acpi_gbl_truncate_io_addresses = TRUE;
+	}
+
 	ACPI_FREE(info.evaluate_info);
 	if (ACPI_FAILURE(status)) {
 		goto error_exit;
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 0e4ab1f..1371cc9 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -69,6 +69,7 @@ extern acpi_name acpi_gbl_trace_method_name;
 extern u32 acpi_gbl_trace_flags;
 extern u8 acpi_gbl_enable_aml_debug_object;
 extern u8 acpi_gbl_copy_dsdt_locally;
+extern u8 acpi_gbl_truncate_io_addresses;
 
 extern u32 acpi_current_gpe_count;
 extern struct acpi_table_fadt acpi_gbl_FADT;
-- 
1.6.0.6

