From: Daniel Stodden <dns@somacoma.net>
Subject: ACPI-ish crashes on Lenovo T400,
Date: Thu, 27 Jan 2011 00:03:29 -0800
Message-ID: <1296115409.16034.27.camel@ramone.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from somacoma.net ([62.75.137.225]:55576 "EHLO vs137225.vserver.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750934Ab1A0INp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Jan 2011 03:13:45 -0500
Received: from [192.168.178.21] (S0106001a4fead28f.vc.shawcable.net [24.84.12.180])
	(Authenticated sender: dns)
	by vs137225.vserver.de (Postfix) with ESMTPSA id 29BC94938004
	for <linux-acpi@vger.kernel.org>; Thu, 27 Jan 2011 09:03:31 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


Hi all.

Can somebody have a brief look at those crash traces and tell me what to
try about it? It looks mildly c state and/or smp related.

This is on a Lenovo T400 notebook, Intel P8400, 2 cores running a
Ubuntu-Lucid 2.6.32 kernel. System does fine for a couple hours, then
goes south all of a sudden. I'd blame it a broken board or memory if it
were more random. No other hiccups.

Affected core is apparently always CPU#1, apparently always idle, dying
on either a #DF, or a fault in some acpi_idle_enter_. I set CPU#1 to
offline this morning and since then the symptom seems gone. But I'd like
to get it back online.

Thanks very much. Hope I'm asking on the right list.

Daniel


1)
      KERNEL: /usr/lib/debug/boot/vmlinux-2.6.32-27-generic
    DUMPFILE: VmCore
        CPUS: 2
        DATE: Mon Jan 24 23:10:16 2011
      UPTIME: 01:24:59
LOAD AVERAGE: 1.11, 0.73, 0.58
       TASKS: 300
    NODENAME: ramone
     RELEASE: 2.6.32-27-generic
     VERSION: #49-Ubuntu SMP Thu Dec 2 00:51:09 UTC 2010
     MACHINE: x86_64  (2260 Mhz)
      MEMORY: 2 GB
       PANIC: "[ 5099.395584] Oops: 0000 [#2] SMP " (check log for
details)
         PID: 0
     COMMAND: "swapper"
        TASK: ffff88007a3f44a0  (1 of 2)  [THREAD_INFO:
ffff880079800000]
         CPU: 1
       STATE: TASK_RUNNING (PANIC)

crash> bt 
PID: 0      TASK: ffff88007a3f44a0  CPU: 1   COMMAND: "swapper"
 #0 [ffff880001c86af0] machine_kexec at ffffffff8103320b
 #1 [ffff880001c86b50] crash_kexec at ffffffff810a8f68
 #2 [ffff880001c86c20] oops_end at ffffffff81545268
 #3 [ffff880001c86c50] no_context at ffffffff8103fa63
 #4 [ffff880001c86c90] __bad_area_nosemaphore at ffffffff8103fc25
 #5 [ffff880001c86ce0] bad_area_nosemaphore at ffffffff8103fcf3
 #6 [ffff880001c86cf0] do_page_fault at ffffffff81546e44
 #7 [ffff880001c86d40] page_fault at ffffffff815445d5
 #8 [ffff880001c86dc8] show_stack_log_lvl at ffffffff81015073
 #9 [ffff880001c86e50] show_registers at ffffffff810151c1
#10 [ffff880001c86ec0] __die at ffffffff81545173
#11 [ffff880001c86ef0] die at ffffffff81016128
#12 [ffff880001c86f20] do_double_fault at ffffffff81013752
#13 [ffff880001c86f50] double_fault at ffffffff81012fc5
    [exception RIP: unknown or invalid address]
    RIP: 00007ff607dd9482  RSP: ffff8800902ab110  RFLAGS: 00010202
    RAX: 0000000000000000  RBX: 0000000001194920  RCX: 00000000e0167730
    RDX: 0000000000000002  RSI: ffff8800902ab200  RDI: 00000000011a65a0
    RBP: ffff880000000000   R8: 0000000000000000   R9: 0000000000000039
    R10: 0000000000000000  R11: 0000000000000000  R12: 0000000000000001
    R13: 0000000000000004  R14: 0000000000000000  R15: 0000000000000000
    ORIG_RAX: ffffffffffffffff  CS: 0030  SS: 0018
bt: WARNING: possibly bogus exception frame
--- <exception stack> ---
bt: cannot transition from exception stack to current process stack:
    exception stack pointer: ffff880001c86af0
      process stack pointer: ffff8800902ab110
         current stack base: ffff880079800000

2)

      KERNEL: /usr/lib/debug/boot/vmlinux-2.6.32-27-generic
    DUMPFILE: VmCore
        CPUS: 2
        DATE: Tue Jan 25 01:37:22 2011
      UPTIME: 02:26:25
