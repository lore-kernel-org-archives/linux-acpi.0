From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 18/22] ACPICA: iASL: Add support for TCPA Server Table.
Date: Thu, 23 Jul 2015 12:54:04 +0800
Message-ID: <f5aa5df595c95826fee7dfbe3114e77324be6292.1437627016.git.lv.zheng@intel.com>
References: <cover.1437627016.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1437627016.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 55fa9555c71eaa99daebed4cd82cfde3875e8c45

In addition to the existing support for the client table.

Link: https://github.com/acpica/acpica/commit/55fa9555
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl2.h |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index a948fc5..6e28f54 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1186,20 +1186,29 @@ enum acpi_spmi_interface_types {
  * December 19, 2014
  *
  * NOTE: There are two versions of the table with the same signature --
- * the client version and the server version.
+ * the client version and the server version. The common platform_class
+ * field is used to differentiate the two types of tables.
  *
  ******************************************************************************/
 
-struct acpi_table_tcpa_client {
+struct acpi_table_tcpa_hdr {
 	struct acpi_table_header header;	/* Common ACPI table header */
 	u16 platform_class;
+};
+
+/*
+ * Values for platform_class above.
+ * This is how the client and server subtables are differentiated
+ */
+#define ACPI_TCPA_CLIENT_TABLE          0
+#define ACPI_TCPA_SERVER_TABLE          1
+
+struct acpi_table_tcpa_client {
 	u32 minimum_log_length;	/* Minimum length for the event log area */
 	u64 log_address;	/* Address of the event log area */
 };
 
 struct acpi_table_tcpa_server {
-	struct acpi_table_header header;	/* Common ACPI table header */
-	u16 platform_class;
 	u16 reserved;
 	u64 minimum_log_length;	/* Minimum length for the event log area */
 	u64 log_address;	/* Address of the event log area */
-- 
1.7.10
