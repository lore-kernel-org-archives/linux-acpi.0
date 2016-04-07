From: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Subject: [PATCH] ACPI/SRAT: fix SRAT order parsing when both LAPIC and X2APIC present
Date: Thu,  7 Apr 2016 10:21:28 +0200
Message-ID: <1460017288-2176-1-git-send-email-lukasz.anaczkowski@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com, mingo@redhat.com, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lukasz.anaczkowski@intel.com
List-Id: linux-acpi@vger.kernel.org

SRAT maps APIC ID to proximity domains ids. Mapping from proximity
domain ids to NUMA node ids is based on order of entries in SRAT table.
SRAT table has just LAPIC entires or mix of LAPIC and X2APIC entries.
As long as there are only LAPIC entires, mapping from proximity domain
id to NUMA node id is as assumed by BIOS. However, once APIC entries are
mixed, X2APIC entries would be first mapped which causes unexpected NUMA
node mapping.

Fixes: d81056b5278 (Handle apic/x2apic entries in MADT in correct order)
Signed-off-by: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
---
 drivers/acpi/numa.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 72b6e9e..d176e0e 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -327,10 +327,18 @@ int __init acpi_numa_init(void)
 
 	/* SRAT: Static Resource Affinity Table */
 	if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
-		acpi_table_parse_srat(ACPI_SRAT_TYPE_X2APIC_CPU_AFFINITY,
-				     acpi_parse_x2apic_affinity, 0);
-		acpi_table_parse_srat(ACPI_SRAT_TYPE_CPU_AFFINITY,
-				     acpi_parse_processor_affinity, 0);
+		struct acpi_subtable_proc srat_proc[2];
+
+		memset(srat_proc, 0, sizeof(srat_proc));
+		srat_proc[0].id = ACPI_SRAT_TYPE_CPU_AFFINITY;
+		srat_proc[0].handler = acpi_parse_processor_affinity;
+		srat_proc[1].id = ACPI_SRAT_TYPE_X2APIC_CPU_AFFINITY;
+		srat_proc[1].handler = acpi_parse_x2apic_affinity;
+
+		acpi_table_parse_entries_array(ACPI_SIG_SRAT,
+					sizeof(struct acpi_table_srat),
+					srat_proc, ARRAY_SIZE(srat_proc), 0);
+
 		cnt = acpi_table_parse_srat(ACPI_SRAT_TYPE_MEMORY_AFFINITY,
 					    acpi_parse_memory_affinity,
 					    NR_NODE_MEMBLKS);
-- 
1.8.3.1
