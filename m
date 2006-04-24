From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: LG-81 kernel fault in ACPI when over-temperature
Date: Mon, 24 Apr 2006 10:27:42 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD13D3AD8@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33365 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751491AbWDXC14 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 23 Apr 2006 22:27:56 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Roger Lucas <roger@planbit.co.uk>, linux-acpi@vger.kernel.org

Interesting! Could you file a bug on bugzilla.kernel.org?
Also please file all necessary information.

Does it work before?

Thanks,
Luming=20

>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org=20
>[mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Roger Lucas
>Sent: 2006=C4=EA4=D4=C224=C8=D5 0:29
>To: linux-acpi@vger.kernel.org
>Subject: LG-81 kernel fault in ACPI when over-temperature
>
>All,
>
>I am setting up an Abit LG-81 motherboard with a 2.8GHz Inter=20
>Celeron CPU.
>The motherboard uses the W83627EHG sensors chip for fan,=20
>voltage and thermal
>monitoring.
>
>I have download, compiled and installed the latest 2.6.16.9 kernel fro=
m
>kernel.org and all seemed to be OK.  I could read the sensors=20
>information
>from the W83627EHG chip using the lm-sensors system with its W83627EHF
>driver (which is compatible, the 'EHG is just a lead-free=20
>variant) and the
>"sensors" utility.
>
>The current temperatures on the board are:
>	SYS	31C
>	CPU	48C
>	PSU	43C
>
>All seems fine.  I then tweaked the sensors.conf file to change the fa=
n
>limts and temperature limits to check the alarms would get set=20
>correctly.
>When I artifically created a CPU over-temperature condition by=20
>setting the
>CPU high temperature threshold at just 40C, two things=20
>happended.  Firstly,
>I got a kernel dump for one of the ACPI processes.  Secondly,=20
>the machine
>ran unbelievably slowly until I changed the CPU high=20
>temperature limit back
>to a more reasonable 65C.
>
>The kernel dump is below:
>
>Pid: 9, comm:               kacpid
>EIP: 0060:[<c02351c9>] CPU: 0
>EIP is at acpi_ps_parse_loop+0x3b5/0x8c0
> EFLAGS: 00000283    Not tainted  (2.6.16.9.rwl4rwl #1)
>EAX: 00000000 EBX: de5ed000 ECX: dd0ac330 EDX: c0226a73
>ESI: de5ed1ec EDI: 00000000 EBP: e000c7a7 DS: 007b ES: 007b
>CR0: 8005003b CR2: 080ee808 CR3: 1f4bf000 CR4: 000006d0
> [<c0234c6d>] acpi_ps_parse_aml+0x4e/0x1f5
> [<c0235cec>] acpi_ps_execute_pass+0x72/0x86
> [<c0235c12>] acpi_ps_execute_method+0x54/0x7e
> [<c0233100>] acpi_ns_execute_control_method+0x56/0x63
> [<c0233096>] acpi_ns_evaluate_by_handle+0x74/0x88
> [<c0232f95>] acpi_ns_evaluate_relative+0xa9/0xc5
> [<c0232865>] acpi_evaluate_object+0x139/0x1fc
> [<c02252fc>] acpi_os_release_object+0xd/0x12
> [<c023b1df>] acpi_ut_acquire_mutex+0x2e/0x67
> [<c0225643>] acpi_evaluate_integer+0x6b/0x93
> [<e0033025>] acpi_thermal_get_temperature+0x25/0x36 [thermal]
> [<e003360c>] acpi_thermal_check+0x21/0x232 [thermal]
> [<e0034050>] acpi_thermal_notify+0x47/0x93 [thermal]
> [<c0229b51>] acpi_ev_notify_dispatch+0x57/0x64
> [<c022506b>] acpi_os_execute_deferred+0xe/0x1b
> [<c0125c3f>] run_workqueue+0x5f/0xc0
> [<c022505d>] acpi_os_execute_deferred+0x0/0x1b
> [<c0125dc9>] worker_thread+0x129/0x150
> [<c01152a0>] default_wake_function+0x0/0x20
> [<c01152a0>] default_wake_function+0x0/0x20
> [<c0125ca0>] worker_thread+0x0/0x150
> [<c0128a67>] kthread+0xa7/0xb0
> [<c01289c0>] kthread+0x0/0xb0
> [<c010133d>] kernel_thread_helper+0x5/0x18
>BUG: soft lockup detected on CPU#0!
>
>Pid: 9, comm:               kacpid
>EIP: 0060:[<c0226e8f>] CPU: 0
>EIP is at acpi_ds_exec_end_op+0x303/0x370
> EFLAGS: 00000246    Not tainted  (2.6.16.9.rwl4rwl #1)
>EAX: c0352ce0 EBX: 00000000 ECX: 00000000 EDX: 00000002
>ESI: de5ed000 EDI: dd0ac330 EBP: 0000000d DS: 007b ES: 007b
>CR0: 8005003b CR2: 08110188 CR3: 1e165000 CR4: 000006d0
> [<c02353c7>] acpi_ps_parse_loop+0x5b3/0x8c0
> [<c0234c6d>] acpi_ps_parse_aml+0x4e/0x1f5
> [<c0235cec>] acpi_ps_execute_pass+0x72/0x86
> [<c0235c12>] acpi_ps_execute_method+0x54/0x7e
> [<c0233100>] acpi_ns_execute_control_method+0x56/0x63
> [<c0233096>] acpi_ns_evaluate_by_handle+0x74/0x88
> [<c0232f95>] acpi_ns_evaluate_relative+0xa9/0xc5
> [<c0232865>] acpi_evaluate_object+0x139/0x1fc
> [<c0225643>] acpi_evaluate_integer+0x6b/0x93
> [<e0033025>] acpi_thermal_get_temperature+0x25/0x36 [thermal]
> [<e003360c>] acpi_thermal_check+0x21/0x232 [thermal]
> [<e0034050>] acpi_thermal_notify+0x47/0x93 [thermal]
> [<c0229b51>] acpi_ev_notify_dispatch+0x57/0x64
> [<c022506b>] acpi_os_execute_deferred+0xe/0x1b
> [<c0125c3f>] run_workqueue+0x5f/0xc0
> [<c022505d>] acpi_os_execute_deferred+0x0/0x1b
> [<c0125dc9>] worker_thread+0x129/0x150
> [<c01152a0>] default_wake_function+0x0/0x20
> [<c01152a0>] default_wake_function+0x0/0x20
> [<c0125ca0>] worker_thread+0x0/0x150
> [<c0128a67>] kthread+0xa7/0xb0
> [<c01289c0>] kthread+0x0/0xb0
> [<c010133d>] kernel_thread_helper+0x5/0x18
>BUG: soft lockup detected on CPU#0!
>
>Pid: 9, comm:               kacpid
>EIP: 0060:[<c0224d5c>] CPU: 0
>EIP is at acpi_os_write_port+0x22/0x30
> EFLAGS: 00000246    Not tainted  (2.6.16.9.rwl4rwl #1)
>EAX: 00000000 EBX: 00000008 ECX: 00000008 EDX: 00000296
>ESI: df609c78 EDI: c147031c EBP: c14702f4 DS: 007b ES: 007b
>CR0: 8005003b CR2: b7efde20 CR3: 1c873000 CR4: 000006d0
> [<c02300c5>] acpi_ex_system_io_space_handler+0x40/0x4e
> [<c0230085>] acpi_ex_system_io_space_handler+0x0/0x4e
> [<c0230085>] acpi_ex_system_io_space_handler+0x0/0x4e
> [<c0229126>] acpi_ev_address_space_dispatch+0x15a/0x1a2
> [<c022d088>] acpi_ex_access_region+0x4b/0xad
> [<c022d22a>] acpi_ex_field_datum_io+0x107/0x18f
> [<c022d3b0>] acpi_ex_write_with_update_rule+0xfe/0x109
> [<c022d871>] acpi_ex_insert_into_field+0x283/0x28e
> [<c022be5a>] acpi_ex_write_data_to_field+0x1d7/0x1fd
> [<c02304b3>] acpi_ex_store_object_to_node+0x6a/0xa7
> [<c0230235>] acpi_ex_store+0x4a/0x132
> [<c022de94>] acpi_ex_opcode_1A_1T_1R+0x4c8/0x651
> [<c022e9e7>] acpi_ex_resolve_operands+0x26b/0x4c0
> [<c0226c48>] acpi_ds_exec_end_op+0xbc/0x370
> [<c02353c7>] acpi_ps_parse_loop+0x5b3/0x8c0
> [<c0234c6d>] acpi_ps_parse_aml+0x4e/0x1f5
> [<c0235cec>] acpi_ps_execute_pass+0x72/0x86
> [<c0235c12>] acpi_ps_execute_method+0x54/0x7e
> [<c0233100>] acpi_ns_execute_control_method+0x56/0x63
> [<c0233096>] acpi_ns_evaluate_by_handle+0x74/0x88
> [<c0232f95>] acpi_ns_evaluate_relative+0xa9/0xc5
> [<c0232865>] acpi_evaluate_object+0x139/0x1fc
> [<c0103d7a>] common_interrupt+0x1a/0x20
> [<c0225643>] acpi_evaluate_integer+0x6b/0x93
> [<e0033025>] acpi_thermal_get_temperature+0x25/0x36 [thermal]
> [<e003360c>] acpi_thermal_check+0x21/0x232 [thermal]
> [<e0034050>] acpi_thermal_notify+0x47/0x93 [thermal]
> [<c0229b51>] acpi_ev_notify_dispatch+0x57/0x64
> [<c022506b>] acpi_os_execute_deferred+0xe/0x1b
> [<c0125c3f>] run_workqueue+0x5f/0xc0
> [<c022505d>] acpi_os_execute_deferred+0x0/0x1b
> [<c0125dc9>] worker_thread+0x129/0x150
> [<c01152a0>] default_wake_function+0x0/0x20
> [<c01152a0>] default_wake_function+0x0/0x20
> [<c0125ca0>] worker_thread+0x0/0x150
> [<c0128a67>] kthread+0xa7/0xb0
> [<c01289c0>] kthread+0x0/0xb0
> [<c010133d>] kernel_thread_helper+0x5/0x18
>BUG: soft lockup detected on CPU#0!
>
>Pid: 9, comm:               kacpid
>EIP: 0060:[<c0224d5c>] CPU: 0
>EIP is at acpi_os_write_port+0x22/0x30
> EFLAGS: 00000246    Not tainted  (2.6.16.9.rwl4rwl #1)
>EAX: 0000004e EBX: 00000008 ECX: 00000008 EDX: 00000295
>ESI: df609c78 EDI: c147031c EBP: c14702f4 DS: 007b ES: 007b
>CR0: 8005003b CR2: b7f17cc0 CR3: 1c873000 CR4: 000006d0
> [<c02300c5>] acpi_ex_system_io_space_handler+0x40/0x4e
> [<c0230085>] acpi_ex_system_io_space_handler+0x0/0x4e
> [<c0230085>] acpi_ex_system_io_space_handler+0x0/0x4e
> [<c0229126>] acpi_ev_address_space_dispatch+0x15a/0x1a2
> [<c022d088>] acpi_ex_access_region+0x4b/0xad
> [<c022d22a>] acpi_ex_field_datum_io+0x107/0x18f
> [<c022d3b0>] acpi_ex_write_with_update_rule+0xfe/0x109
> [<c022d871>] acpi_ex_insert_into_field+0x283/0x28e
> [<c022be5a>] acpi_ex_write_data_to_field+0x1d7/0x1fd
> [<c02304b3>] acpi_ex_store_object_to_node+0x6a/0xa7
> [<c0230235>] acpi_ex_store+0x4a/0x132
> [<c022de94>] acpi_ex_opcode_1A_1T_1R+0x4c8/0x651
> [<c022e9e7>] acpi_ex_resolve_operands+0x26b/0x4c0
> [<c0226c48>] acpi_ds_exec_end_op+0xbc/0x370
> [<c02353c7>] acpi_ps_parse_loop+0x5b3/0x8c0
> [<c0234c6d>] acpi_ps_parse_aml+0x4e/0x1f5
> [<c0235cec>] acpi_ps_execute_pass+0x72/0x86
> [<c0235c12>] acpi_ps_execute_method+0x54/0x7e
> [<c0233100>] acpi_ns_execute_control_method+0x56/0x63
> [<c0233096>] acpi_ns_evaluate_by_handle+0x74/0x88
> [<c0232f95>] acpi_ns_evaluate_relative+0xa9/0xc5
> [<c0232865>] acpi_evaluate_object+0x139/0x1fc
> [<c02252fc>] acpi_os_release_object+0xd/0x12
> [<c023b1df>] acpi_ut_acquire_mutex+0x2e/0x67
> [<c0225643>] acpi_evaluate_integer+0x6b/0x93
> [<e0033025>] acpi_thermal_get_temperature+0x25/0x36 [thermal]
> [<e003360c>] acpi_thermal_check+0x21/0x232 [thermal]
> [<e0034050>] acpi_thermal_notify+0x47/0x93 [thermal]
> [<c0229b51>] acpi_ev_notify_dispatch+0x57/0x64
> [<c022506b>] acpi_os_execute_deferred+0xe/0x1b
> [<c0125c3f>] run_workqueue+0x5f/0xc0
> [<c022505d>] acpi_os_execute_deferred+0x0/0x1b
> [<c0125dc9>] worker_thread+0x129/0x150
> [<c01152a0>] default_wake_function+0x0/0x20
> [<c01152a0>] default_wake_function+0x0/0x20
> [<c0125ca0>] worker_thread+0x0/0x150
> [<c0128a67>] kthread+0xa7/0xb0
> [<c01289c0>] kthread+0x0/0xb0
> [<c010133d>] kernel_thread_helper+0x5/0x18
>BUG: soft lockup detected on CPU#0!
>
>Pid: 9, comm:               kacpid
>EIP: 0060:[<c014c03c>] CPU: 0
>EIP is at kmem_cache_free+0xc/0x40
> EFLAGS: 00000202    Not tainted  (2.6.16.9.rwl4rwl #1)
>EAX: dd0ac368 EBX: dd0ac368 ECX: 00000000 EDX: df7e7640
>ESI: 00000000 EDI: dd0ac368 EBP: dd0ac368 DS: 007b ES: 007b
>CR0: 8005003b CR2: b7f4b000 CR3: 1e43b000 CR4: 000006d0
> [<c02252fc>] acpi_os_release_object+0xd/0x12
> [<c0235a48>] acpi_ps_free_op+0x1f/0x22
> [<c02357bc>] acpi_ps_delete_parse_tree+0x34/0x4c
> [<c0234b00>] acpi_ps_complete_this_op+0x141/0x156
> [<c0235407>] acpi_ps_parse_loop+0x5f3/0x8c0
> [<c0234c6d>] acpi_ps_parse_aml+0x4e/0x1f5
> [<c0235cec>] acpi_ps_execute_pass+0x72/0x86
> [<c0235c12>] acpi_ps_execute_method+0x54/0x7e
> [<c0233100>] acpi_ns_execute_control_method+0x56/0x63
> [<c0233096>] acpi_ns_evaluate_by_handle+0x74/0x88
> [<c0232f95>] acpi_ns_evaluate_relative+0xa9/0xc5
> [<c0232865>] acpi_evaluate_object+0x139/0x1fc
> [<c0225643>] acpi_evaluate_integer+0x6b/0x93
> [<e0033025>] acpi_thermal_get_temperature+0x25/0x36 [thermal]
> [<e003360c>] acpi_thermal_check+0x21/0x232 [thermal]
> [<e0034050>] acpi_thermal_notify+0x47/0x93 [thermal]
> [<c0229b51>] acpi_ev_notify_dispatch+0x57/0x64
> [<c022506b>] acpi_os_execute_deferred+0xe/0x1b
> [<c0125c3f>] run_workqueue+0x5f/0xc0
> [<c022505d>] acpi_os_execute_deferred+0x0/0x1b
> [<c0125dc9>] worker_thread+0x129/0x150
> [<c01152a0>] default_wake_function+0x0/0x20
> [<c01152a0>] default_wake_function+0x0/0x20
> [<c0125ca0>] worker_thread+0x0/0x150
> [<c0128a67>] kthread+0xa7/0xb0
> [<c01289c0>] kthread+0x0/0xb0
> [<c010133d>] kernel_thread_helper+0x5/0x18
>
>
>
>If I removed the "thermal" module and repeated the above=20
>temperature test, I
>got no kernel dump but I still got the very slow running of the system=
=2E
>According to some comments on the WWW, however, removing the=20
>thermal ACPI
>modules is not recommended.
>
>When I rebooted the system with "acpi=3Doff" and repeated the above
>temperature test, I got no kernel dump nor did the system run=20
>slowly.  I
>did, however, get a beeping sound from the motherboard when it=20
>thought the
>CPU was over-temperature.
>
>There was a recommendation from the lm-sensors team that I disable the
>"OVT#" and "SMI#" outputs from the W83627EHG chip.  I modified=20
>the driver to
>(I think) make this change in accordance with the datasheet,=20
>but it didn't
>make any difference - I still got the kernel dump if the ACPI "thermal=
"
>process was running.
>
>Can anyone shed any light on what is happening here ?
>
>Thanks,
>
>Roger
>
>-
>To unsubscribe from this list: send the line "unsubscribe=20
>linux-acpi" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
