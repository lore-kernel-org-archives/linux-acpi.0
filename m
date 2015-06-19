From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 30/32] ACPICA: Update TPM2 ACPI table.
Date: Fri, 19 Jun 2015 11:41:36 +0800
Message-ID: <ac034f61b4c49188067971957b58d22e12c2c3a9.1434684720.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1434684719.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 254bf77e7ca01cb27e026fa5737f7df8dae03f2c

- Add constans for the start_method.
- Remove the control structure, not part of ACPI, not defined in the current
TCG spec.

Link: https://github.com/acpica/acpica/commit/254bf77e
Reported-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl2.h |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 2a9dcc1..a948fc5 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1251,19 +1251,13 @@ struct acpi_table_tpm2 {
 	/* Platform-specific data follows */
 };
 
-/* Control area structure (not part of table, pointed to by control_address) */
+/* Values for start_method above */
 
-struct acpi_tpm2_control {
-	u32 reserved;
-	u32 error;
-	u32 cancel;
-	u32 start;
-	u64 interrupt_control;
-	u32 command_size;
-	u64 command_address;
-	u32 response_size;
-	u64 response_address;
-};
+#define ACPI_TPM2_NOT_ALLOWED                       0
+#define ACPI_TPM2_START_METHOD                      2
+#define ACPI_TPM2_MEMORY_MAPPED                     6
+#define ACPI_TPM2_COMMAND_BUFFER                    7
+#define ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD  8
 
 /*******************************************************************************
  *
-- 
1.7.10
