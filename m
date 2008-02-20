From: Ron Rechenmacher <ron@fnal.gov>
Subject: module bay on dell d830
Date: Wed, 20 Feb 2008 14:11:32 -0600
Message-ID: <47BC8974.1090702@fnal.gov>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_YkBlOlHQ5l3AFUTG8Cbq9g)"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailgw1.fnal.gov ([131.225.111.11]:34613 "EHLO mailgw1.fnal.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933782AbYBTUZz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Feb 2008 15:25:55 -0500
Received: from mailav1.fnal.gov (mailav1.fnal.gov [131.225.111.18])
 by mailgw1.fnal.gov
 (iPlanet Messaging Server 5.2 HotFix 2.06 (built Mar 28 2005))
 with SMTP id <0JWJ00298ZZRKH@mailgw1.fnal.gov> for linux-acpi@vger.kernel.org;
 Wed, 20 Feb 2008 14:11:35 -0600 (CST)
Received: from mailgw1.fnal.gov ([131.225.111.11])
 by mailav1.fnal.gov (SAVSMTP 3.1.7.47) with SMTP id M2008022014113430221 for
 <linux-acpi@vger.kernel.org>; Wed, 20 Feb 2008 14:11:34 -0600
Received: from conversion-daemon.mailgw1.fnal.gov by mailgw1.fnal.gov
 (iPlanet Messaging Server 5.2 HotFix 2.06 (built Mar 28 2005))
 id <0JWK0040102RZT@mailgw1.fnal.gov> (original mail from ron@fnal.gov)
 for linux-acpi@vger.kernel.org; Wed, 20 Feb 2008 14:11:35 -0600 (CST)
Received: from [131.225.88.96] (ronlap.dhcp.fnal.gov [131.225.88.96])
 by mailgw1.fnal.gov
 (iPlanet Messaging Server 5.2 HotFix 2.06 (built Mar 28 2005))
 with ESMTPSA id <0JWK001W003AHJ@mailgw1.fnal.gov> for
 linux-acpi@vger.kernel.org; Wed, 20 Feb 2008 14:11:34 -0600 (CST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: ron@fnal.gov

This is a multi-part message in MIME format.

--Boundary_(ID_YkBlOlHQ5l3AFUTG8Cbq9g)
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT

Hi,

I have a Dell D830 (has "module bay"). I've tried searching the web for 
the answer to "should I, with 2.6.24.2 (and latest Dell BIOS) be able to 
  remove the cdrom bay drive and continue to suspend/resume". I kind of 
don't think I should be able to yet, but I thought I'd ask here.

So:
How do I (or can I) remove the cdrom from the "acpi configuration" (for 
lack if a better term) so that I can replace the cdrom drive in the
module bay with a battery and continue to sleep/resume?

Currently, I can
     1) remove the ide_cd and cdrom modules
     2) echo 1 >|/sys/devices/platform/bay.0/eject   # I do not see that
this does any thing.
     3) physically remove the cdrom

But, if I try to sleep, the sleep process seems to hang. If after
waiting for several 10's of seconds, I physically re-insert the cdrom
module, the system will finish the sleep process and go to sleep.

Note: /sys/devices/platform/bay.0 information seems to mirror the
information in /sys/devices/platform/bay.1. For example, before and
after the cdrom is physically removed, both /sys/.../bay.0/present and
/sys/.../bay.1/present show the same information.

Does anyone know how or if I can do this?
What info do I need to provide? (attached is ACPI message from
/var/log/dmesg) output of acpidump is at 
fnapcf.fnal.gov/~ron/acpidump-d830-2.6.24.2.txt

The following processes are running.
# ps aux | grep '[a]cpi'
root    68  0.0  0.0      0     0 ?    S<   Feb16  0:00 [kacpid]
root    69  0.0  0.0      0     0 ?    S<   Feb16  0:00 [kacpi_notify]
root  3730  0.0  0.0   3768   628 ?    Ss   Feb16  0:00 /usr/sbin/acpid
68    4028  0.0  0.0  12272   852 ?    S    Feb16  0:00 hald-addon-acpi:
listening on acpid socket /var/run/acpid.socket

I have the following modules (among others, of course):
# lsmod | egrep 'cdrom|ide_|bay'
ide_cd                 44832  0
cdrom                  39592  1 ide_cd
bay                    11392  0
dock                   16416  1 bay

Could I write a script that echo's something to some file in
/sys/devices/platform/bay.1/eject and unloads modules?  Then
could/should I adjust the files under /etc/acpi/ to do some sort of
reconfig/rescan?? after I get the
      ACPI: \_SB_.PCI0.IDE1.PRI_.MAST: Bay event
