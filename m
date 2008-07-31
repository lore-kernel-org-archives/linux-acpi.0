From: daniel@visp.name (c)
Subject: PROBLEM: Computer hangs when closing lid on my HP 6510b
Date: Thu, 31 Jul 2008 13:04:40 +0200
Message-ID: <20080731110440.GA3752@s.zortor.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_uD/j1rpSj0NGc0xbApAImg)"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from osl1smout1.broadpark.no ([80.202.4.58]:43814 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbYGaLFH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Jul 2008 07:05:07 -0400
Content-disposition: inline
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0K4V00LG7ASG1Y60@osl1smout1.broadpark.no> for
 linux-acpi@vger.kernel.org; Thu, 31 Jul 2008 13:05:04 +0200 (CEST)
Received: from s.zortor.local ([84.49.120.94]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0K4V004RCAS4EKX2@osl1sminn1.broadpark.no> for
 linux-acpi@vger.kernel.org; Thu, 31 Jul 2008 13:05:04 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org


--Boundary_(ID_uD/j1rpSj0NGc0xbApAImg)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline

This is my first bugreport, so please dont chop my head off :)
Sections are numbered as described in the REPORTING-BUGS file.

[1.]
	Computer hangs when closing lid on my HP 6510b

[2.]
	When closing the lid on my HP 6510b, the computer hangs.
	I managed to get some kernelmessages out via netconsole.
	I believe the bug is somewhere in kacpid.

[3.]
	kacpid, oops, HP 6510b

[4.1]
	Linux version 2.6.26 (root@barney) (gcc version 4.3.1 (Debian 4.3.1-2) ) #1 SMP PREEMPT Sun Jul 27 23:38:38 CEST 2008

[4.2]
	Kernel configuration is sent as an attachment

