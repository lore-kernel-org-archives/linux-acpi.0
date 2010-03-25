From: =?UTF-8?B?w4Frb3MgTWFyw7N5?= <akos@maroy.hu>
Subject: Re: how to debug a kernel that does not power off?
Date: Thu, 25 Mar 2010 10:45:52 -0600
Message-ID: <4BAB9340.4080407@maroy.hu>
References: <4BAAE755.9090509@maroy.hu> <4BAB2150.3020306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from perec.tyrell.hu ([66.197.149.104]:44611 "EHLO perec.tyrell.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753134Ab0CYReB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Mar 2010 13:34:01 -0400
In-Reply-To: <4BAB2150.3020306@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org

Alexey,

> Most probably, you have ACPI disabled either in the BIOS or in the
> kernel (command line or compiled out). Please check if it is enabled.

I seem to have ACPI enabled in the kernel:

# grep ACPI /boot/config-2.6.32.10-custom
CONFIG_X86_64_ACPI_NUMA=y
# Power management and ACPI options
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_PROCFS=y
CONFIG_ACPI_PROCFS_POWER=y
# CONFIG_ACPI_POWER_METER is not set
CONFIG_ACPI_SYSFS_POWER=y
CONFIG_ACPI_PROC_EVENT=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_DEBUG_FUNC_TRACE is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_SBS=y
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_HOTPLUG_PCI_ACPI=m
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
CONFIG_PNPACPI=y
CONFIG_ATA_ACPI=y
CONFIG_PATA_ACPI=y
# ACPI drivers
# ACPI drivers
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_DEBUGFACILITIES=y
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_ACPI_WMI=y
# CONFIG_ACPI_ASUS is not set
CONFIG_ACPI_TOSHIBA=m


but, interestingly, the ACPI states are not listed in /proc/acpi/info:

# cat /proc/acpi/info
version:                 20090903


what could be wrong?

dmesg does report ACPI messages:

# dmesg | grep ACPI
[    0.000000]  BIOS-e820: 00000000bf75c000 - 00000000bf7bf000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bf7e4000 - 00000000bf7ff000 (ACPI data)
[    0.000000]  modified: 00000000bf75c000 - 00000000bf7bf000 (ACPI NVS)
[    0.000000]  modified: 00000000bf7e4000 - 00000000bf7ff000 (ACPI data)
[    0.000000] ACPI: RSDP 00000000000fe020 00024 (v02 HP    )
[    0.000000] ACPI: XSDT 00000000bf7fe120 0009C (v01 HPQOEM SLIC-MPC
00000001      01000013)
[    0.000000] ACPI: FACP 00000000bf7fc000 000F4 (v04 HP     SLIC-MPC
00000001 MSFT 01000013)
[    0.000000] ACPI: DSDT 00000000bf7ee000 0ABEA (v02 HP     SLIC-MPC
00000001 MSFT 01000013)
[    0.000000] ACPI: FACS 00000000bf76e000 00040
[    0.000000] ACPI: ASF! 00000000bf7fd000 000A5 (v32 HPQOEM SLIC-MPC
00000001 MSFT 01000013)
[    0.000000] ACPI: HPET 00000000bf7fb000 00038 (v01 HPQOEM SLIC-MPC
00000001 MSFT 01000013)
[    0.000000] ACPI: APIC 00000000bf7fa000 0008C (v02 HPQOEM SLIC-MPC
00000001 MSFT 01000013)
[    0.000000] ACPI: MCFG 00000000bf7f9000 0003C (v01 HPQOEM SLIC-MPC
00000001 MSFT 01000013)
[    0.000000] ACPI: SLIC 00000000bf7ed000 00176 (v01 HPQOEM SLIC-MPC
00000001 MSFT 01000013)
[    0.000000] ACPI: SSDT 00000000bf7ec000 0073D (v01 TrmRef PtidDevc
00001000 INTL 20051117)
[    0.000000] ACPI: SSDT 00000000bf7eb000 00172 (v01  VaRef  Va_Acpi
00003000 INTL 20051117)
[    0.000000] ACPI: BOOT 00000000bf7ea000 00028 (v01 HPQOEM SLIC-MPC
00000001 MSFT 01000013)
[    0.000000] ACPI: SSDT 00000000bf7e9000 00C39 (v01 INTEL   SataPri
00001000 INTL 20051117)
[    0.000000] ACPI: SSDT 00000000bf7e8000 006C5 (v01 INTEL   SataSec
00001000 INTL 20051117)
[    0.000000] ACPI: SPCR 00000000bf7e7000 00050 (v01 HPQOEM SLIC-MPC
00000000 MSFT 01000013)
[    0.000000] ACPI: ASPT 00000000bf7e6000 00034 (v04 HPQOEM SLIC-MPC
00000001 MSFT 01000013)
[    0.000000] ACPI: WDAT 00000000bf7e5000 00224 (v01 HPQOEM SLIC-MPC
00000001 MSFT 01000013)
[    0.000000] ACPI: SSDT 00000000bf7e4000 009F1 (v01  PmRef    CpuPm
00003000 INTL 20051117)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x06] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x05] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x07] enabled)
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.011966] ACPI: Core revision 20090903
[    1.973050] ACPI FADT declares the system doesn't support PCIe ASPM,
so disable it
[    1.973055] ACPI: bus type pci registered
[    1.997538] ACPI: EC: Look up EC in DSDT
[    2.001806] ACPI: Executed 1 blocks of module-level executable AML code
[    2.010823] ACPI: BIOS _OSI(Linux) query ignored
[    2.027144] ACPI Error (psargs-0359): [\_PR_.CPU0._PPC] Namespace
lookup failure, AE_NOT_FOUND
[    2.027157] ACPI Error (psparse-0537): Method parse/execution failed
[\CPUT] (Node ffff8802370570a0), AE_NOT_FOUND
[    2.027245] ACPI Error (psparse-0537): Method parse/execution failed
[\PSSC] (Node ffff8802370570c0), AE_NOT_FOUND
[    2.027329] ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.PCI0.LPCB.EC0_._REG] (Node ffff88023703fa60), AE_NOT_FOUND
[    2.027553] ACPI: Interpreter enabled
[    2.027562] ACPI: (supports S0 S3 S4 S5)
[    2.027653] ACPI: Using IOAPIC for interrupt routing
[    2.029186] PM: Adding info for acpi:ACPI0003:00
[    2.034019] PM: Adding info for acpi:ACPI0008:00
[    2.052588] ACPI: EC: GPE = 0x16, I/O: command/status = 0x66, data = 0x62
[    2.054369] ACPI: ACPI Dock Station Driver: 1 docks/bays found
[    2.056466] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    2.063919] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    2.064472] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    2.064908] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    2.065171] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
[    2.065529] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEG3._PRT]
[    2.065791] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEG5._PRT]
[    2.092630] ACPI: PCI Root Bridge [CPBG] (0000:ff)
[    2.094790] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12
14 15) *11
[    2.095129] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *11 12
14 15)
[    2.095480] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12
14 15) *0, disabled.
[    2.095818] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12
14 15) *10
[    2.096154] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12
14 15) *11
[    2.096485] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12
14 15) *0, disabled.
[    2.096822] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12
14 15) *11
[    2.097157] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 11 12
14 15) *0, disabled.
[    2.098237] ACPI: WMI: Mapper loaded
[    2.098240] PCI: Using ACPI for IRQ routing
[    2.158194] pnp: PnP ACPI init
[    2.158217] ACPI: bus type pnp registered
[    2.167627] pnp: PnP ACPI: found 12 devices
[    2.167631] ACPI: ACPI bus type pnp unregistered
[    5.030257] ACPI: AC Adapter [ACAD] (on-line)
[    5.030342] ACPI: Power Button [PWRB]
[    5.030756] ACPI: Lid Switch [LID0]
[    5.030820] ACPI: Power Button [PWRF]
[    5.032711] ACPI: SSDT 00000000bf691a98 002DA (v01  PmRef  Cpu0Ist
00003000 INTL 20051117)
[    5.033611] ACPI: SSDT 00000000bf690618 005CD (v01  PmRef  Cpu0Cst
00003001 INTL 20051117)
[    5.035264] ACPI: SSDT 00000000bf691718 00303 (v01  PmRef    ApIst
00003000 INTL 20051117)
[    5.036219] ACPI: SSDT 00000000bf68fd98 00119 (v01  PmRef    ApCst
00003000 INTL 20051117)
[    5.053104] ACPI: Thermal Zone [TZ01] (64 C)
[    5.060449] ACPI: Battery Slot [BAT0] (battery present)
[    5.060818] ACPI: Battery Slot [BAT1] (battery absent)
[    6.736640] ACPI: Video Device [VGA1] (multi-head: yes  rom: no
post: no)
[    7.933379] pci 0000:01:00.0: power state changed by ACPI to D0



as for in the BIOS, I don't see an option to enable / disable ACPI.
also, the same laptop powers down fine on Windows - this might be an
indication that things should be OK on the BIOS side?

is there anywhere else I could look for the cause of this problem?


Akos



