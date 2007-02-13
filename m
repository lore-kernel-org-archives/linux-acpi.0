From: Len Brown <lenb@kernel.org>
Subject: [PATCH 33/41] ACPI: acpi_table_parse() now returns success/fail, not count
Date: Tue, 13 Feb 2007 00:49:35 -0500
Message-ID: <11713458233765-git-send-email-lenb@kernel.org>
References: <11713457831139-git-send-email-lenb@kernel.org> <11713457843659-git-send-email-lenb@kernel.org> <11713457871537-git-send-email-lenb@kernel.org> <1171345789246-git-send-email-lenb@kernel.org> <1171345790970-git-send-email-lenb@kernel.org> <11713457922756-git-send-email-lenb@kernel.org> <11713457941772-git-send-email-lenb@kernel.org> <11713457953042-git-send-email-lenb@kernel.org> <11713457971245-git-send-email-lenb@kernel.org> <1171345798129-git-send-email-lenb@kernel.org> <11713457996-git-send-email-lenb@kernel.org> <11713458001192-git-send-email-lenb@kernel.org> <11713458011379-git-send-email-lenb@kernel.org> <11713458021568-git-send-email-lenb@kernel.org> <11713458031539-git-send-email-lenb@kernel.org> <11713458041996-git-send-email-lenb@kernel.org> <11713458052158-git-send-email-lenb@kernel.org> <11713458062930-git-send-email-lenb@kernel.org> <11713458071963-git-send-email
 -lenb@kernel.org> <11713458083103-git-send-email-lenb@kernel.org> <11713458101527-git-send-email-lenb@kernel.org> <11713458113695-git-send-email-lenb@kernel.org> <11713458122380-git-send-email-lenb@kernel.org> <11713458132236-git-send-email-lenb@kernel.org> <11713458143449-git-send-email-lenb@kernel.org> <11713458152188-git-send-email-lenb@kernel.org> <11713458163685-git-send-email-lenb@kernel.org> <11713458171374-git-send-email-lenb@kernel.org> <11713458183917-git-send-email-lenb@kernel.org> <11713458191475-git-send-email-lenb@kernel.org> <11713458202747-git-send-email-lenb@kernel.org> <11713458211458-git-send-email-lenb@kernel.org> <11713458222751-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:17992 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751091AbXBMFu1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 00:50:27 -0500
In-Reply-To: <11713458222751-git-send-email-lenb@kernel.org>
Message-Id: <f7bbbd219905be041293cd769c6a242d1792d79c.1171345631.git.len.brown@intel.com>
In-Reply-To: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
References: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Returning count for tables that are supposed to be unique
was useless and confusing.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86_64/kernel/early-quirks.c |    4 +++-
 arch/x86_64/pci/mmconfig.c        |    4 +++-
 drivers/acpi/numa.c               |    6 ++----
 drivers/acpi/tables.c             |   13 +++++++++++--
 4 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/x86_64/kernel/early-quirks.c b/arch/x86_64/kernel/early-quirks.c
index bd30d13..8047ea8 100644
--- a/arch/x86_64/kernel/early-quirks.c
+++ b/arch/x86_64/kernel/early-quirks.c
@@ -53,7 +53,9 @@ static void nvidia_bugs(void)
 		return;
 
 	nvidia_hpet_detected = 0;
-	acpi_table_parse(ACPI_SIG_HPET, nvidia_hpet_check);
+	if (acpi_table_parse(ACPI_SIG_HPET, nvidia_hpet_check))
+		return;
+
 	if (nvidia_hpet_detected == 0) {
 		acpi_skip_timer_override = 1;
 		printk(KERN_INFO "Nvidia board "
diff --git a/arch/x86_64/pci/mmconfig.c b/arch/x86_64/pci/mmconfig.c
index faabb6e..98202cb 100644
--- a/arch/x86_64/pci/mmconfig.c
+++ b/arch/x86_64/pci/mmconfig.c
@@ -170,7 +170,9 @@ void __init pci_mmcfg_init(int type)
 	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
 		return;
 
-	acpi_table_parse(ACPI_SIG_MCFG, acpi_parse_mcfg);
+	if (acpi_table_parse(ACPI_SIG_MCFG, acpi_parse_mcfg))
+		return;
+
 	if ((pci_mmcfg_config_num == 0) ||
 	    (pci_mmcfg_config == NULL) ||
 	    (pci_mmcfg_config[0].address == 0))
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 4a9faff..b33daf8 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -220,9 +220,7 @@ int __init acpi_numa_init(void)
 	int result;
 
 	/* SRAT: Static Resource Affinity Table */
-	result = acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat);
-
-	if (result > 0) {
+	if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
 		result = acpi_table_parse_srat(ACPI_SRAT_TYPE_CPU_AFFINITY,
 					       acpi_parse_processor_affinity,
 					       NR_CPUS);
@@ -230,7 +228,7 @@ int __init acpi_numa_init(void)
 	}
 
 	/* SLIT: System Locality Information Table */
-	result = acpi_table_parse(ACPI_SIG_SLIT, acpi_parse_slit);
+	acpi_table_parse(ACPI_SIG_SLIT, acpi_parse_slit);
 
 	acpi_numa_arch_fixup();
 	return 0;
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index ba4cb20..2075ec7 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -226,6 +226,15 @@ acpi_table_parse_madt(enum acpi_madt_type id,
 					    handler, max_entries);
 }
 
+/**
+ * acpi_table_parse - find table with @id, run @handler on it
+ *
+ * @id: table id to find
+ * @handler: handler to run
+ *
+ * Scan the ACPI System Descriptor Table (STD) for a table matching @id,
+ * run @handler on it.  Return 0 if table found, return on if not.
+ */
 int __init acpi_table_parse(char *id, acpi_table_handler handler)
 {
 	struct acpi_table_header *table = NULL;
@@ -235,9 +244,9 @@ int __init acpi_table_parse(char *id, acpi_table_handler handler)
 	acpi_get_table(id, 0, &table);
 	if (table) {
 		handler(table);
-		return 1;
-	} else
 		return 0;
+	} else
+		return 1;
 }
 
 /*
-- 
1.5.0.rc4.345.gb4d2