LOAD AVERAGE: 0.39, 0.44, 0.80
       TASKS: 308
    NODENAME: ramone
     RELEASE: 2.6.32-27-generic
     VERSION: #49-Ubuntu SMP Thu Dec 2 00:51:09 UTC 2010
     MACHINE: x86_64  (2260 Mhz)
      MEMORY: 2 GB
       PANIC: "[ 8785.430388] Oops: 0000 [#1] SMP " (check log for
details)
         PID: 0
     COMMAND: "swapper"
        TASK: ffff88007a3f44a0  (1 of 2)  [THREAD_INFO:
ffff880079800000]
         CPU: 1
       STATE: TASK_RUNNING (PANIC)

crash> bt
PID: 0      TASK: ffff88007a3f44a0  CPU: 1   COMMAND: "swapper"
 #0 [ffff880079801b90] machine_kexec at ffffffff8103320b
 #1 [ffff880079801bf0] crash_kexec at ffffffff810a8f68
 #2 [ffff880079801cc0] oops_end at ffffffff81545268
 #3 [ffff880079801cf0] no_context at ffffffff8103fa63
 #4 [ffff880079801d30] __bad_area_nosemaphore at ffffffff8103fc25
 #5 [ffff880079801d80] bad_area_nosemaphore at ffffffff8103fcf3
 #6 [ffff880079801d90] do_page_fault at ffffffff81546e44
 #7 [ffff880079801de0] page_fault at ffffffff815445d5
 #8 [ffff880079801e68] acpi_idle_enter_bm at ffffffff8130ef74
 #9 [ffff880079801ef0] cpuidle_idle_call at ffffffff81439e77
#10 [ffff880079801f10] cpu_idle at ffffffff81010e73

3)
      KERNEL: /usr/lib/debug/boot/vmlinux-2.6.32-27-generic
    DUMPFILE: VmCore
        CPUS: 2
        DATE: Tue Jan 25 02:30:03 2011
      UPTIME: 00:51:50
LOAD AVERAGE: 0.64, 0.65, 0.66
       TASKS: 285
    NODENAME: ramone
     RELEASE: 2.6.32-27-generic
     VERSION: #49-Ubuntu SMP Thu Dec 2 00:51:09 UTC 2010
     MACHINE: x86_64  (2261 Mhz)
      MEMORY: 2 GB
       PANIC: "[ 3110.678958] Oops: 0010 [#1] SMP " (check log for
details)
         PID: 0
     COMMAND: "swapper"
        TASK: ffff88007a3f44a0  (1 of 2)  [THREAD_INFO:
ffff880079800000]
         CPU: 1
       STATE: TASK_RUNNING (PANIC)

crash> bt
PID: 0      TASK: ffff88007a3f44a0  CPU: 1   COMMAND: "swapper"
 #0 [ffff880079801b70] machine_kexec at ffffffff8103320b
 #1 [ffff880079801bd0] crash_kexec at ffffffff810a8f68
 #2 [ffff880079801ca0] oops_end at ffffffff81545268
 #3 [ffff880079801cd0] no_context at ffffffff8103fa63
 #4 [ffff880079801d10] __bad_area_nosemaphore at ffffffff8103fc25
 #5 [ffff880079801d60] bad_area_nosemaphore at ffffffff8103fcf3
 #6 [ffff880079801d70] do_page_fault at ffffffff81546e44
 #7 [ffff880079801dc0] page_fault at ffffffff815445d5
 #8 [ffff880079801e80] acpi_processor_ffh_cstate_enter at
ffffffff8102cb72
 #9 [ffff880079801e90] acpi_idle_do_entry at ffffffff8130ec56
#10 [ffff880079801ea0] acpi_idle_enter_simple at ffffffff8130f0f7
#11 [ffff880079801ef0] cpuidle_idle_call at ffffffff81439e77
#12 [ffff880079801f10] cpu_idle at ffffffff81010e73

4)
      KERNEL: /usr/lib/debug/boot/vmlinux-2.6.32-27-generic
    DUMPFILE: VmCore
        CPUS: 2
        DATE: Tue Jan 25 03:56:16 2011
      UPTIME: 00:46:22
LOAD AVERAGE: 0.44, 0.39, 0.36
       TASKS: 320
    NODENAME: ramone
     RELEASE: 2.6.32-27-generic
     VERSION: #49-Ubuntu SMP Thu Dec 2 00:51:09 UTC 2010
     MACHINE: x86_64  (2260 Mhz)
      MEMORY: 1.9 GB
       PANIC: "[ 2782.085815] Oops: 0000 [#1] SMP " (check log for
details)
         PID: 0
     COMMAND: "swapper"
        TASK: ffff8800773f44a0  (1 of 2)  [THREAD_INFO:
ffff880076800000]
         CPU: 1
       STATE: TASK_RUNNING (PANIC)

