From: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Subject: [PATCH v2] ACPI/SRAT: fix SRAT order parsing when both LAPIC and X2APIC present
Date: Thu, 21 Apr 2016 11:29:00 +0200
Message-ID: <1461230940-5037-2-git-send-email-lukasz.anaczkowski@intel.com>
References: <5650804.Bpcz1v4kAC@vostro.rjw.lan>
 <1461230940-5037-1-git-send-email-lukasz.anaczkowski@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:34148 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751614AbcDUJ3I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Apr 2016 05:29:08 -0400
In-Reply-To: <1461230940-5037-1-git-send-email-lukasz.anaczkowski@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com, mingo@redhat.com, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lukasz.anaczkowski@intel.com

SRAT maps APIC ID to proximity domains ids (PXM). Mapping from PXM to
NUMA node ids is based on order of entries in SRAT table.
SRAT table has just LAPIC entires or mix of LAPIC and X2APIC entries.
As long as there are only LAPIC entires, mapping from proximity domain
id to NUMA node id is as assumed by BIOS. However, once APIC entries are
mixed, X2APIC entries would be first mapped which causes unexpected NUMA
node mapping.
To fix that, change parsing to check each entry against both LAPIC and
X2APIC so mapping is in the SRAT/PXM order.
This is supplemental change to the fix made by d81056b5278 (thus
"Fixes:" tag) and using same mechanism introduced by 9b3fedd (ACPI / tables:
Add acpi_subtable_proc to ACPI table parsers).

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

