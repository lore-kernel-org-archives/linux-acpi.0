From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Some memory leak reported by kmemleak
Date: Thu, 5 Mar 2015 12:09:22 +0100
Message-ID: <54F83962.3030408@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:42946 "EHLO
	mail.bmw-carit.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422AbbCELJc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Mar 2015 06:09:32 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

I just did some kmemleak run on my test hardware and I got 
some reports mentioning ACPI. I hope I got the right persons and
list.

This is based on 4.0.0-rc2+ 6587457b4b3

unreferenced object 0xffff881fafcbdce0 (size 32):
  comm "swapper/0", pid 1, jiffies 4294671332 (age 4303.330s)
  hex dump (first 32 bytes):
    20 dd cb af 1f 88 ff ff 00 dd cb af 1f 88 ff ff   ...............
    00 00 2d bd 00 00 00 00 04 00 2d bd 00 00 00 00  ..-.......-.....
  backtrace:
    [<ffffffff8176b31e>] kmemleak_alloc+0x4e/0xc0
    [<ffffffff811f99cc>] kmem_cache_alloc_trace+0x1dc/0x260
    [<ffffffff81451283>] apei_res_add+0xc3/0x120
    [<ffffffff814513c2>] collect_res_callback+0xa2/0xc0
    [<ffffffff81450e78>] apei_exec_for_each_entry+0x78/0xc0
    [<ffffffff81450efa>] apei_exec_collect_resources+0x1a/0x20
    [<ffffffff81d89b9b>] erst_init+0xfd/0x314
    [<ffffffff81002148>] do_one_initcall+0xd8/0x210
    [<ffffffff81d411dd>] kernel_init_freeable+0x192/0x22e
    [<ffffffff81767abe>] kernel_init+0xe/0xf0
    [<ffffffff817786fc>] ret_from_fork+0x7c/0xb0
    [<ffffffffffffffff>] 0xffffffffffffffff
unreferenced object 0xffff881fafcbdd20 (size 32):
  comm "swapper/0", pid 1, jiffies 4294671332 (age 4303.330s)
  hex dump (first 32 bytes):
    98 bd f0 b2 1f 88 ff ff e0 dc cb af 1f 88 ff ff  ................
    0c 00 2d bd 00 00 00 00 17 00 2d bd 00 00 00 00  ..-.......-.....
  backtrace:
    [<ffffffff8176b31e>] kmemleak_alloc+0x4e/0xc0
    [<ffffffff811f99cc>] kmem_cache_alloc_trace+0x1dc/0x260
    [<ffffffff81451283>] apei_res_add+0xc3/0x120
    [<ffffffff814513c2>] collect_res_callback+0xa2/0xc0
    [<ffffffff81450e78>] apei_exec_for_each_entry+0x78/0xc0
    [<ffffffff81450efa>] apei_exec_collect_resources+0x1a/0x20
    [<ffffffff81d89b9b>] erst_init+0xfd/0x314
    [<ffffffff81002148>] do_one_initcall+0xd8/0x210
    [<ffffffff81d411dd>] kernel_init_freeable+0x192/0x22e
    [<ffffffff81767abe>] kernel_init+0xe/0xf0
    [<ffffffff817786fc>] ret_from_fork+0x7c/0xb0
    [<ffffffffffffffff>] 0xffffffffffffffff
unreferenced object 0xffff881fafcbdd40 (size 32):
  comm "swapper/0", pid 1, jiffies 4294671332 (age 4303.330s)
  hex dump (first 32 bytes):
    a8 bd f0 b2 1f 88 ff ff a8 bd f0 b2 1f 88 ff ff  ................
    b2 00 00 00 00 00 00 00 b3 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8176b31e>] kmemleak_alloc+0x4e/0xc0
    [<ffffffff811f99cc>] kmem_cache_alloc_trace+0x1dc/0x260
    [<ffffffff81451283>] apei_res_add+0xc3/0x120
    [<ffffffff814513a8>] collect_res_callback+0x88/0xc0
    [<ffffffff81450e78>] apei_exec_for_each_entry+0x78/0xc0
    [<ffffffff81450efa>] apei_exec_collect_resources+0x1a/0x20
    [<ffffffff81d89b9b>] erst_init+0xfd/0x314
    [<ffffffff81002148>] do_one_initcall+0xd8/0x210
    [<ffffffff81d411dd>] kernel_init_freeable+0x192/0x22e
    [<ffffffff81767abe>] kernel_init+0xe/0xf0
    [<ffffffff817786fc>] ret_from_fork+0x7c/0xb0
    [<ffffffffffffffff>] 0xffffffffffffffff
