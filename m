From: Lukasz Muziol <l.muziol-kecf2yCh/1qFxr2TtlUqVg@public.gmane.org>
Subject: No ACPI battery events on HP compaq nx9000 (kernel 2.6.14-suspend2-r7)
Date: Tue, 10 Jan 2006 16:01:08 +0000
Message-ID: <20060110160108.09861e96.l.muziol@cs.ucl.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi folks!

I have a problem with ACPI battery support on my compaq nx9000, running Gentoo and 2.6.14-suspend2-r7 kernel. The battery state is read correctly at boot-up, but then stays at the same level. It only gets updated when the ac adapter is plugged or unplugged. It seems like no regular ACPI battery events are being generated and /proc/acpi/battery/BAT1/state doesn't have the correct values. Also, ocasionally plugging/unplugging the ac adapter doesn't produce an event either. I've tried several other recent kernels, the result always being the same. 

dmesg | grep ACPI produces:

BIOS-e820: 000000000bf70000 - 000000000bf7c000 (ACPI data)
BIOS-e820: 000000000bf7c000 - 000000000bf80000 (ACPI NVS)
ACPI: RSDP (v000 PTLTD ) @ 0x000f6ca0
ACPI: RSDT (v001 PTLTD RSDT 0x06040000 LTP 0x00000000) @ 0x0bf75e53
ACPI: FADT (v001 ATI Salmon 0x06040000 ATI 0x000f4240) @ 0x0bf7bf64
ACPI: BOOT (v001 PTLTD $SBFTBL$ 0x06040000 LTP 0x00000001) @ 0x0bf7bfd8
ACPI: DSDT (v001 ATI MS2_1535 0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x8008
ACPI: setting ELCR to 0200 (from 0420)
ACPI: bus type pci registered
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI quirk: region 8000-803f claimed by ali7101 ACPI
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK0] (IRQs 7 10) *0, disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 7 *10)
ACPI: PCI Interrupt Link [LNK2] (IRQs 7 *10)
ACPI: PCI Interrupt Link [LNK3] (IRQs 7 *10)
ACPI: PCI Interrupt Link [LNK4] (IRQs 7 11) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 7 *11)
ACPI: PCI Interrupt Link [LNK6] (IRQs 7 10) *0, disabled.
ACPI: PCI Interrupt Link [LNK7] (IRQs *5)
ACPI: PCI Interrupt Link [LNK8] (IRQs 7 10) *0, disabled.
ACPI: Embedded Controller [EC0] (gpe 24)
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNK5] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNK5] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt 0000:00:0a.1[A] -> Link [LNK5] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNK0] enabled at IRQ 10
ACPI: PCI Interrupt 0000:01:05.0[A] -> Link [LNK0] -> GSI 10 (level, low) -> IRQ 10
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Lid Switch [LID]
ACPI: Video Device [VGA] (multi-head: yes rom: no post: no)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THRM] (57 C)
ACPI: PCI Interrupt 0000:00:10.0[A]: no GSI
acpi-cpufreq: CPU0 - ACPI performance management activated.
ACPI wakeup devices:
ACPI: (supports S0 S3 S4 S5)
ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNK3] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [LNK2] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt 0000:00:0e.1[b] -> Link [LNK3] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNK7] enabled at IRQ 5
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LNK7] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNK5] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt 0000:00:0a.1[A] -> Link [LNK5] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt 0000:01:05.0[A] -> Link [LNK0] -> GSI 10 (level, low) -> IRQ 10



This line's interesting:

ACPI: Battery Slot [BAT1] (battery absent)

The battery really is there and /proc/acpi/battery/BAT1/state confirms that it's present.



My kernel config:


# Power management options (ACPI, APM)
# ACPI (Advanced Configuration and Power Interface) Support
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
# CONFIG_ACPI_HOTKEY is not set
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_CONTAINER is not set
CONFIG_X86_ACPI_CPUFREQ=y
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
CONFIG_PNPACPI=y
# CONFIG_SERIAL_8250_ACPI is not set




When I got this machine it came with an XP and everything seemed to be fine then.

Anyone's got any ideas why this could be happening?

Thanks in advance.
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
