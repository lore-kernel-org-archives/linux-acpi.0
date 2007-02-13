From: "martin schneebacher" <martin.schneebacher@gmail.com>
Subject: no fan detected
Date: Tue, 13 Feb 2007 15:38:50 +0100
Message-ID: <e30fb88b0702130638g9e26873ned471eceaa309719@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:20201 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbXBMOix (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 09:38:53 -0500
Received: by ug-out-1314.google.com with SMTP id 44so229642uga
        for <linux-acpi@vger.kernel.org>; Tue, 13 Feb 2007 06:38:52 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

hi, list.

i have a aopen notebook 1559as with a centrino cpu and a nvidia
graphic card. there are two fans inside (cpu and graphic), but since
somewhen (i don't remember when exactly, i noticed it with the latest
kernel) there is no fan detected by the acpi system, and
/proc/acpi/fan is empty. the syslog lists all acpi devices but the
fan.

i'm using debian/sid with
Linux gusti 2.6.20 #4 Tue Feb 13 14:58:45 CET 2007 i686 GNU/Linux

acpi compilled in, .config

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_LEGACY is not set
# CONFIG_PM_DEBUG is not set
# CONFIG_PM_SYSFS_DEPRECATED is not set
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_STD_PARTITION="/dev/sda5"

#
# ACPI (Advanced Configuration and Power Interface) Support
#
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
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
# CONFIG_ACPI_CONTAINER is not set
# CONFIG_ACPI_SBS is not set

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=y
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

#
# CPUFreq processor drivers
#
CONFIG_X86_ACPI_CPUFREQ=y
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_GX_SUSPMOD is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_SPEEDSTEP_ICH is not set
# CONFIG_X86_SPEEDSTEP_SMI is not set
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_CPUFREQ_NFORCE2 is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set

#
# shared options
#
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
# CONFIG_X86_SPEEDSTEP_LIB is not set






masc@gusti:/usr/src/linux/drivers/acpi$ cat /var/log/syslog | grep ACPI
Feb 13 15:14:15 gusti kernel: ACPI: Core revision 20060707
Feb 13 15:14:15 gusti kernel: ACPI: bus type pci registered
Feb 13 15:14:15 gusti kernel: ACPI: Interpreter enabled
Feb 13 15:14:15 gusti kernel: ACPI: Using IOAPIC for interrupt routing
Feb 13 15:14:15 gusti kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Feb 13 15:14:15 gusti kernel: PCI quirk: region 1000-107f claimed by
ICH6 ACPI/GPIO/TCO
Feb 13 15:14:15 gusti kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0._PRT]
Feb 13 15:14:15 gusti kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.PEGP._PRT]
Feb 13 15:14:15 gusti kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.AGP_._PRT]
Feb 13 15:14:15 gusti kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.RP01._PRT]
Feb 13 15:14:15 gusti kernel: ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.PCIB._PRT]
Feb 13 15:14:15 gusti kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs *10 11)
Feb 13 15:14:15 gusti kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 10 *11)
Feb 13 15:14:15 gusti kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 10 *11)
Feb 13 15:14:15 gusti kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 10 *11)
Feb 13 15:14:15 gusti kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs *10 11)
Feb 13 15:14:15 gusti kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs *10 11)
Feb 13 15:14:15 gusti kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 11) *10
Feb 13 15:14:15 gusti kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 10 *11)
Feb 13 15:14:15 gusti kernel: pnp: PnP ACPI init
Feb 13 15:14:15 gusti kernel: pnp: PnP ACPI: found 8 devices
Feb 13 15:14:15 gusti kernel: PnPBIOS: Disabled by ACPI PNP
Feb 13 15:14:15 gusti kernel: PCI: Using ACPI for IRQ routing
Feb 13 15:14:15 gusti kernel: ACPI: PCI Interrupt 0000:00:01.0[A] ->
GSI 16 (level, low) -> IRQ 16
Feb 13 15:14:15 gusti kernel: ACPI: PCI Interrupt 0000:00:1c.0[A] ->
GSI 17 (level, low) -> IRQ 17
Feb 13 15:14:15 gusti kernel: ACPI: PCI Interrupt 0000:03:09.0[A] ->
GSI 22 (level, low) -> IRQ 18
Feb 13 15:14:15 gusti kernel: ACPI: AC Adapter [ADP1] (on-line)
Feb 13 15:14:15 gusti kernel: ACPI: Battery Slot [BAT0] (battery present)
Feb 13 15:14:15 gusti kernel: ACPI: Power Button (FF) [PWRF]
Feb 13 15:14:15 gusti kernel: ACPI: Lid Switch [LID0]
Feb 13 15:14:15 gusti kernel: ACPI: Sleep Button (CM) [SLPB]
Feb 13 15:14:15 gusti kernel: ACPI: Video Device [VGA] (multi-head:
yes  rom: no  post: no)
Feb 13 15:14:15 gusti kernel: ACPI: CPU0 (power states: C1[C1] C2[C2])
Feb 13 15:14:15 gusti kernel: ACPI: Processor [CPU0] (supports 8
throttling states)
Feb 13 15:14:15 gusti kernel: ACPI: Thermal Zone [TZS0] (55 C)
Feb 13 15:14:15 gusti kernel: ACPI: Thermal Zone [TZS1] (49 C)
Feb 13 15:14:15 gusti kernel: ACPI: PCI Interrupt 0000:03:07.0[A] ->
GSI 20 (level, low) -> IRQ 19
Feb 13 15:14:15 gusti kernel: ACPI: PCI Interrupt 0000:00:1f.2[B] ->
GSI 17 (level, low) -> IRQ 17
Feb 13 15:14:15 gusti kernel: ACPI: (supports S0 S3 S4 S5)
Feb 13 15:14:15 gusti kernel: ACPI: PCI Interrupt 0000:00:1e.3[B] ->
GSI 21 (level, low) -> IRQ 20
Feb 13 15:14:15 gusti kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] ->
GSI 23 (level, low) -> IRQ 21
Feb 13 15:14:15 gusti kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] ->
GSI 17 (level, low) -> IRQ 17
Feb 13 15:14:15 gusti kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] ->
GSI 18 (level, low) -> IRQ 22
Feb 13 15:14:15 gusti kernel: ACPI: PCI Interrupt 0000:00:1d.3[D] ->
GSI 19 (level, low) -> IRQ 23
Feb 13 15:14:15 gusti kernel: ACPI: PCI Interrupt 0000:00:1d.7[A] ->
GSI 23 (level, low) -> IRQ 21
Feb 13 15:14:15 gusti kernel: ACPI: PCI Interrupt 0000:03:09.2[A] ->
GSI 22 (level, low) -> IRQ 18
Feb 13 15:14:15 gusti kernel: ACPI: PCI Interrupt 0000:03:09.3[A] ->
GSI 22 (level, low) -> IRQ 18
Feb 13 15:14:15 gusti kernel: ACPI: PCI Interrupt 0000:00:1f.3[B] ->
GSI 17 (level, low) -> IRQ 17
Feb 13 15:14:15 gusti kernel: ACPI: PCI Interrupt 0000:03:05.0[A] ->
GSI 20 (level, low) -> IRQ 19
Feb 13 15:14:15 gusti kernel: ACPI: PCI Interrupt 0000:00:1e.2[A] ->
GSI 21 (level, low) -> IRQ 20
Feb 13 15:14:15 gusti kernel: ACPI: PCI Interrupt 0000:03:09.4[A] ->
GSI 22 (level, low) -> IRQ 18
Feb 13 15:14:31 gusti kernel: ACPI: PCI Interrupt 0000:01:00.0[A] ->
GSI 16 (level, low) -> IRQ 16
masc@gusti:/usr/src/linux/drivers/acpi$

any hints?

bye...masc.