unreferenced object 0xffff881fafcbdd00 (size 32):
  comm "swapper/0", pid 1, jiffies 4294671332 (age 4303.330s)
  hex dump (first 32 bytes):
    e0 dc cb af 1f 88 ff ff 98 bd f0 b2 1f 88 ff ff  ................
    71 00 2d bd 00 00 00 00 7d 00 2d bd 00 00 00 00  q.-.....}.-.....
  backtrace:
    [<ffffffff8176b31e>] kmemleak_alloc+0x4e/0xc0
    [<ffffffff811f99cc>] kmem_cache_alloc_trace+0x1dc/0x260
    [<ffffffff81451283>] apei_res_add+0xc3/0x120
    [<ffffffff814513c2>] collect_res_callback+0xa2/0xc0
    [<ffffffff81450e78>] apei_exec_for_each_entry+0x78/0xc0
    [<ffffffff81450efa>] apei_exec_collect_resources+0x1a/0x20
    [<ffffffff81d89b9b>] erst_init+0xfd/0x314
    [<ffffffff81002148>] do_one_initcall+0xd8/0x210
    [<ffffffff81d411dd>] kernel_init_freeable+0x192/0x22e
    [<ffffffff81767abe>] kernel_init+0xe/0xf0
    [<ffffffff817786fc>] ret_from_fork+0x7c/0xb0
    [<ffffffffffffffff>] 0xffffffffffffffff
