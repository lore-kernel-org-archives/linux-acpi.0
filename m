From: "Miles Lane" <miles.lane@gmail.com>
Subject: 2.6.22-rc4-mm2 -- ACPI Exception (processor_throttling-0084): AE_NOT_FOUND, Evaluating _PTC [20070126]
Date: Thu, 7 Jun 2007 23:33:35 -0700
Message-ID: <a44ae5cd0706072333hda8e3c5v883dc9937565f206@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:18320 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbXFHGdg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Jun 2007 02:33:36 -0400
Received: by wa-out-1112.google.com with SMTP id v27so915982wah
        for <linux-acpi@vger.kernel.org>; Thu, 07 Jun 2007 23:33:35 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi,

I got this when I booted:
ACPI Exception (processor_throttling-0084): AE_NOT_FOUND, Evaluating
_PTC [20070126]
ACPI Exception (processor_throttling-0147): AE_NOT_FOUND, Evaluating
_TSS [20070126]

Is this a problem?  As far as I can tell, all of the system's devices
are working.

Here's the dmesg output filtered by "ACPI":

[    0.000000]  BIOS-e820: 000000003dee0000 - 000000003deec000 (ACPI data)
[    0.000000]  BIOS-e820: 000000003deec000 - 000000003df00000 (ACPI NVS)
[    0.000000] ACPI: RSDP 000F7E00, 0014 (r0 HP    )
[    0.000000] ACPI: RSDT 3DEE76BB, 0040 (r1 HP     09B8      6040000
LTP        0)
[    0.000000] ACPI: FACP 3DEEBE8C, 0074 (r1 HP     09B8      6040000
PTL        50)
[    0.000000] ACPI: DSDT 3DEE7B9A, 42F2 (r1 HP     09B8      6040000
MSFT  100000E)
[    0.000000] ACPI: FACS 3DEFCFC0, 0040
[    0.000000] ACPI: HPET 3DEEBF00, 0038 (r1 HP     09B8      6040000
PTL         0)
[    0.000000] ACPI: APIC 3DEEBF38, 005A (r1 HP     09B8      6040000
PTL        50)
[    0.000000] ACPI: APIC 3DEEBF92, 0046 (r1 HP     09B8      6040000
PTL         0)
[    0.000000] ACPI: BOOT 3DEEBFD8, 0028 (r1 HP     09B8      6040000
LTP        1)
[    0.000000] ACPI: SSDT 3DEE7AFE, 009C (r1 HP     09B8            1
INTL 20030224)
[    0.000000] ACPI: SSDT 3DEE76FB, 0277 (r1 HP     09B8         2000
INTL 20030224)
[    0.000000] ACPI: BIOS bug: multiple APIC/MADT found, using 0
[    0.000000] ACPI: If "acpi_apic_instance=2" works better, notify
linux-acpi@vger.kernel.org
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0x0
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.103333] ACPI: Core revision 20070126
[    0.116666]  tbxface-0587 [00] tb_load_namespace     : ACPI Tables
successfully acquired
[    0.119999] evxfevnt-0091 [00] enable                : Transition
to ACPI mode successful
[    0.156562] ACPI: bus type pci registered
[    0.189570] ACPI: Interpreter enabled
[    0.189575] ACPI: (supports S0 S3 S4 S5)
[    0.189751] ACPI: Using IOAPIC for interrupt routing
[    0.212538] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.214365] PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
[    0.215696] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.217070] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
[    0.237612] ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
[    0.237983] ACPI: PCI Interrupt Link [LNKB] (IRQs *5)
[    0.238331] ACPI: PCI Interrupt Link [LNKC] (IRQs *4)
[    0.238803] ACPI: PCI Interrupt Link [LNKD] (IRQs *3)
[    0.239157] ACPI: PCI Interrupt Link [LNKE] (IRQs *11)
[    0.239509] ACPI: PCI Interrupt Link [LNKF] (IRQs 3) *0, disabled.
[    0.239865] ACPI: PCI Interrupt Link [LNKG] (IRQs *4)
[    0.240216] ACPI: PCI Interrupt Link [LNKH] (IRQs *3)
[    0.240712] pnp: PnP ACPI init
[    0.240808] ACPI: bus type pnp registered
[    0.242169] pnp: ACPI device : hid PNP0A03
[    0.245962] pnp: ACPI device : hid PNP0B00
[    0.246320] pnp: ACPI device : hid PNP0C04
[    0.246564] pnp: ACPI device : hid PNP0200
[    0.246810] pnp: ACPI device : hid PNP0C02
[    0.247297] pnp: ACPI device : hid PNP0303
[    0.247633] pnp: ACPI device : hid SYN0110
[    0.248088] pnp: PnP ACPI: found 7 devices
[    0.248092] ACPI: ACPI bus type pnp unregistered
[    0.249667] PCI: Using ACPI for IRQ routing
[    0.256593] ACPI: RTC can wake from S4
[    0.289054] ACPI: PCI Interrupt 0000:02:09.0[A] -> GSI 20 (level,
low) -> IRQ 16
[    0.772639] ACPI: PCI Interrupt 0000:00:1f.6[B] -> GSI 17 (level,
low) -> IRQ 17
[    0.772650] ACPI: PCI interrupt for device 0000:00:1f.6 disabled
[    2.777155] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level,
low) -> IRQ 18
[    3.043268] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level,
low) -> IRQ 19
[    3.146999] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level,
low) -> IRQ 19
[    3.147980] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level,
low) -> IRQ 20
[    3.250210] ACPI: PCI Interrupt 0000:02:09.2[C] -> GSI 22 (level,
low) -> IRQ 21
[    3.250330] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level,
low) -> IRQ 22
[    3.354914] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level,
low) -> IRQ 22
[   16.956092] ACPI: PCI Interrupt 0000:02:09.3[A] -> GSI 20 (level,
low) -> IRQ 16
[   16.956982] ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 18 (level,
low) -> IRQ 22
[   17.256687] ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level,
low) -> IRQ 17
[   17.582960] ACPI: PCI Interrupt 0000:02:09.4[A] -> GSI 20 (level,
low) -> IRQ 16
[   42.970390] ACPI Exception (processor_throttling-0084):
AE_NOT_FOUND, Evaluating _PTC [20070126]
[   42.970402] ACPI Exception (processor_throttling-0147):
AE_NOT_FOUND, Evaluating _TSS [20070126]
[   42.970978] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[   43.027935] ACPI: Video Device [GFX0] (multi-head: yes  rom: yes  post: no)
[   43.078314] ACPI: Battery Slot [BAT0] (battery present)
[   43.143276] ACPI: AC Adapter [ACAD] (on-line)
[   43.156519] ACPI: Power Button (FF) [PWRF]
[   43.156877] ACPI: Lid Switch [LID0]
[   43.157178] ACPI: Sleep Button (CM) [SLPB]
[   47.325573] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level,
low) -> IRQ 19
