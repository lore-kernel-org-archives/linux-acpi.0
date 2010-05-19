From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 1/3] ACPI: Ignore the upper bits of SystemIO addresses
Date: Wed, 19 May 2010 11:43:09 -0400
Message-ID: <1274283791-3380-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:24600 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752320Ab0ESPnc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 May 2010 11:43:32 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: robert.moore@intel.com, lenb@kernel.org, Matthew Garrett <mjg@redhat.com>

Various machines (https://bugzilla.redhat.com/show_bug.cgi?id=585756 for
instance) contain SystemIO spaces with addresses > 16 bits. acpica throws
an error for this, while Windows silently ignores the upper 16 bits and
carries on happily. Provide support for the latter behaviour for bug
compatibility.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/acpica/acglobal.h |    6 ++++++
 drivers/acpi/acpica/hwvalid.c  |   10 ++++++++++
 include/acpi/acpixf.h          |    1 +
 3 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index f8dd8f2..f302168 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -112,6 +112,12 @@ u8 ACPI_INIT_GLOBAL(acpi_gbl_leave_wake_gpes_disabled, TRUE);
  */
 u8 ACPI_INIT_GLOBAL(acpi_gbl_use_default_register_widths, TRUE);
 
+/*
+ * Optionally provide compatibility with Windows by only using the lower
+ * 16 bits of system io addresses.
+ */
+u8 ACPI_INIT_GLOBAL(acpi_gbl_ignore_high_ioport_bits, FALSE);
+
 /* acpi_gbl_FADT is a local copy of the FADT, converted to a common format. */
 
 struct acpi_table_fadt acpi_gbl_FADT;
diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
index e26c17d..c151a15 100644
--- a/drivers/acpi/acpica/hwvalid.c
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -222,6 +222,11 @@ acpi_status acpi_hw_read_port(acpi_io_address address, u32 *value, u32 width)
 	u32 one_byte;
 	u32 i;
 
+	if (acpi_gbl_ignore_high_ioport_bits)
+		/* Windows only uses the lower 16 bits of an address.
+		   Emulate that */
+		address &= 0xffff;
+
 	/* Validate the entire request and perform the I/O */
 
 	status = acpi_hw_validate_io_request(address, width);
@@ -279,6 +284,11 @@ acpi_status acpi_hw_write_port(acpi_io_address address, u32 value, u32 width)
 	acpi_status status;
 	u32 i;
 
+	if (acpi_gbl_ignore_high_ioport_bits)
+		/* Windows only uses the lower 16 bits of an address.
+		   Emulate that */
+		address &= 0xffff;
+
 	/* Validate the entire request and perform the I/O */
 
 	status = acpi_hw_validate_io_request(address, width);
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 4447a04..847d262 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -65,6 +65,7 @@ extern u8 acpi_gbl_all_methods_serialized;
 extern u8 acpi_gbl_create_osi_method;
 extern u8 acpi_gbl_leave_wake_gpes_disabled;
 extern u8 acpi_gbl_use_default_register_widths;
+extern u8 acpi_gbl_ignore_high_ioport_bits;
 extern acpi_name acpi_gbl_trace_method_name;
 extern u32 acpi_gbl_trace_flags;
 
-- 
1.7.0.1

