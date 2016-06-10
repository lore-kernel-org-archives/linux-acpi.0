From: Martin Brandenburg <martin@omnibond.com>
Subject: Re: linux-next boots then hangs...
Date: Fri, 10 Jun 2016 12:46:15 -0400
Message-ID: <CA+D=wkgYbY0TKX2_d4RcNsbDPkQ0mq+4NS+X2h4U1nWdvCoMTA@mail.gmail.com>
References: <CAOg9mSTG08zt8PNjDZ4zKXxFUVyW9-AzjRLreHjN5ETuoqh-Rg@mail.gmail.com>
 <1574a35b-a0e5-2ec0-f19e-8ff01ae5eec0@intel.com> <CAOg9mSRYcD9+P+914WY5_iLUWb4ZwXnQ02avtM3vV5+LiWsrXQ@mail.gmail.com>
 <cface69a-ce21-3faf-bca9-267ddf05237a@intel.com> <CAOg9mSQPGpSOm0ef0rJWFObyBriSEZwDzEAJi3dNtRCjygHyuQ@mail.gmail.com>
 <CAOg9mSSwRGZqQXhwQVi0=OG8xGqdFZbrHuNLSydL0WBziA2haQ@mail.gmail.com>
 <f3c64945-ff99-5afa-057b-b3734c0e3b39@intel.com> <CAOg9mSQa7RhesaPrHj7S3=_rzZFfpj9Z5vrfMmh3XAriuo9p5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34922 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932650AbcFJQqS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Jun 2016 12:46:18 -0400
Received: by mail-oi0-f45.google.com with SMTP id w5so41706204oib.2
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jun 2016 09:46:18 -0700 (PDT)
In-Reply-To: <CAOg9mSQa7RhesaPrHj7S3=_rzZFfpj9Z5vrfMmh3XAriuo9p5Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mike Marshall <hubcap@omnibond.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, kvm@vger.kernel.org, "Zheng, Lv" <lv.zheng@intel.com>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>

On Fri, Jun 10, 2016 at 7:49 AM, Mike Marshall <hubcap@omnibond.com> wrote:
> I'm about to disappear until the 20th on a backroads motorcycle
> trip with The Wild Bunch from Tennessee... I have included
> my co-worker Martin in the CC list, I think he will be able to
> help - I'll give him access to my VMs. Access to the VM's
> graphics console is important here - when the problem
> occurs, the broken thing that boots can't be logged into,
> but the graphics console does a particular whacky
> thing... June 9th's linux-next boots and runs fine on
> my VM BTW...
>
> I'll be able to peek into this thread some evenings
> from motel rooms, and we'll only be up to about rc4
> when I get back...
>
> -Mike
>
> On Thu, Jun 9, 2016 at 7:40 PM, Rafael J. Wysocki
> <rafael.j.wysocki@intel.com> wrote:
>> Let's involve the author of the commits in question (and CC linux-acpi too).
>>
>> On 6/8/2016 6:18 PM, Mike Marshall wrote:
>>>
>>> Hello everyone...
>>>
>>> The problem is gone today, and it looks like Rafael
>>> dropped the ACPICA changes from linux-next.
>>
>>
>> Indeed, I did that.
>>
>> Now, it would be good if you could help to identify which of them exactly
>> introduced the problem.
>>
>> Those patches are available in the kernel.org Patchwork as:
>>
>> https://patchwork.kernel.org/patch/9087951/
>> https://patchwork.kernel.org/patch/9088001/
>> https://patchwork.kernel.org/patch/9088021/
>> https://patchwork.kernel.org/patch/9087971/
>>
>> plus one fix on top of them:
>>
>> https://patchwork.kernel.org/patch/9157765/
>>
>> The ordering of the links above should reflect the correct order of the
>> patches (or you can verify that by looking at their subjects).
>>
>> Can you please try to apply them one by one (they should apply on top of the
>> current mainline) and see which one breaks things for you?

Okay starting at mainline (147d9e7bcad3b8d5465f6eea6292731e7f35dee8) and
applying one by one, I am able to apply v2-1-4, v2-2-4, and v2-3-4 without any
problems. After applying v2-4-4, I can no longer boot.

I don't know if Mike has explained what happens.

On the graphical console we get the OE-ligature character appearing
in what appears to be random locations on the screen. If you let it sit
more appear.

After redirecting to serial, I get the impression that it's not completely
broken. We continue to get output, including from userspace, after the
graphical console fails. But then systemd gets stuck ``A start job is
running for Wait for Plymouth Boot Screen to Quit''. It looks to me like
we'd go multiuser if that didn't stop everything.

I attempted to disable that ... thing by removing the rhgb option on
the command line. Systemd doesn't seem to care, and I can't figure
out how systemd works. Same result.

There is a trace which appears to come from the network code. It
happens after the screen goes wonky, so I'm not sure it's related.
The serial output is below.

I can report that adding rdinit=/bin/sh (it appears init= is now ignored)
causes the system to boot, so whatever is preventing multiuser is
past that point. Don't even get the strange characters this way.

Martin

