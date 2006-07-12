From: "Brown, Len" <len.brown@intel.com>
Subject: RE: kacpi_notify?
Date: Wed, 12 Jul 2006 16:51:16 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6F7627D@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:5130 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751230AbWGLUvV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jul 2006 16:51:21 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>

 
>With ctrl+scrolllock, I finally got something. The traceback for the 
>D-state (millions and millions of them) is
>
>	__down_failed
>	acpi_ut_acquire_mutex
>	acpi_ex_enter_interpreter
>	acpi_ns_evaluate
>	acpi_evaluate_object
>	acpi_evaluate_integer
>	acpi_os_execute_thread
>	acpi_thermal_get_temperature
>	acpi_thermal_check
>	..
>
>and 'kacpid' seems to be stuck using all CPU time, with the 
>thing doing 
>something like:
>
>	EIP is at delay_tsc+0xb/0x13
>	 EFLAGS: 00000283    Not tainted  (2.6.18-rc1-g155dbfd8 #24)
>	EAX: 4aa48900 EBX: 00026be1 ECX: 4aa40b7e EDX: 0000001a
>	ESI: 00000000 EDI: c039300d EBP: c0390df3 DS: 007b ES: 007b
>	CR0: 8005003b CR2: 080516f0 CR3: 362dc000 CR4: 000006d0
>	 [<c01c94c0>] __delay+0x6/0x7
>	 [<c01f23ef>] acpi_os_stall+0x1d/0x29
>	 [<c0201f11>] acpi_ex_system_do_stall+0x37/0x3b
>	 [<c0200fca>] acpi_ex_opcode_1A_0T_0R+0x85/0xc8
>	 [<c01f5308>] acpi_ds_exec_end_op+0x133/0x553
>	 [<c020d0f3>] acpi_ps_parse_loop+0x777/0xbe0
>	 [<c020c488>] acpi_ps_parse_aml+0xd8/0x2d5
>	 [<c020dbbe>] acpi_ps_execute_pass+0xa9/0xd2
>	 [<c020dd6a>] acpi_ps_execute_method+0x153/0x231
>	 [<c02095e1>] acpi_ns_evaluate+0x179/0x24c
>	 [<c01fc12e>] acpi_ev_asynch_execute_gpe_method+0xeb/0x159
>	 [<c01f2083>] acpi_os_execute_deferred+0x19/0x21
>	 [<c01226a0>] run_workqueue+0x68/0x95
>	 [<c01f206a>] acpi_os_execute_deferred+0x0/0x21
>	 [<c0122b2e>] worker_thread+0xf9/0x12b
>	 [<c03570bf>] schedule+0x469/0x4cc
>	 [<c0113bfb>] default_wake_function+0x0/0xc
>	 [<c0122a35>] worker_thread+0x0/0x12b
>	 [<c01249bb>] kthread+0xad/0xd8
>	 [<c012490e>] kthread+0x0/0xd8
>	 [<c0101005>] kernel_thread_helper+0x5/0xb
>
>which I assume is the thing that holds the AML semaphore, and isn't 
>releasing it.
>
>Is there any sane debugging info I can send people?

I think you just did:-)

The os_stall part is due to interpreting AML.  If you can get the
output from acpidump, that would help us see what it is doing.
I ask most people to attach it to a new bugzilla entry,
but I don't know that you have an account:-)

Anyway, if you don't have it already, acpidump is in the latest pmtools
here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

dmesg with CONFIG_ACPI_DEBUG might be interesting too.

thanks,
-Len

