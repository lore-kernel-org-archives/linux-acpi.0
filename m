From: changbin.du@intel.com
Subject: [PATCH] ACPI / sysfs: fix shift-overflow in GPE flooding quirk mechanism
Date: Fri, 22 Dec 2017 23:11:10 +0800
Message-ID: <1513955470-27270-1-git-send-email-changbin.du@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:34632 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752796AbdLVPTN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Dec 2017 10:19:13 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Changbin Du <changbin.du@intel.com>

From: Changbin Du <changbin.du@intel.com>

The ACPI_MASKABLE_GPE_MAX is larger than the number of bits that u64 can
represent. This result in shift-overflow. So actually we need a bitmap.

[    1.003153] ======================================================================
[    1.003257] UBSAN: Undefined behaviour in drivers/acpi/sysfs.c:849:33
[    1.003314] shift exponent 64 is too large for 64-bit type 'long long unsigned int'
[    1.003381] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc4+ #40
[    1.003436] Hardware name: LENOVO 20HAS02515/20HAS02515, BIOS N1VET36W (1.26 ) 10/03/2017
[    1.003504] Call Trace:
[    1.003542]  dump_stack+0xe3/0x177
[    1.003582]  ? _atomic_dec_and_lock+0x219/0x219
[    1.003653]  ubsan_epilogue+0xd/0x4e
[    1.003695]  __ubsan_handle_shift_out_of_bounds+0x1f8/0x23d
[    1.003754]  ? __ubsan_handle_load_invalid_value+0x13b/0x13b
[    1.003817]  ? trace_hardirqs_on_caller+0x1f3/0x370
[    1.003868]  ? trace_hardirqs_on+0xd/0x10
[    1.003917]  ? up+0xe9/0x160
[    1.003957]  ? sugov_should_update_freq+0xa1/0x1f0
[    1.004000]  ? trace_hardirqs_on+0xd/0x10
[    1.004000]  acpi_gpe_apply_masked_gpes+0xa4/0x125
[    1.004000]  ? acpi_gpe_apply_masked_gpes+0xa4/0x125
[    1.004000]  ? acpi_gpe_set_masked_gpes+0xe3/0xe3
[    1.004000]  ? acpi_get_table+0x111/0x127
[    1.004000]  acpi_scan_init+0x299/0x598
[    1.004000]  ? acpi_match_madt+0xae/0xae
[    1.004000]  ? sysfs_add_file_mode_ns+0x160/0x320
[    1.004000]  ? kobject_put+0x23/0x220
[    1.004000]  ? bus_create_file+0x75/0x90
[    1.004000]  ? bus_register+0x44a/0x540
[    1.004000]  ? subsys_register.part.1+0x140/0x140
[    1.004000]  acpi_init+0x532/0x5d8
[    1.004000]  ? acpi_sleep_proc_init+0x36/0x36
[    1.004000]  ? console_trylock+0x60/0x60
[    1.004000]  ? sysfs_add_file_mode_ns+0x160/0x320
[    1.004000]  ? sysfs_create_file_ns+0x56/0x80
[    1.004000]  ? video_setup+0x13c/0x13c
[    1.004000]  ? fb_console_init+0x16c/0x1fc
[    1.004000]  ? acpi_sleep_proc_init+0x36/0x36
[    1.004000]  do_one_initcall+0xae/0x282
[    1.004000]  ? initcall_blacklisted+0x1c0/0x1c0
[    1.004000]  ? up_write+0x92/0x100
[    1.004000]  ? down_write_nested+0x110/0x110
[    1.004000]  ? kasan_unpoison_shadow+0x35/0x50
[    1.004000]  kernel_init_freeable+0x4af/0x573
[    1.004000]  ? start_kernel+0x6b1/0x6b1
[    1.004000]  ? rest_init+0x100/0x100
[    1.004000]  kernel_init+0x13/0x13d
[    1.004000]  ? rest_init+0x100/0x100
[    1.004000]  ? rest_init+0x100/0x100
[    1.004000]  ret_from_fork+0x24/0x30
[    1.004000] ======================================================================

Fixes: 9c4aa1eecb48 ("ACPI / sysfs: Provide quirk mechanism to prevent GPE flooding")
Signed-off-by: Changbin Du <changbin.du@intel.com>
---
 drivers/acpi/sysfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 06a150b..60ade0b 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -823,7 +823,7 @@ static ssize_t counter_set(struct kobject *kobj,
  */
 #define ACPI_MASKABLE_GPE_MAX	0x80
 
-static u64 __initdata acpi_masked_gpes;
+static __initdata DECLARE_BITMAP(acpi_masked_gpes, ACPI_MASKABLE_GPE_MAX);
 
 static int __init acpi_gpe_set_masked_gpes(char *val)
 {
@@ -831,7 +831,8 @@ static int __init acpi_gpe_set_masked_gpes(char *val)
 
 	if (kstrtou8(val, 0, &gpe) || gpe > ACPI_MASKABLE_GPE_MAX)
 		return -EINVAL;
-	acpi_masked_gpes |= ((u64)1<<gpe);
+
+	set_bit(gpe, acpi_masked_gpes);
 
 	return 1;
 }
@@ -846,7 +847,7 @@ void __init acpi_gpe_apply_masked_gpes(void)
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