>>
>> Thanks,
>> Rafael
>>
>>
>>
>>> Now linux-next has an Oops at leaf_walk_rcu and
>>> is not usable <g>... I think I see people on LKML
>>> talking about it.
>>>
>>> Thanks...
>>>
>>> -Mike
>>>
>>> On Tue, Jun 7, 2016 at 2:58 PM, Mike Marshall <hubcap@omnibond.com> wrote:
>>>>
>>>> Well, I started the bisect again, using Paolo's suggestion.
>>>>
>>>> It lead me in a circle back to 407aa3f.
>>>>
>>>> It could be that I'm not competent to perform this bisect, barring
>>>> that - it could be that the "bad" code only emerged as the result
>>>> of 407aa3f, which, according to the commit message, was a merge of
>>>> 41 commits...
>>>>
>>>> As to my bisect competency, sometimes (usually) the next bisect point
>>>> would be a place where 7f9bef9 wouldn't apply. I would only find out
>>>> that 7f9bef9 wouldn't apply by running the cherry pick, so each time
>>>> I'd have to clean up the failed cherry pick before I could continue,
>>>> which I did like this:
>>>>
>>>> git cherry-pick -n 7f9bef9                    <-- fail
>>>>
>>>> git reset HEAD drivers/acpi/acpica/hwregs.c   <-- to unstage
>>>>
>>>> git checkout -- drivers/acpi/acpica/hwregs.c  <-- discard cherry pick
>>>> wreckage
>>>>
>>>> Anyhow, I hope I'm being helpful, and not obstructionist, by trying
>>>> to follow up on this. Good luck Rafael, I'll definitely try
>>>> linux-next tomorrow.
>>>>
>>>> # git bisect log
>>>> git bisect start
>>>> # bad: [407aa3ff6f54ea2be7959639d664ae5183e2e9f8] Merge branch 'acpica'
>>>> git bisect bad 407aa3ff6f54ea2be7959639d664ae5183e2e9f8
>>>> # good: [7f9bef9debafcb767d00efb177d0f2edd4940eab] ACPICA / Hardware:
>>>> Fix old register check in acpi_hw_get_access_bit_width()
>>>> git bisect good 7f9bef9debafcb767d00efb177d0f2edd4940eab
>>>> # good: [d1ce3bb95511dacf8b9eea899c421f1b18a3ef6a] Merge back new
>>>> ACPICA material for v4.7.
>>>> git bisect good d1ce3bb95511dacf8b9eea899c421f1b18a3ef6a
>>>> # good: [d1ce3bb95511dacf8b9eea899c421f1b18a3ef6a] Merge back new
>>>> ACPICA material for v4.7.
>>>> git bisect good d1ce3bb95511dacf8b9eea899c421f1b18a3ef6a
>>>> # good: [21a9703de3045cda0b3aaa5bc193d2e1062908d2] Merge branch
>>>> 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
>>>> git bisect good 21a9703de3045cda0b3aaa5bc193d2e1062908d2
>>>> # good: [dd287690b0aa4b0d22e8dd7dd2cb3055f5141a27] Merge tag
>>>> 'arc-4.6-rc7-fixes' of
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc
>>>> git bisect good dd287690b0aa4b0d22e8dd7dd2cb3055f5141a27
>>>> # good: [35cd3f4563c4a0fc99be300afc7b82a822e634c7] Merge branch
>>>> 'for-4.6-fixes' of
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata
>>>> git bisect good 35cd3f4563c4a0fc99be300afc7b82a822e634c7
>>>> # good: [3f8f0cf2eddb558e5ccf9b155e758f4b950d8697] Merge tag
>>>> 'usb-4.6-rc7' of
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
>>>> git bisect good 3f8f0cf2eddb558e5ccf9b155e758f4b950d8697
>>>> # good: [2b86c4a84377b74a6ec0ec9463feb0803bcb1066] Merge tag
>>>> 'iio-fixes-for-4.6d' of
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into
>>>> staging-linus
>>>> git bisect good 2b86c4a84377b74a6ec0ec9463feb0803bcb1066
>>>> # good: [d1306eb675ad7a9a760b6b8e8e189824b8db89e7] nvmem: mxs-ocotp:
>>>> fix buffer overflow in read
>>>> git bisect good d1306eb675ad7a9a760b6b8e8e189824b8db89e7
>>>> # good: [32cf95db22d49cf4a3b421ba9fd156bb5f920ebb] Merge tag
>>>> 'char-misc-4.6-rc7' of
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
>>>> git bisect good 32cf95db22d49cf4a3b421ba9fd156bb5f920ebb
>>>> # good: [44549e8f5eea4e0a41b487b63e616cb089922b99] Linux 4.6-rc7
>>>> git bisect good 44549e8f5eea4e0a41b487b63e616cb089922b99
>>>> # first bad commit: [407aa3ff6f54ea2be7959639d664ae5183e2e9f8] Merge
>>>> branch 'acpica'
>>>>
>>>> On Tue, Jun 7, 2016 at 11:14 AM, Rafael J. Wysocki
>>>> <rafael.j.wysocki@intel.com> wrote:
>>>>>
>>>>> On 6/7/2016 5:08 PM, Mike Marshall wrote:
>>>>>>
>>>>>> I'm one of the original reporters and testers of that problem/fix...
>>>>>> my current problem started after that... I've tested
>>>>>> next-20160607 and 4.7.0-rc2-00004-g3613a62 (Linus' tree
>>>>>> of the moment) so far today... Linus' tree is still OK (because
>>>>>> it has 7f9bef9) and linux-next is still busted (for me).
>>>>>>
>>>>>> I'll keep on bisecting using the suggestions that Paolo sent...
>>>>>
>>>>>
>>>>> I see.
>>>>>
>>>>> I think I'll need to drop the latest ACPICA changes from linux-next
>>>>> then.
>>>>>
>>>>> Let me try to do that and please test linux-next again tomorrow.
>>>>>
>>>>> Thanks,
>>>>> Rafael
>>>>>
>>>>>
>>>>>
>>>>>> On Tue, Jun 7, 2016 at 10:55 AM, Rafael J. Wysocki
>>>>>> <rafael.j.wysocki@intel.com> wrote:
>>>>>>>
>>>>>>> On 6/6/2016 10:56 PM, Mike Marshall wrote:
>>>>>>>>
>>>>>>>> Greetings...
>>>>>>>>
>>>>>>>> Please keep my email in the loop on this, I'm only subscribed
>>>>>>>> to fs-devel...
>>>>>>>>
>>>>>>>> Linux-next fails to boot properly for me, but Linux 4.7-rc2 from
>>>>>>>> Linus' tree boots fine.
>>>>>>>>
>>>>>>>> I got started bisecting next-20160603 last Friday, but didn't get
>>>>>>>> done.
>>>>>>>>
>>>>>>>> git bisect start '64289ca' '7f9bef9'
>>>>>>>>
>>>>>>>> I picked 7f9bef9 as the good commit to start with because I knew
>>>>>>>> I needed 7f9bef9 or else my QEMU-KVM would crash. Before I started
>>>>>>>> the bisection, I verified that 7f9bef9 was indeed good by checking
>>>>>>>> out a branch from next-20160603 with 7f9bef9 as the HEAD and
>>>>>>>> building it: git checkout -b gas 7f9bef9
>>>>>>>>
>>>>>>>> Today I got next-20160606 and checked to see if the same failure
>>>>>>>> occurred - it did. So I continued with the bisection of
>>>>>>>> next-20160603.
>>>>>>>>
>>>>>>>> I arrived at 407aa3ff6f54ea2be7959639d664ae5183e2e9f8 as the bad
>>>>>>>> commit.
>>>>>>>>
>>>>>>>>
>>>>>>>> 407aa3f is a rather complex commit... there is a problem with it,
>>>>>>>> but I'm not sure what to do next... both 7f9bef9 and 407aa3f are
>>>>>>>> related to ACPICA...
>>>>>>>
>>>>>>>
>>>>>>> It looks like this commit
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=acpica-fixes&id=7f9bef9debafcb767d00efb177d0f2edd4940eab
>>>>>>>
>>>>>>> should fix the problem for you.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Rafael
>>>>>>>
>>

