From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI: use bitmap helper for masked GPEs
Date: Thu, 25 Jan 2018 14:14:27 +0800
Message-ID: <1516860867-6391-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:57874 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750769AbeAYGOb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Jan 2018 01:14:31 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, pmenzel+bugzilla.kernel.org@molgen.mpg.de

"acpi_mask_gpe=" kernel parameter is introduced to mask one or more GPEs
at boot stage, to prevent GPE flooding.

Currently, a maximum of 128 GPEs (from GPE 0x00 to GPE 0x7f) are allowed
to be masked by this kernel parameter, but only one u64 variant is used
as the bitmap for the masked GPEs in kernel.

This is bogus and makes some GPEs masked unexpected when masking a GPE
larger than 0x40.
For example, with CONFIG_UBSAN=y, when "acpi_mask_gpe=0x6f" is parsed,
we get

[    0.039669] ACPI: Masking GPE 0x2f.
[    0.039681] ================================================================================
[    0.039684] UBSAN: Undefined behaviour in drivers/acpi/sysfs.c:846:33
[    0.039688] shift exponent 64 is too large for 64-bit type 'long long unsigned int'
[    0.039692] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.14.0-UBSAN-check+ #37
[    0.039695] Hardware name: Microsoft Corporation Surface Pro 4/Surface Pro 4, BIOS 106.1281.768 08/01/2016
[    0.039698] Call Trace:
[    0.039704]  dump_stack+0x64/0x91
[    0.039709]  ubsan_epilogue+0xd/0x40
[    0.039712]  __ubsan_handle_shift_out_of_bounds+0xf6/0x140
[    0.039716]  ? do_syscall_64+0x1e6/0x760
[    0.039720]  ? acpi_ev_mask_gpe+0x141/0x14c
[    0.039724]  acpi_gpe_apply_masked_gpes+0x41/0x8a
[    0.039727]  ? acpi_gpe_apply_masked_gpes+0x41/0x8a
[    0.039731]  acpi_scan_init+0x14d/0x2df
[    0.039734]  acpi_init+0x32d/0x379
[    0.039737]  ? acpi_sleep_proc_init+0x2a/0x2a
[    0.039740]  do_one_initcall+0x116/0x1d0
[    0.039743]  kernel_init_freeable+0x304/0x39a
[    0.039746]  ? rest_init+0xf0/0xf0
[    0.039749]  kernel_init+0xf/0x120
[    0.039752]  ? rest_init+0xf0/0xf0
[    0.039756]  ret_from_fork+0x25/0x30
[    0.039758] ================================================================================
[    0.039762] ACPI: Masking GPE 0x6f.

Fix this by using the bitmap helper, for declaring, testing and setting
the bitmap.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=198481
Reported-and-tested-by: Paul Menzel <pmenzel+bugzilla.kernel.org@molgen.mpg.de>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Cc: 4.10+ <stable@vger.kernel.org> # 4.10+
---
 drivers/acpi/sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 0fd57bf..f0d1163 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -820,7 +820,7 @@ static ssize_t counter_set(struct kobject *kobj,
  */
 #define ACPI_MASKABLE_GPE_MAX	0x80
 
-static u64 __initdata acpi_masked_gpes;
+static __initdata DECLARE_BITMAP(acpi_masked_gpes, ACPI_MASKABLE_GPE_MAX);
 
 static int __init acpi_gpe_set_masked_gpes(char *val)
 {
@@ -828,7 +828,7 @@ static int __init acpi_gpe_set_masked_gpes(char *val)
 
 	if (kstrtou8(val, 0, &gpe) || gpe > ACPI_MASKABLE_GPE_MAX)
 		return -EINVAL;
-	acpi_masked_gpes |= ((u64)1<<gpe);
+	set_bit(gpe, acpi_masked_gpes);
 
 	return 1;
 }
@@ -843,7 +843,7 @@ void __init acpi_gpe_apply_masked_gpes(void)
 	for (gpe = 0;
 	     gpe < min_t(u8, ACPI_MASKABLE_GPE_MAX, acpi_current_gpe_count);
 	     gpe++) {
-		if (acpi_masked_gpes & ((u64)1<<gpe)) {
+		if (test_bit(gpe, acpi_masked_gpes)) {
 			status = acpi_get_gpe_device(gpe, &handle);
 			if (ACPI_SUCCESS(status)) {
 				pr_info("Masking GPE 0x%x.\n", gpe);
-- 
2.7.4