[6.]
	Kernel output 1
		
		SysRq : Changing Loglevel
		Loglevel set to 9
		BUG: unable to handle kernel paging request at ffff8100bf0d6780
		IP:ACPI Error (exregion-0107): Invalid SystemMemory width 256 [20080321]
		BUG: unable to handle kernel <3>BUG: scheduling while atomic: kacpid/160/0x00000104
		Pid: 160, comm: kacpid Not tainted 2.6.26 #1
		
		Call Trace:
		 [<ffffffff807e3980>] thread_return+0xfd/0x5bd
		 [<ffffffff8040b751>] acpi_ut_allocate_object_desc_dbg+0x34/0x6d
		 [<ffffffff802464f4>] lock_timer_base+0x34/0x70
		 [<ffffffff802466e0>] __mod_timer+0xb0/0xd0
		BUG: unable to handle kernel paging request [<ffffffff807e4129>] schedule_timeout+0x79/0xf0
		 at ffff8100bf2db6b0
		IP: [<ffffffff [<bfff8f02bfb6bb6b0>]
		
		 [<ffffffff803ff614>] acpi_ex_system_do_suspend+0x11/0x1a
		 [<ffffffff803f6ca9>] acpi_ds_exec_end_op+0xf3/0x3c6
		 [<ffffffff8040643b>] acpi_ps_parse_loop+0x693/0x814
		 [<ffffffff804056f0>] acpi_ps_parse_aml+0x7f/0x299
		 [<ffffffff803f4794>] acpi_os_execute_deferred+0x0/0x2c
		 [<ffffffff80406b65>] acpi_ps_execute_method+0x14e/0x21d
		 [<ffffffff804039c2>] acpi_ns_evaluate+0xa2/0xfc
		 [<ffffffff803fb73a>] acpi_ev_asynch_execute_gpe_method+0xc6/0x11a
		 [<ffffffff803f47b7>] acpi_os_execute_deferred+0x23/0x2c
		 [<ffffffff8024e4e6>] run_workqueue+0x86/0x150
		 [<ffffffff8024e64f>] worker_thread+0x9f/0x110
		 [<ffffffff802528d0>] autoremove_wake_function+0x0/0x30
		PGD 8063 PUD b063 PMD 80000000bf2001e3 
		Oops: 0011 [1] PREEMPT SMP 
		CPU 1 
		Modules linked in: ntfs hci_usb
		Pid: 160, comm: kacpid Not tainted 2.6.26 #1
		RIP: 0010:[<ffff8100bf2db6b0>]  [<ffff8100bf2db6b0>]
		RSP: 0018:ffff8100bf2db678  EFLAGS: 00010006
		RAX: ffff8100bf2dbfd8 RBX: ffff810001047080 RCX: 0000000000000018
		RDX: 0000000000000106 RSI: 0000000000000046 RDI: ffffffff80b60ce4
		RBP: 0000000000000074 R08: ffff8100000bad56 R09: 0000000000000000
		R10: ffffffff80b0d8c0 R11: ffffffff803f0e20 R12: 000000000000000e
		R13: 000000000000002b R14: 0000000000000000 R15: ffffffff80b1780a
		FS:  0000000000000000(0000) GS:ffff8100bf086b40(0000) knlGS:0000000000000000
		CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
		CR2: ffff8100bf2db6b0 CR3: 0000000000201000 CR4: 00000000000006e0
		DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
		DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
		Process kacpid (pid: 160, threadinfo ffff8100bf2da000, task ffff8100bf2d9800)
		Stack:  0000000000000000 ffff8100000bad3a ffff810001047080 ffffffff00000074
		 0000000000000087 3830323532383330 6666666666666666 000000000000000e
		 00000000ffffff11 0000000000000046 ffff8100bf2db738 ffffffff8023b525
		Call Trace:
		 [<ffffffff8023b525>] ? __call_console_drivers+0x65/0x80
		 [<ffffffff8023b965>] ? release_console_sem+0x45/0x1f0
		 [<ffffffff80212d20>] ? nommu_map_single+0x0/0xa0
		 [<ffffffff8024e5b0>] worker_thread+0x0/0x110
		 [<ffffffff80252527>] kthread+0x47/0x90
		 [<ffffffff80238557>] schedule_tail+0x27/0x60
		 [<ffffffff8020c6a8>] child_rip+0xa/0x12
		 [<ffffffff802524e0>] kthread+0x0/0x90
		 [<ffffffff804d23bb>] ? write_msg+0xcb/0x110
		 [<ffffffff8023b525>] ? __call_console_drivers+0x65/0x80
		 [<ffffffff8023b974>] ? release_console_sem+0x54/0x1f0
		 [<ffffffff8023c0e5>] ? vprintk+0x375/0x450
		 [<ffffffff802524e0>] ? kthread+0x0/0x90
		 [<ffffffff802524e0>] ? kthread+0x0/0x90
		 [<ffffffff802524e0>] ? kthread+0x0/0x90
		 [<ffffffff8020c69e>] child_rip+0x0/0x12
		
		 [<ffffffff80265fdb>] ? kallsyms_lookup+0x3b/0x140
		 [<ffffffff8020c69e>] ? child_rip+0x0/0x12
		 [<ffffffff80256ec0>] ? down_trylock+0x30/0x50
		 [<ffffffff8023b8b0>] ? try_acquire_console_sem+0x10/0x40
		 [<ffffffff8023c140>] ? vprintk+0x3d0/0x450
		 [<ffffffff8025016f>] ? __kernel_text_address+0x2f/0x60
		 [<ffffffff80230fb1>] ? dequeue_entity+0x21/0xc0
		 [<ffffffff80230f60>] ? __dequeue_entity+0x60/0x90
		 [<ffffffff8023292f>] ? pick_next_task_fair+0xaf/0xc0
		 [<ffffffff8040b751>] ? acpi_ut_allocate_object_desc_dbg+0x34/0x6d
		 [<ffffffff802464f4>] ? lock_timer_base+0x34/0x70
		 [<ffffffff802466e0>] ? __mod_timer+0xb0/0xd0
		 [<ffffffff807e4129>] ? schedule_timeout+0x79/0xf0
		 [<ffffffff802460e0>] ? process_timeout+0x0/0x10
		 [<ffffffff803ff614>] ? acpi_ex_system_do_suspend+0x11/0x1a
		 [<ffffffff803f6ca9>] ? acpi_ds_exec_end_op+0xf3/0x3c6
		 [<ffffffff8040643b>] ? acpi_ps_parse_loop+0x693/0x814
		 [<ffffffff804056f0>] ? acpi_ps_parse_aml+0x7f/0x299
		 [<ffffffff803f4794>] ? acpi_os_execute_deferred+0x0/0x2c
		 [<ffffffff80406b65>] ? acpi_ps_execute_method+0x14e/0x21d
		 [<ffffffff804039c2>] ? acpi_ns_evaluate+0xa2/0xfc
		 [<ffffffff803fb73a>] ? acpi_ev_asynch_execute_gpe_method+0xc6/0x11a
		 [<ffffffff803f47b7>] ? acpi_os_execute_deferred+0x23/0x2c
		 [<ffffffff8024e4e6>] ? run_workqueue+0x86/0x150
		 [<ffffffff8024e64f>] ? worker_thread+0x9f/0x110
		 [<ffffffff802528d0>] ? autoremove_wake_function+0x0/0x30
		 [<ffffffff8024e5b0>] ? worker_thread+0x0/0x110
		 [<ffffffff80252527>] ? kthread+0x47/0x90
		 [<ffffffff80238557>] ? schedule_tail+0x27/0x60
		 [<ffffffff8020c6a8>] ? child_rip+0xa/0x12
		BUG: workqueue leaked lock or atomic: kacpi_notify/0xffffffff/161
		 [<ffffffff802524e0>] ? kthread+0x0/0x90
		 [<ffffffff8020c69e>] ? child_rip+0x0/0x12
		
		
		Code: 81 ff ff 86 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00 32 31 36 63 30 32 30 38 66 66 66 66 66 66 66 66 18 00 00 00 00 00 00 00 65 8e 2a 80 ff ff ff ff 46 00 00 00 00 
		RIP  [<0000000000000001>]
		 RSP <ffffffff809d3a48>
		CR2: ffff8100bf2db6b0
		---[ end trace 99cb9eda96011921 ]---
		Kernel panic - not syncing: Aiee, killing interrupt handler!
	
	Kernel output 2
		

		SysRq : Changing Loglevel
		Loglevel set to 9
		huh, entered ffffffff802460e0 with preempt_count 000000ff, exited with 000000fe?
		------------[ cut here ]------------
		kernel BUG at kernel/timer.c:805!
		invalid opcode: 0000 [1] PREEMPT SMP 
		BUG: scheduling while atomic: kacpid/160/0x000000fc
		CPU 1:
		Modules linked in: ntfs hci_usb
		Pid: 160, comm: kacpid Not tainted 2.6.26 #1
		RIP: 0000:[<ffffffff8023b8b0>]  [<ffffffff8023b8b0>] try_acquire_console_sem+0x10/0x40
		RSP: 1bf2d7988:0000000000000002  EFLAGS: ffffffff8023c140
		RAX: 0000000000000400 RBX: 0000000000000018 RCX: ffffffff809cc710
		RDX: ffffffff80256ec0 RSI: 0000000000000001 RDI: ffffffff80b0d502
		RBP: ffffc20000004195 R08: ffff8100bf2d79e0 R09: ffff8100bf2d7ab8
		R10: 0000003000000030 R11: ffffffff807e957a R12: 0000000000000001
		R13: 0000000000000002 R14: 0000000000000001 R15: ffffffff8023b8b0
		FS:  0000000000000000(0000) GS:ffff8100bf086b40(0000) knlGS:0000000000000000
		CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
		CR2: 00007f69d5bfd000 CR3: 0000000000201000 CR4: 00000000000006e0
		DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
		DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
		
		Call Trace:
		 [<ffffffff8023b8b0>] ? try_acquire_console_sem+0x10/0x40
		 [<ffffffff8020db04>] ? printk_address+0xc4/0xf0
		 [<ffffffff8023c140>] ? vprintk+0x3d0/0x450
		 [<ffffffff8020eab8>] ? print_trace_address+0x18/0x30
		 [<ffffffff8025016f>] ? __kernel_text_address+0x2f/0x60
		 [<ffffffff8025016f>] ? __kernel_text_address+0x2f/0x60
		 [<ffffffff8020d00d>] ? dump_trace+0x16d/0x410
		 [<ffffffff8020d2fd>] ? show_trace+0x4d/0x80
		 [<ffffffff807e3980>] ? thread_return+0xfd/0x5bd
		 [<ffffffff8040b751>] ? acpi_ut_allocate_object_desc_dbg+0x34/0x6d
		 [<ffffffff802464f4>] ? lock_timer_base+0x34/0x70
		 [<ffffffff802466e0>] ? __mod_timer+0xb0/0xd0
		 [<ffffffff807e4129>] ? schedule_timeout+0x79/0xf0
		 [<ffffffff802460e0>] ? process_timeout+0x0/0x10
		 [<ffffffff803ff614>] ? acpi_ex_system_do_suspend+0x11/0x1a
		 [<ffffffff803f6ca9>] ? acpi_ds_exec_end_op+0xf3/0x3c6
		 [<ffffffff8040643b>] ? acpi_ps_parse_loop+0x693/0x814
		 [<ffffffff804056f0>] ? acpi_ps_parse_aml+0x7f/0x299
		 [<ffffffff803f4794>] ? acpi_os_execute_deferred+0x0/0x2c
		 [<ffffffff80406b65>] ? acpi_ps_execute_method+0x14e/0x21d
		 [<ffffffff804039c2>] ? acpi_ns_evaluate+0xa2/0xfc
		 [<ffffffff803fb73a>] ? acpi_ev_asynch_execute_gpe_method+0xc6/0x11a
		 [<ffffffff803f47b7>] ? acpi_os_execute_deferred+0x23/0x2c
		 [<ffffffff8024e4e6>] ? run_workqueue+0x86/0x150
		 [<ffffffff8024e64f>] ? worker_thread+0x9f/0x110
		 [<ffffffff802528d0>] ? autoremove_wake_function+0x0/0x30
		 [<ffffffff8024e5b0>] ? worker_thread+0x0/0x110
		 [<ffffffff80252527>] ? kthread+0x47/0x90
		 [<ffffffff80238557>] ? schedule_tail+0x27/0x60
		 [<ffffffff8020c6a8>] ? child_rip+0xa/0x12
		 [<ffffffff802524e0>] ? kthread+0x0/0x90
		 [<ffffffff8020c69e>] ? child_rip+0x0/0x12
		
		CPU 1 
		Modules linked in: ntfs hci_usb
		Pid: 1320, comm: w1_control Not tainted 2.6.26 #1
		RIP: 0010:[<ffffffff80245e51>]  [<ffffffff80245e51>] run_timer_softirq+0x211/0x220
		RSP: 0018:ffff8100bf0bfec0  EFLAGS: 00010286
		RAX: 0000000000000054 RBX: ffff8100bf1b1840 RCX: ffff8100bcd85e60
		RDX: 00000000000000f9 RSI: 0000000000000082 RDI: ffffffff809cc6c0
		RBP: ffff8100bf0b4000 R08: 000000000000060b R09: 00000001079028ab
		R10: 0000000000000000 R11: 0000000000000001 R12: 00000000000000ff
		R13: ffff8100bf0bfee0 R14: ffffffff802460e0 R15: ffff8100bf0b5018
		FS:  0000000000000000(0000) GS:ffff8100bf086b40(0000) knlGS:0000000000000000
		CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
		CR2: 00007f2aeff03000 CR3: 0000000000201000 CR4: 00000000000006e0
		DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
		DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
		Process w1_control (pid: 1320, threadinfo ffff8100be076000, task ffff8100bf1b1840)
		Stack:  00000000000242f2 ffff8100bf0b5c18 ffff8100bf0b5818 ffff8100bf0b5418
		 ffff8100bf0bfee0 ffff8100bf0bfee0 ffffffff8025651c ffffffff80a83190
		 0000000000000021 000000000000000a ffffffff80af09a0 0000000000000001
		Call Trace:
		 <IRQ>  [<ffffffff8025651c>] ? ktime_get+0xc/0x50
		 [<ffffffff802417aa>] ? __do_softirq+0x7a/0xf0
		 [<ffffffff8020ca1c>] ? call_softirq+0x1c/0x30
		 [<ffffffff8020eb05>] ? do_softirq+0x35/0x70
		 [<ffffffff80241545>] ? irq_exit+0xa5/0xb0
		 [<ffffffff8021f40d>] ? smp_apic_timer_interrupt+0x7d/0xc0
		 [<ffffffff8020c4c6>] ? apic_timer_interrupt+0x66/0x70
		 <EOI> 
		
		Code: 59 00 48 83 c4 38 5b 5d 41 5c 41 5d 41 5e 41 5f c3 8b 88 44 e0 ff ff 44 89 e2 4c 89 f6 48 c7 c7 f0 e4 90 80 31 c0 e8 db 36 5a 00 <0f> 0b eb fe 66 66 2e 0f 1f 84 00 00 00 00 00 41 54 b9 0e 00 00 
		RIP  [<ffffffff80245e51>] run_timer_softirq+0x211/0x220
		 RSP <ffff8100bf0bfec0>
		---[ end trace b338748305b49ecb ]---
		Kernel panic - not syncing: Aiee, killing interrupt handler!

[8.1.]
	If some fields are empty or look unusual you may have an old version.
	Compare to the current minimal requirements in Documentation/Changes.
	 
	Linux barney 2.6.26 #1 SMP PREEMPT Sun Jul 27 23:38:38 CEST 2008 x86_64 GNU/Linux
	 
	Gnu C                  4.3.1
	Gnu make               3.81
	binutils               2.18.0.20080103
	util-linux             2.13.1.1
	mount                  2.13.1.1
	module-init-tools      3.4
	e2fsprogs              1.40.8
	pcmciautils            014
	PPP                    2.4.4
	Linux C Library        2.7
	Dynamic linker (ldd)   2.7
	Procps                 3.2.7
	Net-tools              1.60
	Console-tools          0.2.3
	Sh-utils               6.10
	udev                   114
	wireless-tools         29
	Modules Loaded         ntfs

[8.2.]
	
	processor	: 0
	vendor_id	: GenuineIntel
	cpu family	: 6
	model		: 15
	model name	: Intel(R) Core(TM)2 Duo CPU     T7250  @ 2.00GHz
	stepping	: 13
	cpu MHz		: 800.000
	cache size	: 2048 KB
	physical id	: 0
	siblings	: 2
	core id		: 0
	cpu cores	: 2
	apicid		: 0
	initial apicid	: 0
	fpu		: yes
	fpu_exception	: yes
	cpuid level	: 10
	wp		: yes
	flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm constant_tsc arch_perfmon pebs bts rep_good pni monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr lahf_lm ida
	bogomips	: 3996.54
	clflush size	: 64
	cache_alignment	: 64
	address sizes	: 36 bits physical, 48 bits virtual
	power management:
	
	processor	: 1
	vendor_id	: GenuineIntel
	cpu family	: 6
	model		: 15
	model name	: Intel(R) Core(TM)2 Duo CPU     T7250  @ 2.00GHz
	stepping	: 13
	cpu MHz		: 800.000
	cache size	: 2048 KB
	physical id	: 0
	siblings	: 2
	core id		: 1
	cpu cores	: 2
	apicid		: 1
	initial apicid	: 1
	fpu		: yes
	fpu_exception	: yes
	cpuid level	: 10
	wp		: yes
	flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm constant_tsc arch_perfmon pebs bts rep_good pni monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr lahf_lm ida
	bogomips	: 3991.24
	clflush size	: 64
	cache_alignment	: 64
	address sizes	: 36 bits physical, 48 bits virtual
	power management:

[8.3.]
	ntfs 209856 1 - Live 0xffffffffa0000000

[8.4.]
	ioports:
		0000-001f : dma1
		0020-0021 : pic1
		0040-0043 : timer0
		0050-0053 : timer1
		0060-0060 : keyboard
		0064-0064 : keyboard
		0070-0077 : rtc
		0080-008f : dma page reg
		00a0-00a1 : pic2
		00c0-00df : dma2
		00f0-00ff : fpu
		0170-0177 : 0000:00:1f.1
		  0170-0177 : ICH8M
		01f0-01f7 : 0000:00:1f.1
		  01f0-01f7 : ICH8M
		0376-0376 : 0000:00:1f.1
		  0376-0376 : ICH8M
		0378-037a : parport0
		037b-037f : parport0
		03c0-03df : vga+
		03f6-03f6 : 0000:00:1f.1
		  03f6-03f6 : ICH8M
		04d0-04d1 : pnp 00:0c
		0500-057f : pnp 00:0a
		0800-080f : pnp 00:0a
		0cf8-0cff : PCI conf1
		1000-107f : 0000:00:1f.0
		  1000-107f : pnp 00:0c
		    1000-1003 : ACPI PM1a_EVT_BLK
		    1004-1005 : ACPI PM1a_CNT_BLK
		    1008-100b : ACPI PM_TMR
		    1010-1015 : ACPI CPU throttle
		    1020-1020 : ACPI PM2_CNT_BLK
		    1028-102f : ACPI GPE0_BLK
		    1060-107f : iTCO_wdt
		1100-113f : 0000:00:1f.0
		  1100-113f : pnp 00:0c
		1200-121f : pnp 00:0c
		1370-1377 : 0000:00:1f.2
		  1370-1377 : ahci
		13f0-13f7 : 0000:00:1f.2
		  13f0-13f7 : ahci
		1574-1577 : 0000:00:1f.2
		  1574-1577 : ahci
		15f4-15f7 : 0000:00:1f.2
		  15f4-15f7 : ahci
		2000-3fff : PCI Bus 0000:28
		4000-4007 : 0000:00:02.0
		4020-403f : 0000:00:1a.0
		  4020-403f : uhci_hcd
		4040-405f : 0000:00:1a.1
		  4040-405f : uhci_hcd
		4060-407f : 0000:00:1d.0
		  4060-407f : uhci_hcd
		4080-409f : 0000:00:1d.1
		  4080-409f : uhci_hcd
		40a0-40bf : 0000:00:1d.2
		  40a0-40bf : uhci_hcd
		40c0-40cf : 0000:00:1f.1
		  40c0-40cf : ICH8M
		4100-411f : 0000:00:1f.2
		  4100-411f : ahci
		5000-5fff : PCI Bus 0000:02
		  5000-50ff : PCI CardBus 0000:03
		  5400-54ff : PCI CardBus 0000:03
	
	iomem:
		00000000-0009fbff : System RAM
		0009fc00-0009ffff : reserved
		000cee00-000cffff : pnp 00:0d
		000e0000-000fffff : reserved
		00100000-bf7affff : System RAM
		  00200000-007e9377 : Kernel code
		  007e9378-00a82cf7 : Kernel data
		  00af5000-00b8454f : Kernel bss
		bf7b0000-bf7c53ff : reserved
		bf7c5400-bf7e7fb7 : ACPI Non-volatile Storage
		bf7e7fb8-bfffffff : reserved
		c4000000-c7ffffff : PCI CardBus 0000:03
		c8000000-c8000fff : Intel Flush Page
		c8400000-c87fffff : PCI CardBus 0000:03
		d0000000-dfffffff : 0000:00:02.0
		e0000000-e3ffffff : PCI Bus 0000:28
		e4000000-e40fffff : PCI Bus 0000:18
		  e4000000-e400ffff : 0000:18:00.0
		    e4000000-e400ffff : tg3
		e4100000-e41fffff : PCI Bus 0000:10
		  e4100000-e4100fff : 0000:10:00.0
		    e4100000-e4100fff : iwl3945
		e4200000-e45fffff : PCI Bus 0000:02
		  e4200000-e4200fff : 0000:02:04.0
		    e4200000-e4200fff : yenta_socket
		  e4201000-e42017ff : 0000:02:04.1
		    e4201000-e42017ff : firewire_ohci
		e4600000-e46fffff : 0000:00:02.0
		e4700000-e47fffff : 0000:00:02.1
		e4800000-e48003ff : 0000:00:1a.7
		  e4800000-e48003ff : ehci_hcd
		e4804000-e4807fff : 0000:00:1b.0
		  e4804000-e4807fff : ICH HD audio
		e4808000-e48083ff : 0000:00:1d.7
		  e4808000-e48083ff : ehci_hcd
		e4809000-e48097ff : 0000:00:1f.2
		  e4809000-e48097ff : ahci
		f8000000-fbffffff : PCI MMCONFIG 0
		  f8000000-fbffffff : pnp 00:0c
		fec00000-fec00fff : IOAPIC 0
		  fec00000-fec00fff : reserved
		fed00000-fed003ff : HPET 0
		fed20000-fed99fff : reserved
		feda0000-fedbffff : reserved
		fee00000-fee00fff : Local APIC
		  fee00000-fee00fff : reserved
		ffb00000-ffbfffff : reserved
		fff00000-ffffffff : reserved

[8.5.]
	
	00:00.0 Host bridge: Intel Corporation Mobile PM965/GM965/GL960 Memory Controller Hub (rev 0c)
		Subsystem: Hewlett-Packard Company Device 30c0
		Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
		Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
		Latency: 0
		Capabilities: [e0] Vendor Specific Information <?>
		Kernel driver in use: agpgart-intel
	
	00:02.0 VGA compatible controller: Intel Corporation Mobile GM965/GL960 Integrated Graphics Controller (rev 0c)
		Subsystem: Hewlett-Packard Company Device 30c0
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
		Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
		Latency: 0
		Interrupt: pin A routed to IRQ 16
		Region 0: Memory at e4600000 (64-bit, non-prefetchable) [size=1M]
		Region 2: Memory at d0000000 (64-bit, prefetchable) [size=256M]
		Region 4: I/O ports at 4000 [size=8]
		Capabilities: [90] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable-
			Address: 00000000  Data: 0000
		Capabilities: [d0] Power Management version 3
			Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
			Status: D0 PME-Enable- DSel=0 DScale=0 PME-
			Bridge: PM- B3+
	
	00:02.1 Display controller: Intel Corporation Mobile GM965/GL960 Integrated Graphics Controller (rev 0c)
		Subsystem: Hewlett-Packard Company Device 30c0
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
		Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
		Latency: 0
		Region 0: Memory at e4700000 (64-bit, non-prefetchable) [size=1M]
		Capabilities: [d0] Power Management version 3
			Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
			Status: D0 PME-Enable- DSel=0 DScale=0 PME-
			Bridge: PM- B3+
	
	00:1a.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #4 (rev 03)
		Subsystem: Hewlett-Packard Company Device 30c0
		Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
		Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
		Latency: 0
		Interrupt: pin A routed to IRQ 16
		Region 4: I/O ports at 4020 [size=32]
		Kernel driver in use: uhci_hcd
	
	00:1a.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #5 (rev 03)
		Subsystem: Hewlett-Packard Company Device 30c0
		Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
		Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
		Latency: 0
		Interrupt: pin B routed to IRQ 17
		Region 4: I/O ports at 4040 [size=32]
		Kernel driver in use: uhci_hcd
	
	00:1a.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI Controller #2 (rev 03) (prog-if 20)
		Subsystem: Hewlett-Packard Company Device 30c0
		Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
		Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
		Latency: 0
		Interrupt: pin C routed to IRQ 18
		Region 0: Memory at e4800000 (32-bit, non-prefetchable) [size=1K]
		Capabilities: [50] Power Management version 2
			Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
			Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Capabilities: [58] Debug port: BAR=1 offset=00a0
		Kernel driver in use: ehci_hcd
	
	00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio Controller (rev 03)
		Subsystem: Hewlett-Packard Company Device 30c0
		Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
		Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
		Latency: 0, Cache Line Size: 64 bytes
		Interrupt: pin A routed to IRQ 16
		Region 0: Memory at e4804000 (64-bit, non-prefetchable) [size=16K]
		Capabilities: [50] Power Management version 2
			Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
			Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
			Address: 0000000000000000  Data: 0000
		Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
			DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
				ExtTag- RBE- FLReset-
			DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
				RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
				MaxPayload 128 bytes, MaxReadReq 128 bytes
			DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
			LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
				ClockPM- Suprise- LLActRep- BwNot-
			LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
				ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
			LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		Capabilities: [100] Virtual Channel <?>
		Capabilities: [130] Root Complex Link <?>
		Kernel driver in use: HDA Intel
	
	00:1c.0 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 1 (rev 03)
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
		Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
		Latency: 0, Cache Line Size: 64 bytes
		Bus: primary=00, secondary=08, subordinate=08, sec-latency=0
		I/O behind bridge: 0000f000-00000fff
		Memory behind bridge: fff00000-000fffff
		Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
		Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
		BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
			PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
		Capabilities: [40] Express (v1) Root Port (Slot-), MSI 00
			DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
				ExtTag- RBE+ FLReset-
			DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
				RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
				MaxPayload 128 bytes, MaxReadReq 128 bytes
			DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
			LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <4us
				ClockPM- Suprise- LLActRep+ BwNot-
			LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
				ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
			LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
			RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
			RootCap: CRSVisible-
			RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable-
			Address: fee0300c  Data: 4169
		Capabilities: [90] Subsystem: Hewlett-Packard Company Device 30c0
		Capabilities: [a0] Power Management version 2
			Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
			Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Capabilities: [100] Virtual Channel <?>
		Capabilities: [180] Root Complex Link <?>
		Kernel driver in use: pcieport-driver
		Kernel modules: shpchp
	
	00:1c.1 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 2 (rev 03)
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
		Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
		Latency: 0, Cache Line Size: 64 bytes
		Bus: primary=00, secondary=10, subordinate=10, sec-latency=0
		I/O behind bridge: 0000f000-00000fff
		Memory behind bridge: e4100000-e41fffff
		Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
		Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
		BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
			PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
		Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
			DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
				ExtTag- RBE+ FLReset-
			DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
				RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
				MaxPayload 128 bytes, MaxReadReq 128 bytes
			DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
			LnkCap:	Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <256ns, L1 <4us
				ClockPM- Suprise- LLActRep+ BwNot-
			LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
				ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
			LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
			SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surpise+
				Slot #  2, PowerLimit 0.160000; Interlock- NoCompl-
			SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
				Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
			SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
				Changed: MRL- PresDet- LinkState+
			RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
			RootCap: CRSVisible-
			RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable-
			Address: fee0300c  Data: 4171
		Capabilities: [90] Subsystem: Hewlett-Packard Company Device 30c0
		Capabilities: [a0] Power Management version 2
			Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
			Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Capabilities: [100] Virtual Channel <?>
		Capabilities: [180] Root Complex Link <?>
		Kernel driver in use: pcieport-driver
		Kernel modules: shpchp
	
	00:1c.2 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 3 (rev 03)
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
		Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
		Latency: 0, Cache Line Size: 64 bytes
		Bus: primary=00, secondary=18, subordinate=18, sec-latency=0
		I/O behind bridge: 0000f000-00000fff
		Memory behind bridge: e4000000-e40fffff
		Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
		Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
		BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
			PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
		Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
			DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
				ExtTag- RBE+ FLReset-
			DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
				RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
				MaxPayload 128 bytes, MaxReadReq 128 bytes
			DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
			LnkCap:	Port #3, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <256ns, L1 <4us
				ClockPM- Suprise- LLActRep+ BwNot-
			LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
				ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
			LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
			SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surpise+
				Slot #  3, PowerLimit 10.000000; Interlock- NoCompl-
			SltCtl:	Enable: AttnBtn+ PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- LinkChg-
				Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
			SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
				Changed: MRL- PresDet- LinkState+
			RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
			RootCap: CRSVisible-
			RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable-
			Address: fee0300c  Data: 4179
		Capabilities: [90] Subsystem: Hewlett-Packard Company Device 30c0
		Capabilities: [a0] Power Management version 2
			Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
			Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Capabilities: [100] Virtual Channel <?>
		Capabilities: [180] Root Complex Link <?>
		Kernel driver in use: pcieport-driver
		Kernel modules: shpchp
	
	00:1c.4 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 5 (rev 03)
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
		Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
		Latency: 0, Cache Line Size: 64 bytes
		Bus: primary=00, secondary=28, subordinate=28, sec-latency=0
		I/O behind bridge: 00002000-00003fff
		Memory behind bridge: e0000000-e3ffffff
		Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
		Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
		BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
			PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
		Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
			DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
				ExtTag- RBE+ FLReset-
			DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
				RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
				MaxPayload 128 bytes, MaxReadReq 128 bytes
			DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
			LnkCap:	Port #5, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <4us
				ClockPM- Suprise- LLActRep+ BwNot-
			LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
				ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
			LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
			SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surpise+
				Slot #  5, PowerLimit 0.160000; Interlock- NoCompl-
			SltCtl:	Enable: AttnBtn+ PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- LinkChg-
				Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
			SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
				Changed: MRL- PresDet- LinkState-
			RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
			RootCap: CRSVisible-
			RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable-
			Address: fee0300c  Data: 4181
		Capabilities: [90] Subsystem: Hewlett-Packard Company Device 30c0
		Capabilities: [a0] Power Management version 2
			Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
			Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Capabilities: [100] Virtual Channel <?>
		Capabilities: [180] Root Complex Link <?>
		Kernel driver in use: pcieport-driver
		Kernel modules: shpchp
	
	00:1d.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #1 (rev 03)
		Subsystem: Hewlett-Packard Company Device 30c0
		Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
		Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
		Latency: 0
		Interrupt: pin A routed to IRQ 20
		Region 4: I/O ports at 4060 [size=32]
		Kernel driver in use: uhci_hcd
	
	00:1d.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #2 (rev 03)
		Subsystem: Hewlett-Packard Company Device 30c0
		Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
		Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
		Latency: 0
		Interrupt: pin B routed to IRQ 21
		Region 4: I/O ports at 4080 [size=32]
		Kernel driver in use: uhci_hcd
	
	00:1d.2 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #3 (rev 03)
		Subsystem: Hewlett-Packard Company Device 30c0
		Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
		Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
		Latency: 0
		Interrupt: pin C routed to IRQ 18
		Region 4: I/O ports at 40a0 [size=32]
		Kernel driver in use: uhci_hcd
	
	00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI Controller #1 (rev 03) (prog-if 20)
		Subsystem: Hewlett-Packard Company Device 30c0
		Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
		Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
		Latency: 0
		Interrupt: pin A routed to IRQ 20
		Region 0: Memory at e4808000 (32-bit, non-prefetchable) [size=1K]
		Capabilities: [50] Power Management version 2
			Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
			Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Capabilities: [58] Debug port: BAR=1 offset=00a0
		Kernel driver in use: ehci_hcd
	
	00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev f3) (prog-if 01)
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
		Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
		Latency: 0
		Bus: primary=00, secondary=02, subordinate=06, sec-latency=32
		I/O behind bridge: 00005000-00005fff
		Memory behind bridge: e4200000-e45fffff
		Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
		Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
		BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
			PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
		Capabilities: [50] Subsystem: Hewlett-Packard Company Device 30c0
	
	00:1f.0 ISA bridge: Intel Corporation 82801HEM (ICH8M) LPC Interface Controller (rev 03)
		Subsystem: Hewlett-Packard Company Device 30c0
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
		Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
		Latency: 0
		Capabilities: [e0] Vendor Specific Information <?>
	
	00:1f.1 IDE interface: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E) IDE Controller (rev 03) (prog-if 8a [Master SecP PriP])
		Subsystem: Hewlett-Packard Company Device 30c0
		Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
		Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
		Latency: 0
		Interrupt: pin A routed to IRQ 16
		Region 0: I/O ports at 01f0 [size=8]
		Region 1: I/O ports at 03f4 [size=1]
		Region 2: I/O ports at 0170 [size=8]
		Region 3: I/O ports at 0374 [size=1]
		Region 4: I/O ports at 40c0 [size=16]
		Kernel driver in use: PIIX_IDE
	
	00:1f.2 SATA controller: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E) SATA AHCI Controller (rev 03) (prog-if 01)
		Subsystem: Hewlett-Packard Company Device 30c0
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
		Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
		Latency: 0
		Interrupt: pin B routed to IRQ 315
		Region 0: I/O ports at 13f0 [size=8]
		Region 1: I/O ports at 15f4 [size=4]
		Region 2: I/O ports at 1370 [size=8]
		Region 3: I/O ports at 1574 [size=4]
		Region 4: I/O ports at 4100 [size=32]
		Region 5: Memory at e4809000 (32-bit, non-prefetchable) [size=2K]
		Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/2 Enable+
			Address: fee0300c  Data: 4189
		Capabilities: [70] Power Management version 3
			Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
			Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Capabilities: [a8] SATA HBA <?>
		Kernel driver in use: ahci
	
	02:04.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev b6)
		Subsystem: Hewlett-Packard Company Device 30c0
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
		Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
		Latency: 168
		Interrupt: pin A routed to IRQ 16
		Region 0: Memory at e4200000 (32-bit, non-prefetchable) [size=4K]
		Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
		Memory window 0: c8400000-c87ff000 (prefetchable)
		Memory window 1: c4000000-c7fff000
		I/O window 0: 00005000-000050ff
		I/O window 1: 00005400-000054ff
		BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
		16-bit legacy interface ports at 0001
		Kernel driver in use: yenta_cardbus
	
	02:04.1 FireWire (IEEE 1394): Ricoh Co Ltd R5C832 IEEE 1394 Controller (rev 02) (prog-if 10)
		Subsystem: Hewlett-Packard Company Device 30c0
		Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
		Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
		Latency: 64 (500ns min, 1000ns max), Cache Line Size: 64 bytes
		Interrupt: pin B routed to IRQ 17
		Region 0: Memory at e4201000 (32-bit, non-prefetchable) [size=2K]
		Capabilities: [dc] Power Management version 2
			Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
			Status: D0 PME-Enable- DSel=0 DScale=2 PME+
		Kernel driver in use: firewire_ohci
	
	10:00.0 Network controller: Intel Corporation PRO/Wireless 3945ABG Network Connection (rev 02)
		Subsystem: Hewlett-Packard Company Device 135c
		Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
		Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
		Interrupt: pin A routed to IRQ 17
		Region 0: Memory at e4100000 (32-bit, non-prefetchable) [size=4K]
		Capabilities: [c8] Power Management version 2
			Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
			Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Capabilities: [d0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
			Address: 00000000fee0300c  Data: 41c1
		Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
			DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 unlimited
				ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
			DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
				RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
				MaxPayload 128 bytes, MaxReadReq 128 bytes
			DevSta:	CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr+ TransPend-
			LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <128ns, L1 <64us
				ClockPM+ Suprise- LLActRep- BwNot-
			LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
				ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
			LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		Capabilities: [100] Advanced Error Reporting <?>
		Capabilities: [140] Device Serial Number b0-ae-28-ff-ff-bf-1c-00
		Kernel driver in use: iwl3945
	
	18:00.0 Ethernet controller: Broadcom Corporation NetLink BCM5787M Gigabit Ethernet PCI Express (rev 02)
		Subsystem: Hewlett-Packard Company Device 30c0
		Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
		Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
		Latency: 0, Cache Line Size: 64 bytes
		Interrupt: pin A routed to IRQ 314
		Region 0: Memory at e4000000 (64-bit, non-prefetchable) [size=64K]
		Expansion ROM at <ignored> [disabled]
		Capabilities: [48] Power Management version 3
			Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
			Status: D0 PME-Enable- DSel=0 DScale=1 PME-
		Capabilities: [50] Vital Product Data <?>
		Capabilities: [58] Vendor Specific Information <?>
		Capabilities: [e8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable+
			Address: 00000000fee0300c  Data: 41a9
		Capabilities: [d0] Express (v1) Endpoint, MSI 00
			DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
				ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
			DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
				RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
				MaxPayload 128 bytes, MaxReadReq 4096 bytes
			DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
			LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <4us, L1 <64us
				ClockPM+ Suprise- LLActRep- BwNot-
			LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
				ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
			LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		Capabilities: [100] Advanced Error Reporting <?>
		Capabilities: [13c] Virtual Channel <?>
		Capabilities: [160] Device Serial Number ee-07-72-fe-ff-4b-1a-00
		Capabilities: [16c] Power Budgeting <?>
		Kernel driver in use: tg3

[8.6.]
	Attached devices:
	Host: scsi0 Channel: 00 Id: 00 Lun: 00
	  Vendor: ATA      Model: ST9120822AS      Rev: 3.BH
	  Type:   Direct-Access                    ANSI  SCSI revision: 05


	

--Boundary_(ID_uD/j1rpSj0NGc0xbApAImg)
Content-type: application/octet-stream; NAME=kernel_2.6.26-hp6510b.config.gz
Content-transfer-encoding: base64
Content-disposition: attachment; filename=kernel_2.6.26-hp6510b.config.gz

H4sICOqbkUgAA2tlcm5lbF8yLjYuMjYtaHA2NTEwYi5jb25maWcAlFxbc9u2l3/vp9CkO9Pd
h39jy47jdCYPIAhKqAgCAUDJygvHsZVEU8fKynLbfPs9AC8CyEM525km0fkd3A/ODQB//eXX
CXk+7L7dHrZ3tw8PPyZfNo+b/e1hcz/5dvvXZnK3e/y8/fLH5H73+NthsrnfHqBEvn18/nfy
12b/uHmY/L3ZP213j39Mpr9f/T69Atg8P07+fH6YTN9Ophd/nF/+cXk2mZ6dXf/y6y9UFhmf
VVeXCbfvfwBvQ7i5vqouppPt0+Rxd5g8bQ6/BMDVJbAefx9/EE3nVcqy+uf7V7f7u6+v/72+
el33+sn9G0pX95vPNeXVscUZK5jmtMolXSSakQXSeMtjuWDHVlsqFdJUpUqJDUDq6jOy1JRV
K2LpPJUzpKjjYktWWHMSrBItSUqJsUc2h6ZMVaZUSuoAMJbQhdUEWh5gc7JkVQ49LejaSqRw
Bm3AiNQNnfsmSH7EhCiPPz7KglWpIMN+c0NGACmIGpKTEpmZ+Yrx2TySjRaaKS6RRfJCIMi6
HqOiVZbSY716ZZjoqjCKF27+wuprDjdukqYVyWdSczsXYUsdr29rTkzFczmbVmUssqNsV5dj
/XZMVJUVT3MnL9wi4kBynmhYOpD0nKyHDE46q6VZG+DMe5ujrV9D0RsMI3QOgsFhTQ3/yHoC
Y5gtVaWY9nUQ2CU9BiALYhaVzDxHtMx1GzxhuiCWy6JS0hie5KzHYkqjWJEicCtqF9NeESVV
6YTZVIVMWa/ZMuXWsw3a8SJvKiJLO4ZJBbMJE5FWICi84AUmokSnXH9Adi5QK6VlgigLN0So
zbFEyqwyQsUE0FcD2tzGvxMOqkezRMoeANtfKOnWMxTxhRcRJx9EI5LYaVAQBNA0r14/bD+9
/ra7f37YPL3+r7IgUBgEiBHDXv/eKlJQ5r9OZt5YPLjKnr8f1Tu7AZmBJgsbqhG38aoFiAML
iDDHtmLFEtbBNS9gB1xMgxIkXzJtQHzevwqUdwjAiltML5hVKBawPZZc0QHB/U1t0CEQQ35T
iQ8lK4NlTEzqVpYyA/JDqR1HquXFEbSwOUAth1rekeqd3KvIAzcIjUvHKcvCRuLoBb33c6gE
/G6wmgVj4YvGXg4ofiDhgsHwyqwyc57Z9+fXnY2baVkqE0pYTYJxgVJHVWLDUBhkpbrCS05D
U6pKUEDB1HmVUxYwoaAmQJznsE1po87b7eZr8lBo27jGEW1xOjSsO1p/DJ4+PgzodryImjX+
gF9DENrQslZyBQoiGHRdiQCTBOUqEE0dyWxmYJ6UZhTUXzqOVMtAZ7pVrRRPmxkNexYZFLfR
jQL/IVraEtRivGwd5PbPCORncARzXRmBktxtjqVXCzrFJYl2WrrKpPZ2C9v+7b7uCjKRsDRF
l67k6flVNJtQthrspphegRyEsrcAmlmLaPJaGqhEUM2VIgbbAHNpVR56Q0rzwgZVR64Sy8Ha
Sh3sFEWNWuhKgU2EGRGRzEqhiAU/EvNvE9DoVVaGQ8xKy0JHoQAFy52VDaSWgYUJZ4XPCpJn
gTQ6c6NDgvdmQ4KZg4Qffy5FzYJsEZOTJByQycsElQuTSxwA8c84mERcMQmiwSahq+LUjaxL
x+bU2/jRIg3c01sLzWwHdFV5CFyciliLdqLeu2QGXo6EPSF1PDO8yGSkzoRbv7gNMBvresLH
RMAIJ+ZnnVaSaZnHddQkt99Aj+UQkyBVNTxl4fBAx4VFEbAx42ZQwmjamfhQ3haAh1EPhDMC
3Nja5+n0SGQWOrUiKx8ghUNrscTMsPnxXku9i6CU93ogDDF3XzfOP9o/Hb0e8Mm8SSqkDByP
lkqi+WypKSOp89Zw9dow0ewD7rWRMre9ilvqyYpbpl7FA9yN5ETLTf8g7n48bO+2328Pu/2P
V8dIGJQdeL6alu3Eqf3ubvP0tNtPDj++bya3j/eTz5vbw/N+E0yj5TDh4PmbeejcFrKafwy2
FASJ3kB6VfNSEF3yPJSYvnft3cIoFQF2sUBnxoFLuYb9qEfxAmIifF69v18KcHJH4YTPoH/j
bXOzwi2nQ5vBu5BmlIeZt2dnZ6OwTunF9PxmvANjvVNEkyV3DlXJjMXUAxMQsYEpgqDFMQfq
fwBVS5KD+30WKKCL6ytcf1+OAW9OANbQUUwIfPjiaqxCCO4sLwXnL8CncTzl0KKXOLoY6dLi
7Qj9GqdTXRqJawvBsgwcc4nvCLHiBShfRUc60sB4oqRFL3BXT8wYeB6zm/MTaJWPrBZda34z
OudLTuhFNdIrB47Mn4oFp2sM/LEplrQCl3skqwlIrIby8yYdk6xhN7y/ugxB7twin+0Y52nS
dyO11lHcVYjNpATDpDiNi7i2cu/BU6nWMQbUSoFTUju/oMx6qhTUn+ypV9hrMYEKuYwpAvx9
UQqfRMqI4Pm6NzQfWILvLUzgAM0Vs7UB6NGY8Okh8IeCllPBAzNBtLNfdWbz6CyTHIB1DaAp
BS5tnoTGHRirOctV2IfC58vM+y6PUZtxI8JkrSeJyPJA8MaEcmZ3xG63DEuZg5sMPUUdRs+D
1QuWeEQWfT4FkwSJEEUYpDeEWmb6ZtQBROB7m19jEYngFBxeEPP33wakSuZpvQ8yMuhCKBfN
7uJR8O6s8lgWFoJebZiLuRvXpp8e7HBWECSDyXJGrbNiEoQHvNMwwYWDXbcyEFRXsSBFSXLc
G+MG/mX5DOdr2+n6WLMEPWiRXkTSdAmkw4CJiWKsri6XvOKYxgumBCJbFp6PHKEl/CGIGsza
gCMKNepuNTExJuHgfcG0zXxQzYo0yoOonNtK2dprd5uwUyNtGsZ0p08N0KaZ3VrM3p93nj+E
oqGYeefGSvAmw1DF6p7g1XHCMemQcWz2GHUhRRQJfqzOR/wygKZvzpBqALg4OxvWgvO+B95Y
/cy1c7aj0BaCR9wzopqYeZWWAosI1HwNrj6oEJAXbd+f/Ts9c/8FhyzMqRifuDtVnOR8VhyL
t12vRaGxmP3UxjI1o8dCteD1RKqLRnb/bPaTb7ePt1823zaPh8nu+2G7ewxCERWlUpQY5jeP
kMmZO5QLY4uWGohnfdYxIFQZqOiP3oYcl/J4dIINj6rAnLlf/bY8zaUPMoMSKyVXodWq6/B5
RAzxiQgfUPUAQnuEhFjQ0es+tbRWFj3ikqdM9mgZ6XOlvRO7phXM+nVdZcbI/hBiOQoRO2da
hDrTU1feY4ibJbBi+Jmfr0eCl5WQcQZaGitBjkyKhUj1wHJCF+4gplozosMYqJ6MERH0IOuv
xcgaW9b320Tfkaq7C3aH8GJYRWLaXeQc3Gy/+d/nzePdj8nT3e3D9vHLcQt5j06z4NCrpVS2
MQrHDd0iY2PsGJxZQks6AIpDp3N8mYI26iTGTC7dCafLmxLQ9/+PQm5qDRjSny/iXGqfYP/5
IhLsG3QMPW/A+AGDRpagNpYMmfPeaMc42qGN4N04RvC20yNwr4+tGDkpmnzvUkT3++3fUX7N
yWktlcBbi1TkbfpeF3JVxTFuwAG6lqUg/KqioMc0L2RvF1zWeaM6wej79fT1dr+5H5qGfmdq
/QjeaRZXeWwy50k8H+7Mf0jxM5STNI1OhUJQsKLLqCXPT23fJv+tKJ9sDne//09gwWhgJeAH
OJOahYdTjiZE/aPHKQVs/Ti5KNDzY+Bm7vi89oyOBqxRt64yxzJSksRmz5OMwnLV8VG9ML2h
DQg5mxEa2KG5jY/fmwsrLsQJssvXVZGE9VCi07iDgnIy7gp4OKzAs7u0d0W5GQBcRsfPrrV6
Hmsfhf7n7nZ/P/m0395/CbOka3e4fizmf1Zy2qdoTuW8T7S8T2HgAdsyTKA3nLU9i4afXr2d
vhsJ6aZn77BLXPUkuri2jieCJTnKCEoEb2ARxIIh4j2gUaTiicBROtqWQ6qP9s2bN2fjRdvM
Ds5h5sohfu3Yv5u758Ptp4fN5PPW/bHbf7s9PE1eT9i354fbnkJxRznCusO9QBiawzsEamiC
h8kVTi6mTfKDh76Wp8fXXroTjbgpd6BaXl3WjriInL32wkR8FlJsDv/s9n9FNr9gCIx41+Dn
hKfR9e9KRNd5yoIHx5E3mRbxL2+LIkvgiKZMKncNhmI+oucQfKbri3u9kk5ADcgodhgHA4MI
KTwxrwlBbe2MF+HIuKpgUaDS6CIfUEm6dGY4rTQsTuRluXsfqsp44q5pzcNuNmQwX5hGjQv1
2ldgQbzXZSLMN95wEDtHsCXTiTSs1w1VYLGgmxOuuDpukJoy0wwhYTccXXd9uxFJcWFEtTzH
iFHqlWiFuUtmXYDsygWPRu86QubHjnkCM6pHAcF38XpM9AIDatNdaIoRlFjLnUtkWU0K4+9f
jnKcriBhrF8217I3rJSTWY9kqeqRHQX+OetEEYGSUGN3VFomoRbs6Ctm7EqCBzWE5vAvjGxG
6GuIhRD6Euy6Qej+gpuLKYZQjtUPwaxEyBB2zREyz3NwGHnQcOt31/MzPF11E3TyfNXNx0kG
P9KTHO1sn2TSMNAT57jtEN+/+rS9C27ZObpI3xiO35yA7bccuxe0xE+DQAZhhRiWvwRoJfXC
pcbclYxIx2Y8t7GW74ijftiRYyjZiebpjEU110HIbr9xJgvM9WGzh5/uquPz3pvqyLw1Nbvh
8ALrawtVvXuEQ4Y8vB9euJs9ReHuKCxiqu3dFgw5q96EhdBwOkO0u4J+nFjfFgQzVlYppaiC
D1hmmo2VNtS+VLpMXbqWjXSOuBCSjICZVSPI/GJ6MQJxTUcQWA1/pza8hhIxKGVVf6THSSYF
ZotjHj7WYTsYiz0lWTd9Cx5CYN71DBR9ffkiW7/ABX0Y2WwBV2qoOs3xch1FNroRQqZ4M2As
sr83ECbnirHQocCY2ntAJ1jGVVFvDn+KEbSpMC8sG/BIZQ34dmMzLtybEueDx845ylMU9Snx
S1z1teuXuE6M8Mh0anVqLqdUTjOMi1vN4LyzU/jgOHbIwhV4YLOx5a95clbMQmcYY3lx4kSY
HUfxFya1dz0Y4ajjnNOteNc+eu+DVTRfm5QtIyd9wLOwdq1OT9yHUoapCYTj9AZteBjJxUkO
Z2BOM9goJhvh8NHeC1w6unmPsJzc3A1L9IgMYSjDdy6YXENM10pcfQ9R/fET3kpkANUyeEsX
GziXv+xnBcDFA6ae6q6JXCGRJNDb1aORfgoxRgscIHOcbsMEWVQgTXUsjjXaeXURtbUO7M8o
AxqBkQGKkLLvqBXE9n/DqrHoODqqQRADM6lJOuhv17N+djaCQSSi1EjTpimEctd4OR1AoY+G
IZj/5dC+Q+Jofd/J0QaeiyMibptvUSG8A1/NDyg0fu1yF7N8bNoQeWrN6VBwOv+oNCAiw5Y0
WfVJRI+IOgC4pAFw7HKdp/f525/Yrm1oklUsaVr91sMAcFkTlx/BINuKPw46scWQ67NpdYEi
RLjYEEW0QukcJ9fKC0O8GcSA1t5gmLF4M8ucFGPd1UzlaxRMxybG9a3CoW7Dot0bq9ApEoxe
jgG1X/wtirxHYjOuWrN4vMwDv6s0mVXC4HF8xyCTP2mBX032PHPwZsYvpx1ZzJycYwm4jkGk
b8Iegm+C50mIRZ8s+Jk5zpRbbye+5x/COUpBLTDskD3PacgHP/FboFzhF0uJJfkCRW6mb1B6
ThT+MoXB3wyf8BWMqU4Kj6RY29dpXr18eN48b7aPX1437xL66XjHXdEkOPtqiXObIMTM0CFV
aS6HVB3au5ZoMqQpyz7kCDXJhsQZWmtqBu6yp8PfTAzJ4LNpZo4XFR5un562n7d3w3QOmIPY
d3OEgU1tyJbyIg3fSLWAX67LEfqQnK2GtMgFbAj+vH5IHU6Fb8ssFU69QnqQy14fmPerMFr9
dYHgbW4AUaHQIj78RJG+q9vSBetFDi1g2Y0dDoDQHpG41JKLh9iQPou4Z6TOQiVDRsH1QPwc
nSuktdgLbLvAUo6QDe9PlBsELxBRz7h/1xWeoU0Om6fDYGODgZyxIlRocyLAx4w/lRDccMYu
k3HtHbY6qNinxN3COOzudg/h6yadhxezuI5PuLRLSYS/UwIGDUKLqN7BGaDnaz5C4L5AkZvQ
w/Wo/zJFeMvSU33at6v78fPeXdP4z/fd/jC53/y9vdsE90c8j+F6iHQ1gpcBy6Pbo9t09/jl
YTN5ev7uajwypjL2Q5nhLa0zR7DS3KzNgG7Zwr1sGZAlF+AFTweA88x9hrgPCHJ1djagzrhO
eD5kpmp6Ph2yu7vUCcsXvMAGMD07G1YFvDNTDvkXJiUfP+YMAd69eXek+pnNTixDaZJaFLsa
DJ/B/mc57IfAny0MjQkrXiTS3aIMiUa4DzLQHivJeUxY5qZP4SQmCGpiQhK+/wehndJQap3v
R2X0W2fx9uhIEKKsI3JSMDUgQA8GMW0L1ZEcgs55qrrw4+F5c9jtDl9H594VoBxWIBxlQxoM
B8iJNaBjBswkPNM80qr5Zb8CT06oUSgQvvdsGqRienZx0689UeT8bEjN6pEcH3l6cmpz/ClR
O6YL3A9t4Lxk7h7LyRpc708wLOF/7GYTBJ43On6H2NJOfFRB3yzQl7juBoBunvD69V9t95uH
zVOw3jSbOZc5OE0v8h5hxd1HP4y/Zn+kgv/e8vmq9e3BfyXqsN89TG4fvuz228PXb9Cbh81d
7Gi1JStNu6NHFT/SwFj6AUetzevqH79Mfvvxm7tZM7l9DFr/Z/vw0Cr+T8/bh/vJ4esmwLeP
h93k2+2db+z3k118/+r79v4VxjDWd8HMHFmUDs9ZatCCfqEz/Eg1ZmrvynTXdH6iDGb3GWP1
YobBZUt8uVhF9Vq5M+jwZkQPpFScQO0izBXobMHDnV//Bg9JhVeXGmp/Gp039E4NJCWtFV4a
ewP+wzXbu4Y8kX2/pKw/R1AfJVT+Vsyr10+fto+vv+4O3x+ev3QSAX5xkZJcxl/cUbquAMyG
WBF3zcW9Qca26spfDYxPt537MF9Dy0tuJBYAwl8Fo9HXAI7382Phsliriuj4OKAhVOEXclqa
YZqHd+OPvK2bGj4CbiFTum8AYdcOAqbusuSghtnIA90WJzfX12/fXZ2o/nx6HRgdVajoR+xA
qqG/CzzxG4vmOwEDQpWlvQHwFM+QuAJUfahS/IFAC1MOOvcEj2szJfTdFf5aqGUpex98GDBQ
ufIHiej7kpYpjz5m0BV1m1fiWJFE89GSzQ3+8rjrLp4iaWFwnbF9kGopXAxE02V42zwku08Y
Ze4bAddBGBQxrHwAMpbsqeQSVACzqE7nhjbfLYo/75CIihh8+tWcFFZio2FMuW69u6A3V6FG
NjPurgljH5GzPBP1x2ACfk98ezPybJpQGM5K4O+i3fMWl6+yEr+YlJV/cmvKUywC/OkTsJHF
+hRu5xDzKJL6W7x4Ys4/Twarl8sVnlaDiaSn2mAFzaUptfvCnfaLhz2Yc28keXRYE/7oPimS
dkl+9fB/jF1bc+M4rv4rftudqrlYkmXL59Q80JJss6Nbi7Ls5MXlSTzTOZ1OuuJkp+ffL0FK
MikBynnoi/GBFO8EQQA8ny7y1HiW283L/Tv4lCld02+PD2f48+vbjzclq3w5P33/7fH5z5fJ
y/MEVgsljl+0mmqQ/VHIUTgyRSVLxIXlIdWQ9MWvMhkcTx+KYcUidTpEKxxGBLk1FD3GZZmX
AlsHOHjnFB+UZ53khel5bkAiFMNFGQB7tYZ2a6KnWfb1QFdb5boTjqED7r88fpdFaU/8v/3x
/tefjz9Mg3tI2Jp+I9VqYy+Nr7hpNJ+Nr9ryM7hZrdnbKTuK9bobdvJIYdThMlRbmJmHvDdQ
GveMlZz4eRkRcU3aHPL1epX3zkA9lpFGgrhdc5c4grUL/R3hwNprgF5FWpTF4dw94Jr7jifh
jn/wxnnSaDH7KJ+K8wO+wlg9Pp5LVfJ1Eo/zhLeBG86X40UOhe+746MLWLxxlm1ReR+UGFjm
uIFny/JJee3jEUM6iSB03NGeLriy/R/OkSpwnfG2UCzjtchEsJg5+I1NV4IodKdyOIG67P/H
mMX4ntRVut7fjIe+E5ynbENLkJpHduQHTSCScDmNP+inqkzd5fiAqDmTg+/wwVyowmAeTqfY
vZ89cbEO3UbHPEtuxwed1QFaCSC3glahdV3zrtoRxiMyrpq9jcAvO3axolSbqkcZ2GUqam9D
UeVqCqQjXf374fHy9efJ2+n7+edJGP0ixbyfhsuzsKNNbktNxQ/3LZwLgqHLFT1Atplv0E/a
8aN0pV6+nc0Wv0z+ff71r19lbSb/9/71/MfLj5+6On97f3p7/P50niS7zJJqVGtpoURCRLco
/1B5qjZDfyp6km82liGWooqQZVJuvc3CHgDhlBXa6p5V6avX0/MFSmns7Tof8O6G0WKokIG+
DjuyXQ8JyAEyOsKOXP2NZSuYIOkJXwk2/KBOgh8MO4ZtLqojFaSr9wVSw6P5yoKoOSAfVl1K
50lc29FOdHNQXg/tiPX2R7ncHNQEpqshuZbUqqRbnVTWapiF4x9gPFyMf0AzkJtDx7T8IJcl
JWnodamojtzF7/N0DuDgIG7xbUVzlGEqcMkujTdMrZRy55Ki2ziP9qgd5xGEx4oqiBQdOHUw
BFxKoXKWc1z306zSB89ZOiMtHo/OkfWugoOf9m6m2TZRhcfQ09O6GKkjxK4lrl9bnFGhXvR2
UoyUnxNx4vTSWo+2vqgIOVOjt6nvhYEc0LhBTFNzfBgp8LPqO9C8jdTuc8Lk0jmOq3WCZkmK
sQyi0Fv6P8bxKWXmJJAIG4PFb6RkzaLXaDaxq57KEoFAwaT9orMIP1cBR3O2vX4LiAUaikdB
bBsO+QVPXPQhgqo9Tvb46z3B3RfMFXta482iaohjUmqWi1dKjHZI+FlUOTHgVEGkIMUFYY+m
6nDA4ya2DTIGEhMJwF1CjE4Aaz5SoZpXsRgrsVwdQkceYQntdzMYRlCiaBokgrFpsKT0ZRqm
T7sK18oNOJd/wDNStZEjbIcT51eN30I0MyLqODDEazSCBUCI3kIlGTntdvhipE6AH1x8q7ky
4Gc5hY+cZa/4SPqxs7hiGNNAKIaUlXJNwyeLZoAVgYalgDTOII9V4egHMp59YsRrK5pBneZH
hsbYcV8XUoom4yi1UimG4YLfw+VaRwmKigGMtighTjMMNGM2PtSn9PBY9mIJTrYjH9GKjLHx
LFfNObG/F2MLZzG2NiqwMeMZqyF6CYPeN6VjOsrICuwW0YHdJKTuuq5HS0kRGSvs6NRRqqwG
zftYSbqLTZ984BmGWDCpx9iOB2phZcQIZ3KTa0v4k6f6yRG8hrs2rFvHv96JXtg5rSmP43ji
eMvZ5N/rx9czWJX8ZGhedNSTZxXx5OX56R/5l/zPn8r24u3vl8nl7XT/9fLz5P0ZbFEm/7y8
T74+v/w9+fvL6U39Or2eJw8vlo3jmpcxGKJcW6ylHPOtGcjFIne3u31QrArD8hTqA9UZUlQu
DXQ9vbag3OOS2+yAtGbH0nxomBYA5Wp3pJaTjjWutupfuBSEeFX4wavPPlaqku1NG+6OruLw
ES0R1WQ7NLc9tMBMHVtTFvIMggsdo5LX+PMLck9AblavVD3qlW8a/u01fqMc7dIUmwiw9Gjt
klnMOkEtZuPPOylo3Zkmd9UuM9PWMXGAVCa+K3Ipl0d1yidA2UNDqELcsUE3jYr/aZ0wwjgj
DtRR4uKeDDFZPIXgDa6hJuYmEfS3IDPmG7y75L7tBYRMuGXq4QcUu5XyRL5fE2f8MnDmeBAr
uX05hEZc3BBqeXFzi4smYEpaQ+hTXmFDruKbPDMc4FbZwVo05FHYozRQjLJlNIYBXo3KkoAt
+8CJHO3XtXcPjjVSoG7t/a71BQd1fJvWQc32rCafUGhYIN5HL3ii+dnBN5tkJbsNqaAje5dS
qwBGyUYJxFmtCLUJ4yW+gkHA0JhIU6UxLspCbkei+G3LJZ4/xTu2KLlIffw8C1a6d5GU//Ck
AMPqUcolTqgGxmdFlQQOIdtpDI+KL8/w8ghClNqfIVZGRmNtfSwQON8ne742L/T3SfPo0bVX
NY+yBKSzuFoVmglny7mPp5Ebm299FggQxzGsyp2UtWIGliN2+IWWq2+T2NLpHRLU9YxQh8+I
C76ZN6KHhVHgOCV+C1lW7sGeBmr6y+HReZmwh9P3N20paQ2fkFX4JgLgDdtT2x3ABYQxIuLm
Aq7Glo+PO8Dln7E9kdS17Zm1Jcthn8YRcQLZRgm1SRIaDVkoHFhHEQ5seUGpbhKOKfOKwrRa
LJowbvYNJJD75v9A612JAQkotscBUMHcxgqUAMSViJoI5ebXi8Jmy3s/E7fne4pXSyTbsCfU
9VTCV0D+T+SJ7c/V0I7RbcbSno+e/TZZQ4BoLz3XK0WWv6tS/sc2v+UiIrauLWaLzp+/v78N
76HbzBrj5WvuQDiu1xCVPInR9+A0C5RQG5zqSXo5vz7Bk0mPz3J+/nm6t6yTVIo034E0btio
2vRjIdjuQKIiLOM4Ox5+d6bubJzn9vfFPOjX6VN+K1nI+sS1LlovVVz31kajUQfG21bKm/hW
GSNdK9RS5LZyY5uhdojYZRJCu7fjSW4+ZDlUH7Jk8b4idr1raap8z/bowdxoeMP7IlcPsAgX
IR1ZUgiMDrcy8l9zLbmCck1gBcS7RFPyNTwye4NhKmxIkXNbc2Dg+S7c3hBPXWk2bVk+wsCK
IolVRiNMtZAyMiPO0u3AhCAv+FlHs6hYC3hZGwYohR79I1xgEDwYy9vT68PfoNvgv+WTvulB
bHlVq59HHkxnbp8o/+69963IYRW44cKxjnwaKVhJjdGGIYRhga3PCpaCsTXQNFUHyOhy2rBU
xX4eVDr8cno93UOki8Ze5Frn2qhErSJo2Sv8dm/QrmepygAg/m1EPekol5kbyvhdDznqyu26
I+V3uW0i3bgdvT6enobec02ugetP7fZqiMM6rvnhGLMyuZW/j9bbLGYyK1SxBWRFv8O7T6EW
GQZDVh7BS00YztwmXMJDw2nc8Mzwj7QvrwxaKHt5/gU4JEU1lbIHGmyKTVb2K6YGEev/Bv4k
MNN5CBO8DI5FdWusY1pKJon6sdHfXb97E0s9u2rLAknRlgUVz/o7WpHy41aOqwSN2yDHbynB
PLXGuiYNX1C6QgxVZmc1PKJ3dZ6qLJmq9JZz/KwIiyoPbQ+ExpBYydH3yMy99oIUIZVXMnGM
BZubVJ7fZ5T24cpAWELLs3rjeIiv+X2tgXGCDhbe/MdxU6BuR3LharSNxm7GDpoe18IcCPCK
mNFH8KaYbF47eryi2sGqZc9v1Lto3WMaV6VLKP8U+Jok+109O4Bp5+PaXvS5G1o/jkqOsJ+B
BXIIr9RbkqAksmSTr1QIHi1jueF1b4KXBBAjSp2MO76HX511+Bw/rHY4ccOp8DRa+PgNawMH
joNZlgIq90pLT6RpxE0ggHATiU8MQDP1Ti0REUbiOSxPhAIKMtfOZx/hcm/dbEe4ylywmjIC
Bg4N09UQPK2Ih5w0LHx/SfeoxOfEPXsDL+e4WhLgiuVCivX4YFfpK8LbS6WG54pBI0ExUHeI
DVYQGjsF53mU5/RILEKGenKoGZE+Xu7PT/IIdn6RcwUmT/jl8Ts2aSLhzANcsJJbSSkaTy9z
69P0IlwH/sJ0W1QEn+BcOkNALmnzAEtRicT1/Wl/rmh/YhjVZKtoFlg8PmBZEToe4ztbQnEs
Cswvfm+6ozuwE7enYeeXvx+bVSs9Xd4saUxypgzCu0GYwDI3ogNckUi4s+WUQgK3XSOb74in
03/O9idEAg5i6uUoKxtNFyDTDcmQueeZBrU96BiWmCLE5FrMDSFTPXqjHkVJbi11uUEfUT8W
EdOsyDebd7wGn9zuU/NxCfUTbhANQ+ZmyDG52ew2u3I3AnkIFi1mToDRU2fqOhTgU8CcApYE
4OHfWLqzKQZUi9mCBJD63QRVbDrFdwnUtSBCrw4FUiJYZbDW4D7Ezl4NgfXCCab+GgcCd73B
EN9b+AIBIP5YidKLnOBPkSGySXwnECkKuFMMgKVKtd9gheNVsBjyJ+kc6YMkXSDjRVLRHBbI
aEzSAOkrSUW/FqBfw8u7RPNduigV+ZrcApy5gwxu2BvmPpK7Fp0JYOYipWwkCGRUprGz8LAU
qQhnixQZsC2C1VBjK2+J5MgisQhcpGuqbRpi1ZTSwTyYMwSoHB0FY0APXGwx2AfeInCQ4QzA
kgRcCkA6UdKTReBXyFzS0DxD5quE5u5ii8xxjcQYtI1YgXxGKd9EakVL1Is9vpe3p5n+W4oN
ob9v7CGwW5RbBhct7Zjle3ab74Zqpf3p7f7Lw8tfQ9XwVZTI11WXE34CDj/vwBpoH+EyuHKo
kPLzluZIeApnolGGhTN1SAYRyvWNRONdmY8WgK8WUzo5X0lhBreb3rM1+P9TCaXYP43Fqs/Q
wlWYA2QcK4FSx1mUl+3TbJaEKZdkx12T39sW4z2lbRrJ5Gp5cjwSn08PB7oHVqGcE3TmYbGj
+xfWJW+xWgQLkqWdi6MMyw8YgsViFF+O4WAdczdW/2NcHI6hh/ZB61v+yx+ny/nhOvHC0+uD
Nd9AjRyO9qIsQc8svL12/jBzyYNn3jglPj/eXybi8enx/uV5sjrdf/0OBzRD0wjXz7kQvPfW
qLAPmPqAB26Lf74/q7hVw0hp12Zdw2PulJnGtoJjvuChh3/g2/nh8WSo1vrIPTxCM9CYKgs9
O/6MJtWzxG0MLCxtuQIZ2EABC6Y96dI717jv1yNsvRocCq106ia9PY2ZFevrxjW7YGzhzAxJ
3CIf69rcZVTe4F3IcINfBcN7hZaKzSA37+zyO6z8Jh+E5DTV8iZWRSxwl1MSXAZSfMPBmPmL
uTMGEinTypVLFo4dwDI7oDBfm/0NxkaPttqtjzpgaJ+qokpsEKBOYRiF/a5bVeGhT+OlUlAO
qH1KVTcakD5d9WmPGLJCu+xpU1FklEc1acCtOZo4XiCxSLlmV+X9lqpqtrPiGTbkiC1mnouQ
l4F5fmimhCi8mXmAa8ovfC/xXNan76X4P8wkr+XgGOSh5okzaO+qLnzHH37x4PrBDCN7s2Em
Na/5sHODWYAUYu4HGNl3Z/NB/TR9iVbFmxFkuWSJQU7b+MB36TEv4VVLHNvEKc8G1QgPw+IC
Df2KAtTr2yteRsNRuI6PYWg+eSenlzJPug7M66bVpoJ3mPpZFXUpOQajqiHrN9iHo7yF1Ujn
qLmMZoxTNzgczPXUpKuqk2nlF2ourGaGysTV3JFjyrGpIluGztS1iXfh1Jv2GO9Kbz6zi6TS
Vzf7eBUy4qYW3iNhaVzi2l4V41hOfbk49OzHr3sYG+7xm9fT9y8gMwx2WLYxVAryB9w7zGc2
aXBHB0TK4QWwGrVLi0rb/wSekYzWuEIdwNJx8eBpCmSy4zAbdQDhJqT/KR7Yqn0TWjp+nz3d
4B0AGFV1wCg1vUpH327UG6be7SGHqDwVgqWFpIHpllla2+C/Ia7kfFa3LcckjIwjSgMDUU3S
JoybYYzdJfwQz8sNxwC5xW1i1j0vGD1epHT6D2kqFnFRJOzWKKSV7Et7VdeLbB2+PF9eniS5
zV7HtByKkBs2tEOQRPk/fWYWIdjCrawXvHBcdvxd/Pt8ZveMiBPr9RrlaWF8shHZ358fDPk8
32XdMwbs4T+n53t5Hkgen99/aNYJe73/8vh2vn97fzXlejNquvzR3bgapCJMbcJ2H5nRlYFU
sn3KI24TRfx5F2dhPz9J1nWyyfJ0AW8u28SUH6TAkZtvQjVFIolHeEWaZ4IoyzBdWYVIraGU
LdIFsbU4GrNJWcasF6RNpdejT0UIZ+itDHC1gd4g9M16kMcVlSsmbnalCkKFH4Es9HVMOzTa
gK2YSYJqQoEammYQR3C5kIMwisN+KQeeQHYdeAkjg8TTqmCEy7tCBWF+oftI2bLsnLlPmD2r
PIrdjDhkqjrLXkpZ5tq32V1IOKKlWOQEAeH6AnAiPCo2hYZJyw6Nc3/m02UecSK/wipgISEU
ANMuoO73W5jwF2ph4mpbwXsi+AVgd5XnETsx4FJoJhxnAQ3Z1JniVg4KTjnlOq8WmcMtFZ1F
pRYzN6CbXcJzKsSMgkm3ejVPWJmwkSaVi9YYLLe00eQ6e3qyqOxpWGdP42meEfEY1DJNY3G4
zT1CLSlhMEAkbsSvMBUHpmOIPtHfT3fO9Ibu1AanuzXOhOMt6IbX+MgHhLP06OEO8JyG12mA
hoNTG3HEOlm6R0b2aCCrBVw9ClnFNxTMMma90mej7WMSFF5zRmZc8W2UcgqWxPjAsorEW2UZ
US5v6s+G6DUgRQ9o7vZZHY9h3d4/tftlGwl6AQaQXnm3fM2JAKFqRIexs3Do9VPhaAgaPR9k
3wSHqV2nlpr2N+8bKXQ77sjXUhYLeULAjX0aEY16rAHgLHUJozQtcBy2dEuUHMJFEM6igKcx
EcyiQZf0lxXq06lFnvGw5ivCSk3JyhCiPKOrrkI+juwXDf7BPi0FqGqXC3oFrA+uS9fjNl0X
6GMZnVBHzYMeaEyEztttYJMO6UAnodWAvbGmfdAOLi0sag85zj4jopgyqiWksfpQ5PCSAz3O
IlWicD28+/jn8nb+BhGklRna6f3h8QUzRtNjYuiVoPRA4iVsUkJc6vXr+Xy5P8mzpExwfTlJ
8rCOB4I5VOcfp8uEP1/eXlWU68skT1nR8uffz8/N2U2X0b6c3UGtSnk6QbpW9dxqZ5xzthw5
tG/tlzeAhzpKSEx7LHRdb3oW9R4f0vnahNYXaw9Hmvym/931Gvlok9S6rVEKr35F1Igr9du+
x20YEYgd6cKC4j5kFlApJ0nbL5VPlskOCWNwVmoD2Q+vrSzDR2jDwTte+kuQfN3Tg2pqowjt
l806iBINKXaiiLOonzavhteBULTty+UNVCLwHs3T+RUzEFCTdb44TKfQ5sRnoWGHXaKoZZ5X
x+1udawqBK3gpd59+zyj9VEuCseZH/pfHfAs5oOS2XVvykYUfXctuq1vTQLHGc24DNh87ss5
2GPqWrexulBvKeIPeDFT6aKcfzunCoO4VxF4tMdIXsX/M9H64LwEteBZhZC5qHitP0/A5fFf
OvDs4+Vru8L9q11tvp3+mZyeLi+TP86T5/P54fzwvxOIwG9muD0/fVeL1ze4W4XA+6/feq9A
GuyDZtNkcomxeFjF1mzVm/YNuC7jOMxTHOQics0bPCvXot+oLSL/zyocElFUTpc05vs49mmX
9qIbmShL5H7EcAweMwUvORy9YaUd/dkEm8BtEIgtxC2/gTuBKPU722Pwuq5/O/0FD0IhOy2k
TaMwIBQXCoYYafJoQfRverU8hm/pdwbxlWUnxMLFFOyqvu1bOnYrtJ5PlKORWlzu9Oo+TDc4
KBgY42UIro29m5sOVDsxDpY3nlytUEy/HIhC4dabOYObHo3tt7yKtzHDTIsMNnkuhui9YZwo
10L8M4Xr9K+ZWqgZS2mAwnFaxBsUWVcRl6exHAd3GSjBUUw904QivGCfcaAk2iiONgOHyjG+
Y4XJyObokPOO6Cte7IlS8N1uPNeb+FYUEB5GPdeIZdFwfJBNIjhatJscXrMUId7gaVgdd67n
4mAuFnIGkph1M25hcjHKE4aC/23sWJbbxmG/kul9p4kdO86hB0qibNZ6VQ9H6UWTpm7j2bbJ
2M7s9O+XoESZD8DJJQ4BkCLBF0CCQMY2KcO5WCST6eUUReW1mC9m+DisirBYtDMUtyquWzwT
iznBb0B1BYucV5kIodThwRFY/8iOKO2tURXeB7z8DFdFWDVbFQ8WZwl4gMYZmaeZgKiyGK53
6Pb7tATbQimxFvNUzHENc8BOcD1bCTJRUze4Dtwrirys7hjh0VEJUyKfndlxEr6UA+6OOE9R
FGckNcn98l698iPuUftP0AXoVTK8vwmJt3s9mTLfJfHFCoKx06uViNQjfRKv1lzSV5RiNJgh
D1ej9KIopJoQbIirasULmhV1yaQKtBFByShvw6op+R0rZafSFDUnYjH0gj3cCce4Yx4gWDKX
kwMytd1CyuQZrQ6wcquCxUD2b5P6/kokxccqUqaWvmcNyB7AY1TDzkyDukDpisZhC5hgqJiv
TvVcRpjfpRU0o4AqsvRaAEkJJ19hvLgLKrxvVU0gFhqF56nnFmJAgTo8OHMaIJAatVjVHphd
yLozEPJN3qVM+LIqZKv3u58/rUarXHUplkvLksgEu1fcFg7CUw1RwDC0FLrKOuCmrmDhdbBV
24gUZDAwnRWJ479upBDybyYClmF7Do9YqJlVbkFmBvn88PrtoI6FLK4BLalhKWSa6gJNKL+Z
TVoHJhaT25uZB51aFpI9bOY4S4RX3qqT0dZGKUPOSE7salpkndIz3D5WbMB1h4jxxQC8faSt
N3Li3f63MgDxpgyPLGVfJiFSF94GniRdGTQ4MowChh3ERKmwz9z6SB4iiCHGaeYfFsQ7iJ8+
9rOuWFtPOvOEaAB0LYQS8cFFXolWDsPER1U8bEph+rIayxLG/ZGblkRTtwZTvAZTugZTpwYn
zrf1tYoJijHxs+2SSCbJES+LTwMVltIanVxIcSiuOiJI8GcPdSrObMiYoaXLWsbVhMKByYeL
1AMlkzJvbPSKIAByyzMXsy9NXjMnqaMtqUugMmbm1qNOlQYyuS1njufWL3Fadxvs+rHHTJxP
WTECwUBYMcYFXVuwGJwPmYBBDx+Y3K9uKtbTx2gTqRnhTQipON7O55dWMZ/zRJjuJ75KIutU
NYo7N50l47YU5dXHmNUfsxr/pMRZ2dNK5rAgG5cE0nqHgDvLAk7JFvMZhhc5CKWVbMCH1+OP
xRgnOat7lhrqhgJRM0Ahy/HkvjhsX78/X/zAWnQKv2UC1rZ3GQWr7iurp7Wp7ZCs08JL4hNn
1UhRLQmI+TFgu8IxchzQ/Y8eYcgRu93K0/4S0dOVxTSO97G2qcrSGSWqSBoSHXA6a3CmOjQq
LFlKoDZn1iow/W7JRhR0xi9Ze01j5cylkXLouMv8aQOn1mFwepuXa/DXyGUBtRRAT8Mt0xPE
SG+mNn4ztfciBbu20pFVQiTXOi9L5JYbYQVHVsmgABhFq6RFwFs4jnIbIAsdr70sxPhkSfOz
ycrCMK7v093SNJ8fYOD7a2p8WcLkXgyk3boMZuYSY6CqYp0SxgBpgHeXFNCsBQvSEPC9JkYv
oO84W3fFHVzO4U7rFJWSNmi0WhTxgwuFl7zmcHCb1YT7vCwsyDmWR4xeRdyB2y++D1J0V4/i
6r8v5qVpIbUKCHaV9U9mQ/vKi8kVODvR4KJEFb9BwVKxZG/R1KwUb9CkLMQprH1wpDgNL6le
KtUqYYFpPNQvOlUTIFmqPJEVkt28mGMlgrcyKbRwrNgkSq0sJ70SC1NxGsPLt9ovN+dSVvg8
kZxhb1Coa5yzjOSxwFsAS+Z8cTZvL8ecEqPtxofd4XmxmN3+c/XBGOVJNcoj3fUUd05tEd28
i+gGcw1tkSxsRzoODp+5DhHufckhekdtF3P8jNEhIpzF20TvqThxWOgQYVZeDsmM5iARb8kh
wq2YLaLb6TtKuiVssJ2S3sGc2+t31GlxgxurApEU9WGUd7hZpVXM1eQ91ZZUmBYENKwKhbBn
m/78lds1GkHzQFPQo0NTvN16empoCrpXNQU9czQF3VUjG95uzBU10EcCb5ivc7Ho8M1/RGO3
b4Bs6th4ARwlqZUYw96oXXu93f/Z/rp4enj81wqpA457OfgyjBO2rDCvDf2zDXXeiK3vKsCH
0rrlB4uSh6zmhp3MgE+bSmqL4A3RUCSlfN/n/DS5vF6MWymDsJFyezD9KzYZuJyGqJRBbu4K
vfMR+83JirOIg28g+Bxx7AW51hA7JUHapP2XLYeXK9bGK5uXhfdkcLwyh+dPY8Qg9ZAaYoCi
1HaYopKnec3JSEAVg9fpmGS6ArtGZQS2XkaGVUCWZ31MRDhM3Vh+ZZW32aFrT1CQUNKiAI3d
OKLJ+3BRXX1f8O6yXVx+uqRwsuevcFyj/v80wbGypvzT1MOpj5nnjCcEFVNGUzReiCufJnMc
uI/drw8vjCpqe9Fq+/i63x3/+lZvcMVtVhbSw1DqjyD4PdZ5/tGlhmgFkcZ0bVymCDpkBVPn
9IJXCBoUTpfmNMw0FRi2wSO0M3UeWQWeT0EGlpJ/VFo25pqy4onIGixKljqPyMczsv3fl+Nz
7/fieX/xtP31st2fmNwTg/tBVhjblQbLme8Bg2QdimJlni8OGNDKPGDKMrlV+sTL+GqysF72
DYisseOJDGD1g12E6Lo29YpnIZITvS9jr8en7Z/j7vHhuP1+wf88Ap9ACftvd3y6YIfD8+NO
oaKH44PHr9A0GdMNQmAV/yLGGAPBr+fHfy9+P383lTxdYBB6mcPa51poxm0fYDwMkFYnJRZg
dkAW/ffcPG3tq6erh8MTUelVyvxat33Rw+Pan9vD0W9sGU4nfs40ukZgMx8mwhXjSWcFp9AM
X7ErDDiZzTHw7GrigetlCc7SXPBd0RP3s2r38mTdEY0Txu8eCVMbwdxvHcuaQCA5ytCnDVTA
LWSCwTP+JDFfwIyIqva5B1CfFxFS8dgJzjiA1yv2lUXI6KnA6J14imaTDPygx2fFub/wgI9+
KzDQOL/9tsvlHGXWAPcOyBz02F/DG/DfL/vt4WDZtI6Mc+K76On3NUdYtMLmpBI31hvrEY56
3gFB8Jiry/fX3Ltv+4f934v98+tx98ecmoGoSw4OM4wq6asTuEsEGUmKjuCoGsdnvHXQcrqC
b47aBl3NbQpRN51NMbUmUWg45UlE4K4BXyUMLrxtZiqox2LJW+VUCUxsbGjEfXgtG1RxEOcw
WLc2nV0a8CBFwXFlwItEVObLCSY1k9ySC3uQ88CCqfCUMLr+BzPUjwki4AAA

--Boundary_(ID_uD/j1rpSj0NGc0xbApAImg)--
