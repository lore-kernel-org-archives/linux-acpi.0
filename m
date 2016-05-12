From: Meelis Roos <mroos@linux.ee>
Subject: UBSAN: Undefined behaviour in drivers/acpi/acpica/dsutils.c:641:16
Date: Thu, 12 May 2016 19:08:04 +0300 (EEST)
Message-ID: <alpine.LRH.2.20.1605121906100.4797@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org

This appears on a lot of my test machines after turning on UBSAN checks.

[    0.180837] ================================================================================
[    0.181001] UBSAN: Undefined behaviour in drivers/acpi/acpica/dsutils.c:641:16
[    0.181161] index -1 is out of range for type 'acpi_operand_object *[9]'
[    0.181262] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.6.0-rc6-00072-g33656a1 #22
[    0.181421] Hardware name: Unknown Unknown/S2462 THUNDER K7, BIOS Guinness-8    04/07/2003
[    0.181584]  00000000 c134beac 00000046 f6461cac ffffffff c1381f8b f6461ca4 c19182d4
[    0.181941]  c13825bf c17001c8 f6461cb0 c19182ec 00000202 c100312d 00000299 f64ddc00
[    0.182296]  f6461cf4 00000286 f6427000 c13ad4ec 00000286 f6427090 00000286 f64ddc00
[    0.182655] Call Trace:
[    0.182755]  [<c134beac>] ? dump_stack+0x45/0x69
[    0.182853]  [<c1381f8b>] ? ubsan_epilogue+0xb/0x40
[    0.182948]  [<c13825bf>] ? __ubsan_handle_out_of_bounds+0x5f/0x70
[    0.183046]  [<c100312d>] ? perf_assign_events+0x36d/0x520
[    0.183146]  [<c13ad4ec>] ? acpi_os_release_object+0x5/0x8
[    0.183244]  [<c13c11af>] ? acpi_ds_create_operand+0x1f6/0x283
[    0.183340]  [<c13c132b>] ? acpi_ds_create_operands+0xef/0x131
[    0.183436]  [<c13ad4ec>] ? acpi_os_release_object+0x5/0x8
[    0.183533]  [<c13ad4ec>] ? acpi_os_release_object+0x5/0x8
[    0.183628]  [<c13c18d2>] ? acpi_ds_exec_end_op+0xe0/0x4be
[    0.183729]  [<c13d7f02>] ? acpi_ps_complete_op+0x1c5/0x248
[    0.183825]  [<c13d78da>] ? acpi_ps_parse_loop+0x618/0x65e
[    0.183923]  [<c13d864c>] ? acpi_ps_parse_aml+0x8a/0x26d
[    0.184000]  [<c13d8fd1>] ? acpi_ps_execute_method+0x1a0/0x1ce
[    0.184000]  [<c13d2462>] ? acpi_ns_evaluate+0x1e4/0x263
[    0.184000]  [<c13df567>] ? acpi_ut_evaluate_object+0x31/0x15b
[    0.184000]  [<c13df57b>] ? acpi_ut_evaluate_object+0x45/0x15b
[    0.184000]  [<c13df8b9>] ? acpi_ut_execute_HID+0x1e/0xcb
[    0.184000]  [<c13d5c07>] ? acpi_ns_get_device_callback+0x7e/0x157
[    0.184000]  [<c13ad469>] ? acpi_os_signal_semaphore+0x3f/0x4c
[    0.184000]  [<c13d5632>] ? acpi_ns_walk_namespace+0xe9/0x1ae
[    0.184000]  [<c1a6e163>] ? acpi_sleep_proc_init+0x1f/0x1f
[    0.184000]  [<c13d5952>] ? acpi_get_devices+0x43/0x61
[    0.184000]  [<c13d5b89>] ? acpi_evaluate_object_typed+0xcd/0xcd
[    0.184000]  [<c13b659f>] ? ec_get_handle+0xf/0xf
[    0.184000]  [<c1a6ebbd>] ? acpi_ec_ecdt_probe+0xfa/0x1d0
[    0.184000]  [<c1a6e1de>] ? acpi_init+0x7b/0x25d
[    0.184000]  [<c1363303>] ? kvasprintf+0x43/0x90
[    0.184000]  [<c13507c8>] ? kset_create_and_add+0x58/0xa0
[    0.184000]  [<c1000413>] ? do_one_initcall+0x73/0x260
[    0.184000]  [<c100042a>] ? do_one_initcall+0x8a/0x260
[    0.184000]  [<c1a6e163>] ? acpi_sleep_proc_init+0x1f/0x1f
[    0.184000]  [<c10962af>] ? parameq+0xf/0xb0
[    0.184000]  [<c1096555>] ? parse_args+0x205/0x510
[    0.184000]  [<c1a46dad>] ? kernel_init_freeable+0x153/0x25c
[    0.184000]  [<c1a46e2a>] ? kernel_init_freeable+0x1d0/0x25c
[    0.184000]  [<c1644f99>] ? kernel_init+0x9/0x120
[    0.184000]  [<c10a320b>] ? schedule_tail+0xb/0xa0
[    0.184000]  [<c164de09>] ? ret_from_kernel_thread+0x21/0x38
[    0.184000]  [<c1644f90>] ? rest_init+0x60/0x60
[    0.184000] ================================================================================

-- 
Meelis Roos (mroos@linux.ee)
