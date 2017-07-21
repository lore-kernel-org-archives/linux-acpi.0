From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: [PATCH 2/2] acpi: Fix typo in SRAT table name
Date: Fri, 21 Jul 2017 16:51:24 -0600
Message-ID: <20170721225124.15297-2-ross.zwisler@linux.intel.com>
References: <20170721225124.15297-1-ross.zwisler@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170721225124.15297-1-ross.zwisler@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, devel@acpica.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

To save someone the time of searching the ACPI spec for "Static Resource
Affinity Table".

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
---
 drivers/acpi/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index edb0c79..917f1cc 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -443,7 +443,7 @@ int __init acpi_numa_init(void)
 	 * So go over all cpu entries in SRAT to get apicid to node mapping.
 	 */
 
-	/* SRAT: Static Resource Affinity Table */
+	/* SRAT: System Resource Affinity Table */
 	if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
 		struct acpi_subtable_proc srat_proc[3];
 
-- 
2.9.4
