From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 2/3] ACPI: Add acpi_gbl_osi_data to OS headers
Date: Wed, 19 May 2010 11:43:10 -0400
Message-ID: <1274283791-3380-2-git-send-email-mjg@redhat.com>
References: <1274283791-3380-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:18175 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752044Ab0ESPnc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 May 2010 11:43:32 -0400
In-Reply-To: <1274283791-3380-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: robert.moore@intel.com, lenb@kernel.org, Matthew Garrett <mjg@redhat.com>

Different operating systems may wish to enable different workaround quirks
depending on the _OSI methods called by the firmware. Add the declaration
of acpi_gbl_osi_data to the OS headers and move the associated #defines in
order to make this possible.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/acpica/aclocal.h |   13 -------------
 include/acpi/acpixf.h         |   14 ++++++++++++++
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 24b8faa..66f58f0 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -891,19 +891,6 @@ struct acpi_bit_register_info {
 
 #define ACPI_BITPOSITION_ARB_DISABLE            0x00
 
-/* Structs and definitions for _OSI support and I/O port validation */
-
-#define ACPI_OSI_WIN_2000               0x01
-#define ACPI_OSI_WIN_XP                 0x02
-#define ACPI_OSI_WIN_XP_SP1             0x03
-#define ACPI_OSI_WINSRV_2003            0x04
-#define ACPI_OSI_WIN_XP_SP2             0x05
-#define ACPI_OSI_WINSRV_2003_SP1        0x06
-#define ACPI_OSI_WIN_VISTA              0x07
-#define ACPI_OSI_WINSRV_2008            0x08
-#define ACPI_OSI_WIN_VISTA_SP1          0x09
-#define ACPI_OSI_WIN_7                  0x0A
-
 #define ACPI_ALWAYS_ILLEGAL             0x00
 
 struct acpi_interface_info {
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 847d262..fa0a8ef 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -66,9 +66,23 @@ extern u8 acpi_gbl_create_osi_method;
 extern u8 acpi_gbl_leave_wake_gpes_disabled;
 extern u8 acpi_gbl_use_default_register_widths;
 extern u8 acpi_gbl_ignore_high_ioport_bits;
+extern u8 acpi_gbl_osi_data;
 extern acpi_name acpi_gbl_trace_method_name;
 extern u32 acpi_gbl_trace_flags;
 
+/* Structs and definitions for _OSI support and I/O port validation */
+
+#define ACPI_OSI_WIN_2000               0x01
+#define ACPI_OSI_WIN_XP                 0x02
+#define ACPI_OSI_WIN_XP_SP1             0x03
+#define ACPI_OSI_WINSRV_2003            0x04
+#define ACPI_OSI_WIN_XP_SP2             0x05
+#define ACPI_OSI_WINSRV_2003_SP1        0x06
+#define ACPI_OSI_WIN_VISTA              0x07
+#define ACPI_OSI_WINSRV_2008            0x08
+#define ACPI_OSI_WIN_VISTA_SP1          0x09
+#define ACPI_OSI_WIN_7                  0x0A
+
 extern u32 acpi_current_gpe_count;
 extern struct acpi_table_fadt acpi_gbl_FADT;
 
-- 
1.7.0.1

