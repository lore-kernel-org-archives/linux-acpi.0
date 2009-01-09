From: Michael Wallner <mike@iworks.at>
Subject: Re: How to help with sony-laptop on Vaio VGN-TT11
Date: Fri, 09 Jan 2009 12:09:45 +0100
Message-ID: <49673079.2070801@iworks.at>
References: <496634F2.3080505@iworks.at> <alpine.LFD.2.00.0901081534190.4505@localhost.localdomain> <20090108234127.GB19979@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080903060408090605010502"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:33906 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134AbZAILJ4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Jan 2009 06:09:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LLFFS-0002BY-Jd
	for linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 11:09:54 +0000
Received: from border-g21.inqnet.at ([213.229.41.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Fri, 09 Jan 2009 11:09:54 +0000
Received: from mike by border-g21.inqnet.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Fri, 09 Jan 2009 11:09:54 +0000
In-Reply-To: <20090108234127.GB19979@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>

This is a multi-part message in MIME format.
--------------080903060408090605010502
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Norbert Preining wrote:
> Hi Len, hi all,
> 
> On Do, 08 Jan 2009, Len Brown wrote:
>> I've recently got a VGN-z540 and was impressed at how bright it is too:-)
>>
>> they hotkeys do not work,
>> however, echo into /sys/class/backlight/*/brightness files works,
>> do you have those files?
> 
> VGN Z11 same problem. hardware keys don't work, but via /sys it does.

The /sys backlight interface doesn't work for me.

Fn+F{1-12} do not work at all (no events).
Hardware button for cdrom-eject and s1-button, too.

Hardware buttons for mute, vol-down, vol-up do work, though.
Wireless switch does something, I'm just not sure yet what it does,
dmesg says "rfkill switch must be enabled for wireless to work" or
something along those words.  I'm sorry, I don't have my notebook
with me today.

> 
> Michael: Which kernel you are running? There have been some fixed which
> helped my laptop to at least get the /sys files working.

Current Ubuntus kernel, 2.6.27.

> 
> The problems is that the /sys files for the wwan interface etc are NOT
> working, they are not doing anything useful AFAI could deduce. 

Same here.

I attached an egrep -i "ACPI|sony" of dmesg.

Mike

--------------080903060408090605010502
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="dmesg.txt"

[    0.000000]  BIOS-e820: 000000007a20a000 - 000000007a20d000 (ACPI NVS)=

[    0.000000]  BIOS-e820: 000000007bc85000 - 000000007bcbf000 (ACPI NVS)=

[    0.000000]  BIOS-e820: 000000007bceb000 - 000000007bcff000 (ACPI data=
)
[    0.000000] ACPI: RSDP 000FE020, 0024 (r2   Sony)
[    0.000000] ACPI: XSDT 7BCFE120, 006C (r1   Sony     VAIO 20080829    =
   1000013)
[    0.000000] ACPI: FACP 7BCFD000, 00F4 (r4   Sony     VAIO 20080829 MSF=
T  1000013)
[    0.000000] ACPI: DSDT 7BCEE000, 99BB (r1   Sony     VAIO 20080829 MSF=
T  1000013)
[    0.000000] ACPI: FACS 7BC92000, 0040
[    0.000000] ACPI: HPET 7BCFC000, 0038 (r1   Sony     VAIO 20080829 MSF=
T  1000013)
[    0.000000] ACPI: APIC 7BCFB000, 006C (r1   Sony     VAIO 20080829 MSF=
T  1000013)
[    0.000000] ACPI: MCFG 7BCFA000, 003C (r1   Sony     VAIO 20080829 MSF=
T  1000013)
[    0.000000] ACPI: SLIC 7BCF9000, 0176 (r1   Sony     VAIO 20080829 MSF=
T  1000013)
[    0.000000] ACPI: ASF! 7BCF8000, 00A5 (r32   Sony     VAIO 20080829 MS=
FT  1000013)
[    0.000000] ACPI: BOOT 7BCED000, 0028 (r1   Sony     VAIO 20080829 MSF=
T  1000013)
[    0.000000] ACPI: DBGP 7BCEC000, 0034 (r1   Sony     VAIO 20080829 MSF=
T  1000013)
[    0.000000] ACPI: SSDT 7BCEB000, 0655 (r1   Sony     VAIO 20080829 INT=
L 20051117)
[    0.000000] ACPI: DMI detected: Sony
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x00] disabled)
[    0.000000] ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level=
)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.019139] ACPI: Core revision 20080609
[    0.023405] ACPI: Checking initramfs for custom DSDT
[    0.728487] ACPI: bus type pci registered
[    0.734492] ACPI: EC: Look up EC in DSDT
[    0.742761] ACPI: BIOS _OSI(Linux) query ignored via DMI
[    0.758150] ACPI: Interpreter enabled
[    0.758156] ACPI: (supports S0 S3 S4 S5)
[    0.758190] ACPI: Using IOAPIC for interrupt routing
[    0.773534] ACPI: EC: GPE =3D 0x17, I/O: command/status =3D 0x66, data=
 =3D 0x62
[    0.773534] ACPI: EC: driver started in poll mode
[    0.773534] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.777982] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.778763] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P32_._PRT]
[    0.779147] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP1._PRT]
[    0.779417] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP2._PRT]
[    0.779728] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP4._PRT]
[    0.816227] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 *10 11 12)=

[    0.816508] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 12)=

[    0.816785] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 *10 11 12)=

[    0.817060] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 *10 11 12)=

[    0.817335] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 *10 11 12)=

[    0.817610] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 *10 11 12)=

[    0.817885] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 *10 11 12)=

[    0.818160] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 *10 11 12)=

[    0.818340] pnp: PnP ACPI init
[    0.818340] ACPI: bus type pnp registered
[    0.824402] pnp: PnP ACPI: found 10 devices
[    0.824402] ACPI: ACPI bus type pnp unregistered
[    0.824402] PnPBIOS: Disabled by ACPI PNP
[    0.824402] PCI: Using ACPI for IRQ routing
[    0.834698] ACPI: RTC can wake from S4
[    2.849472] ACPI: SSDT 7BB6FC98, 0223 (r1   Sony     VAIO 20080829 INT=
L 20051117)
[    2.850344] ACPI: SSDT 7BB6D618, 05B2 (r1   Sony     VAIO 20080829 INT=
L 20051117)
[    2.981140] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[    2.981223] processor ACPI0007:00: registered as cooling_device0
[    2.981230] ACPI: Processor [CPU0] (supports 8 throttling states)
[    2.982033] ACPI: SSDT 7BB6EE18, 01CF (r1   Sony     VAIO 20080829 INT=
L 20051117)
[    2.982960] ACPI: SSDT 7BB6FF18, 008D (r1   Sony     VAIO 20080829 INT=
L 20051117)
[    2.984463] ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
[    2.992583] processor ACPI0007:01: registered as cooling_device1
[    2.992590] ACPI: Processor [CPU1] (supports 8 throttling states)
[    3.060963] ACPI: Thermal Zone [ATF0] (63 C)
[    3.436259] ACPI: ACPI Dock Station Driver
[    5.296882] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 filtered out
[    5.355659] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 filtered out
[    6.094253] ata2.00: ACPI cmd 00/00:00:00:00:00:a0 rejected by device =
(Stat=3D0x51 Err=3D0x04)
[    6.096623] ata2.00: ACPI cmd 00/00:00:00:00:00:a0 rejected by device =
(Stat=3D0x51 Err=3D0x04)
[   29.417216] ACPI: AC Adapter [AC] (on-line)
[   29.512047] ACPI: Power Button (CM) [PWRB]
[   29.514003] ACPI: Lid Switch [LID0]
[   29.525351] ACPI: Battery Slot [BAT0] (battery present)
[   29.784528] acpi device:04: registered as cooling_device2
[   29.812043] ACPI: Video Device [OVGA] (multi-head: yes  rom: no  post:=
 no)
[   30.016929] sony-laptop: Sony Programmable IO Control Driver v0.6.
[   30.016962] sony-laptop: detected Type2 model
[   30.016965] sony-laptop: Evaluating _STA
[   30.016978] sony-laptop: Device disabled
[   30.016981] sony-laptop: Evaluating _PRS
[   30.017120] sony-laptop: IO1 at 0xc000 (0x20)
[   30.017124] sony-laptop: IO1 at 0xc800 (0x20)
[   30.017127] sony-laptop: IO1 at 0xd000 (0x20)
[   30.017130] sony-laptop: IO1 at 0xd800 (0x20)
[   30.017356] input: Sony Vaio Keys as /devices/LNXSYSTM:00/device:00/PN=
P0A08:00/device:0a/SNY6001:00/input/input5
[   30.036102] input: Sony Vaio Jogdial as /devices/virtual/input/input6
[   30.052189] sony-laptop: device allocated minor is 60
[   30.052198] sony-laptop: I/O port1: 0xc000 (0xc000) + 0x20
[   30.052216] sony-laptop: IRQ: 6 - triggering: 1 - polarity: 0 - shr: 0=

[   30.052220] sony-laptop: Evaluating _SRS
[   30.053501] sony-laptop: sony_pic_call1(0x82): 0x000a
[   30.053570] sony-laptop: event ([00] [04]) at port 0xc000(+0x12)
[   30.053638] sony-laptop: sony_pic_call2(0x81 - 0xff): 0x0000
[   30.053715] sony-laptop: sony_pic_call1(0x82): 0x000a
[   30.053727] sony-laptop: event ([00] [04]) at port 0xc000(+0x12)
[   30.053814] sony-laptop: event ([ff] [04]) at port 0xc000(+0x12)
[   30.053925] sony-laptop: Sony Notebook Control Driver v0.6.
[   30.053930] sony-laptop: method: name: _INI, args 0
[   30.053934] sony-laptop: method: name: PWAK, args 0
[   30.053938] sony-laptop: method: name: ECON, args 1
[   30.053941] sony-laptop: method: name: GBRT, args 0
[   30.053944] sony-laptop: method: name: SBRT, args 1
[   30.053947] sony-laptop: method: name: EAWK, args 1
[   30.053950] sony-laptop: method: name: SN00, args 1
[   30.053953] sony-laptop: method: name: SN01, args 0
[   30.053957] sony-laptop: method: name: SN02, args 1
[   30.053960] sony-laptop: method: name: SN03, args 1
[   30.053963] sony-laptop: method: name: SN04, args 0
[   30.053966] sony-laptop: method: name: SN05, args 1
[   30.053969] sony-laptop: method: name: SN06, args 1
[   30.053972] sony-laptop: method: name: SN07, args 1
[   30.053975] sony-laptop: method: name: SNIN, args 0
[   30.053978] sony-laptop: method: name: SNCF, args 2
[   30.053981] sony-laptop: method: name: SNNE, args 1
[   30.053984] sony-laptop: method: name: F100, args 0
[   30.053988] sony-laptop: method: name: F113, args 0
[   30.053991] sony-laptop: method: name: F101, args 0
[   30.053994] sony-laptop: method: name: F105, args 0
[   30.053997] sony-laptop: method: name: F114, args 0
[   30.054000] sony-laptop: method: name: F115, args 0
[   30.054003] sony-laptop: method: name: F11D, args 0
[   30.054006] sony-laptop: method: name: GPID, args 0
[   30.054009] sony-laptop: method: name: F119, args 0
[   30.054012] sony-laptop: method: name: F121, args 0
[   30.054015] sony-laptop: method: name: F122, args 0
[   30.054018] sony-laptop: method: name: F124, args 0
[   30.054021] sony-laptop: method: name: F125, args 0
[   30.054025] sony-laptop: method: name: F126, args 0
[   30.054028] sony-laptop: method: name: F12F, args 0
[   30.054031] sony-laptop: method: name: F131, args 0
[   30.054037] sony-laptop: Invoking _INI
[   30.066854] sony-laptop: Found PID getter: GPID
[   38.754222] ACPI: WMI: Mapper loaded
[   49.601516] sonypi: Sony Programmable I/O Controller Driver v1.26.
[   49.604497] sonypi: please try the sony-laptop module instead and repo=
rt failures, see also http://www.linux.it/~malattia/wiki/index.php/Sony_d=
rivers
[   49.605080] sysfs: duplicate filename 'sonypi' can not be created
[   49.605083] Modules linked in: sonypi(+) ppdev acpi_cpufreq cpufreq_on=
demand cpufreq_userspace cpufreq_stats cpufreq_conservative freq_table cp=
ufreq_powersave wmi container sbs sbshc pci_slot iptable_filter ip_tables=
 x_tables ext2 sbp2 parport_pc lp parport joydev pcmcia snd_hda_intel snd=
_pcm_oss snd_mixer_oss arc4 snd_pcm ecb crypto_blkcipher snd_seq_dummy sn=
d_seq_oss snd_seq_midi iwlagn iwlcore snd_rawmidi snd_seq_midi_event led_=
class snd_seq mac80211 snd_timer snd_seq_device evdev cfg80211 serio_raw =
snd yenta_socket sdhci_pci sdhci psmouse rsrc_nonstatic pcspkr mmc_core s=
oundcore pcmcia_core uvcvideo shpchp pci_hotplug snd_page_alloc compat_io=
ctl32 videodev v4l1_compat hso rfkill sony_laptop video output battery bu=
tton ac intel_agp agpgart ext3 jbd mbcache sr_mod cdrom sd_mod crc_t10dif=
 sg ahci libata ohci1394 scsi_mod ieee1394 ehci_hcd uhci_hcd e1000e usbco=
re dock thermal processor fan fbcon tileblit font bitblit softcursor fuse=

[   49.605354]  [<f8fc6bca>] sonypi_probe+0x252/0x4ee [sonypi]
[   49.605364]  [<f8fc65d0>] ? sonypi_irq+0x0/0x1b8 [sonypi]
[   49.605452]  [<f8892000>] ? sonypi_init+0x0/0xa3 [sonypi]
[   49.605459]  [<f889206d>] sonypi_init+0x6d/0xa3 [sonypi]
[   49.605505] kobject_add_internal failed for sonypi with -EEXIST, don't=
 try to register things with the same name in the same directory.
[   49.605571]  [<f8fc6bca>] sonypi_probe+0x252/0x4ee [sonypi]
[   49.605579]  [<f8fc65d0>] ? sonypi_irq+0x0/0x1b8 [sonypi]
[   49.605666]  [<f8892000>] ? sonypi_init+0x0/0xa3 [sonypi]
[   49.605674]  [<f889206d>] sonypi_init+0x6d/0xa3 [sonypi]
[   49.605713] sonypi: misc_register failed
[   49.629724] sonypi: probe of sonypi failed with error -17


--------------080903060408090605010502--