unreferenced object 0xffff881fafcbdd60 (size 32):
  comm "swapper/0", pid 1, jiffies 4294671332 (age 4303.349s)
  hex dump (first 32 bytes):
    28 bd f0 b2 1f 88 ff ff 28 bd f0 b2 1f 88 ff ff  (.......(.......
    00 00 00 e0 00 00 00 00 00 00 00 f0 00 00 00 00  ................
  backtrace:
    [<ffffffff8176b31e>] kmemleak_alloc+0x4e/0xc0
    [<ffffffff811f99cc>] kmem_cache_alloc_trace+0x1dc/0x260
    [<ffffffff81451283>] apei_res_add+0xc3/0x120
    [<ffffffff8145131a>] apei_get_res_callback+0x1a/0x20
    [<ffffffff81636e64>] pci_mmcfg_for_each_region+0x54/0x80
    [<ffffffff814519ae>] apei_resources_request+0xce/0x320
    [<ffffffff81d89bb1>] erst_init+0x113/0x314
    [<ffffffff81002148>] do_one_initcall+0xd8/0x210
    [<ffffffff81d411dd>] kernel_init_freeable+0x192/0x22e
    [<ffffffff81767abe>] kernel_init+0xe/0xf0
    [<ffffffff817786fc>] ret_from_fork+0x7c/0xb0
    [<ffffffffffffffff>] 0xffffffffffffffff
unreferenced object 0xffff887fb33ec000 (size 8192):
  comm "kworker/0:0", pid 4, jiffies 4294673526 (age 4301.169s)
  hex dump (first 32 bytes):
    00 82 e8 ae 1f 88 ff ff 80 82 e8 ae 1f 88 ff ff  ................
    00 83 e8 ae 1f 88 ff ff 80 83 e8 ae 1f 88 ff ff  ................
  backtrace:
    [<ffffffff8176b31e>] kmemleak_alloc+0x4e/0xc0
    [<ffffffff811fa3fc>] __kmalloc+0x20c/0x2d0
    [<ffffffffa0069bff>] megasas_alloc_cmds_fusion+0x1cf/0x6f0 [megaraid_sas]
    [<ffffffffa006abe0>] megasas_init_adapter_fusion+0x140/0x5a0 [megaraid_sas]
    [<ffffffffa0067590>] megasas_probe_one+0x9e0/0x1a00 [megaraid_sas]
    [<ffffffff813de065>] local_pci_probe+0x45/0xa0
    [<ffffffff810afcb8>] work_for_cpu_fn+0x18/0x30
    [<ffffffff810b2feb>] process_one_work+0x14b/0x400
    [<ffffffff810b3b2c>] worker_thread+0x1bc/0x470
    [<ffffffff810b8878>] kthread+0xd8/0xf0
    [<ffffffff817786fc>] ret_from_fork+0x7c/0xb0
    [<ffffffffffffffff>] 0xffffffffffffffff
unreferenced object 0xffff887fae847ab0 (size 72):
  comm "systemd-udevd", pid 1342, jiffies 4294685829 (age 4288.978s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 0e 03 01 00 04 00 00 00  ................
    00 96 e2 ae 7f 88 ff ff 42 00 00 00 00 00 00 00  ........B.......
  backtrace:
    [<ffffffff8176b31e>] kmemleak_alloc+0x4e/0xc0
    [<ffffffff811f9770>] kmem_cache_alloc+0x1d0/0x250
    [<ffffffff8144722a>] acpi_ut_allocate_object_desc_dbg+0x40/0x6d
    [<ffffffff814472ca>] acpi_ut_create_internal_object_dbg+0x25/0x8a
    [<ffffffff814473f4>] acpi_ut_create_buffer_object+0x2a/0x81
    [<ffffffff81433c3f>] acpi_ex_write_data_to_field+0x12c/0x217
    [<ffffffff81437e9e>] acpi_ex_store_object_to_node+0xc1/0xf1
    [<ffffffff81437fa0>] acpi_ex_store+0xd2/0x273
    [<ffffffff814353f3>] acpi_ex_opcode_1A_1T_1R+0x3ed/0x526
    [<ffffffff8142d0c9>] acpi_ds_exec_end_op+0xd0/0x3ef
    [<ffffffff8143faeb>] acpi_ps_parse_loop+0x531/0x597
    [<ffffffff814405f6>] acpi_ps_parse_aml+0x99/0x271
    [<ffffffff81440e30>] acpi_ps_execute_method+0x1c0/0x264
    [<ffffffff8143b483>] acpi_ns_evaluate+0x1c3/0x24f
    [<ffffffff8143df2a>] acpi_evaluate_object+0x14b/0x25b
    [<ffffffffa017af81>] read_capabilities+0x71/0x260 [acpi_power_meter]
unreferenced object 0xffff887faee29600 (size 96):
  comm "systemd-udevd", pid 1342, jiffies 4294685829 (age 4289.079s)
  hex dump (first 32 bytes):
    00 04 00 ea 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8176b31e>] kmemleak_alloc+0x4e/0xc0
    [<ffffffff811fa3fc>] __kmalloc+0x20c/0x2d0
    [<ffffffff81447036>] acpi_os_allocate_zeroed+0x35/0x37
    [<ffffffff8144740b>] acpi_ut_create_buffer_object+0x41/0x81
    [<ffffffff81433c3f>] acpi_ex_write_data_to_field+0x12c/0x217
    [<ffffffff81437e9e>] acpi_ex_store_object_to_node+0xc1/0xf1
    [<ffffffff81437fa0>] acpi_ex_store+0xd2/0x273
    [<ffffffff814353f3>] acpi_ex_opcode_1A_1T_1R+0x3ed/0x526
    [<ffffffff8142d0c9>] acpi_ds_exec_end_op+0xd0/0x3ef
    [<ffffffff8143faeb>] acpi_ps_parse_loop+0x531/0x597
    [<ffffffff814405f6>] acpi_ps_parse_aml+0x99/0x271
    [<ffffffff81440e30>] acpi_ps_execute_method+0x1c0/0x264
    [<ffffffff8143b483>] acpi_ns_evaluate+0x1c3/0x24f
    [<ffffffff8143df2a>] acpi_evaluate_object+0x14b/0x25b
    [<ffffffffa017af81>] read_capabilities+0x71/0x260 [acpi_power_meter]
    [<ffffffffa017b4b5>] acpi_power_meter_add+0xe5/0x16a [acpi_power_meter]
