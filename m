From: Lv Zheng <zetalog@gmail.com>
Subject: [PATCH v2 2/2] ACPI: Fix regressions that x86 Linux kernel suffers from early mapping size limitation.
Date: Sat, 31 May 2014 08:15:02 +0800
Message-ID: <27f098e96a4686a58a495c6802d4c388ebfa9817.1401494654.git.lv.zheng@intel.com>
References: <e28682572e0736657b0120aeec5f64ac21159faf.1401415540.git.lv.zheng@intel.com> <cover.1401494652.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:34189 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934893AbaEaAPS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 May 2014 20:15:18 -0400
Received: by mail-pb0-f45.google.com with SMTP id um1so2253610pbc.4
        for <linux-acpi@vger.kernel.org>; Fri, 30 May 2014 17:15:18 -0700 (PDT)
In-Reply-To: <cover.1401494652.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, lkp@vger.linux-kernel.cn, x86@kernel.org

From: Lv Zheng <lv.zheng@intel.com>

The following warning message is triggered:
 WARNING: CPU: 0 PID: 0 at mm/early_ioremap.c:136 __early_ioremap+0x11f/0x1f2()
 Modules linked in:
 CPU: 0 PID: 0 Comm: swapper Not tainted 3.15.0-rc1-00017-g86dfc6f3-dirty #298
 Hardware name: Intel Corporation S2600CP/S2600CP, BIOS SE5C600.86B.99.99.x036.091920111209 09/19/2011
  0000000000000009 ffffffff81b75c40 ffffffff817c627b 0000000000000000
  ffffffff81b75c78 ffffffff81067b5d 000000000000007b 8000000000000563
  00000000b96b20dc 0000000000000001 ffffffffff300e0c ffffffff81b75c88
 Call Trace:
  [<ffffffff817c627b>] dump_stack+0x45/0x56
  [<ffffffff81067b5d>] warn_slowpath_common+0x7d/0xa0
  [<ffffffff81067c3a>] warn_slowpath_null+0x1a/0x20
  [<ffffffff81d4b9d5>] __early_ioremap+0x11f/0x1f2
  [<ffffffff81d4bc5b>] early_ioremap+0x13/0x15
  [<ffffffff81d2b8f3>] __acpi_map_table+0x13/0x18
  [<ffffffff817b8d1a>] acpi_os_map_memory+0x26/0x14e
  [<ffffffff813ff018>] acpi_tb_acquire_table+0x42/0x70
  [<ffffffff813ff086>] acpi_tb_validate_table+0x27/0x37
  [<ffffffff813ff0e5>] acpi_tb_verify_table+0x22/0xd8
  [<ffffffff813ff6a8>] acpi_tb_install_non_fixed_table+0x60/0x1c9
  [<ffffffff81d61024>] acpi_tb_parse_root_table+0x218/0x26a
  [<ffffffff81d1b120>] ? early_idt_handlers+0x120/0x120
  [<ffffffff81d610cd>] acpi_initialize_tables+0x57/0x59
  [<ffffffff81d5f25d>] acpi_table_init+0x1b/0x99
  [<ffffffff81d2bca0>] acpi_boot_table_init+0x1e/0x85
  [<ffffffff81d23043>] setup_arch+0x99d/0xcc6
  [<ffffffff81d1b120>] ? early_idt_handlers+0x120/0x120
  [<ffffffff81d1bbbe>] start_kernel+0x8b/0x415
  [<ffffffff81d1b120>] ? early_idt_handlers+0x120/0x120
  [<ffffffff81d1b5ee>] x86_64_start_reservations+0x2a/0x2c
  [<ffffffff81d1b72e>] x86_64_start_kernel+0x13e/0x14d
 ---[ end trace 11ae599a1898f4e7 ]---
when installing the following table during early stage:
 ACPI: SSDT 0x00000000B9638018 07A0C4 (v02 INTEL  S2600CP  00004000 INTL 20100331)
The regression is caused by the size limitation of the x86 early IO mapping.

The root cause is:
1. ACPICA doesn't split IO memory mapping and table mapping;
2. Linux x86 OSL implements acpi_os_map_memory() using a size limited fix-map
   mechanism during early boot stage, which is more suitable for only IO
   mappings.

This patch fixes this issue by utilizing acpi_gbl_verify_table_checksum to
disable the table mapping during early stage and enabling it again for the
late stage. In this way, the normal code path is not affected. Then after
the code related to the root cause is cleaned up, the early checksum
verification can be easily re-enabled.

A new boot parameter - acpi_force_table_verification is introduced for
the platforms that require the checksum verification to stop loading bad
tables.

This fix also covers the checksum verification for the table overrides. Now
large tables can also be overridden using the initrd override mechanism.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Bisected-and-tested-by: Yuanhan Liu <yuanhan.liu@linux.intel.com>
Cc: <lkp@vger.linux-kernel.cn>
Cc: <x86@kernel.org>
---
 Documentation/kernel-parameters.txt |    5 +++++
 drivers/acpi/bus.c                  |    3 +++
 drivers/acpi/tables.c               |   23 +++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 7a4802d..0933ec4 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -214,6 +214,11 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			unusable.  The "log_buf_len" parameter may be useful
 			if you need to capture more output.
 
+	acpi_force_table_verification	[HW,ACPI]
+			Enable table checksum verification during early stage.
+			By default, this is disabled due to x86 early mapping
+			size limitation.
+
 	acpi_irq_balance [HW,ACPI]
 			ACPI will balance active IRQs
 			default in APIC mode
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 4ce0ea1..c5bc8cf 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -489,6 +489,9 @@ void __init acpi_early_init(void)
 
 	printk(KERN_INFO PREFIX "Core revision %08x\n", ACPI_CA_VERSION);
 
+	/* It's safe to verify table checksums during late stage */
+	acpi_gbl_verify_table_checksum = TRUE;
+
 	/* enable workarounds, unless strict ACPI spec. compliance */
 	if (!acpi_strict)
 		acpi_gbl_enable_interpreter_slack = TRUE;
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 2178229..05550ba 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -44,6 +44,12 @@ static struct acpi_table_desc initial_tables[ACPI_MAX_TABLES] __initdata;
 
 static int acpi_apic_instance __initdata;
 
+/*
+ * Disable table checksum verification for the early stage due to the size
+ * limitation of the current x86 early mapping implementation.
+ */
+static bool acpi_verify_table_checksum __initdata = false;
+
 void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 {
 	if (!header)
@@ -333,6 +339,14 @@ int __init acpi_table_init(void)
 {
 	acpi_status status;
 
+	if (acpi_verify_table_checksum) {
+		pr_info("Early table checksum verification enabled\n");
+		acpi_gbl_verify_table_checksum = TRUE;
+	} else {
+		pr_info("Early table checksum verification disabled\n");
+		acpi_gbl_verify_table_checksum = FALSE;
+	}
+
 	status = acpi_initialize_tables(initial_tables, ACPI_MAX_TABLES, 0);
 	if (ACPI_FAILURE(status))
 		return -EINVAL;
@@ -354,3 +368,12 @@ static int __init acpi_parse_apic_instance(char *str)
 }
 
 early_param("acpi_apic_instance", acpi_parse_apic_instance);
+
+static int __init acpi_force_table_verification_setup(char *s)
+{
+	acpi_verify_table_checksum = true;
+
+	return 0;
+}
+
+early_param("acpi_force_table_verification", acpi_force_table_verification_setup);
-- 
1.7.10