which appears in dmesg, but not in /var/log/acpid (which is most likely
because I do not have anything configured in /etc/acpi/events.

I have a dell latitude d830 with BIOS A08 (the latest). I'm running
linux-2.6.24.2 x86_64. My distribution is Scientific Linux 5 (based on
RHEL5). I have the latest nvidia driver and can suspend to ram and
resume.  BTW, thanks to all who have made this possible! I really feel
that my productivity at work is maximized when all the information I
keep on my 24 virtual desktops can be maintained across many many
suspend/resume cycles.

I did buy an 80 Gig. module bay hard disk tha I would eventually like to
get working under linux also.

I apologize if I missed the answer to this before. I really have tried
to search the web for the answer and have failed.

Thanks,
Ron





--Boundary_(ID_YkBlOlHQ5l3AFUTG8Cbq9g)
Content-type: text/plain; name=dmesg.ACPI
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=dmesg.ACPI

ACPI: RSDP 000FBB00, 0024 (r2 DELL  )
ACPI: XSDT DFE5D200, 0064 (r1 DELL    M08     27D8010E ASL        61)
ACPI: FACP DFE5D09C, 00F4 (r4 DELL    M08     27D8010E ASL        61)
ACPI: DSDT DFE5D800, 63F7 (r2 INT430 SYSFexxx     1001 INTL 20050624)
ACPI: FACS DFE6C000, 0040
ACPI: HPET DFE5D300, 0038 (r1 DELL    M08            1 ASL        61)
ACPI: APIC DFE5D400, 0068 (r1 DELL    M08     27D8010E ASL        47)
ACPI: ASF! DFE5D000, 007E (r32 DELL    M08     27D8010E ASL        61)
ACPI: MCFG DFE5D3C0, 003E (r16 DELL    M08     27D8010E ASL        61)
ACPI: SLIC DFE5D49C, 0176 (r1 DELL    M08     27D8010E ASL        61)
ACPI: TCPA DFE5D700, 0032 (r1                        0 ASL         0)
ACPI: SSDT DFE5B97E, 04CC (r1  PmRef    CpuPm     3000 INTL 20050624)
ACPI: DMI detected: Dell
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
ACPI: Core revision 20070126
ACPI: bus type pci registered
ACPI: EC: Look up EC in DSDT
ACPI: BIOS _OSI(Linux) query ignored via DMI
ACPI: If "acpi_osi=Linux" works better, please notify linux-acpi@vger.kernel.org
ACPI: SSDT DFE6C080, 0043 (r1  LMPWR  DELLLOM     1001 INTL 20050624)
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP06._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 11) *5
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7) *10
ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 11) *3
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 14 devices
ACPI: ACPI bus type pnp unregistered
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI Interrupt 0000:03:01.0[A] -> GSI 19 (level, low) -> IRQ 19
ACPI: SSDT DFE5C4B4, 02C8 (r1  PmRef  Cpu0Ist     3000 INTL 20050624)
ACPI: SSDT DFE5BE4A, 05E5 (r1  PmRef  Cpu0Cst     3001 INTL 20050624)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: SSDT DFE5C77C, 00C4 (r1  PmRef  Cpu1Ist     3000 INTL 20050624)
ACPI: SSDT DFE5C42F, 0085 (r1  PmRef  Cpu1Cst     3000 INTL 20050624)
ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: Thermal Zone [THM] (57 C)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 20 (level, low) -> IRQ 20
ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 21 (level, low) -> IRQ 21
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 20
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 21 (level, low) -> IRQ 21
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 22 (level, low) -> IRQ 22
ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 22 (level, low) -> IRQ 22
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 20 (level, low) -> IRQ 20
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: AC Adapter [AC] (on-line)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PBTN]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
ACPI: Video Device [VID1] (multi-head: yes  rom: no  post: no)
ACPI: Video Device [VID2] (multi-head: yes  rom: no  post: no)
ACPI: PCI Interrupt 0000:03:01.4[A] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI Interrupt 0000:09:00.0[A] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:0c:00.0[A] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 21 (level, low) -> IRQ 21
ACPI: ACPI Dock Station Driver 
ACPI: \_SB_.PCI0.IDE0.SEC0.MAST: found ejectable bay
ACPI: \_SB_.PCI0.IDE0.SEC0.MAST: Adding notify handler
ACPI: Bay [\_SB_.PCI0.IDE0.SEC0.MAST] Added
ACPI: \_SB_.PCI0.IDE1.PRI_.MAST: found ejectable bay
ACPI: \_SB_.PCI0.IDE1.PRI_.MAST: Adding notify handler
ACPI: Bay [\_SB_.PCI0.IDE1.PRI_.MAST] Added



--Boundary_(ID_YkBlOlHQ5l3AFUTG8Cbq9g)--
