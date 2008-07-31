From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: Re: PROBLEM: Computer hangs when closing lid on my HP 6510b
Date: Thu, 31 Jul 2008 12:45:59 +0100
Message-ID: <1217504759.18934.7.camel@segulix.localdomain>
References: <20080731110440.GA3752@s.zortor.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-6pzNOuIHa1YWajRYrUVu"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:50515 "HELO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751774AbYGaLqV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Jul 2008 07:46:21 -0400
In-Reply-To: <20080731110440.GA3752@s.zortor.local>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: c <daniel@visp.name>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org


--=-6pzNOuIHa1YWajRYrUVu
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


We know about a lot HP and others having problems with _DOS=3D0 and
freezing on LID:
https://bugzilla.novell.com/show_bug.cgi?id=3D378917 (-> a lot duplicates)
https://bugzilla.novell.com/show_bug.cgi?id=3D290219

Someone said :
echoing "1" into /proc/acpi/video/*/DOS keeps
the machine from crashing


On Thu, 2008-07-31 at 13:04 +0200, c wrote:
> This is my first bugreport, so please dont chop my head off :)
> Sections are numbered as described in the REPORTING-BUGS file.
>=20
> [1.]
> 	Computer hangs when closing lid on my HP 6510b
>=20
> [2.]
> 	When closing the lid on my HP 6510b, the computer hangs.
> 	I managed to get some kernelmessages out via netconsole.
> 	I believe the bug is somewhere in kacpid.
>=20
> [3.]
> 	kacpid, oops, HP 6510b
>=20
> [4.1]
> 	Linux version 2.6.26 (root@barney) (gcc version 4.3.1 (Debian 4.3.1-2) )=
 #1 SMP PREEMPT Sun Jul 27 23:38:38 CEST 2008
>=20
> [4.2]
> 	Kernel configuration is sent as an attachment
>=20
> [6.]
> 	Kernel output 1
> 	=09
> 		SysRq : Changing Loglevel
> 		Loglevel set to 9
> 		BUG: unable to handle kernel paging request at ffff8100bf0d6780
> 		IP:ACPI Error (exregion-0107): Invalid SystemMemory width 256 [20080321=
]
> 		BUG: unable to handle kernel <3>BUG: scheduling while atomic: kacpid/16=
0/0x00000104
> 		Pid: 160, comm: kacpid Not tainted 2.6.26 #1
> 	=09
> 		Call Trace:
> 		 [<ffffffff807e3980>] thread_return+0xfd/0x5bd
> 		 [<ffffffff8040b751>] acpi_ut_allocate_object_desc_dbg+0x34/0x6d
> 		 [<ffffffff802464f4>] lock_timer_base+0x34/0x70
> 		 [<ffffffff802466e0>] __mod_timer+0xb0/0xd0
> 		BUG: unable to handle kernel paging request [<ffffffff807e4129>] schedu=
le_timeout+0x79/0xf0
> 		 at ffff8100bf2db6b0
> 		IP: [<ffffffff [<bfff8f02bfb6bb6b0>]
> 	=09
> 		 [<ffffffff803ff614>] acpi_ex_system_do_suspend+0x11/0x1a
> 		 [<ffffffff803f6ca9>] acpi_ds_exec_end_op+0xf3/0x3c6
> 		 [<ffffffff8040643b>] acpi_ps_parse_loop+0x693/0x814
> 		 [<ffffffff804056f0>] acpi_ps_parse_aml+0x7f/0x299
> 		 [<ffffffff803f4794>] acpi_os_execute_deferred+0x0/0x2c
> 		 [<ffffffff80406b65>] acpi_ps_execute_method+0x14e/0x21d
> 		 [<ffffffff804039c2>] acpi_ns_evaluate+0xa2/0xfc
> 		 [<ffffffff803fb73a>] acpi_ev_asynch_execute_gpe_method+0xc6/0x11a
> 		 [<ffffffff803f47b7>] acpi_os_execute_deferred+0x23/0x2c
> 		 [<ffffffff8024e4e6>] run_workqueue+0x86/0x150
> 		 [<ffffffff8024e64f>] worker_thread+0x9f/0x110
> 		 [<ffffffff802528d0>] autoremove_wake_function+0x0/0x30
> 		PGD 8063 PUD b063 PMD 80000000bf2001e3=20
> 		Oops: 0011 [1] PREEMPT SMP=20
> 		CPU 1=20
> 		Modules linked in: ntfs hci_usb
> 		Pid: 160, comm: kacpid Not tainted 2.6.26 #1
> 		RIP: 0010:[<ffff8100bf2db6b0>]  [<ffff8100bf2db6b0>]
> 		RSP: 0018:ffff8100bf2db678  EFLAGS: 00010006
> 		RAX: ffff8100bf2dbfd8 RBX: ffff810001047080 RCX: 0000000000000018
> 		RDX: 0000000000000106 RSI: 0000000000000046 RDI: ffffffff80b60ce4
> 		RBP: 0000000000000074 R08: ffff8100000bad56 R09: 0000000000000000
> 		R10: ffffffff80b0d8c0 R11: ffffffff803f0e20 R12: 000000000000000e
> 		R13: 000000000000002b R14: 0000000000000000 R15: ffffffff80b1780a
> 		FS:  0000000000000000(0000) GS:ffff8100bf086b40(0000) knlGS:00000000000=
00000
> 		CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> 		CR2: ffff8100bf2db6b0 CR3: 0000000000201000 CR4: 00000000000006e0
> 		DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> 		DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> 		Process kacpid (pid: 160, threadinfo ffff8100bf2da000, task ffff8100bf2=
d9800)
> 		Stack:  0000000000000000 ffff8100000bad3a ffff810001047080 ffffffff0000=
0074
> 		 0000000000000087 3830323532383330 6666666666666666 000000000000000e
> 		 00000000ffffff11 0000000000000046 ffff8100bf2db738 ffffffff8023b525
> 		Call Trace:
> 		 [<ffffffff8023b525>] ? __call_console_drivers+0x65/0x80
> 		 [<ffffffff8023b965>] ? release_console_sem+0x45/0x1f0
> 		 [<ffffffff80212d20>] ? nommu_map_single+0x0/0xa0
> 		 [<ffffffff8024e5b0>] worker_thread+0x0/0x110
> 		 [<ffffffff80252527>] kthread+0x47/0x90
> 		 [<ffffffff80238557>] schedule_tail+0x27/0x60
> 		 [<ffffffff8020c6a8>] child_rip+0xa/0x12
> 		 [<ffffffff802524e0>] kthread+0x0/0x90
> 		 [<ffffffff804d23bb>] ? write_msg+0xcb/0x110
> 		 [<ffffffff8023b525>] ? __call_console_drivers+0x65/0x80
> 		 [<ffffffff8023b974>] ? release_console_sem+0x54/0x1f0
> 		 [<ffffffff8023c0e5>] ? vprintk+0x375/0x450
> 		 [<ffffffff802524e0>] ? kthread+0x0/0x90
> 		 [<ffffffff802524e0>] ? kthread+0x0/0x90
> 		 [<ffffffff802524e0>] ? kthread+0x0/0x90
> 		 [<ffffffff8020c69e>] child_rip+0x0/0x12
> 	=09
> 		 [<ffffffff80265fdb>] ? kallsyms_lookup+0x3b/0x140
> 		 [<ffffffff8020c69e>] ? child_rip+0x0/0x12
> 		 [<ffffffff80256ec0>] ? down_trylock+0x30/0x50
> 		 [<ffffffff8023b8b0>] ? try_acquire_console_sem+0x10/0x40
> 		 [<ffffffff8023c140>] ? vprintk+0x3d0/0x450
> 		 [<ffffffff8025016f>] ? __kernel_text_address+0x2f/0x60
> 		 [<ffffffff80230fb1>] ? dequeue_entity+0x21/0xc0
> 		 [<ffffffff80230f60>] ? __dequeue_entity+0x60/0x90
> 		 [<ffffffff8023292f>] ? pick_next_task_fair+0xaf/0xc0
> 		 [<ffffffff8040b751>] ? acpi_ut_allocate_object_desc_dbg+0x34/0x6d
> 		 [<ffffffff802464f4>] ? lock_timer_base+0x34/0x70
> 		 [<ffffffff802466e0>] ? __mod_timer+0xb0/0xd0
> 		 [<ffffffff807e4129>] ? schedule_timeout+0x79/0xf0
> 		 [<ffffffff802460e0>] ? process_timeout+0x0/0x10
> 		 [<ffffffff803ff614>] ? acpi_ex_system_do_suspend+0x11/0x1a
> 		 [<ffffffff803f6ca9>] ? acpi_ds_exec_end_op+0xf3/0x3c6
> 		 [<ffffffff8040643b>] ? acpi_ps_parse_loop+0x693/0x814
> 		 [<ffffffff804056f0>] ? acpi_ps_parse_aml+0x7f/0x299
> 		 [<ffffffff803f4794>] ? acpi_os_execute_deferred+0x0/0x2c
> 		 [<ffffffff80406b65>] ? acpi_ps_execute_method+0x14e/0x21d
> 		 [<ffffffff804039c2>] ? acpi_ns_evaluate+0xa2/0xfc
> 		 [<ffffffff803fb73a>] ? acpi_ev_asynch_execute_gpe_method+0xc6/0x11a
> 		 [<ffffffff803f47b7>] ? acpi_os_execute_deferred+0x23/0x2c
> 		 [<ffffffff8024e4e6>] ? run_workqueue+0x86/0x150
> 		 [<ffffffff8024e64f>] ? worker_thread+0x9f/0x110
> 		 [<ffffffff802528d0>] ? autoremove_wake_function+0x0/0x30
> 		 [<ffffffff8024e5b0>] ? worker_thread+0x0/0x110
> 		 [<ffffffff80252527>] ? kthread+0x47/0x90
> 		 [<ffffffff80238557>] ? schedule_tail+0x27/0x60
> 		 [<ffffffff8020c6a8>] ? child_rip+0xa/0x12
> 		BUG: workqueue leaked lock or atomic: kacpi_notify/0xffffffff/161
> 		 [<ffffffff802524e0>] ? kthread+0x0/0x90
> 		 [<ffffffff8020c69e>] ? child_rip+0x0/0x12
> 	=09
> 	=09
> 		Code: 81 ff ff 86 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00=
 00 00 00 00 00 32 31 36 63 30 32 30 38 66 66 66 66 66 66 66 66 18 00 00 00=
 00 00 00 00 65 8e 2a 80 ff ff ff ff 46 00 00 00 00=20
> 		RIP  [<0000000000000001>]
> 		 RSP <ffffffff809d3a48>
> 		CR2: ffff8100bf2db6b0
> 		---[ end trace 99cb9eda96011921 ]---
> 		Kernel panic - not syncing: Aiee, killing interrupt handler!
> =09
> 	Kernel output 2
> 	=09
>=20
> 		SysRq : Changing Loglevel
> 		Loglevel set to 9
> 		huh, entered ffffffff802460e0 with preempt_count 000000ff, exited with =
000000fe?
> 		------------[ cut here ]------------
> 		kernel BUG at kernel/timer.c:805!
> 		invalid opcode: 0000 [1] PREEMPT SMP=20
> 		BUG: scheduling while atomic: kacpid/160/0x000000fc
> 		CPU 1:
> 		Modules linked in: ntfs hci_usb
> 		Pid: 160, comm: kacpid Not tainted 2.6.26 #1
> 		RIP: 0000:[<ffffffff8023b8b0>]  [<ffffffff8023b8b0>] try_acquire_consol=
e_sem+0x10/0x40
> 		RSP: 1bf2d7988:0000000000000002  EFLAGS: ffffffff8023c140
> 		RAX: 0000000000000400 RBX: 0000000000000018 RCX: ffffffff809cc710
> 		RDX: ffffffff80256ec0 RSI: 0000000000000001 RDI: ffffffff80b0d502
> 		RBP: ffffc20000004195 R08: ffff8100bf2d79e0 R09: ffff8100bf2d7ab8
> 		R10: 0000003000000030 R11: ffffffff807e957a R12: 0000000000000001
> 		R13: 0000000000000002 R14: 0000000000000001 R15: ffffffff8023b8b0
> 		FS:  0000000000000000(0000) GS:ffff8100bf086b40(0000) knlGS:00000000000=
00000
> 		CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> 		CR2: 00007f69d5bfd000 CR3: 0000000000201000 CR4: 00000000000006e0
> 		DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> 		DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> 	=09
> 		Call Trace:
> 		 [<ffffffff8023b8b0>] ? try_acquire_console_sem+0x10/0x40
> 		 [<ffffffff8020db04>] ? printk_address+0xc4/0xf0
> 		 [<ffffffff8023c140>] ? vprintk+0x3d0/0x450
> 		 [<ffffffff8020eab8>] ? print_trace_address+0x18/0x30
> 		 [<ffffffff8025016f>] ? __kernel_text_address+0x2f/0x60
> 		 [<ffffffff8025016f>] ? __kernel_text_address+0x2f/0x60
> 		 [<ffffffff8020d00d>] ? dump_trace+0x16d/0x410
> 		 [<ffffffff8020d2fd>] ? show_trace+0x4d/0x80
> 		 [<ffffffff807e3980>] ? thread_return+0xfd/0x5bd
> 		 [<ffffffff8040b751>] ? acpi_ut_allocate_object_desc_dbg+0x34/0x6d
> 		 [<ffffffff802464f4>] ? lock_timer_base+0x34/0x70
> 		 [<ffffffff802466e0>] ? __mod_timer+0xb0/0xd0
> 		 [<ffffffff807e4129>] ? schedule_timeout+0x79/0xf0
> 		 [<ffffffff802460e0>] ? process_timeout+0x0/0x10
> 		 [<ffffffff803ff614>] ? acpi_ex_system_do_suspend+0x11/0x1a
> 		 [<ffffffff803f6ca9>] ? acpi_ds_exec_end_op+0xf3/0x3c6
> 		 [<ffffffff8040643b>] ? acpi_ps_parse_loop+0x693/0x814
> 		 [<ffffffff804056f0>] ? acpi_ps_parse_aml+0x7f/0x299
> 		 [<ffffffff803f4794>] ? acpi_os_execute_deferred+0x0/0x2c
> 		 [<ffffffff80406b65>] ? acpi_ps_execute_method+0x14e/0x21d
> 		 [<ffffffff804039c2>] ? acpi_ns_evaluate+0xa2/0xfc
> 		 [<ffffffff803fb73a>] ? acpi_ev_asynch_execute_gpe_method+0xc6/0x11a
> 		 [<ffffffff803f47b7>] ? acpi_os_execute_deferred+0x23/0x2c
> 		 [<ffffffff8024e4e6>] ? run_workqueue+0x86/0x150
> 		 [<ffffffff8024e64f>] ? worker_thread+0x9f/0x110
> 		 [<ffffffff802528d0>] ? autoremove_wake_function+0x0/0x30
> 		 [<ffffffff8024e5b0>] ? worker_thread+0x0/0x110
> 		 [<ffffffff80252527>] ? kthread+0x47/0x90
> 		 [<ffffffff80238557>] ? schedule_tail+0x27/0x60
> 		 [<ffffffff8020c6a8>] ? child_rip+0xa/0x12
> 		 [<ffffffff802524e0>] ? kthread+0x0/0x90
> 		 [<ffffffff8020c69e>] ? child_rip+0x0/0x12
> 	=09
> 		CPU 1=20
> 		Modules linked in: ntfs hci_usb
> 		Pid: 1320, comm: w1_control Not tainted 2.6.26 #1
> 		RIP: 0010:[<ffffffff80245e51>]  [<ffffffff80245e51>] run_timer_softirq+=
0x211/0x220
> 		RSP: 0018:ffff8100bf0bfec0  EFLAGS: 00010286
> 		RAX: 0000000000000054 RBX: ffff8100bf1b1840 RCX: ffff8100bcd85e60
> 		RDX: 00000000000000f9 RSI: 0000000000000082 RDI: ffffffff809cc6c0
> 		RBP: ffff8100bf0b4000 R08: 000000000000060b R09: 00000001079028ab
> 		R10: 0000000000000000 R11: 0000000000000001 R12: 00000000000000ff
> 		R13: ffff8100bf0bfee0 R14: ffffffff802460e0 R15: ffff8100bf0b5018
> 		FS:  0000000000000000(0000) GS:ffff8100bf086b40(0000) knlGS:00000000000=
00000
> 		CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> 		CR2: 00007f2aeff03000 CR3: 0000000000201000 CR4: 00000000000006e0
> 		DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> 		DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> 		Process w1_control (pid: 1320, threadinfo ffff8100be076000, task ffff81=
00bf1b1840)
> 		Stack:  00000000000242f2 ffff8100bf0b5c18 ffff8100bf0b5818 ffff8100bf0b=
5418
> 		 ffff8100bf0bfee0 ffff8100bf0bfee0 ffffffff8025651c ffffffff80a83190
> 		 0000000000000021 000000000000000a ffffffff80af09a0 0000000000000001
> 		Call Trace:
> 		 <IRQ>  [<ffffffff8025651c>] ? ktime_get+0xc/0x50
> 		 [<ffffffff802417aa>] ? __do_softirq+0x7a/0xf0
> 		 [<ffffffff8020ca1c>] ? call_softirq+0x1c/0x30
> 		 [<ffffffff8020eb05>] ? do_softirq+0x35/0x70
> 		 [<ffffffff80241545>] ? irq_exit+0xa5/0xb0
> 		 [<ffffffff8021f40d>] ? smp_apic_timer_interrupt+0x7d/0xc0
> 		 [<ffffffff8020c4c6>] ? apic_timer_interrupt+0x66/0x70
> 		 <EOI>=20
> 	=09
> 		Code: 59 00 48 83 c4 38 5b 5d 41 5c 41 5d 41 5e 41 5f c3 8b 88 44 e0 ff=
 ff 44 89 e2 4c 89 f6 48 c7 c7 f0 e4 90 80 31 c0 e8 db 36 5a 00 <0f> 0b eb =
fe 66 66 2e 0f 1f 84 00 00 00 00 00 41 54 b9 0e 00 00=20
> 		RIP  [<ffffffff80245e51>] run_timer_softirq+0x211/0x220
> 		 RSP <ffff8100bf0bfec0>
> 		---[ end trace b338748305b49ecb ]---
> 		Kernel panic - not syncing: Aiee, killing interrupt handler!
>=20
> [8.1.]
> 	If some fields are empty or look unusual you may have an old version.
> 	Compare to the current minimal requirements in Documentation/Changes.
> 	=20
> 	Linux barney 2.6.26 #1 SMP PREEMPT Sun Jul 27 23:38:38 CEST 2008 x86_64 =
GNU/Linux
> 	=20
> 	Gnu C                  4.3.1
> 	Gnu make               3.81
> 	binutils               2.18.0.20080103
> 	util-linux             2.13.1.1
> 	mount                  2.13.1.1
> 	module-init-tools      3.4
> 	e2fsprogs              1.40.8
> 	pcmciautils            014
> 	PPP                    2.4.4
> 	Linux C Library        2.7
> 	Dynamic linker (ldd)   2.7
> 	Procps                 3.2.7
> 	Net-tools              1.60
> 	Console-tools          0.2.3
> 	Sh-utils               6.10
> 	udev                   114
> 	wireless-tools         29
> 	Modules Loaded         ntfs
>=20
> [8.2.]
> =09
> 	processor	: 0
> 	vendor_id	: GenuineIntel
> 	cpu family	: 6
> 	model		: 15
> 	model name	: Intel(R) Core(TM)2 Duo CPU     T7250  @ 2.00GHz
> 	stepping	: 13
> 	cpu MHz		: 800.000
> 	cache size	: 2048 KB
> 	physical id	: 0
> 	siblings	: 2
> 	core id		: 0
> 	cpu cores	: 2
> 	apicid		: 0
> 	initial apicid	: 0
> 	fpu		: yes
> 	fpu_exception	: yes
> 	cpuid level	: 10
> 	wp		: yes
> 	flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov p=
at pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm cons=
tant_tsc arch_perfmon pebs bts rep_good pni monitor ds_cpl vmx est tm2 ssse=
3 cx16 xtpr lahf_lm ida
> 	bogomips	: 3996.54
> 	clflush size	: 64
> 	cache_alignment	: 64
> 	address sizes	: 36 bits physical, 48 bits virtual
> 	power management:
> =09
> 	processor	: 1
> 	vendor_id	: GenuineIntel
> 	cpu family	: 6
> 	model		: 15
> 	model name	: Intel(R) Core(TM)2 Duo CPU     T7250  @ 2.00GHz
> 	stepping	: 13
> 	cpu MHz		: 800.000
> 	cache size	: 2048 KB
> 	physical id	: 0
> 	siblings	: 2
> 	core id		: 1
> 	cpu cores	: 2
> 	apicid		: 1
> 	initial apicid	: 1
> 	fpu		: yes
> 	fpu_exception	: yes
> 	cpuid level	: 10
> 	wp		: yes
> 	flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov p=
at pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm cons=
tant_tsc arch_perfmon pebs bts rep_good pni monitor ds_cpl vmx est tm2 ssse=
3 cx16 xtpr lahf_lm ida
> 	bogomips	: 3991.24
> 	clflush size	: 64
> 	cache_alignment	: 64
> 	address sizes	: 36 bits physical, 48 bits virtual
> 	power management:
>=20
> [8.3.]
> 	ntfs 209856 1 - Live 0xffffffffa0000000
>=20
> [8.4.]
> 	ioports:
> 		0000-001f : dma1
> 		0020-0021 : pic1
> 		0040-0043 : timer0
> 		0050-0053 : timer1
> 		0060-0060 : keyboard
> 		0064-0064 : keyboard
> 		0070-0077 : rtc
> 		0080-008f : dma page reg
> 		00a0-00a1 : pic2
> 		00c0-00df : dma2
> 		00f0-00ff : fpu
> 		0170-0177 : 0000:00:1f.1
> 		  0170-0177 : ICH8M
> 		01f0-01f7 : 0000:00:1f.1
> 		  01f0-01f7 : ICH8M
> 		0376-0376 : 0000:00:1f.1
> 		  0376-0376 : ICH8M
> 		0378-037a : parport0
> 		037b-037f : parport0
> 		03c0-03df : vga+
> 		03f6-03f6 : 0000:00:1f.1
> 		  03f6-03f6 : ICH8M
> 		04d0-04d1 : pnp 00:0c
> 		0500-057f : pnp 00:0a
> 		0800-080f : pnp 00:0a
> 		0cf8-0cff : PCI conf1
> 		1000-107f : 0000:00:1f.0
> 		  1000-107f : pnp 00:0c
> 		    1000-1003 : ACPI PM1a_EVT_BLK
> 		    1004-1005 : ACPI PM1a_CNT_BLK
> 		    1008-100b : ACPI PM_TMR
> 		    1010-1015 : ACPI CPU throttle
> 		    1020-1020 : ACPI PM2_CNT_BLK
> 		    1028-102f : ACPI GPE0_BLK
> 		    1060-107f : iTCO_wdt
> 		1100-113f : 0000:00:1f.0
> 		  1100-113f : pnp 00:0c
> 		1200-121f : pnp 00:0c
> 		1370-1377 : 0000:00:1f.2
> 		  1370-1377 : ahci
> 		13f0-13f7 : 0000:00:1f.2
> 		  13f0-13f7 : ahci
> 		1574-1577 : 0000:00:1f.2
> 		  1574-1577 : ahci
> 		15f4-15f7 : 0000:00:1f.2
> 		  15f4-15f7 : ahci
> 		2000-3fff : PCI Bus 0000:28
> 		4000-4007 : 0000:00:02.0
> 		4020-403f : 0000:00:1a.0
> 		  4020-403f : uhci_hcd
> 		4040-405f : 0000:00:1a.1
> 		  4040-405f : uhci_hcd
> 		4060-407f : 0000:00:1d.0
> 		  4060-407f : uhci_hcd
> 		4080-409f : 0000:00:1d.1
> 		  4080-409f : uhci_hcd
> 		40a0-40bf : 0000:00:1d.2
> 		  40a0-40bf : uhci_hcd
> 		40c0-40cf : 0000:00:1f.1
> 		  40c0-40cf : ICH8M
> 		4100-411f : 0000:00:1f.2
> 		  4100-411f : ahci
> 		5000-5fff : PCI Bus 0000:02
> 		  5000-50ff : PCI CardBus 0000:03
> 		  5400-54ff : PCI CardBus 0000:03
> =09
> 	iomem:
> 		00000000-0009fbff : System RAM
> 		0009fc00-0009ffff : reserved
> 		000cee00-000cffff : pnp 00:0d
> 		000e0000-000fffff : reserved
> 		00100000-bf7affff : System RAM
> 		  00200000-007e9377 : Kernel code
> 		  007e9378-00a82cf7 : Kernel data
> 		  00af5000-00b8454f : Kernel bss
> 		bf7b0000-bf7c53ff : reserved
> 		bf7c5400-bf7e7fb7 : ACPI Non-volatile Storage
> 		bf7e7fb8-bfffffff : reserved
> 		c4000000-c7ffffff : PCI CardBus 0000:03
> 		c8000000-c8000fff : Intel Flush Page
> 		c8400000-c87fffff : PCI CardBus 0000:03
> 		d0000000-dfffffff : 0000:00:02.0
> 		e0000000-e3ffffff : PCI Bus 0000:28
> 		e4000000-e40fffff : PCI Bus 0000:18
> 		  e4000000-e400ffff : 0000:18:00.0
> 		    e4000000-e400ffff : tg3
> 		e4100000-e41fffff : PCI Bus 0000:10
> 		  e4100000-e4100fff : 0000:10:00.0
> 		    e4100000-e4100fff : iwl3945
> 		e4200000-e45fffff : PCI Bus 0000:02
> 		  e4200000-e4200fff : 0000:02:04.0
> 		    e4200000-e4200fff : yenta_socket
> 		  e4201000-e42017ff : 0000:02:04.1
> 		    e4201000-e42017ff : firewire_ohci
> 		e4600000-e46fffff : 0000:00:02.0
> 		e4700000-e47fffff : 0000:00:02.1
> 		e4800000-e48003ff : 0000:00:1a.7
> 		  e4800000-e48003ff : ehci_hcd
> 		e4804000-e4807fff : 0000:00:1b.0
> 		  e4804000-e4807fff : ICH HD audio
> 		e4808000-e48083ff : 0000:00:1d.7
> 		  e4808000-e48083ff : ehci_hcd
> 		e4809000-e48097ff : 0000:00:1f.2
> 		  e4809000-e48097ff : ahci
> 		f8000000-fbffffff : PCI MMCONFIG 0
> 		  f8000000-fbffffff : pnp 00:0c
> 		fec00000-fec00fff : IOAPIC 0
> 		  fec00000-fec00fff : reserved
> 		fed00000-fed003ff : HPET 0
> 		fed20000-fed99fff : reserved
> 		feda0000-fedbffff : reserved
> 		fee00000-fee00fff : Local APIC
> 		  fee00000-fee00fff : reserved
> 		ffb00000-ffbfffff : reserved
> 		fff00000-ffffffff : reserved
>=20
> [8.5.]
> =09
> 	00:00.0 Host bridge: Intel Corporation Mobile PM965/GM965/GL960 Memory C=
ontroller Hub (rev 0c)
> 		Subsystem: Hewlett-Packard Company Device 30c0
> 		Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
> 		Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort+ >SERR- <PERR- INTx-
> 		Latency: 0
> 		Capabilities: [e0] Vendor Specific Information <?>
> 		Kernel driver in use: agpgart-intel
> =09
> 	00:02.0 VGA compatible controller: Intel Corporation Mobile GM965/GL960 =
Integrated Graphics Controller (rev 0c)
> 		Subsystem: Hewlett-Packard Company Device 30c0
> 		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
> 		Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
> 		Latency: 0
> 		Interrupt: pin A routed to IRQ 16
> 		Region 0: Memory at e4600000 (64-bit, non-prefetchable) [size=3D1M]
> 		Region 2: Memory at d0000000 (64-bit, prefetchable) [size=3D256M]
> 		Region 4: I/O ports at 4000 [size=3D8]
> 		Capabilities: [90] Message Signalled Interrupts: Mask- 64bit- Queue=3D0=
/0 Enable-
> 			Address: 00000000  Data: 0000
> 		Capabilities: [d0] Power Management version 3
> 			Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3=
cold-)
> 			Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
> 			Bridge: PM- B3+
> =09
> 	00:02.1 Display controller: Intel Corporation Mobile GM965/GL960 Integra=
ted Graphics Controller (rev 0c)
> 		Subsystem: Hewlett-Packard Company Device 30c0
> 		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
> 		Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
> 		Latency: 0
> 		Region 0: Memory at e4700000 (64-bit, non-prefetchable) [size=3D1M]
> 		Capabilities: [d0] Power Management version 3
> 			Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3=
cold-)
> 			Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
> 			Bridge: PM- B3+
> =09
> 	00:1a.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI =
Controller #4 (rev 03)
> 		Subsystem: Hewlett-Packard Company Device 30c0
> 		Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
> 		Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR- INTx-
> 		Latency: 0
> 		Interrupt: pin A routed to IRQ 16
> 		Region 4: I/O ports at 4020 [size=3D32]
> 		Kernel driver in use: uhci_hcd
> =09
> 	00:1a.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI =
Controller #5 (rev 03)
> 		Subsystem: Hewlett-Packard Company Device 30c0
> 		Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
> 		Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR- INTx-
> 		Latency: 0
> 		Interrupt: pin B routed to IRQ 17
> 		Region 4: I/O ports at 4040 [size=3D32]
> 		Kernel driver in use: uhci_hcd
> =09
> 	00:1a.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI=
 Controller #2 (rev 03) (prog-if 20)
> 		Subsystem: Hewlett-Packard Company Device 30c0
> 		Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
> 		Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR- INTx-
> 		Latency: 0
> 		Interrupt: pin C routed to IRQ 18
> 		Region 0: Memory at e4800000 (32-bit, non-prefetchable) [size=3D1K]
> 		Capabilities: [50] Power Management version 2
> 			Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+,D1-,D2-,D3hot+,=
D3cold+)
> 			Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
> 		Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
> 		Kernel driver in use: ehci_hcd
> =09
> 	00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio Co=
ntroller (rev 03)
> 		Subsystem: Hewlett-Packard Company Device 30c0
> 		Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
> 		Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
> 		Latency: 0, Cache Line Size: 64 bytes
> 		Interrupt: pin A routed to IRQ 16
> 		Region 0: Memory at e4804000 (64-bit, non-prefetchable) [size=3D16K]
> 		Capabilities: [50] Power Management version 2
> 			Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA PME(D0+,D1-,D2-,D3hot+,D=
3cold+)
> 			Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
> 		Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=3D0=
/0 Enable-
> 			Address: 0000000000000000  Data: 0000
> 		Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 0=
0
> 			DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 u=
nlimited
> 				ExtTag- RBE- FLReset-
> 			DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> 				RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
> 				MaxPayload 128 bytes, MaxReadReq 128 bytes
> 			DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> 			LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64=
ns, L1 <1us
> 				ClockPM- Suprise- LLActRep- BwNot-
> 			LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
> 				ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 			LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMg=
mt- ABWMgmt-
> 		Capabilities: [100] Virtual Channel <?>
> 		Capabilities: [130] Root Complex Link <?>
> 		Kernel driver in use: HDA Intel
> =09
> 	00:1c.0 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express P=
ort 1 (rev 03)
> 		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx+
> 		Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
> 		Latency: 0, Cache Line Size: 64 bytes
> 		Bus: primary=3D00, secondary=3D08, subordinate=3D08, sec-latency=3D0
> 		I/O behind bridge: 0000f000-00000fff
> 		Memory behind bridge: fff00000-000fffff
> 		Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
> 		Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort+ <SERR- <PERR-
> 		BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
> 			PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 		Capabilities: [40] Express (v1) Root Port (Slot-), MSI 00
> 			DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 u=
nlimited
> 				ExtTag- RBE+ FLReset-
> 			DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
> 				RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 				MaxPayload 128 bytes, MaxReadReq 128 bytes
> 			DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> 			LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us=
, L1 <4us
> 				ClockPM- Suprise- LLActRep+ BwNot-
> 			LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
> 				ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 			LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMg=
mt- ABWMgmt-
> 			RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible=
-
> 			RootCap: CRSVisible-
> 			RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=3D0=
/0 Enable-
> 			Address: fee0300c  Data: 4169
> 		Capabilities: [90] Subsystem: Hewlett-Packard Company Device 30c0
> 		Capabilities: [a0] Power Management version 2
> 			Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3=
cold+)
> 			Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
> 		Capabilities: [100] Virtual Channel <?>
> 		Capabilities: [180] Root Complex Link <?>
> 		Kernel driver in use: pcieport-driver
> 		Kernel modules: shpchp
> =09
> 	00:1c.1 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express P=
ort 2 (rev 03)
> 		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx+
> 		Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
> 		Latency: 0, Cache Line Size: 64 bytes
> 		Bus: primary=3D00, secondary=3D10, subordinate=3D10, sec-latency=3D0
> 		I/O behind bridge: 0000f000-00000fff
> 		Memory behind bridge: e4100000-e41fffff
> 		Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
> 		Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort+ <SERR- <PERR-
> 		BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
> 			PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 		Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
> 			DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 u=
nlimited
> 				ExtTag- RBE+ FLReset-
> 			DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
> 				RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 				MaxPayload 128 bytes, MaxReadReq 128 bytes
> 			DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> 			LnkCap:	Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <256=
ns, L1 <4us
> 				ClockPM- Suprise- LLActRep+ BwNot-
> 			LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
> 				ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 			LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMg=
mt- ABWMgmt-
> 			SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surpise+
> 				Slot #  2, PowerLimit 0.160000; Interlock- NoCompl-
> 			SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg=
-
> 				Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> 			SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> 				Changed: MRL- PresDet- LinkState+
> 			RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible=
-
> 			RootCap: CRSVisible-
> 			RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=3D0=
/0 Enable-
> 			Address: fee0300c  Data: 4171
> 		Capabilities: [90] Subsystem: Hewlett-Packard Company Device 30c0
> 		Capabilities: [a0] Power Management version 2
> 			Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3=
cold+)
> 			Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
> 		Capabilities: [100] Virtual Channel <?>
> 		Capabilities: [180] Root Complex Link <?>
> 		Kernel driver in use: pcieport-driver
> 		Kernel modules: shpchp
> =09
> 	00:1c.2 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express P=
ort 3 (rev 03)
> 		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx+
> 		Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
> 		Latency: 0, Cache Line Size: 64 bytes
> 		Bus: primary=3D00, secondary=3D18, subordinate=3D18, sec-latency=3D0
> 		I/O behind bridge: 0000f000-00000fff
> 		Memory behind bridge: e4000000-e40fffff
> 		Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
> 		Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort+ <SERR- <PERR-
> 		BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
> 			PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 		Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
> 			DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 u=
nlimited
> 				ExtTag- RBE+ FLReset-
> 			DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
> 				RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 				MaxPayload 128 bytes, MaxReadReq 128 bytes
> 			DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> 			LnkCap:	Port #3, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <256=
ns, L1 <4us
> 				ClockPM- Suprise- LLActRep+ BwNot-
> 			LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
> 				ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 			LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMg=
mt- ABWMgmt-
> 			SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surpise+
> 				Slot #  3, PowerLimit 10.000000; Interlock- NoCompl-
> 			SltCtl:	Enable: AttnBtn+ PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- LinkChg=
-
> 				Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> 			SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
> 				Changed: MRL- PresDet- LinkState+
> 			RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible=
-
> 			RootCap: CRSVisible-
> 			RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=3D0=
/0 Enable-
> 			Address: fee0300c  Data: 4179
> 		Capabilities: [90] Subsystem: Hewlett-Packard Company Device 30c0
> 		Capabilities: [a0] Power Management version 2
> 			Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3=
cold+)
> 			Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
> 		Capabilities: [100] Virtual Channel <?>
> 		Capabilities: [180] Root Complex Link <?>
> 		Kernel driver in use: pcieport-driver
> 		Kernel modules: shpchp
> =09
> 	00:1c.4 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express P=
ort 5 (rev 03)
> 		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx+
> 		Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
> 		Latency: 0, Cache Line Size: 64 bytes
> 		Bus: primary=3D00, secondary=3D28, subordinate=3D28, sec-latency=3D0
> 		I/O behind bridge: 00002000-00003fff
> 		Memory behind bridge: e0000000-e3ffffff
> 		Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
> 		Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- <SERR- <PERR-
> 		BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
> 			PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 		Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
> 			DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 u=
nlimited
> 				ExtTag- RBE+ FLReset-
> 			DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
> 				RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 				MaxPayload 128 bytes, MaxReadReq 128 bytes
> 			DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> 			LnkCap:	Port #5, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us=
, L1 <4us
> 				ClockPM- Suprise- LLActRep+ BwNot-
> 			LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
> 				ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 			LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMg=
mt- ABWMgmt-
> 			SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surpise+
> 				Slot #  5, PowerLimit 0.160000; Interlock- NoCompl-
> 			SltCtl:	Enable: AttnBtn+ PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- LinkChg=
-
> 				Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> 			SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
> 				Changed: MRL- PresDet- LinkState-
> 			RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible=
-
> 			RootCap: CRSVisible-
> 			RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> 		Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=3D0=
/0 Enable-
> 			Address: fee0300c  Data: 4181
> 		Capabilities: [90] Subsystem: Hewlett-Packard Company Device 30c0
> 		Capabilities: [a0] Power Management version 2
> 			Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3=
cold+)
> 			Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
> 		Capabilities: [100] Virtual Channel <?>
> 		Capabilities: [180] Root Complex Link <?>
> 		Kernel driver in use: pcieport-driver
> 		Kernel modules: shpchp
> =09
> 	00:1d.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI =
Controller #1 (rev 03)
> 		Subsystem: Hewlett-Packard Company Device 30c0
> 		Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
> 		Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR- INTx-
> 		Latency: 0
> 		Interrupt: pin A routed to IRQ 20
> 		Region 4: I/O ports at 4060 [size=3D32]
> 		Kernel driver in use: uhci_hcd
> =09
> 	00:1d.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI =
Controller #2 (rev 03)
> 		Subsystem: Hewlett-Packard Company Device 30c0
> 		Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
> 		Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR- INTx-
> 		Latency: 0
> 		Interrupt: pin B routed to IRQ 21
> 		Region 4: I/O ports at 4080 [size=3D32]
> 		Kernel driver in use: uhci_hcd
> =09
> 	00:1d.2 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI =
Controller #3 (rev 03)
> 		Subsystem: Hewlett-Packard Company Device 30c0
> 		Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
> 		Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR- INTx-
> 		Latency: 0
> 		Interrupt: pin C routed to IRQ 18
> 		Region 4: I/O ports at 40a0 [size=3D32]
> 		Kernel driver in use: uhci_hcd
> =09
> 	00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI=
 Controller #1 (rev 03) (prog-if 20)
> 		Subsystem: Hewlett-Packard Company Device 30c0
> 		Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
> 		Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR- INTx-
> 		Latency: 0
> 		Interrupt: pin A routed to IRQ 20
> 		Region 0: Memory at e4808000 (32-bit, non-prefetchable) [size=3D1K]
> 		Capabilities: [50] Power Management version 2
> 			Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+,D1-,D2-,D3hot+,=
D3cold+)
> 			Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
> 		Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
> 		Kernel driver in use: ehci_hcd
> =09
> 	00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev f3) (=
prog-if 01)
> 		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR+ FastB2B- DisINTx-
> 		Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
> 		Latency: 0
> 		Bus: primary=3D00, secondary=3D02, subordinate=3D06, sec-latency=3D32
> 		I/O behind bridge: 00005000-00005fff
> 		Memory behind bridge: e4200000-e45fffff
> 		Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
> 		Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort+ <SERR- <PERR-
> 		BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
> 			PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 		Capabilities: [50] Subsystem: Hewlett-Packard Company Device 30c0
> =09
> 	00:1f.0 ISA bridge: Intel Corporation 82801HEM (ICH8M) LPC Interface Con=
troller (rev 03)
> 		Subsystem: Hewlett-Packard Company Device 30c0
> 		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
> 		Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR- INTx-
> 		Latency: 0
> 		Capabilities: [e0] Vendor Specific Information <?>
> =09
> 	00:1f.1 IDE interface: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E) ID=
E Controller (rev 03) (prog-if 8a [Master SecP PriP])
> 		Subsystem: Hewlett-Packard Company Device 30c0
> 		Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
> 		Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR- INTx-
> 		Latency: 0
> 		Interrupt: pin A routed to IRQ 16
> 		Region 0: I/O ports at 01f0 [size=3D8]
> 		Region 1: I/O ports at 03f4 [size=3D1]
> 		Region 2: I/O ports at 0170 [size=3D8]
> 		Region 3: I/O ports at 0374 [size=3D1]
> 		Region 4: I/O ports at 40c0 [size=3D16]
> 		Kernel driver in use: PIIX_IDE
> =09
> 	00:1f.2 SATA controller: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E) =
SATA AHCI Controller (rev 03) (prog-if 01)
> 		Subsystem: Hewlett-Packard Company Device 30c0
> 		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx+
> 		Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR- INTx-
> 		Latency: 0
> 		Interrupt: pin B routed to IRQ 315
> 		Region 0: I/O ports at 13f0 [size=3D8]
> 		Region 1: I/O ports at 15f4 [size=3D4]
> 		Region 2: I/O ports at 1370 [size=3D8]
> 		Region 3: I/O ports at 1574 [size=3D4]
> 		Region 4: I/O ports at 4100 [size=3D32]
> 		Region 5: Memory at e4809000 (32-bit, non-prefetchable) [size=3D2K]
> 		Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=3D0=
/2 Enable+
> 			Address: fee0300c  Data: 4189
> 		Capabilities: [70] Power Management version 3
> 			Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot+,D3=
cold-)
> 			Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
> 		Capabilities: [a8] SATA HBA <?>
> 		Kernel driver in use: ahci
> =09
> 	02:04.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev b6)
> 		Subsystem: Hewlett-Packard Company Device 30c0
> 		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
> 		Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR- INTx-
> 		Latency: 168
> 		Interrupt: pin A routed to IRQ 16
> 		Region 0: Memory at e4200000 (32-bit, non-prefetchable) [size=3D4K]
> 		Bus: primary=3D02, secondary=3D03, subordinate=3D06, sec-latency=3D176
> 		Memory window 0: c8400000-c87ff000 (prefetchable)
> 		Memory window 1: c4000000-c7fff000
> 		I/O window 0: 00005000-000050ff
> 		I/O window 1: 00005400-000054ff
> 		BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
> 		16-bit legacy interface ports at 0001
> 		Kernel driver in use: yenta_cardbus
> =09
> 	02:04.1 FireWire (IEEE 1394): Ricoh Co Ltd R5C832 IEEE 1394 Controller (=
rev 02) (prog-if 10)
> 		Subsystem: Hewlett-Packard Company Device 30c0
> 		Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
> 		Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR- INTx-
> 		Latency: 64 (500ns min, 1000ns max), Cache Line Size: 64 bytes
> 		Interrupt: pin B routed to IRQ 17
> 		Region 0: Memory at e4201000 (32-bit, non-prefetchable) [size=3D2K]
> 		Capabilities: [dc] Power Management version 2
> 			Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3=
cold+)
> 			Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME+
> 		Kernel driver in use: firewire_ohci
> =09
> 	10:00.0 Network controller: Intel Corporation PRO/Wireless 3945ABG Netwo=
rk Connection (rev 02)
> 		Subsystem: Hewlett-Packard Company Device 135c
> 		Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx-
> 		Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
> 		Interrupt: pin A routed to IRQ 17
> 		Region 0: Memory at e4100000 (32-bit, non-prefetchable) [size=3D4K]
> 		Capabilities: [c8] Power Management version 2
> 			Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3=
cold+)
> 			Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
> 		Capabilities: [d0] Message Signalled Interrupts: Mask- 64bit+ Queue=3D0=
/0 Enable-
> 			Address: 00000000fee0300c  Data: 41c1
> 		Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
> 			DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 unli=
mited
> 				ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
> 			DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> 				RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
> 				MaxPayload 128 bytes, MaxReadReq 128 bytes
> 			DevSta:	CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr+ TransPend-
> 			LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <128=
ns, L1 <64us
> 				ClockPM+ Suprise- LLActRep- BwNot-
> 			LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
> 				ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
> 			LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMg=
mt- ABWMgmt-
> 		Capabilities: [100] Advanced Error Reporting <?>
> 		Capabilities: [140] Device Serial Number b0-ae-28-ff-ff-bf-1c-00
> 		Kernel driver in use: iwl3945
> =09
> 	18:00.0 Ethernet controller: Broadcom Corporation NetLink BCM5787M Gigab=
it Ethernet PCI Express (rev 02)
> 		Subsystem: Hewlett-Packard Company Device 30c0
> 		Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B- DisINTx+
> 		Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR- INTx-
> 		Latency: 0, Cache Line Size: 64 bytes
> 		Interrupt: pin A routed to IRQ 314
> 		Region 0: Memory at e4000000 (64-bit, non-prefetchable) [size=3D64K]
> 		Expansion ROM at <ignored> [disabled]
> 		Capabilities: [48] Power Management version 3
> 			Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot+,D3=
cold+)
> 			Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-
> 		Capabilities: [50] Vital Product Data <?>
> 		Capabilities: [58] Vendor Specific Information <?>
> 		Capabilities: [e8] Message Signalled Interrupts: Mask- 64bit+ Queue=3D0=
/0 Enable+
> 			Address: 00000000fee0300c  Data: 41a9
> 		Capabilities: [d0] Express (v1) Endpoint, MSI 00
> 			DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimi=
ted
> 				ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> 			DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> 				RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 				MaxPayload 128 bytes, MaxReadReq 4096 bytes
> 			DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> 			LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <4us=
, L1 <64us
> 				ClockPM+ Suprise- LLActRep- BwNot-
> 			LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
> 				ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
> 			LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMg=
mt- ABWMgmt-
> 		Capabilities: [100] Advanced Error Reporting <?>
> 		Capabilities: [13c] Virtual Channel <?>
> 		Capabilities: [160] Device Serial Number ee-07-72-fe-ff-4b-1a-00
> 		Capabilities: [16c] Power Budgeting <?>
> 		Kernel driver in use: tg3
>=20
> [8.6.]
> 	Attached devices:
> 	Host: scsi0 Channel: 00 Id: 00 Lun: 00
> 	  Vendor: ATA      Model: ST9120822AS      Rev: 3.BH
> 	  Type:   Direct-Access                    ANSI  SCSI revision: 05
>=20
>=20
> =09
--=20
S=C3=A9rgio M. B.

--=-6pzNOuIHa1YWajRYrUVu
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGVjCCAw8w
ggJ4oAMCAQICECv58J8+j9G8Y7r6tize4dAwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA3MTAxMzIyMjE1NFoXDTA4MTAxMjIyMjE1
NFowSzEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEoMCYGCSqGSIb3DQEJARYZc2Vy
Z2lvQHNlcmdpb21iLm5vLWlwLm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALmR
do8nLKka6p0NNur5o8znYir80AaybL3nuKDDeY2CNjm8JdpJPea9KmXurRU9Q/jnsmgtn2UH9blF
1qUDxzUvFrZ8fEFkMBht+DJMPShJIa885JyggTvRg+ZUEPdjvb7pHrvpEhxlDcJ9vpYnB4M06D2p
lefGl9TVq9srUCUMc/4/G/OLaLz0f6Nhc0Gb7YcUDIRINHR0pWuCpxl8wxOU8YSx43KbNgPOo3Kn
jtdcgGRoy7kAKN2rQmU4tgLDh8F+f9a3mMc3YRs0CfkPq7RSGMWcNagkEWCcoh0f5tDYjq1iQEWD
5fK1esWmiR5onZ+QyUd+kU7IycY68iMD5BMCAwEAAaNZMFcwDgYDVR0PAQH/BAQDAgSQMBEGCWCG
SAGG+EIBAQQEAwIFoDAkBgNVHREEHTAbgRlzZXJnaW9Ac2VyZ2lvbWIubm8taXAub3JnMAwGA1Ud
EwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAetiCq+dKlfTpFybx+lLoL7A/ep10fER7eHDGB6MQ
9n8HDqz2eOXMZrw0WSYfWXhG+fnrpUE85DseFXQFJDf6gBdD/KlYqnmaDY0nK9LdFHA3hapRARvB
el9wYF60z+1yI69bFzyoZpCnY3+1oFQGews7kwT6u77QVdj6Y8v+Ai0wggM/MIICqKADAgECAgEN
MA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIw
EAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBDb25zdWx0aW5nMSgwJgYDVQQLEx9D
ZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYDVQQDExtUaGF3dGUgUGVyc29uYWwg
RnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFsLWZyZWVtYWlsQHRoYXd0ZS5jb20w
HhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2MjM1OTU5WjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMc
VGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZy
ZWVtYWlsIElzc3VpbmcgQ0EwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMSmPFVzVftOucqZ
Wh5owHUEcJ3f6f+jHuy9zfVb8hp2vX8MOmHyv1HOAdTlUAow1wJjWiyJFXCO3cnwK4Vaqj9xVsuv
PAsH5/EfkTYkKhPPK9Xzgnc9A74r/rsYPge/QIACZNenprufZdHFKlSFD0gEf6e20TxhBEAeZBly
YLf7AgMBAAGjgZQwgZEwEgYDVR0TAQH/BAgwBgEB/wIBADBDBgNVHR8EPDA6MDigNqA0hjJodHRw
Oi8vY3JsLnRoYXd0ZS5jb20vVGhhd3RlUGVyc29uYWxGcmVlbWFpbENBLmNybDALBgNVHQ8EBAMC
AQYwKQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVByaXZhdGVMYWJlbDItMTM4MA0GCSqGSIb3DQEB
BQUAA4GBAEiM0VCD6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0whuPg2H6otnzYvwPQcUCCTcDz9reFh
YsPZOhl+hLGZGwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBPZV+V2vf3h9bGCE6u9uo05RAaWzVN
d+NWIXiC3CEZNd4ksdMdRv9dX2VPMYIB/DCCAfgCAQEwdjBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFs
IEZyZWVtYWlsIElzc3VpbmcgQ0ECECv58J8+j9G8Y7r6tize4dAwCQYFKw4DAhoFAKBdMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA4MDczMTExNDU1MlowIwYJKoZI
hvcNAQkEMRYEFAUMxNYCYHILpI4kQe7yS4AqO/jZMA0GCSqGSIb3DQEBAQUABIIBAKtZK2xEiW4y
/nQcZhyi4ekX7sDj9nxC/t1kyWda/5IhMS/+AFksXMK6mRSGZ5SL1wDIrjz4h8JVyUpd1jjqEDCx
c9PsV1LdscRAP0v0x2gyDthd/VyovSvA4qwS2NkEXM0PXKYgqjSHEU6gY9OLzokERxFkQwcpeyjL
fvUbRaeI3phO4BO57/zKX2xa8DyQj7cUCWN6CeelzS7xuUzoPXtM9LaxE2OygJb5LPq27/+0XS+6
MQPx4xUsKOHQ9G9AziL3qUHIxjgnrVEBynPpGkbarv6UR1L+4AUvlALiKzRRG0GZ3AZmw4dWCI1e
em2Cv6xYf3QgLmId3CJfqm4cF6oAAAAAAAA=


--=-6pzNOuIHa1YWajRYrUVu--