Linux version 4.7.0-rc2-00068-g7191535 (root@fedora20) (gcc version
4.8.3 20140911 (Red Hat 4.8.3-7) (GCC) ) #5 SMP Fri Jun 10 12:15:22
EDT 2016
Command line: BOOT_IMAGE=/vmlinuz-4.7.0-rc2-00068-g7191535
root=/dev/mapper/fedora-root ro rd.lvm.lv=fedora/swap
vconsole.font=latarcyrheb-sun16 rd.lvm.lv=fedora/root rhgb
LANG=en_US.UTF-8 console=ttyS0
x86/fpu: Legacy x87 FPU detected.
x86/fpu: Using 'eager' FPU context switches.
e820: BIOS-provided physical RAM map:
BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
BIOS-e820: [mem 0x0000000000100000-0x000000003fffdfff] usable
BIOS-e820: [mem 0x000000003fffe000-0x000000003fffffff] reserved
BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
NX (Execute Disable) protection: active
SMBIOS 2.4 present.
Hypervisor detected: KVM
e820: last_pfn = 0x3fffe max_arch_pfn = 0x400000000
x86/PAT: PAT not supported by CPU.
x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC
found SMP MP-table at [mem 0x000f1ff0-0x000f1fff] mapped at [ffff8800000f1ff0]
RAMDISK: [mem 0x34db4000-0x366d1fff]
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x00000000000F1E50 000014 (v00 BOCHS )
ACPI: RSDT 0x000000003FFFFA9B 000030 (v01 BOCHS  BXPCRSDT 00000001
BXPC 00000001)
ACPI: FACP 0x000000003FFFF177 000074 (v01 BOCHS  BXPCFACP 00000001
BXPC 00000001)
ACPI: DSDT 0x000000003FFFE040 001137 (v01 BXPC   BXDSDT   00000001
INTL 20150619)
ACPI: FACS 0x000000003FFFE000 000040
ACPI: SSDT 0x000000003FFFF1EB 000838 (v01 BOCHS  BXPCSSDT 00000001
BXPC 00000001)
ACPI: APIC 0x000000003FFFFA23 000078 (v01 BOCHS  BXPCAPIC 00000001
BXPC 00000001)
No NUMA configuration found
Faking a node at [mem 0x0000000000000000-0x000000003fffdfff]
NODE_DATA(0) allocated [mem 0x3ffec000-0x3fffdfff]
kvm-clock: Using msrs 4b564d01 and 4b564d00
kvm-clock: cpu 0, msr 0:3ffeb001, primary cpu clock
kvm-clock: using sched offset of 83647295628862 cycles
clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles:
0x1cd42e4dffb, max_idle_ns: 881590591483 ns
Zone ranges:
  DMA      [mem 0x0000000000001000-0x0000000000ffffff]
  DMA32    [mem 0x0000000001000000-0x000000003fffdfff]
  Normal   empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000001000-0x000000000009efff]
  node   0: [mem 0x0000000000100000-0x000000003fffdfff]
Initmem setup node 0 [mem 0x0000000000001000-0x000000003fffdfff]
ACPI: PM-Timer IO Port: 0x608
ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
Using ACPI (MADT) for SMP configuration information
smpboot: Allowing 1 CPUs, 0 hotplug CPUs
PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
e820: [mem 0x40000000-0xfeffbfff] available for PCI devices
Booting paravirtualized kernel on KVM
clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 1910969940391419 ns
setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:1 nr_node_ids:1
percpu: Embedded 35 pages/cpu @ffff88003fc00000 s102872 r8192 d32296 u2097152
KVM setup async PF for cpu 0
kvm-stealtime: cpu 0, msr 3fc0d900
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 257927
Policy zone: DMA32
Kernel command line: BOOT_IMAGE=/vmlinuz-4.7.0-rc2-00068-g7191535
root=/dev/mapper/fedora-root ro rd.lvm.lv=fedora/swap
vconsole.font=latarcyrheb-sun16 rd.lvm.lv=fedora/root rhgb
LANG=en_US.UTF-8 console=ttyS0
PID hash table entries: 4096 (order: 3, 32768 bytes)
Memory: 988860K/1048176K available (7808K kernel code, 1277K rwdata,
3176K rodata, 1564K init, 1464K bss, 59316K reserved, 0K cma-reserved)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Hierarchical RCU implementation.
Build-time adjustment of leaf fanout to 64.
RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=1.
RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=1
NR_IRQS:4352 nr_irqs:256 16
Offload RCU callbacks from all CPUs
Offload RCU callbacks from CPUs: 0.
Console: colour VGA+ 80x25
console [ttyS0] enabled
tsc: Detected 3392.144 MHz processor
Calibrating delay loop (skipped) preset value.. 6784.28 BogoMIPS (lpj=3392144)
pid_max: default: 32768 minimum: 301
ACPI: Core revision 20160422
Security Framework initialized
SELinux:  Initializing.
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Mountpoint-cache hash table entries: 2048 (order: 2, 16384 bytes)
mce: CPU supports 10 MCE banks
Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
Freeing SMP alternatives memory: 28K (ffffffff81ec8000 - ffffffff81ecf000)
ftrace: allocating 29398 entries in 115 pages
smpboot: Max logical packages: 1
smpboot: APIC(0) Converting physical 0 to logical package 0
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
smpboot: CPU0: Intel QEMU Virtual CPU version 1.5.3 (family: 0x6,
model: 0xd, stepping: 0x3)
Performance Events: Broken PMU hardware detected, using software events only.
 6Failed to access perfctr msr (MSR c2 is 0)
