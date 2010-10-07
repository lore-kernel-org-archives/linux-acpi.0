From: Oliver Freyd <Oliver.Freyd@gmx.de>
Subject: CLEVO B5120 acpi problems, probably EC-related
Date: Thu, 07 Oct 2010 22:45:45 +0200
Message-ID: <i8lbib$jb$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:33462 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721Ab0JGUuG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Oct 2010 16:50:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-acpi-devel@m.gmane.org>)
	id 1P3xPf-0003Pk-UK
	for linux-acpi@vger.kernel.org; Thu, 07 Oct 2010 22:50:03 +0200
Received: from pd9fff5bb.dip.t-dialin.net ([217.255.245.187])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Thu, 07 Oct 2010 22:50:03 +0200
Received: from Oliver.Freyd by pd9fff5bb.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Thu, 07 Oct 2010 22:50:03 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

I'm trying to get this new laptop running with linux (debian testing)
most things are working well, I get acpi events for hotkeys
like volume up/down, or light up/down, but no acpi_events
or even interrupts for the sleep button, the power button,
lid switch and AC power plug.

uname -a
Linux falkenstein 2.6.32-5-amd64 #1 SMP Fri Sep 17 21:50:19 UTC 2010 
x86_64 GNU/Linux





dmesg|grep ACPI says:

[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.002994] ACPI: Core revision 20090903
[    0.497370] ACPI: bus type pci registered
[    0.512734] ACPI: EC: Look up EC in DSDT
[    0.518819] ACPI: BIOS _OSI(Linux) query ignored
[    0.520679] ACPI: EC: GPE storm detected, transactions will use 
polling mode
[    0.540248] ACPI: Interpreter enabled
[    0.540252] ACPI: (supports S0 S3 S4 S5)
[    0.540287] ACPI: Using IOAPIC for interrupt routing
[    0.540597] [Firmware Bug]: ACPI: ACPI brightness control misses _BQC 
function
[    0.575483] [Firmware Bug]: ACPI: ACPI brightness control misses _BQC 
function
[    0.612412] ACPI: EC: GPE = 0x17, I/O: command/status = 0x66, data = 0x62
[    0.612664] ACPI: No dock devices found.
[    0.613466] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.628222] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.628467] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
[    0.628586] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    0.628785] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    0.628900] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
[    0.629015] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
[    0.629129] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
[    0.639287] ACPI: PCI Root Bridge [CPBG] (0000:ff)
[    0.639612] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 
14 15) *11
[    0.639713] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 
14 15) *10
[    0.639812] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 12 
14 15)
[    0.639911] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 *5 6 7 11 12 
14 15)
[    0.640009] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 
14 15) *0, disabled.
[    0.640114] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 
14 15) *0, disabled.
[    0.640215] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 *7 10 12 
14 15)
[    0.640314] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 *11 12 
14 15)
[    0.640454] PCI: Using ACPI for IRQ routing
[    0.649093] pnp: PnP ACPI init
[    0.649105] ACPI: bus type pnp registered
[    0.665529] pnp: PnP ACPI: found 11 devices
[    0.665530] ACPI: ACPI bus type pnp unregistered
[    1.083544] ACPI Error (psargs-0359): [\_PR_.CPU0._PPC] Namespace 
lookup failure, AE_NOT_FOUND
[    1.083550] ACPI Error (psparse-0537): Method parse/execution failed 
[\_SB_.PCI0.LPCB.EC__.ADJP] (Node ffff880137a40240), AE_NOT_FOUND
[    1.083581] ACPI Error (psparse-0537): Method parse/execution failed 
[\_TZ_.TZ0_._TMP] (Node ffff880137a44de0), AE_NOT_FOUND
[    3.203371] ACPI: SSDT 00000000bf71a918 003F0 (v01  PmRef  Cpu0Ist 
00003000 INTL 20060912)
[    3.203922] ACPI: SSDT 00000000bf718a18 00471 (v01  PmRef  Cpu0Cst 
00003001 INTL 20060912)
[    3.218859] ACPI: Power Button [PWRB]
[    3.218919] ACPI: Sleep Button [SLPB]
[    3.223950] ACPI: SSDT 00000000bf719a98 00303 (v01  PmRef    ApIst 
00003000 INTL 20060912)
[    3.224539] ACPI: SSDT 00000000bf717d98 00119 (v01  PmRef    ApCst 
00003000 INTL 20060912)
[    3.293155] ACPI: Lid Switch [LID0]
[    3.293230] ACPI: WMI: Mapper loaded
[    3.293237] ACPI: Power Button [PWRF]
[    3.328155] ACPI: AC Adapter [AC] (on-line)
[    3.377779] [Firmware Bug]: ACPI(VGA) defines _DOD but not _DOS
[    3.377905] [Firmware Bug]: ACPI: ACPI brightness control misses _BQC 
function
[    3.517464] acpi device:01: registered as cooling_device4
[    3.517750] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[    4.015196] ACPI: Battery Slot [BAT] (battery present)
[    4.020328] ACPI: I/O resource 0000:00:1f.3 [0x1840-0x185f] conflicts 
with ACPI region SMBI [0x1840-0x184f]
[    4.020388] ACPI: If an ACPI driver is available for this device, you 
should use it instead of the native driver
[    8.689480] input: ACPI Virtual Keyboard Device as 
/devices/virtual/input/input11


especially strange I find the "EC GPE storm detected" and the 3 
AE_NOT_FOUND errors.
I tried to decompile the DSDT, and was able to compile it back after 
fixing some rather trivial errors, but I'm at a loss with the missing 
methods.

I also tried a 2.6.36rc1 kernel, compiled from source,
the missing methods in dmesg were gone, but the buttons did not
work either...


lots of fun hacking linux,

	Oliver

