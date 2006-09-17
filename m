From: "Tvrtko A. Ursulin" <tvrtko@ursulin.net>
Subject: A bug or not? No C states on Turion64 ML-34
Date: Sun, 17 Sep 2006 16:46:45 +0100
Message-ID: <200609171646.46064.tvrtko@ursulin.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outmail1.freedom2surf.net ([194.106.33.237]:39065 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S964967AbWIQPqr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 17 Sep 2006 11:46:47 -0400
Received: from [192.168.1.3] (i-83-67-11-44.freedom2surf.net [83.67.11.44])
	by outmail.freedom2surf.net (Postfix) with ESMTP id E29EF51D64
	for <linux-acpi@vger.kernel.org>; Sun, 17 Sep 2006 16:46:46 +0100 (BST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


Hi all,

On my new HP Pavilion s7510 PC I seem to be missing C states and CPU power 
management capabilities. Frequency scaling works though. 

I am not sure if this is even a bug, or an ACPI bug os some sort?

I also tried vanilla 2.6.17.13, or noapic/nolapic but to no avail.

tvrtko@astrid:~> cat /etc/issue

Welcome to SUSE LINUX 10.1 (i586) - Kernel \r (\l).

tvrtko@astrid:~> uname -a
Linux astrid 2.6.16.21-0.21-default #1 Tue Aug 29 16:42:05 UTC 2006 i686 
athlon i386 GNU/Linux

tvrtko@astrid:~> cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 36
model name      : AMD Turion(tm) 64 Mobile Technology ML-34
stepping        : 2
cpu MHz         : 800.000
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext fxsr_opt lm 
3dnowext 3dnow pni lahf_lm ts fid vid ttp tm stc
bogomips        : 1595.08

tvrtko@astrid:~> dmesg | grep powern
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.60.2)
powernow-k8:    0 : fid 0xa (1800 MHz), vid 0x4 (1450 mV)
powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x6 (1400 mV)
powernow-k8:    2 : fid 0x0 (800 MHz), vid 0x16 (1000 mV)
powernow-k8: ph2 null fid transition 0xa

tvrtko@astrid:~> cat /proc/acpi/processor/CPU0/info
processor id:            0
acpi id:                 0
bus mastering control:   yes
power management:        no
throttling control:      yes
limit interface:         yes

tvrtko@astrid:~> cat /proc/acpi/processor/CPU0/power
active state:            C1
max_cstate:              C8
bus master activity:     00000000
states:
   *C1:                  type[C1] promotion[--] demotion[--] latency[000] 
usage[00000000]

tvrtko@astrid:~> dmesg | grep ACPI
 BIOS-e820: 000000003bef0000 - 000000003bef3000 (ACPI NVS)
 BIOS-e820: 000000003bef3000 - 000000003bf00000 (ACPI data)
ACPI: RSDP (v000 HP-CPC                                ) @ 0x000f7590
ACPI: RSDT (v001 HP-CPC AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3bef3040
ACPI: FADT (v001 HP-CPC AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3bef30c0
ACPI: MCFG (v001 HP-CPC AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3bef7c00
ACPI: MADT (v001 HP-CPC AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3bef7b40
ACPI: DSDT (v001 HP-CPC AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
ACPI: bus type pci registered
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *10 11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11), disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
pnp: PnP ACPI init
pnp: PnP ACPI: found 9 devices
PCI: Using ACPI for IRQ routing
apm: overridden by ACPI.
ACPI wakeup devices:
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 177
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THRM] (40 C)
ACPI: Fan [FAN] (on)
ACPI: PCI Interrupt 0000:00:14.5[B] -> GSI 17 (level, low) -> IRQ 185
ACPI: PCI Interrupt 0000:00:13.2[A] -> GSI 19 (level, low) -> IRQ 193
ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 19 (level, low) -> IRQ 193
ACPI: PCI Interrupt 0000:00:13.1[A] -> GSI 19 (level, low) -> IRQ 193
ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 21 (level, low) -> IRQ 201
ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 20 (level, low) -> IRQ 209
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: PCI Interrupt 0000:01:05.0[A] -> GSI 17 (level, low) -> IRQ 185