x86: Booted up 1 node, 1 CPUs
smpboot: Total of 1 processors activated (6784.28 BogoMIPS)
devtmpfs: initialized
x86/mm: Memory block size: 128MB
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 1911260446275000 ns
atomic64_test: passed for x86-64 platform with CX8 and with SSE
pinctrl core: initialized pinctrl subsystem
RTC time: 16:21:18, date: 06/10/16
NET: Registered protocol family 16
cpuidle: using governor menu
ACPI: bus type PCI registered
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
PCI: Using configuration type 1 for base access
HugeTLB registered 2 MB page size, pre-allocated 0 pages
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: 2 ACPI AML tables successfully acquired and loaded

ACPI: Interpreter enabled
ACPI: (supports S0 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: Using host bridge windows from ACPI; if necessary, use
"pci=nocrs" and report a bug
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI]
acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
acpi PNP0A03:00: fail to add MMCONFIG information, can't access
extended PCI configuration space under this bridge.
acpiphp: Slot [3] registered
acpiphp: Slot [4] registered
acpiphp: Slot [5] registered
acpiphp: Slot [6] registered
acpiphp: Slot [7] registered
acpiphp: Slot [8] registered
acpiphp: Slot [9] registered
acpiphp: Slot [10] registered
acpiphp: Slot [11] registered
acpiphp: Slot [12] registered
acpiphp: Slot [13] registered
acpiphp: Slot [14] registered
acpiphp: Slot [15] registered
acpiphp: Slot [16] registered
acpiphp: Slot [17] registered
acpiphp: Slot [18] registered
acpiphp: Slot [19] registered
acpiphp: Slot [20] registered
acpiphp: Slot [21] registered
acpiphp: Slot [22] registered
acpiphp: Slot [23] registered
acpiphp: Slot [24] registered
acpiphp: Slot [25] registered
acpiphp: Slot [26] registered
acpiphp: Slot [27] registered
acpiphp: Slot [28] registered
acpiphp: Slot [29] registered
acpiphp: Slot [30] registered
acpiphp: Slot [31] registered
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: root bus resource [mem 0x40000000-0xfebfffff window]
pci_bus 0000:00: root bus resource [bus 00-ff]
pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
ACPI: Enabled 16 GPEs in block 00 to 0F
vgaarb: setting as boot device: PCI:0000:00:02.0
vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
vgaarb: loaded
vgaarb: bridge control possible 0000:00:02.0
SCSI subsystem initialized
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
clocksource: Switched to clocksource kvm-clock
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
pnp: PnP ACPI init
pnp: PnP ACPI: found 5 devices
clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff,
max_idle_ns: 2085701024 ns
NET: Registered protocol family 2
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
UDP hash table entries: 512 (order: 2, 16384 bytes)
UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
NET: Registered protocol family 1
pci 0000:00:00.0: Limiting direct PCI/PCI transfers
pci 0000:00:01.0: PIIX3: Enabling Passive Release
pci 0000:00:01.0: Activating ISA DMA hang workarounds
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
ACPI Warning: \_SB.PCI0._PRT: Found unexpected NULL package element
(20160422/nsrepair-223)
pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
Unpacking initramfs...
Freeing initrd memory: 25720K (ffff880034db4000 - ffff8800366d2000)
futex hash table entries: 256 (order: 2, 16384 bytes)
audit: initializing netlink subsys (disabled)
audit: type=2000 audit(1465575677.422:1): initialized
Initialise system trusted keyrings
workingset: timestamp_bits=35 max_order=18 bucket_order=0
zbud: loaded
orangefs_init: called with debug mask: :none: :0:
orangefs: module version upstream loaded
Key type big_key registered
NET: Registered protocol family 38
Key type asymmetric registered
Asymmetric key parser 'x509' registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: PCI Express Hot Plug Controller Driver version: 0.4
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
ACPI: Power Button [PWRF]
GHES: HEST is not enabled!
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
Non-volatile memory driver v1.3
Linux agpgart interface v0.103
scsi host0: ata_piix
scsi host1: ata_piix
ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc180 irq 14
ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc188 irq 15
libphy: Fixed MDIO Bus: probed
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
uhci_hcd: USB Universal Host Controller Interface driver
uhci_hcd 0000:00:01.2: UHCI Host Controller
uhci_hcd 0000:00:01.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:01.2: detected 2 ports
uhci_hcd 0000:00:01.2: irq 24, io base 0x0000c100
usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 4.7.0-rc2-00068-g7191535 uhci_hcd
usb usb1: SerialNumber: 0000:00:01.2
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usbcore: registered new interface driver usbserial
usbcore: registered new interface driver usbserial_generic
usbserial: USB Serial support registered for generic
i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mousedev: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input1
rtc_cmos 00:00: RTC can wake from S4
rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
rtc_cmos 00:00: alarms up to one day, 114 bytes nvram
device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.34.0-ioctl (2015-10-28) initialised: dm-devel@redhat.com
hidraw: raw HID events driver (C) Jiri Kosina
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
drop_monitor: Initializing network drop monitor service
ip_tables: (C) 2000-2006 Netfilter Core Team
Initializing XFRM netlink socket
NET: Registered protocol family 10
mip6: Mobile IPv6
NET: Registered protocol family 17
microcode: CPU0 sig=0x6d3, pf=0x1, revision=0x1
microcode: Microcode Update Driver: v2.01
<tigran@aivazian.fsnet.co.uk>, Peter Oruba
registered taskstats version 1
Loading compiled-in X.509 certificates
alg: No test for pkcs1pad(rsa,sha256) (pkcs1pad(rsa-generic,sha256))
Loaded X.509 cert 'Build time autogenerated kernel key:
d0b9e00574de38a8532ee4c66c716b6b7392818d'
zswap: loaded using pool lzo/zbud
  Magic number: 4:271:388
