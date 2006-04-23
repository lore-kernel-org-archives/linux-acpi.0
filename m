From: "Roger Lucas" <roger@planbit.co.uk>
Subject: LG-81 kernel fault in ACPI when over-temperature
Date: Sun, 23 Apr 2006 17:28:43 +0100
Message-ID: <20060423162841.A3B3512ED4@bluewhale.planbit.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 82-71-36-240.dsl.in-addr.zen.co.uk ([82.71.36.240]:61824 "EHLO
	bluewhale.planbit.co.uk") by vger.kernel.org with ESMTP
	id S1751423AbWDWQ2o (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Apr 2006 12:28:44 -0400
Received: from wolverine (unknown [192.168.1.125])
	by bluewhale.planbit.co.uk (Postfix) with ESMTP id A3B3512ED4
	for <linux-acpi@vger.kernel.org>; Sun, 23 Apr 2006 17:28:41 +0100 (BST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

All,

I am setting up an Abit LG-81 motherboard with a 2.8GHz Inter Celeron CPU.
The motherboard uses the W83627EHG sensors chip for fan, voltage and thermal
monitoring.

I have download, compiled and installed the latest 2.6.16.9 kernel from
kernel.org and all seemed to be OK.  I could read the sensors information
from the W83627EHG chip using the lm-sensors system with its W83627EHF
driver (which is compatible, the 'EHG is just a lead-free variant) and the
"sensors" utility.

The current temperatures on the board are:
	SYS	31C
	CPU	48C
	PSU	43C

All seems fine.  I then tweaked the sensors.conf file to change the fan
limts and temperature limits to check the alarms would get set correctly.
When I artifically created a CPU over-temperature condition by setting the
CPU high temperature threshold at just 40C, two things happended.  Firstly,
I got a kernel dump for one of the ACPI processes.  Secondly, the machine
ran unbelievably slowly until I changed the CPU high temperature limit back
to a more reasonable 65C.

The kernel dump is below:

Pid: 9, comm:               kacpid
EIP: 0060:[<c02351c9>] CPU: 0
EIP is at acpi_ps_parse_loop+0x3b5/0x8c0
 EFLAGS: 00000283    Not tainted  (2.6.16.9.rwl4rwl #1)
EAX: 00000000 EBX: de5ed000 ECX: dd0ac330 EDX: c0226a73
ESI: de5ed1ec EDI: 00000000 EBP: e000c7a7 DS: 007b ES: 007b
CR0: 8005003b CR2: 080ee808 CR3: 1f4bf000 CR4: 000006d0
 [<c0234c6d>] acpi_ps_parse_aml+0x4e/0x1f5
 [<c0235cec>] acpi_ps_execute_pass+0x72/0x86
 [<c0235c12>] acpi_ps_execute_method+0x54/0x7e
 [<c0233100>] acpi_ns_execute_control_method+0x56/0x63
 [<c0233096>] acpi_ns_evaluate_by_handle+0x74/0x88
 [<c0232f95>] acpi_ns_evaluate_relative+0xa9/0xc5
 [<c0232865>] acpi_evaluate_object+0x139/0x1fc
 [<c02252fc>] acpi_os_release_object+0xd/0x12
 [<c023b1df>] acpi_ut_acquire_mutex+0x2e/0x67
 [<c0225643>] acpi_evaluate_integer+0x6b/0x93
 [<e0033025>] acpi_thermal_get_temperature+0x25/0x36 [thermal]
 [<e003360c>] acpi_thermal_check+0x21/0x232 [thermal]
 [<e0034050>] acpi_thermal_notify+0x47/0x93 [thermal]
 [<c0229b51>] acpi_ev_notify_dispatch+0x57/0x64
 [<c022506b>] acpi_os_execute_deferred+0xe/0x1b
 [<c0125c3f>] run_workqueue+0x5f/0xc0
 [<c022505d>] acpi_os_execute_deferred+0x0/0x1b
 [<c0125dc9>] worker_thread+0x129/0x150
 [<c01152a0>] default_wake_function+0x0/0x20
 [<c01152a0>] default_wake_function+0x0/0x20
 [<c0125ca0>] worker_thread+0x0/0x150
 [<c0128a67>] kthread+0xa7/0xb0
 [<c01289c0>] kthread+0x0/0xb0
 [<c010133d>] kernel_thread_helper+0x5/0x18
BUG: soft lockup detected on CPU#0!

Pid: 9, comm:               kacpid
EIP: 0060:[<c0226e8f>] CPU: 0
EIP is at acpi_ds_exec_end_op+0x303/0x370
 EFLAGS: 00000246    Not tainted  (2.6.16.9.rwl4rwl #1)
EAX: c0352ce0 EBX: 00000000 ECX: 00000000 EDX: 00000002
ESI: de5ed000 EDI: dd0ac330 EBP: 0000000d DS: 007b ES: 007b
CR0: 8005003b CR2: 08110188 CR3: 1e165000 CR4: 000006d0
 [<c02353c7>] acpi_ps_parse_loop+0x5b3/0x8c0
 [<c0234c6d>] acpi_ps_parse_aml+0x4e/0x1f5
 [<c0235cec>] acpi_ps_execute_pass+0x72/0x86
 [<c0235c12>] acpi_ps_execute_method+0x54/0x7e
 [<c0233100>] acpi_ns_execute_control_method+0x56/0x63
 [<c0233096>] acpi_ns_evaluate_by_handle+0x74/0x88
 [<c0232f95>] acpi_ns_evaluate_relative+0xa9/0xc5
 [<c0232865>] acpi_evaluate_object+0x139/0x1fc
 [<c0225643>] acpi_evaluate_integer+0x6b/0x93
 [<e0033025>] acpi_thermal_get_temperature+0x25/0x36 [thermal]
 [<e003360c>] acpi_thermal_check+0x21/0x232 [thermal]
 [<e0034050>] acpi_thermal_notify+0x47/0x93 [thermal]
 [<c0229b51>] acpi_ev_notify_dispatch+0x57/0x64
 [<c022506b>] acpi_os_execute_deferred+0xe/0x1b
 [<c0125c3f>] run_workqueue+0x5f/0xc0
 [<c022505d>] acpi_os_execute_deferred+0x0/0x1b
 [<c0125dc9>] worker_thread+0x129/0x150
 [<c01152a0>] default_wake_function+0x0/0x20
 [<c01152a0>] default_wake_function+0x0/0x20
 [<c0125ca0>] worker_thread+0x0/0x150
 [<c0128a67>] kthread+0xa7/0xb0
 [<c01289c0>] kthread+0x0/0xb0
 [<c010133d>] kernel_thread_helper+0x5/0x18
BUG: soft lockup detected on CPU#0!

Pid: 9, comm:               kacpid
EIP: 0060:[<c0224d5c>] CPU: 0
EIP is at acpi_os_write_port+0x22/0x30
 EFLAGS: 00000246    Not tainted  (2.6.16.9.rwl4rwl #1)
EAX: 00000000 EBX: 00000008 ECX: 00000008 EDX: 00000296
ESI: df609c78 EDI: c147031c EBP: c14702f4 DS: 007b ES: 007b
CR0: 8005003b CR2: b7efde20 CR3: 1c873000 CR4: 000006d0
 [<c02300c5>] acpi_ex_system_io_space_handler+0x40/0x4e
 [<c0230085>] acpi_ex_system_io_space_handler+0x0/0x4e
 [<c0230085>] acpi_ex_system_io_space_handler+0x0/0x4e
 [<c0229126>] acpi_ev_address_space_dispatch+0x15a/0x1a2
 [<c022d088>] acpi_ex_access_region+0x4b/0xad
 [<c022d22a>] acpi_ex_field_datum_io+0x107/0x18f
 [<c022d3b0>] acpi_ex_write_with_update_rule+0xfe/0x109
 [<c022d871>] acpi_ex_insert_into_field+0x283/0x28e
 [<c022be5a>] acpi_ex_write_data_to_field+0x1d7/0x1fd
 [<c02304b3>] acpi_ex_store_object_to_node+0x6a/0xa7
 [<c0230235>] acpi_ex_store+0x4a/0x132
 [<c022de94>] acpi_ex_opcode_1A_1T_1R+0x4c8/0x651
 [<c022e9e7>] acpi_ex_resolve_operands+0x26b/0x4c0
 [<c0226c48>] acpi_ds_exec_end_op+0xbc/0x370
 [<c02353c7>] acpi_ps_parse_loop+0x5b3/0x8c0
 [<c0234c6d>] acpi_ps_parse_aml+0x4e/0x1f5
 [<c0235cec>] acpi_ps_execute_pass+0x72/0x86
 [<c0235c12>] acpi_ps_execute_method+0x54/0x7e
 [<c0233100>] acpi_ns_execute_control_method+0x56/0x63
 [<c0233096>] acpi_ns_evaluate_by_handle+0x74/0x88
 [<c0232f95>] acpi_ns_evaluate_relative+0xa9/0xc5
 [<c0232865>] acpi_evaluate_object+0x139/0x1fc
 [<c0103d7a>] common_interrupt+0x1a/0x20
 [<c0225643>] acpi_evaluate_integer+0x6b/0x93
 [<e0033025>] acpi_thermal_get_temperature+0x25/0x36 [thermal]
 [<e003360c>] acpi_thermal_check+0x21/0x232 [thermal]
 [<e0034050>] acpi_thermal_notify+0x47/0x93 [thermal]
 [<c0229b51>] acpi_ev_notify_dispatch+0x57/0x64
 [<c022506b>] acpi_os_execute_deferred+0xe/0x1b
 [<c0125c3f>] run_workqueue+0x5f/0xc0
 [<c022505d>] acpi_os_execute_deferred+0x0/0x1b
 [<c0125dc9>] worker_thread+0x129/0x150
 [<c01152a0>] default_wake_function+0x0/0x20
 [<c01152a0>] default_wake_function+0x0/0x20
 [<c0125ca0>] worker_thread+0x0/0x150
 [<c0128a67>] kthread+0xa7/0xb0
 [<c01289c0>] kthread+0x0/0xb0
 [<c010133d>] kernel_thread_helper+0x5/0x18
BUG: soft lockup detected on CPU#0!

Pid: 9, comm:               kacpid
EIP: 0060:[<c0224d5c>] CPU: 0
EIP is at acpi_os_write_port+0x22/0x30
 EFLAGS: 00000246    Not tainted  (2.6.16.9.rwl4rwl #1)
EAX: 0000004e EBX: 00000008 ECX: 00000008 EDX: 00000295
ESI: df609c78 EDI: c147031c EBP: c14702f4 DS: 007b ES: 007b
CR0: 8005003b CR2: b7f17cc0 CR3: 1c873000 CR4: 000006d0
 [<c02300c5>] acpi_ex_system_io_space_handler+0x40/0x4e
 [<c0230085>] acpi_ex_system_io_space_handler+0x0/0x4e
 [<c0230085>] acpi_ex_system_io_space_handler+0x0/0x4e
 [<c0229126>] acpi_ev_address_space_dispatch+0x15a/0x1a2
 [<c022d088>] acpi_ex_access_region+0x4b/0xad
 [<c022d22a>] acpi_ex_field_datum_io+0x107/0x18f
 [<c022d3b0>] acpi_ex_write_with_update_rule+0xfe/0x109
 [<c022d871>] acpi_ex_insert_into_field+0x283/0x28e
 [<c022be5a>] acpi_ex_write_data_to_field+0x1d7/0x1fd
 [<c02304b3>] acpi_ex_store_object_to_node+0x6a/0xa7
 [<c0230235>] acpi_ex_store+0x4a/0x132
 [<c022de94>] acpi_ex_opcode_1A_1T_1R+0x4c8/0x651
 [<c022e9e7>] acpi_ex_resolve_operands+0x26b/0x4c0
 [<c0226c48>] acpi_ds_exec_end_op+0xbc/0x370
 [<c02353c7>] acpi_ps_parse_loop+0x5b3/0x8c0
 [<c0234c6d>] acpi_ps_parse_aml+0x4e/0x1f5
 [<c0235cec>] acpi_ps_execute_pass+0x72/0x86
 [<c0235c12>] acpi_ps_execute_method+0x54/0x7e
 [<c0233100>] acpi_ns_execute_control_method+0x56/0x63
 [<c0233096>] acpi_ns_evaluate_by_handle+0x74/0x88
 [<c0232f95>] acpi_ns_evaluate_relative+0xa9/0xc5
 [<c0232865>] acpi_evaluate_object+0x139/0x1fc
 [<c02252fc>] acpi_os_release_object+0xd/0x12
 [<c023b1df>] acpi_ut_acquire_mutex+0x2e/0x67
 [<c0225643>] acpi_evaluate_integer+0x6b/0x93
 [<e0033025>] acpi_thermal_get_temperature+0x25/0x36 [thermal]
 [<e003360c>] acpi_thermal_check+0x21/0x232 [thermal]
 [<e0034050>] acpi_thermal_notify+0x47/0x93 [thermal]
 [<c0229b51>] acpi_ev_notify_dispatch+0x57/0x64
 [<c022506b>] acpi_os_execute_deferred+0xe/0x1b
 [<c0125c3f>] run_workqueue+0x5f/0xc0
 [<c022505d>] acpi_os_execute_deferred+0x0/0x1b
 [<c0125dc9>] worker_thread+0x129/0x150
 [<c01152a0>] default_wake_function+0x0/0x20
 [<c01152a0>] default_wake_function+0x0/0x20
 [<c0125ca0>] worker_thread+0x0/0x150
 [<c0128a67>] kthread+0xa7/0xb0
 [<c01289c0>] kthread+0x0/0xb0
 [<c010133d>] kernel_thread_helper+0x5/0x18
BUG: soft lockup detected on CPU#0!

Pid: 9, comm:               kacpid
EIP: 0060:[<c014c03c>] CPU: 0
EIP is at kmem_cache_free+0xc/0x40
 EFLAGS: 00000202    Not tainted  (2.6.16.9.rwl4rwl #1)
EAX: dd0ac368 EBX: dd0ac368 ECX: 00000000 EDX: df7e7640
ESI: 00000000 EDI: dd0ac368 EBP: dd0ac368 DS: 007b ES: 007b
CR0: 8005003b CR2: b7f4b000 CR3: 1e43b000 CR4: 000006d0
 [<c02252fc>] acpi_os_release_object+0xd/0x12
 [<c0235a48>] acpi_ps_free_op+0x1f/0x22
 [<c02357bc>] acpi_ps_delete_parse_tree+0x34/0x4c
 [<c0234b00>] acpi_ps_complete_this_op+0x141/0x156
 [<c0235407>] acpi_ps_parse_loop+0x5f3/0x8c0
 [<c0234c6d>] acpi_ps_parse_aml+0x4e/0x1f5
 [<c0235cec>] acpi_ps_execute_pass+0x72/0x86
 [<c0235c12>] acpi_ps_execute_method+0x54/0x7e
 [<c0233100>] acpi_ns_execute_control_method+0x56/0x63
 [<c0233096>] acpi_ns_evaluate_by_handle+0x74/0x88
 [<c0232f95>] acpi_ns_evaluate_relative+0xa9/0xc5
 [<c0232865>] acpi_evaluate_object+0x139/0x1fc
 [<c0225643>] acpi_evaluate_integer+0x6b/0x93
 [<e0033025>] acpi_thermal_get_temperature+0x25/0x36 [thermal]
 [<e003360c>] acpi_thermal_check+0x21/0x232 [thermal]
 [<e0034050>] acpi_thermal_notify+0x47/0x93 [thermal]
 [<c0229b51>] acpi_ev_notify_dispatch+0x57/0x64
 [<c022506b>] acpi_os_execute_deferred+0xe/0x1b
 [<c0125c3f>] run_workqueue+0x5f/0xc0
 [<c022505d>] acpi_os_execute_deferred+0x0/0x1b
 [<c0125dc9>] worker_thread+0x129/0x150
 [<c01152a0>] default_wake_function+0x0/0x20
 [<c01152a0>] default_wake_function+0x0/0x20
 [<c0125ca0>] worker_thread+0x0/0x150
 [<c0128a67>] kthread+0xa7/0xb0
 [<c01289c0>] kthread+0x0/0xb0
 [<c010133d>] kernel_thread_helper+0x5/0x18



If I removed the "thermal" module and repeated the above temperature test, I
got no kernel dump but I still got the very slow running of the system.
According to some comments on the WWW, however, removing the thermal ACPI
modules is not recommended.

When I rebooted the system with "acpi=off" and repeated the above
temperature test, I got no kernel dump nor did the system run slowly.  I
did, however, get a beeping sound from the motherboard when it thought the
CPU was over-temperature.

There was a recommendation from the lm-sensors team that I disable the
"OVT#" and "SMI#" outputs from the W83627EHG chip.  I modified the driver to
(I think) make this change in accordance with the datasheet, but it didn't
make any difference - I still got the kernel dump if the ACPI "thermal"
process was running.

Can anyone shed any light on what is happening here ?

Thanks,

Roger

