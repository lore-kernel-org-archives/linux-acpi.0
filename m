From: Daniel Walker <dwalker@mvista.com>
Subject: acpi lockdep warning.
Date: Mon, 21 Jul 2008 07:22:30 -0700
Message-ID: <1216650150.2294.30.camel@dhcp32.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:18611 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbYGUOWe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jul 2008 10:22:34 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, len.brown@intel.com, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>


Below is the only lockdep warning that I've seen.. I've booted a number
of machines without warning displayed, but one consistently has this.

I think it's due to a repeated release/re-lock of the interpreter mutex.
Where the interpreter mutex can be re-locked anyplace inside an AML
Mutex lock sequence.

Daniel

=======================================================
[ INFO: possible circular locking dependency detected ]
2.6.26 #7
-------------------------------------------------------
swapper/1 is trying to acquire lock:
 (key#5){--..}, at: [<c039d0ee>] acpi_os_acquire_mutex_nested+0x29/0x3f

but task is already holding lock:
 (key#6){--..}, at: [<c039d0ee>] acpi_os_acquire_mutex_nested+0x29/0x3f

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (key#6){--..}:
       [<c024a29a>] __lock_acquire+0xbba/0x10d0
       [<c024a810>] lock_acquire+0x60/0x80
       [<c05622b3>] mutex_lock_interruptible_nested+0x93/0x340
       [<c039d0ee>] acpi_os_acquire_mutex_nested+0x29/0x3f
       [<c03a74cd>] acpi_ex_system_wait_mutex_nested+0x11/0x3b
       [<c03a8f92>] acpi_ex_acquire_mutex_object+0x3f/0x5b
       [<c03a903f>] acpi_ex_acquire_mutex+0x91/0xe6
       [<c03a7f60>] acpi_ex_opcode_2A_0T_1R+0xb4/0x130
       [<c039f4ab>] acpi_ds_exec_end_op+0xe6/0x373
       [<c03adba5>] acpi_ps_parse_loop+0x5cd/0x720
       [<c03acfd8>] acpi_ps_parse_aml+0x6d/0x25b
       [<c03ae20d>] acpi_ps_execute_method+0x11c/0x1d7
       [<c03ab55a>] acpi_ns_evaluate+0x12e/0x188
       [<c03b0b7a>] acpi_ut_evaluate_object+0x51/0x158
       [<c03b0cf2>] acpi_ut_execute_STA+0x1d/0x49
       [<c03aaf6e>] acpi_ns_get_device_callback+0x59/0x112
       [<c03ac5fe>] acpi_ns_walk_namespace+0x9a/0x110
       [<c03aae99>] acpi_get_devices+0x47/0x5d
       [<c070c8e6>] acpi_ec_ecdt_probe+0x97/0xf7
       [<c070c403>] acpi_init+0x76/0x21f
       [<c06f638f>] kernel_init+0x19d/0x2b1
       [<c0203f13>] kernel_thread_helper+0x7/0x14
       [<ffffffff>] 0xffffffff

-> #0 (key#5){--..}:
       [<c024a30f>] __lock_acquire+0xc2f/0x10d0
       [<c024a810>] lock_acquire+0x60/0x80
       [<c05622b3>] mutex_lock_interruptible_nested+0x93/0x340
       [<c039d0ee>] acpi_os_acquire_mutex_nested+0x29/0x3f
       [<c03b2d8e>] acpi_ut_acquire_mutex+0x33/0x70
       [<c03a8d30>] acpi_ex_enter_interpreter+0xa/0x24
       [<c03a1bf4>] acpi_ev_address_space_dispatch+0xb8/0x16f
       [<c03a59ee>] acpi_ex_access_region+0x1b2/0x1c0
       [<c03a5b13>] acpi_ex_field_datum_io+0x117/0x1ae
       [<c03a5e67>] acpi_ex_write_with_update_rule+0xd5/0xde
       [<c03a6117>] acpi_ex_insert_into_field+0x2a7/0x2c4
       [<c03a4789>] acpi_ex_write_data_to_field+0x169/0x181
       [<c03a8836>] acpi_ex_store_object_to_node+0x82/0xb7
       [<c03a8a04>] acpi_ex_store+0xc9/0x221
       [<c03a6a0e>] acpi_ex_opcode_1A_1T_1R+0x3db/0x535
       [<c039f4ab>] acpi_ds_exec_end_op+0xe6/0x373
       [<c03adba5>] acpi_ps_parse_loop+0x5cd/0x720
       [<c03acfd8>] acpi_ps_parse_aml+0x6d/0x25b
       [<c03ae20d>] acpi_ps_execute_method+0x11c/0x1d7
       [<c03ab55a>] acpi_ns_evaluate+0x12e/0x188
       [<c03b0b7a>] acpi_ut_evaluate_object+0x51/0x158
       [<c03b0cf2>] acpi_ut_execute_STA+0x1d/0x49
       [<c03aaf6e>] acpi_ns_get_device_callback+0x59/0x112
       [<c03ac5fe>] acpi_ns_walk_namespace+0x9a/0x110
       [<c03aae99>] acpi_get_devices+0x47/0x5d
       [<c070c8e6>] acpi_ec_ecdt_probe+0x97/0xf7
       [<c070c403>] acpi_init+0x76/0x21f
       [<c06f638f>] kernel_init+0x19d/0x2b1
       [<c0203f13>] kernel_thread_helper+0x7/0x14
       [<ffffffff>] 0xffffffff

other info that might help us debug this:

1 lock held by swapper/1:
 #0:  (key#6){--..}, at: [<c039d0ee>] acpi_os_acquire_mutex_nested+0x29/0x3f


stack backtrace:
Pid: 1, comm: swapper Not tainted 2.6.26 #7
 [<c024946f>] print_circular_bug_tail+0x6f/0x80
 [<c024a30f>] __lock_acquire+0xc2f/0x10d0
 [<c039cebe>] ? acpi_os_validate_address+0x6b/0x98
 [<c024a810>] lock_acquire+0x60/0x80
 [<c039d0ee>] ? acpi_os_acquire_mutex_nested+0x29/0x3f
 [<c05622b3>] mutex_lock_interruptible_nested+0x93/0x340
 [<c039d0ee>] ? acpi_os_acquire_mutex_nested+0x29/0x3f
 [<c039d0ee>] ? acpi_os_acquire_mutex_nested+0x29/0x3f
 [<c039d0ee>] acpi_os_acquire_mutex_nested+0x29/0x3f
 [<c03b2d8e>] acpi_ut_acquire_mutex+0x33/0x70
 [<c03a8d30>] acpi_ex_enter_interpreter+0xa/0x24
 [<c03a1bf4>] acpi_ev_address_space_dispatch+0xb8/0x16f
 [<c03a59ee>] acpi_ex_access_region+0x1b2/0x1c0
 [<c03a5b13>] acpi_ex_field_datum_io+0x117/0x1ae
 [<c03a5e67>] acpi_ex_write_with_update_rule+0xd5/0xde
 [<c03a6117>] acpi_ex_insert_into_field+0x2a7/0x2c4
 [<c03a4789>] acpi_ex_write_data_to_field+0x169/0x181
 [<c03b29bd>] ? acpi_ut_allocate_object_desc_dbg+0x2c/0x5d
 [<c03a8836>] acpi_ex_store_object_to_node+0x82/0xb7
 [<c03a8a04>] acpi_ex_store+0xc9/0x221
 [<c03a6a0e>] acpi_ex_opcode_1A_1T_1R+0x3db/0x535
 [<c03a716c>] ? acpi_ex_resolve_operands+0x1cc/0x47c
 [<c039f4ab>] acpi_ds_exec_end_op+0xe6/0x373
 [<c03adba5>] acpi_ps_parse_loop+0x5cd/0x720
 [<c03acfd8>] acpi_ps_parse_aml+0x6d/0x25b
 [<c03ae20d>] acpi_ps_execute_method+0x11c/0x1d7
 [<c03ab55a>] acpi_ns_evaluate+0x12e/0x188
 [<c03b0b7a>] acpi_ut_evaluate_object+0x51/0x158
 [<c03b0cf2>] acpi_ut_execute_STA+0x1d/0x49
 [<c039d0c1>] ? acpi_os_release_mutex+0x15/0x19
 [<c03aaf6e>] acpi_ns_get_device_callback+0x59/0x112
 [<c0562cb8>] ? mutex_unlock+0x8/0x10
 [<c03ac5fe>] acpi_ns_walk_namespace+0x9a/0x110
 [<c03aae99>] acpi_get_devices+0x47/0x5d
 [<c03aaf15>] ? acpi_ns_get_device_callback+0x0/0x112
 [<c03b6bdf>] ? ec_parse_device+0x0/0x56
 [<c070c8e6>] acpi_ec_ecdt_probe+0x97/0xf7
 [<c070c403>] acpi_init+0x76/0x21f
 [<c070af87>] ? fbmem_init+0x47/0x89
 [<c06f638f>] kernel_init+0x19d/0x2b1
 [<c0563e5d>] ? _spin_unlock_irq+0x2d/0x50
 [<c070c38d>] ? acpi_init+0x0/0x21f
 [<c024908e>] ? trace_hardirqs_on_caller+0xfe/0x140
 [<c0341878>] ? trace_hardirqs_on_thunk+0xc/0x10
 [<c020333a>] ? restore_nocheck_notrace+0x0/0xe
 [<c06f61f2>] ? kernel_init+0x0/0x2b1
 [<c06f61f2>] ? kernel_init+0x0/0x2b1
 [<c0203f13>] kernel_thread_helper+0x7/0x14
 =======================