rtc_cmos 00:00: setting system clock to 2016-06-10 16:21:18 UTC (1465575678)
ata1.00: ATA-7: QEMU HARDDISK, 1.5.3, max UDMA/100
ata1.00: 100663296 sectors, multi 16: LBA48
ata1.00: configured for MWDMA2
scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    3    PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 100663296 512-byte logical blocks: (51.5 GB/48.0 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
ata2.00: ATAPI: QEMU DVD-ROM, 1.5.3, max UDMA/100
ata2.00: configured for MWDMA2
scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     1.5. PQ: 0 ANSI: 5
 sda: sda1 sda2
sd 0:0:0:0: [sda] Attached SCSI disk
sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
cdrom: Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi generic sg1 type 5
Freeing unused kernel memory: 1564K (ffffffff81d41000 - ffffffff81ec8000)
Write protecting the kernel read-only data: 12288k
Freeing unused kernel memory: 368K (ffff8800017a4000 - ffff880001800000)
Freeing unused kernel memory: 920K (ffff880001b1a000 - ffff880001c00000)
systemd[1]: systemd 208 running in system mode. (+PAM +LIBWRAP +AUDIT
+SELINUX +IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ)
systemd[1]: Detected virtualization 'kvm'.
systemd[1]: Running in initial RAM disk.

Welcome to Fedora 20 (Heisenbug) dracut-037-11.git20140402.fc20 (Initramfs)!

systemd[1]: Set hostname to <fedora20>.
random: systemd urandom read with 13 bits of entropy available
systemd[1]: Expecting device dev-mapper-fedora\x2droot.device...
         Expecting device dev-mapper-fedora\x2droot.device...
systemd[1]: Starting -.slice.
[  OK  ] Created slice -.slice.
systemd[1]: Created slice -.slice.
systemd[1]: Starting System Slice.
[  OK  ] Created slice System Slice.
systemd[1]: Created slice System Slice.
systemd[1]: Starting Slices.
[  OK  ] Reached target Slices.
systemd[1]: Reached target Slices.
systemd[1]: Starting Timers.
[  OK  ] Reached target Timers.
systemd[1]: Reached target Timers.
systemd[1]: Starting Journal Socket.
[  OK  ] Listening on Journal Socket.
systemd[1]: Listening on Journal Socket.
systemd[1]: Starting dracut cmdline hook...
         Starting dracut cmdline hook...
systemd[1]: Starting Create list of required static device nodes for
the current kernel...
         Starting Create list of required static device nodes...rrent kernel...
systemd[1]: Started Load Kernel Modules.
systemd[1]: Starting Apply Kernel Variables...
         Starting Apply Kernel Variables...
systemd[1]: Starting Setup Virtual Console...
         Starting Setup Virtual Console...
systemd[1]: Starting Journal Service...
         Starting Journal Service...
[  OK  ] Started Journal Service.
systemd[1]: Started Journal Service.
[  OK  ] Listening on udev Kernel Socket.
[  OK  ] Listening on udev Control Socket.
[  OK  ] Reached target Sockets.
[  OK  ] Reached target Swap.
[  OK  ] Reached target Local File Systems.
[  OK  ] Started Create list of required static device nodes ...current kernel.
[  OK  ] Started Apply Kernel Variables.
         Starting Create static device nodes in /dev...
[  OK  ] Started Create static device nodes in /dev.
[  OK  ] Started Setup Virtual Console.
[  OK  ] Started dracut cmdline hook.
         Starting dracut pre-udev hook...
[  OK  ] Started dracut pre-udev hook.
         Starting udev Kernel Device Manager...
systemd-udevd[252]: starting version 208
[  OK  ] Started udev Kernel Device Manager.
         Starting udev Coldplug all Devices...
[  OK  ] Started udev Coldplug all Devices.
         Starting dracut initqueue hook...
[  OK  ] Reached target System Initialization.
         Starting Show Plymouth Boot Screen...
virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driver
virtio-pci 0000:00:05.0: virtio_pci: leaving for legacy driver
8139cp: 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
8139cp 0000:00:03.0 eth0: RTL-8139C+ at 0xffffc900001fc000,
52:54:00:4d:a5:0f, IRQ 24
8139too: 8139too Fast Ethernet driver 0.9.28
8139cp 0000:00:03.0 ens3: renamed from eth0
systemd-udevd[258]: renamed network interface eth0 to ens3
[drm] Initialized drm 1.1.0 20060810
[drm] Device Version 0.0
[drm] Compression level 0 log level 0
[drm] Currently using mode #0, list at 0x488
[drm] 12286 io pages at offset 0x1000000
[drm] 16777216 byte draw area at offset 0x0
[drm] RAM header offset: 0x3ffe000
[drm] rom modes offset 0x488 for 128 modes
[TTM] Zone  kernel: Available graphics memory: 508730 kiB
[TTM] Initializing pool allocator
[TTM] Initializing DMA pool allocator
[drm] qxl: 16M of VRAM memory size
[drm] qxl: 63M of IO pages memory ready (VRAM domain)
[drm] qxl: 64M of Surface memory size
input: ImExPS/2 BYD TouchPad as /devices/platform/i8042/serio1/input/input3
tsc: Refined TSC clocksource calibration: 3392.082 MHz
clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x30e51689adc,
max_idle_ns: 440795263471 ns
[drm] main mem slot 1 [f4000000,3ffe000]
[drm] surface mem slot 2 [f8000000,4000000]
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] No driver support for vblank timestamp query.
[drm] fb mappable at 0xF4000000, size 3145728
[drm] fb: depth 24, pitch 4096, width 1024, height 768
fbcon: qxldrmfb (fb0) is primary device
Console: switching to colour frame buffer device 128x48
qxl 0000:00:02.0: fb0: qxldrmfb frame buffer device
         Mounting Configuration File System...
