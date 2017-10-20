From: Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Shift overflow in acpi_gpe_apply_masked_gpes
Date: Fri, 20 Oct 2017 19:30:31 +0100
Message-ID: <a44e380e-4efc-1ff4-2ff4-9ef38d27d6cf@ursulin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:47640 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752379AbdJTSae (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Oct 2017 14:30:34 -0400
Received: by mail-wm0-f66.google.com with SMTP id t69so23622803wmt.2
        for <linux-acpi@vger.kernel.org>; Fri, 20 Oct 2017 11:30:33 -0700 (PDT)
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org


Hi all,

Triggered with ubsan:

  UBSAN: Undefined behaviour in drivers/acpi/sysfs.c:845:33
  shift exponent 64 is too large for 64-bit type 'long long unsigned int'
  CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.14.0-rc5+ #532
  Hardware name: LENOVO 80MX/Lenovo E31-80, BIOS DCCN34WW(V2.03) 12/01/2015
  Call Trace:
   dump_stack+0xab/0xfe
   ? _atomic_dec_and_lock+0x112/0x112
   ? get_unsigned_val+0x48/0x91
   ubsan_epilogue+0x9/0x49
   __ubsan_handle_shift_out_of_bounds+0x1ea/0x241
   ? __ubsan_handle_load_invalid_value+0x136/0x136
   ? do_raw_spin_unlock+0xf5/0x1d0
   ? do_raw_spin_trylock+0x90/0x90
   ? __lock_is_held+0x71/0x150
   ? _raw_spin_unlock_irqrestore+0x32/0x50
   ? trace_hardirqs_on_caller+0x184/0x360
   ? acpi_gpe_apply_masked_gpes+0x95/0xfd
   acpi_gpe_apply_masked_gpes+0x95/0xfd
   ? acpi_gpe_set_masked_gpes+0xc1/0xc1
   ? acpi_get_table+0xff/0x114
   acpi_scan_init+0x1cf/0x3fe
   ? acpi_match_madt+0xa7/0xa7
   ? bus_register+0x386/0x450
   ? subsys_register.part.1+0x140/0x140
   acpi_init+0x41f/0x492
   ? acpi_sleep_proc_init+0x30/0x30
   ? console_unlock+0x524/0x7a0
   ? trace_hardirqs_on_caller+0x184/0x360
   ? scan_for_dmi_ipmi+0x22/0x202
   ? fb_console_init+0x14f/0x1e6
   ? acpi_sleep_proc_init+0x30/0x30
   do_one_initcall+0xa3/0x256
   ? parameq+0xe0/0xe0
   ? initcall_blacklisted+0x160/0x160
   ? down_write_nested+0x110/0x110
   ? kasan_unpoison_shadow+0x30/0x40
   kernel_init_freeable+0x3ee/0x47f
   ? rest_init+0xf0/0xf0
   kernel_init+0xf/0x140
   ? rest_init+0xf0/0xf0
   ret_from_fork+0x27/0x40

Code is:

#define ACPI_MASKABLE_GPE_MAX	0x80
...
void __init acpi_gpe_apply_masked_gpes(void)
{
	acpi_handle handle;
	acpi_status status;
	u8 gpe;

	for (gpe = 0;
	     gpe < min_t(u8, ACPI_MASKABLE_GPE_MAX, acpi_current_gpe_count);
	     gpe++) {
		if (acpi_masked_gpes & ((u64)1<<gpe)) {
...

Left shift on the last line is bound by ACPI_MASKABLE_GPE_MAX which is 0x80.

Regards,

Tvrtko
