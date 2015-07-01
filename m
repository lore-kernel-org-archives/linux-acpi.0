From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 24/26] ACPICA: Update TPM2 ACPI table.
Date: Wed,  1 Jul 2015 14:45:32 +0800
Message-ID: <3eaac0c66997cd238671830bd2c73dc3471ed287.1435731597.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com> <cover.1435731597.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51782 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753657AbbGAGpi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Jul 2015 02:45:38 -0400
In-Reply-To: <cover.1435731597.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

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