[  OK  ] Mounted Configuration File System.
[  OK  ] Started Show Plymouth Boot Screen.
[  OK  ] Reached target Paths.
[  OK  ] Reached target Basic System.
[drm] Initialized qxl 0.1.0 20120117 for 0000:00:02.0 on minor 0
random: nonblocking pool is initialized
[  OK  ] Found device /dev/mapper/fedora-root.
[  OK  ] Started dracut initqueue hook.
         Starting dracut pre-mount hook...
PM: Starting manual resume from disk
[  OK  ] Started dracut pre-mount hook.
         Mounting /sysroot...
EXT4-fs (dm-1): mounted filesystem with ordered data mode. Opts: (null)
[  OK  ] Mounted /sysroot.
[  OK  ] Reached target Initrd Root File System.
         Starting Reload Configuration from the Real Root...
[  OK  ] Started Reload Configuration from the Real Root.
[  OK  ] Reached target Initrd File Systems.
[  OK  ] Reached target Initrd Default Target.
systemd-journald[119]: Received SIGTERM
audit: type=1404 audit(1465575764.800:2): enforcing=1 old_enforcing=0
auid=4294967295 ses=4294967295
SELinux:  Permission validate_trans in class security not defined in policy.
SELinux:  Permission module_load in class system not defined in policy.
SELinux:  Class netlink_iscsi_socket not defined in policy.
SELinux:  Class netlink_fib_lookup_socket not defined in policy.
SELinux:  Class netlink_connector_socket not defined in policy.
SELinux:  Class netlink_netfilter_socket not defined in policy.
SELinux:  Class netlink_generic_socket not defined in policy.
SELinux:  Class netlink_scsitransport_socket not defined in policy.
SELinux:  Class netlink_rdma_socket not defined in policy.
SELinux:  Class netlink_crypto_socket not defined in policy.
SELinux:  Permission audit_read in class capability2 not defined in policy.
SELinux:  Class binder not defined in policy.
SELinux:  Class cap_userns not defined in policy.
SELinux:  Class cap2_userns not defined in policy.
SELinux: the above unknown classes and permissions will be allowed
audit: type=1403 audit(1465575764.902:3): policy loaded
auid=4294967295 ses=4294967295
systemd[1]: Successfully loaded SELinux policy in 114.659ms.
audit: type=1400 audit(1465575765.012:4): avc:  denied  { associate }
for  pid=1 comm="systemd" name="/" dev="pstore" ino=8755
scontext=system_u:object_r:sysfs_t:s0
tcontext=system_u:object_r:pstorefs_t:s0 tclass=filesystem
permissive=0
systemd[1]: Unable to fix label of /sys/fs/pstore: Permission denied
systemd[1]: Relabelled /dev and /run in 9.442ms.

Welcome to Fedora 20 (Heisenbug)!

[  OK  ] Stopped Switch Root.
[  OK  ] Stopped target Switch Root.
[  OK  ] Stopped target Initrd File Systems.
[  OK  ] Stopped target Initrd Root File System.
[  OK  ] Created slice system-serial\x2dgetty.slice.
         Expecting device dev-ttyS0.device...
[  OK  ] Created slice system-getty.slice.
[  OK  ] Created slice User and Session Slice.
[  OK  ] Reached target Remote File Systems.
[  OK  ] Reached target Slices.
[  OK  ] Listening on /dev/initctl Compatibility Named Pipe.
[  OK  ] Listening on Delayed Shutdown Socket.
         Starting Create list of required static device nodes...rrent kernel...
         Mounting Debug File System...
         Starting Apply Kernel Variables...
         Mounting Huge Pages File System...
         Mounting POSIX Message Queue File System...
[  OK  ] Listening on udev Kernel Socket.
[  OK  ] Listening on udev Control Socket.
         Starting udev Coldplug all Devices...
[  OK  ] Listening on LVM2 metadata daemon socket.
[  OK  ] Listening on Device-mapper event daemon FIFOs.
         Starting Monitoring of LVM2 mirrors, snapshots etc. ...ress polling...
         Expecting device dev-mapper-fedora\x2dswap.device...
         Mounting Temporary Directory...
         Starting File System Check on Root Device...
         Expecting device dev-disk-by\x2duuid-9283c5dd\x2dee7...e4b4c.device...
[  OK  ] Stopped Trigger Flushing of Journal to Persistent Storage.
         Stopping Journal Service...
[  OK  ] Stopped Journal Service.
         Starting Journal Service...
[  OK  ] Started Journal Service.
[  OK  ] Started Create list of required static device nodes ...current kernel.
         Starting Create static device nodes in /dev...
[  OK  ] Started Apply Kernel Variables.
[  OK  ] Mounted Debug File System.
[  OK  ] Mounted Huge Pages File System.
[  OK  ] Mounted POSIX Message Queue File System.
[  OK  ] Mounted Temporary Directory.
[  OK  ] Started udev Coldplug all Devices.
         Starting udev Wait for Complete Device Initialization...
         Starting LVM2 metadata daemon...
[  OK  ] Started LVM2 metadata daemon.
systemd-fsck[471]: /dev/mapper/fedora-root: clean, 398438/2981888
files, 5921141/11921408 blocks
[  OK  ] Started File System Check on Root Device.
         Starting Remount Root and Kernel File Systems...
[  OK  ] Started Create static device nodes in /dev.
         Starting udev Kernel Device Manager...
[  OK  ] Started udev Kernel Device Manager.
systemd-udevd[491]: starting version 208
EXT4-fs (dm-1): re-mounted. Opts: (null)
[  OK  ] Started Remount Root and Kernel File Systems.
         Starting Import network configuration from initramfs...
         Starting Configure read-only root support...
         Starting Load/Save Random Seed...
[  OK  ] Reached target Local File Systems (Pre).
[  OK  ] Started Load/Save Random Seed.
[  OK  ] Started Import network configuration from initramfs.
[  OK  ] Started Configure read-only root support.
[  OK  ] Started Monitoring of LVM2 mirrors, snapshots etc. u...ogress polling.
[  OK  ] Started udev Wait for Complete Device Initialization.
         Starting Activation of DM RAID sets...
