From: "Adrian Yee" <brewt-acpi.sf.net-CDLCgzMZgTDYtjvyW6yDsg@public.gmane.org>
Subject: S3 suspend/resume driver questions
Date: Sun, 18 Apr 2004 03:06:49 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <GMail.1082282809.299052003.09816679024@brewt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

Well after hacking around with the 2.6 kernels for some time now trying to =
get ACPI S3 suspend/resume working, I've finally gotten it to work on my no=
tebook (Fujitsu S6010 - PIII 1GHz, i830 chipset/graphics).  I had to use th=
e acpi_sleep=3Ds3_bios kernel argument to get video restored on resume, but=
 I had other problems - other devices were causing lockups on resume.  This=
 turned out to be caused by the pci states of devices not being restored on=
 resume (is this normal?).  To fix this, I had to make some changes to the =
various drivers: 8139too and the alsa intel8x0 driver.

For the 8139too driver, I had to move the pci save/restore power/state code=
=2E  It currently is located after:

if (!netif_running (dev))

And because I didn't have the device running (the module is loaded, but the=
 device isn't configured), it wasn't restoring the device properly.  Is the=
re a reason why it doesn't pci_save_state() if the device isn't running?  T=
he problem with this is that I often switch between wired and wireless netw=
ork, so the device is often not up.  I looked at the 3c59x driver and it al=
so doesn't perform any suspend/resume code on the device if it isn't runnin=
g.  Is this proper behaviour?

For the alsa intel8x0 driver, I just added code to save/restore the pci sta=
te on suspend and resume.  Is this the correct way to fix the problem?

One thing I couldn't fix was the i830 video state:

Before suspend:
00:02.1 Display controller: Intel Corp. 82830 CGC [Chipset Graphics Control=
ler]
	Subsystem: Fujitsu Limited.: Unknown device 113c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0 (2750ns max)
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=3D128M]
	Region 1: Memory at e0100000 (32-bit, non-prefetchable) [size=3D512K]
	Capabilities: [d0] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: 86 80 77 35 07 00 90 00 00 00 80 03 00 00 80 00
10: 08 00 00 f0 00 00 10 e0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 cf 10 3c 11
30: 00 00 00 00 d0 00 00 00 00 00 00 00 00 00 00 0b

After resume:
00:02.1 Display controller: Intel Corp. 82830 CGC [Chipset Graphics Control=
ler]
	Subsystem: Fujitsu Limited.: Unknown device 113c
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0 (2750ns max)
	Region 0: Memory at f0000000 (32-bit, prefetchable) [disabled] [size=3D128=
M]
	Region 1: Memory at e0100000 (32-bit, non-prefetchable) [disabled] [size=
=3D512K]
	Capabilities: [d0] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: 86 80 77 35 04 00 90 00 00 00 80 03 00 00 80 00
10: 08 00 00 f0 00 00 10 e0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 cf 10 3c 11
30: 00 00 00 00 d0 00 00 00 00 00 00 00 00 00 00 0b

I tried modifing the intel-agp module to save/restore the state, but it did=
n't seem to have any effect on it.  Any clues?

Thanks in advance for any help.

Adrian


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
