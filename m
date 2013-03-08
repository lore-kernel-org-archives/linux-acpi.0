From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 04/21] ACPICA: iASL/Disassembler: Add support for VRTC table
Date: Fri,  8 Mar 2013 17:20:32 +0800
Message-ID: <204e5bf1369a6aedc6b8a89cb518be9bf3006a18.1361292877.git.lv.zheng@intel.com>
References: <cover.1361292877.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:36032 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756027Ab3CHJUs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Mar 2013 04:20:48 -0500
In-Reply-To: <cover.1361292877.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

VRTC is used in Intel MID platforms as a replacement of the
traditional x86 RTC. VRTC table can be found in the recent ACPI
BIOS enabled Intel MID platforms. The format of this table has
been defined in the "Simple Firmware Interface Specification"
except it uses GAS instead of 64-bit values for address fields.
This patch introduces VRTC table support into ACPICA.  Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/actbl2.h |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 77dc7a4..3f1b0a4 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -77,6 +77,7 @@
 #define ACPI_SIG_SPMI           "SPMI"	/* Server Platform Management Interface table */
 #define ACPI_SIG_TCPA           "TCPA"	/* Trusted Computing Platform Alliance table */
 #define ACPI_SIG_UEFI           "UEFI"	/* Uefi Boot Optimization Table */
+#define ACPI_SIG_VRTC           "VRTC"	/* Virtual Real Time Clock Table */
 #define ACPI_SIG_WAET           "WAET"	/* Windows ACPI Emulated devices Table */
 #define ACPI_SIG_WDAT           "WDAT"	/* Watchdog Action Table */
 #define ACPI_SIG_WDDT           "WDDT"	/* Watchdog Timer Description Table */
@@ -1025,6 +1026,28 @@ struct acpi_table_uefi {
 
 /*******************************************************************************
  *
+ * VRTC - Virtual Real Time Clock Table
+ *        Version 1
+ *
+ * Conforms to "Simple Firmware Interface Specification",
+ * Draft 0.8.2, Oct 19, 2010
+ * NOTE: The ACPI VRTC is equivalent to The SFI MRTC table.
+ *
+ ******************************************************************************/
+
+struct acpi_table_vrtc {
+	struct acpi_table_header header;	/* Common ACPI table header */
+};
+
+/* VRTC entry */
+
+struct acpi_vrtc_entry {
+	struct acpi_generic_address physical_address;
+	u32 irq;
+};
+
+/*******************************************************************************
+ *
  * WAET - Windows ACPI Emulated devices Table
  *        Version 1
  *
-- 
1.7.10

