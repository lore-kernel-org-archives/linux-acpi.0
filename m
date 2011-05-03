From: =?ISO-8859-1?Q?Sebastian_F=E4rber?= <faerber@gmail.com>
Subject: Hard LOCKUP, maybe acpi related (present in 2.6.32 to 2.6.37, fixed
 in 2.6.38)
Date: Tue, 3 May 2011 12:24:52 +0200
Message-ID: <BANLkTimK9+d8USk_9_NzKcOmbnPAq6P+tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-px0-f170.google.com ([209.85.212.170]:47146 "EHLO
	mail-px0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627Ab1ECKYw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 May 2011 06:24:52 -0400
Received: by pxi19 with SMTP id 19so2837912pxi.1
        for <linux-acpi@vger.kernel.org>; Tue, 03 May 2011 03:24:52 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I'm trying to track down a problem i have with newer hardware which seems
fixed in 2.6.38.4 but which i can reproduce from 2.6.32 to 2.6.37
I'm running a DEBUG Kernel with nmi_watchdog=1 and attached a backtrace
of the lockup that happened on 2.6.37.6. I can also provide backtraces for
2.6.32 to 2.6.35 if necessary, they look very similar.

To my untrained eye this looks like a problem with ACPI/CPU C States
(CPU in Question
is a Quadcore Core i5 750). It's strange that the watchdog only shows
backtraces for 3 CPUs/Cores, one is still fine?
The servers on which this happens are all completely idle and the lockup
occurs every 1-2 days.
Would be great if someone more experienced could have a look and see
which change in 2.6.38 fixed this.
Unfortunately i can't upgrade all servers to 2.6.38 right now so I'm hoping
it's possible to backport this to the stable kernel series.


My .config is here: http://pastebin.com/iC1udT93
Backtrace: http://pastebin.com/yR1YseM7

If someone needs more information just let me know.

Regards,

Sebastian

---
BUG: NMI Watchdog detected LOCKUP on CPU1, ip c100a556, registers:
Modules linked in: i2c_dev ipt_LOG xt_limit nf_conntrack_ipv4
nf_defrag_ipv4 xt_state xt_NOTRACK iptable_raw ipt_REJECT
iptable_filter nf_conntrack_ftp nf_conntrack e1000e usbcore ipv6

Pid: 0, comm: kworker/0:0 Not tainted 2.6.37.6 #1 Gigabyte Technology
Co., Ltd. Q57M-S2H/Q57M-S2H
EIP: 0060:[<c100a556>] EFLAGS: 00000046 CPU: 1
EIP is at mwait_idle_with_hints+0x66/0x80
EAX: 00000020 EBX: 00000001 ECX: 00000001 EDX: 00000000
ESI: 00000020 EDI: f0498000 EBP: f0499f44 ESP: f0499f38
 DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
Process kworker/0:0 (pid: 0, ti=f0498000 task=f0475400 task.ti=f0498000)
Stack:
 cfc15d32 1218f498 f052b6a0 f0499f4c c101bcf7 f0499f74 c122e781 00002635
 00000001 f052b260 000026c7 00000000 f052b394 f052b27c 00000000 f0499f84
 c131c8f5 00000001 c152fc00 f0499f94 c1001d35 00000001 00000000 f0499fb0
Call Trace:
 [<c101bcf7>] ? acpi_processor_ffh_cstate_enter+0x27/0x30
 [<c122e781>] ? acpi_idle_enter_bm+0x1b7/0x29e
 [<c131c8f5>] ? cpuidle_idle_call+0x95/0xe0
 [<c1001d35>] ? cpu_idle+0x45/0x80
 [<c13cb304>] ? start_secondary+0x180/0x1ec
Code: 74 04 0f ae 7a 08 89 e7 31 c9 81 e7 00 e0 ff ff 89 ca 8d 47 08
0f 01 c8 0f ae f0 89 f6 8b 47 08 a8 08 75 07 89 f0 89 d9 0f 01 c9 <8b>
1c 24 8b 74 24 04 8b 7c 24 08 89 ec 5d c3 8d 74 26 00
8d bc
---[ end trace 1ccb64a1e31d2874 ]---
BUG: NMI Watchdog detected LOCKUP on CPU2, ip c100a556, registers:
Modules linked in: i2c_dev ipt_LOG xt_limit nf_conntrack_ipv4
nf_defrag_ipv4 xt_state xt_NOTRACK iptable_raw ipt_REJECT
iptable_filter nf_conntrack_ftp nf_conntrack e1000e usbcore ipv6

Pid: 0, comm: kworker/0:1 Tainted: G      D     2.6.37.6 #1 Gigabyte
Technology Co., Ltd. Q57M-S2H/Q57M-S2H
EIP: 0060:[<c100a556>] EFLAGS: 00000046 CPU: 2
EIP is at mwait_idle_with_hints+0x66/0x80
EAX: 00000020 EBX: 00000001 ECX: 00000001 EDX: 00000000
ESI: 00000020 EDI: f04a6000 EBP: f04a7f44 ESP: f04a7f38
 DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
Process kworker/0:1 (pid: 0, ti=f04a6000 task=f0479400 task.ti=f04a6000)
Stack:
 cfc13a0e 1218f498 f04bac88 f04a7f4c c101bcf7 f04a7f74 c122e781 00002636
 00000001 f04ba848 000026b5 00000000 f04ba97c f04ba864 00000000 f04a7f84
 c131c8f5 00000002 c152fc00 f04a7f94 c1001d35 00000002 00000000 f04a7fb0
Call Trace:
 [<c101bcf7>] ? acpi_processor_ffh_cstate_enter+0x27/0x30
 [<c122e781>] ? acpi_idle_enter_bm+0x1b7/0x29e
 [<c131c8f5>] ? cpuidle_idle_call+0x95/0xe0
 [<c1001d35>] ? cpu_idle+0x45/0x80
 [<c13cb304>] ? start_secondary+0x180/0x1ec
Code: 74 04 0f ae 7a 08 89 e7 31 c9 81 e7 00 e0 ff ff 89 ca 8d 47 08
0f 01 c8 0f ae f0 89 f6 8b 47 08 a8 08 75 07 89 f0 89 d9 0f 01 c9 <8b>
1c 24 8b 74 24 04 8b 7c 24 08 89 ec 5d c3 8d 74 26 00
8d bc
---[ end trace 1ccb64a1e31d2875 ]---
BUG: NMI Watchdog detected LOCKUP on CPU0, ip c100a556, registers:
Kernel panic - not syncing: Attempted to kill the idle task!
Modules linked in: i2c_dev ipt_LOG xt_limit nf_conntrack_ipv4
nf_defrag_ipv4 xt_state xt_NOTRACK iptable_raw ipt_REJECT
iptable_filter nf_conntrack_ftp nf_conntrack e1000e usbcore ipv6

Pid: 0, comm: swapper Tainted: G      D     2.6.37.6 #1 Gigabyte
Technology Co., Ltd. Q57M-S2H/Q57M-S2H
EIP: 0060:[<c100a556>] EFLAGS: 00000046 CPU: 0
EIP is at mwait_idle_with_hints+0x66/0x80
EAX: 00000020 EBX: 00000001 ECX: 00000001 EDX: 00000000
ESI: 00000020 EDI: c14e8000 EBP: c14e9f74 ESP: c14e9f68
 DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
Process swapper (pid: 0, ti=c14e8000 task=c1506020 task.ti=c14e8000)
Stack:
 d2bc5b3a 1218f498 efc336e0 c14e9f7c c101bcf7 c14e9fa4 c122e781 000113d3
 00000001 efc332a0 00003f36 00000000 efc333d4 efc332bc c14eb000 c14e9fb4
 c131c8f5 00000000 c152fc00 c14e9fc4 c1001d35 c156a140 00099d00 c14e9fcc
Call Trace:
 [<c101bcf7>] ? acpi_processor_ffh_cstate_enter+0x27/0x30
 [<c122e781>] ? acpi_idle_enter_bm+0x1b7/0x29e
 [<c131c8f5>] ? cpuidle_idle_call+0x95/0xe0
 [<c1001d35>] ? cpu_idle+0x45/0x80
 [<c13b936d>] ? rest_init+0x5d/0x70
 [<c1532955>] ? start_kernel+0x2ec/0x32c
 [<c1532429>] ? unknown_bootoption+0x0/0x1ef
 [<c153208e>] ? i386_start_kernel+0x8e/0x90
Code: 74 04 0f ae 7a 08 89 e7 31 c9 81 e7 00 e0 ff ff 89 ca 8d 47 08
0f 01 c8 0f ae f0 89 f6 8b 47 08 a8 08 75 07 89 f0 89 d9 0f 01 c9 <8b>
1c 24 8b 74 24 04 8b 7c 24 08 89 ec 5d c3 8d 74 26 00 8d bc
---[ end trace 1ccb64a1e31d2876 ]---