[  OK  ] Found device /dev/ttyS0.
piix4_smbus 0000:00:01.3: SMBus Host Controller at 0x700, revision 0
[  OK  ] Started Activation of DM RAID sets.
[  OK  ] Reached target Encrypted Volumes.
ppdev: user-space parallel port driver
[  OK  ] Found device QEMU_HARDDISK.
         Starting File System Check on /dev/disk/by-uuid/9283...2c85009e4b4c...
systemd-fsck[543]: /dev/sda1: clean, 413/128016 files, 455610/512000 blocks
         Starting LVM2 PV scan on device 8:2...
[  OK  ] Found device /dev/mapper/fedora-swap.
         Activating swap /dev/mapper/fedora-swap...
[  OK  ] Started File System Check on /dev/disk/by-uuid/9283c...e-2c85009e4b4c.
         Mounting /boot...
Adding 2129916k swap on /dev/mapper/fedora-swap.  Priority:-1
extents:1 across:2129916k FS
[  OK  ] Activated swap /dev/mapper/fedora-swap.
[  OK  ] Reached target Swap.
[  OK  ] Started LVM2 PV scan on device 8:2.
EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[  OK  ] Mounted /boot.
[  OK  ] Reached target Local File Systems.
         Starting Trigger Flushing of Journal to Persistent Storage...
         Starting Create Volatile Files and Directories...
         Starting Tell Plymouth To Write Out Runtime Data...
systemd-journald[472]: Received request to flush runtime journal from PID 1
[  OK  ] Started Trigger Flushing of Journal to Persistent Storage.
[  OK  ] Started Tell Plymouth To Write Out Runtime Data.
[  OK  ] Started Create Volatile Files and Directories.
         Starting Security Auditing Service...
[  OK  ] Started Security Auditing Service.
         Starting Update UTMP about System Reboot/Shutdown...
[  OK  ] Started Update UTMP about System Reboot/Shutdown.
[  OK  ] Reached target System Initialization.
[  OK  ] Reached target Timers.
         Starting Manage Sound Card State (restore and store)...
[  OK  ] Started Manage Sound Card State (restore and store).
audit: type=1305 audit(1465575768.617:5): audit_pid=564 old=0
auid=4294967295 ses=4294967295 subj=system_u:system_r:auditd_t:s0
res=1
[  OK  ] Listening on Open-iSCSI iscsiuio Socket.
[  OK  ] Listening on Open-iSCSI iscsid Socket.
[  OK  ] Listening on CUPS Printing Service Sockets.
[  OK  ] Reached target Paths.
[  OK  ] Listening on Avahi mDNS/DNS-SD Stack Activation Socket.
[  OK  ] Listening on D-Bus System Message Bus Socket.
[  OK  ] Reached target Sockets.
[  OK  ] Reached target Basic System.
         Starting Agent daemon for Spice guests...
         Starting LSB: Init script for live image....
         Starting firewalld - dynamic firewall daemon...
         Starting Permit User Sessions...
         Starting RealtimeKit Scheduling Policy Service...
         Starting Accounts Service...
         Starting NTP client/server...
         Starting Modem Manager...
         Starting irqbalance daemon...
[  OK  ] Started irqbalance daemon.
         Starting Avahi mDNS/DNS-SD Stack...
         Starting Hardware RNG Entropy Gatherer Daemon...
[  OK  ] Started Hardware RNG Entropy Gatherer Daemon.
         Starting Machine Check Exception Logging Daemon...
         Starting Login Service...
         Starting D-Bus System Message Bus...
[  OK  ] Started D-Bus System Message Bus.
[  OK  ] Started LSB: Init script for live image..
[  OK  ] Started Permit User Sessions.
         Starting Job spooling tools...
[  OK  ] Started Job spooling tools.
         Starting Command Scheduler...
[  OK  ] Started Command Scheduler.
         Starting Wait for Plymouth Boot Screen to Quit...
         Starting SYSV: Late init script for live image....
         Starting GNOME Display Manager...
         Starting ABRT Automated Bug Reporting Tool...
[  OK  ] Started ABRT Automated Bug Reporting Tool.
         Starting Install ABRT coredump hook...
         Starting ABRT kernel log watcher...
[  OK  ] Started ABRT kernel log watcher.
         Starting ABRT Xorg log watcher...
[  OK  ] Started ABRT Xorg log watcher.
[  OK  ] Started Machine Check Exception Logging Daemon.
[  OK  ] Started Agent daemon for Spice guests.
[  OK  ] Started NTP client/server.
[  OK  ] Started SYSV: Late init script for live image..
[  OK  ] Reached target Agent daemon for Spice guests.
[  OK  ] Started Install ABRT coredump hook.
[  OK  ] Started RealtimeKit Scheduling Policy Service.
[  OK  ] Started Avahi mDNS/DNS-SD Stack.
[  OK  ] Started Login Service.
[  OK  ] Started GNOME Display Manager.
         Starting Authorization Manager...
[  OK  ] Started Modem Manager.
[  OK  ] Started Authorization Manager.
[  OK  ] Started Accounts Service.
nf_conntrack version 0.5.0 (8192 buckets, 32768 max)
ip6_tables: (C) 2000-2006 Netfilter Core Team
Ebtables v2.0 registered
bridge: automatic filtering via arp/ip/ip6tables has been deprecated.
Update your scripts to load br_netfilter if you need this.
[  OK  ] Started firewalld - dynamic firewall daemon.
         Starting Network Manager...
[  OK  ] Started Network Manager.
[  OK  ] Reached target Network.
8139cp 0000:00:03.0 ens3: link up, 100Mbps, full-duplex, lpa 0x05E1
         Starting OpenSSH server daemon...
         Starting Bluetooth service...
[  OK  ] Started Bluetooth service.
[  OK  ] Started OpenSSH server daemon.
Bluetooth: Core ver 2.21
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO socket layer initialized
Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Bluetooth: BNEP filters: protocol multicast
Bluetooth: BNEP socket layer initialized
         Starting Hostname Service...