crash> bt
PID: 0      TASK: ffff8800773f44a0  CPU: 1   COMMAND: "swapper"
 #0 [ffff880076801b90] machine_kexec at ffffffff8103320b
 #1 [ffff880076801bf0] crash_kexec at ffffffff810a8f68
 #2 [ffff880076801cc0] oops_end at ffffffff81545268
 #3 [ffff880076801cf0] no_context at ffffffff8103fa63
 #4 [ffff880076801d30] __bad_area_nosemaphore at ffffffff8103fc25
 #5 [ffff880076801d80] bad_area_nosemaphore at ffffffff8103fcf3
 #6 [ffff880076801d90] do_page_fault at ffffffff81546e44
 #7 [ffff880076801de0] page_fault at ffffffff815445d5
 #8 [ffff880076801e68] acpi_idle_enter_bm at ffffffff8130ef74
 #9 [ffff880076801ef0] cpuidle_idle_call at ffffffff81439e77
#10 [ffff880076801f10] cpu_idle at ffffffff81010e73

5)
      KERNEL: /usr/lib/debug/boot/vmlinux-2.6.32-27-generic
    DUMPFILE: VmCore
        CPUS: 2
        DATE: Wed Jan 26 14:59:34 2011
      UPTIME: 03:53:45
LOAD AVERAGE: 1.19, 0.82, 0.56
       TASKS: 343
    NODENAME: ramone
     RELEASE: 2.6.32-27-generic
     VERSION: #49-Ubuntu SMP Thu Dec 2 00:51:09 UTC 2010
     MACHINE: x86_64  (2260 Mhz)
      MEMORY: 1.9 GB
       PANIC: "[14025.298851] Oops: 0000 [#2] SMP " (check log for
details)
         PID: 0
     COMMAND: "swapper"
        TASK: ffff8800773f44a0  (1 of 2)  [THREAD_INFO:
ffff880076800000]
         CPU: 1
       STATE: TASK_RUNNING (PANIC)

crash> bt
PID: 0      TASK: ffff8800773f44a0  CPU: 1   COMMAND: "swapper"
 #0 [ffff880001c86af0] machine_kexec at ffffffff8103320b
 #1 [ffff880001c86b50] crash_kexec at ffffffff810a8f68
 #2 [ffff880001c86c20] oops_end at ffffffff81545268
 #3 [ffff880001c86c50] no_context at ffffffff8103fa63
 #4 [ffff880001c86c90] __bad_area_nosemaphore at ffffffff8103fc25
 #5 [ffff880001c86ce0] bad_area_nosemaphore at ffffffff8103fcf3
 #6 [ffff880001c86cf0] do_page_fault at ffffffff81546e44
 #7 [ffff880001c86d40] page_fault at ffffffff815445d5
 #8 [ffff880001c86dc8] show_stack_log_lvl at ffffffff81015073
 #9 [ffff880001c86e50] show_registers at ffffffff810151c1
#10 [ffff880001c86ec0] __die at ffffffff81545173
#11 [ffff880001c86ef0] die at ffffffff81016128
#12 [ffff880001c86f20] do_double_fault at ffffffff81013752
#13 [ffff880001c86f50] double_fault at ffffffff81012fc5
    [exception RIP: unknown or invalid address]
    RIP: 00000000fff94120  RSP: ffff88008b183c30  RFLAGS: 00010202
    RAX: 00000000fff94120  RBX: 0000000089a8bcd0  RCX: 0000000000000002
    RDX: 0000000000000006  RSI: ffff880000000017  RDI: 0000000089a8bcd0
    RBP: ffff88008b183c70   R8: 0000000000000000   R9: 0000000000000201
    R10: 0000000000000000  R11: 000000010014f172  R12: 0000000000000001
    R13: 0000000000000004  R14: 0000000000000000  R15: 0000000000000000
    ORIG_RAX: ffffffffffffffff  CS: 0030  SS: 0018
bt: WARNING: possibly bogus exception frame
--- <exception stack> ---
bt: cannot transition from exception stack to current process stack:
    exception stack pointer: ffff880001c86af0
      process stack pointer: ffff88008b183c30
         current stack base: ffff880076800000

$ cat /proc/cpuinfo 
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 23
model name	: Intel(R) Core(TM)2 Duo CPU     P8400  @ 2.26GHz
stepping	: 6
cpu MHz		: 800.000
cache size	: 3072 KB
physical id	: 0
siblings	: 1
core id		: 0
cpu cores	: 1
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm
constant_tsc up arch_perfmon pebs bts rep_good aperfmperf pni dtes64
monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm sse4_1 lahf_lm
tpr_shadow vnmi flexpriority
bogomips	: 4521.08
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

-- 
"Wire up your home and stay there."

