From: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy@intel.com>
Subject: RE: Bad libata resume behaviour due to ACPICA change (in acpi-test)
Date: Mon, 5 Feb 2007 21:51:35 +0300
Message-ID: <B41635854730A14CA71C92B36EC22AAC803F9D@mssmsx411>
References: <20070203004140.GB619@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:8519 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933337AbXBESwQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Feb 2007 13:52:16 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20070203004140.GB619@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org
Cc: "Brown, Len" <len.brown@intel.com>

Henrique,

I cannot reproduce your problem with T43 here on linux-acpi-test with
defconfig (relevant ACPI modules were tried both dynamic and static).
Resume time is about 4-6 seconds, not 20-40 as you mention.
Could you please send your .config and try defconfig on your machine?

BTW, my T43 use AHCI mode of SATA controller, if it matters...

Regards,
	Alex.

>-----Original Message-----
>From: Henrique de Moraes Holschuh [mailto:hmh@hmh.eng.br]
>Sent: Saturday, February 03, 2007 3:42 AM
>To: linux-acpi@vger.kernel.org
>Cc: Starikovskiy, Alexey Y; Brown, Len
>Subject: Bad libata resume behaviour due to ACPICA change (in
acpi-test)
>
>On an otherwise ordinary ThinkPad T43, v2.6.20-rc7-g190ff5b runs and
works
>beaufully, however if I apply the acpi-test patches, it adds a 40-50s
pause
>right after libata tries to resume the disks.
>
>Here's the relevant info:
>
>1. The relevant detail of logs of a normal resume:
>Feb  1 20:50:02 thorin kernel: ata2.00: configured for UDMA/33
>Feb  1 20:50:02 thorin kernel: ata1.00: configured for UDMA/100
>Feb  1 20:50:02 thorin kernel: SCSI device sda: 117210240 512-byte hdwr
>sectors (60012 MB)
>Feb  1 20:50:02 thorin kernel: sda: Write Protect is off
>Feb  1 20:50:02 thorin kernel: sda: Mode Sense: 00 3a 00 00
>Feb  1 20:50:02 thorin kernel: SCSI device sda: write cache: enabled,
read
>cache: enabled, doesn't support DPO or FUA
>Feb  1 20:50:20 thorin kernel: ...
>
>2. The relevant detail of logs of a resume with the strange pause:
>Feb  1 19:21:28 thorin kernel: Restarting tasks ... done.
>Feb  1 19:21:29 thorin kernel: ata2.00: configured for UDMA/33
>Feb  1 19:21:29 thorin kernel: ata1.00: configured for UDMA/100
>Feb  1 19:21:29 thorin kernel: SCSI device sda: 117210240 512-byte hdwr
>sectors (60012 MB)
>Feb  1 19:21:29 thorin kernel: sda: Write Protect is off
>Feb  1 19:21:29 thorin kernel: sda: Mode Sense: 00 3a 00 00
>Feb  1 19:21:29 thorin kernel: SCSI device sda: write cache: enabled,
read
>cache: enabled, doesn't support DPO or FUA
>Feb  1 19:21:53 thorin kernel: ...
>
>Note the timestamps on the two last lines of the log.  Another delay I
had
>was bigger by 20s.  It is really, *really* annoying.
>
>3. The affected PCI device:
>
>00:1f.2 IDE interface: Intel Corporation 82801FBM (ICH6M) SATA
Controller
>(rev 03) (prog-if 80 [Master])
>        Subsystem: IBM Unknown device 056a
>        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr-
>Stepping- SERR- FastB2B-
>        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort-
><TAbort- <MAbort- >SERR- <PERR-
>        Latency: 0
>        Region 0: I/O ports at 01f0 [size=8]
>        Region 1: I/O ports at 03f4 [size=1]
>        Region 2: I/O ports at 0170 [size=8]
>        Region 3: I/O ports at 0374 [size=1]
>        Region 4: I/O ports at 18c0 [size=16]
>        Capabilities: [70] Power Management version 2
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-
>,D3hot+,D3cold-)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
>4. The relevant DSDT:
>http://acpi.sourceforge.net/dsdt/view.php?id=742
>
>5. The culprit (insert ob. Linus-is-a-genius git bisect thanks here):
>
> 5559e40e60632ab6927f08cd2a2a3b65c088fc03 is first bad commit
> commit 5559e40e60632ab6927f08cd2a2a3b65c088fc03
> Author: Bob Moore <robert.moore@intel.com>
> Date:   Tue Jan 23 15:49:27 2007 +0300
>
>    ACPICA: Disable all wake GPEs after first one recieved
>
>    Change for GPE support: when a wake GPE is
>    received, now all wake GPEs are immediately disabled to
>    prevent the waking GPE from firing again, and to prevent
>    other wake GPEs from interrupting the wake process.
>
>    Signed-off-by: Alexey Starikovskiy
<alexey.y.starikovskiy@intel.com>
>    Signed-off-by: Len Brown <len.brown@intel.com>
>
>I will try to run with the above commit reverted, so as to continue
playing
>with the acpi-test tree.
>
>If there is anything I can contribute to help shape up the above into
>something that is not annoying for ThinkPad T43 onwers, just tell me
what,
>and I'll see what I can do.
>
>The bug is reproducible at will.
>
>--
>  "One disk to rule them all, One disk to find them. One disk to bring
>  them all and in the darkness grind them. In the Land of Redmond
>  where the shadows lie." -- The Silicon Valley Tarot
>  Henrique Holschuh