[  OK  ] Started Hostname Service.
[*     ] A start job is running for Wait for Plymouth Boot Screen to
Quit------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at net/sched/sch_generic.c:270 dev_watchdog+0x217/0x220
NETDEV WATCHDOG: ens3 (8139cp): transmit queue 0 timed out
Modules linked in: ip6t_rpfilter bnep ip6t_REJECT nf_reject_ipv6
bluetooth xt_conntrack cfg80211 rfkill ebtable_nat ebtable_broute
bridge stp llc ebtable_filter ebtables ip6table_nat nf_conntrack_ipv6
nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_security
ip6table_raw ip6table_filter ip6_tables iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle
iptable_security iptable_raw ppdev parport_pc parport virtio_console
i2c_piix4 virtio_balloon serio_raw pvpanic qxl drm_kms_helper ttm drm
8139too ata_generic 8139cp virtio_pci virtio virtio_ring mii pata_acpi
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.7.0-rc2-00068-g7191535 #5
Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
 0000000000000286 d3c807548ecfe710 ffff88003fc03da0 ffffffff813bdaa7
 ffff88003fc03df0 0000000000000000 ffff88003fc03de0 ffffffff810a1d71
 0000010e3fc17680 0000000000000000 ffff88003928c000 0000000000000001
Call Trace:
 <IRQ>  [<ffffffff813bdaa7>] dump_stack+0x63/0x8c
 [<ffffffff810a1d71>] __warn+0xd1/0xf0
 [<ffffffff810a1def>] warn_slowpath_fmt+0x5f/0x80
 [<ffffffff816af767>] dev_watchdog+0x217/0x220
 [<ffffffff816af550>] ? dev_deactivate_queue.constprop.33+0x60/0x60
 [<ffffffff81109ca5>] call_timer_fn+0x35/0x120
 [<ffffffff816af550>] ? dev_deactivate_queue.constprop.33+0x60/0x60
 [<ffffffff8110a30a>] run_timer_softirq+0x22a/0x2e0
 [<ffffffff8179dfb7>] __do_softirq+0xd7/0x2c5
 [<ffffffff810a7797>] irq_exit+0xd7/0xe0
 [<ffffffff8179ddf2>] smp_apic_timer_interrupt+0x42/0x50
 [<ffffffff8179bfdc>] apic_timer_interrupt+0x8c/0xa0
 <EOI>  [<ffffffff81063566>] ? native_safe_halt+0x6/0x10
 [<ffffffff8103797e>] default_idle+0x1e/0xd0
 [<ffffffff8103811f>] arch_cpu_idle+0xf/0x20
 [<ffffffff810e3ce3>] default_idle_call+0x33/0x40
 [<ffffffff810e3ff9>] cpu_startup_entry+0x309/0x3a0
 [<ffffffff8178f5b7>] rest_init+0x77/0x80
 [<ffffffff81d5c185>] start_kernel+0x48d/0x4ae
 [<ffffffff81d5bae6>] ? set_init_arg+0x55/0x55
 [<ffffffff81d5b120>] ? early_idt_handler_array+0x120/0x120
 [<ffffffff81d5b5db>] x86_64_start_reservations+0x2f/0x31
 [<ffffffff81d5b729>] x86_64_start_kernel+0x14c/0x16f
---[ end trace 911a405f4406bf7f ]---
8139cp 0000:00:03.0 ens3: Transmit timeout, status  d   3b    4 80ff
[***   ] A start job is running for Wait for Plymouth Boot Screen to
Quit8139cp 0000:00:03.0 ens3: Transmit timeout, status  d   3b    4
80ff
[  *** ] A start job is running for Wait for Plymouth Boot Screen to
Quit8139cp 0000:00:03.0 ens3: Transmit timeout, status  d   3b    4
80ff
[    **] A start job is running for Wait for Plymouth Boot Screen to
Quit8139cp 0000:00:03.0 ens3: Transmit timeout, status  d   3b    4
80ff
[    **] A start job is running for Wait for Plymouth Boot Screen to
Quit8139cp 0000:00:03.0 ens3: Transmit timeout, status  d   3b    4
80ff
[  *** ] A start job is running for Wait for Plymouth Boot Screen to
Quit8139cp 0000:00:03.0 ens3: Transmit timeout, status  d   3b    4
80ff
[***   ] A start job is running for Wait for Plymouth Boot Screen to
Quit8139cp 0000:00:03.0 ens3: Transmit timeout, status  d   3b    4
80ff
[*     ] A start job is running for Wait for Plymouth Boot Screen to
Quit8139cp 0000:00:03.0 ens3: Transmit timeout, status  d   3b    5
80ff
[***   ] A start job is running for Wait for Plymouth Boot Screen to
Quit8139cp 0000:00:03.0 ens3: Transmit timeout, status  d   3b    5
80ff
[  *** ] A start job is running for Wait for Plymouth Boot Screen to
Quit8139cp 0000:00:03.0 ens3: Transmit timeout, status  d   3b    5
80ff
[    **] A start job is running for Wait for Plymouth Boot Screen to
Quit8139cp 0000:00:03.0 ens3: Transmit timeout, status  d   3b    4
80ff
[    **] A start job is running for Wait for Plymouth Boot Screen to
Quit8139cp 0000:00:03.0 ens3: Transmit timeout, status  d   3b    4
80ff
[  *** ] A start job is running for Wait for Plymouth Boot Screen to
Quit8139cp 0000:00:03.0 ens3: Transmit timeout, status  d   3b    5
80ff
[***   ] A start job is running for Wait for Plymouth Boot Screen to
Quit8139cp 0000:00:03.0 ens3: Transmit timeout, status  d   3b    4
80ff
[*     ] A start job is running for Wait for Plymouth Boot Screen to
Quit8139cp 0000:00:03.0 ens3: Transmit timeout, status  d   3b    5
80ff
[***   ] A start job is running for Wait for Plymouth Boot Screen to
Quit8139cp 0000:00:03.0 ens3: Transmit timeout, status  d   3b    4
80ff
[    **] A start job is running for Wait for Plymouth Boot Screen to Quit
