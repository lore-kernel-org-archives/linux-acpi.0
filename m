From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: [PROBLEM] 2.6.3-rc1: still no suspend/resume on Centrino
 notebook (contains agp, lapic, swsusp)
Date: Mon, 09 Feb 2004 00:27:34 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4026C5E6.4010903@pca.it>
References: <200402081522.i18FMVl7001382@brain.gnuhh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200402081522.i18FMVl7001382-eMhNhoSsuh6q92djB/mqZw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello Georg,

I have not the knowledge neither the capacity to help you again, but I
can underline something maybe interesting.

on 02/08/04 16:22, Georg C F Greve wrote:
> All of this on ASUS M2N with kernel 2.6.3-rc1 + acpi-20040116-2.6.3
> patch. When booting 2.6.3-rc1, I found an apparent inconsistency in
> the AGP code, as dmesg reports
>
>  agpgart: Detected an Intel 855 Chipset.
>  agpgart: Maximum main memory to use for agp memory: 431M
>  agpgart: Detected 8060K stolen memory.
>  agpgart: AGP aperture is 128M @ 0xf0000000
>
> while the chipset is Intel 855GM; output of lspci -vvv
>
>   00:00.0 Host bridge: Intel Corp. 82852/855GM Host Bridge (rev 02)
> 	  Subsystem: Asustek Computer, Inc.: Unknown device 1751
>   	  Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
> 	  Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
> 	  Latency: 0
> 	  Region 0: Memory at <unassigned> (32-bit, prefetchable)
> 	  Capabilities: [40] #09 [a105]
same here on ASUS M3N:
=====
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855 Chipset.
agpgart: Maximum main memory to use for agp memory: 431M
agpgart: Detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0xf0000000
[drm] Initialized i830 1.3.2 20021108 on minor 0
=====
00:02.0 VGA compatible controller: Intel Corp. 82852/855GM Integrated
Graphics Device (rev 02) (prog-if 00 [VGA])
        Subsystem: Asustek Computer, Inc.: Unknown device 1742
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at ffa80000 (32-bit, non-prefetchable) [size=512K]
        Region 2: I/O ports at dc00 [size=8]
        Capabilities: [d0] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 Display controller: Intel Corp. 82852/855GM Integrated Graphics
Device (rev 02)
        Subsystem: Asustek Computer, Inc.: Unknown device 1742
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at ff980000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [d0] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
=====

> *** Suspend to RAM
>
> When trying suspend to ram (S3), it showed the same results as 2.6.1:
> the machine seems to suspend find with "echo 3bios > /etc/acpi/sleep"
have you tried 'echo 3 ...'? I mean, I never tried S3bios on mine, while
S3 gives the same problem as your.

> As I wasn't sure whether the chipset detection was correct, I forced
> usage of the 845 driver by modifying the logic above to
>
> 	case PCI_DEVICE_ID_INTEL_82855GM_HB:
> 		bridge->driver = &intel_845_driver;
> 		name = "855GM";
> 		break;
>
> The kernel boots up normally and everything seems to work just like it
> did for i830. Unfortunately, that includes suspend 2 ram (S3), which
> shows the same behaviour. Here are the syslog entries:
>
> Feb  8 13:19:40 myhost kernel: PM: Preparing system for suspend
> Feb  8 13:19:40 myhost kernel: Stopping tasks:
==========================================|
> Feb  8 13:19:40 myhost kernel: hdc: start_power_step(step: 0)
> Feb  8 13:19:40 myhost kernel: hdc: completing PM request, suspend
> Feb  8 13:19:40 myhost kernel: hda: start_power_step(step: 0)
> Feb  8 13:19:40 myhost kernel: hda: start_power_step(step: 1)
> Feb  8 13:19:40 myhost kernel: hda: complete_power_step(step: 1, stat:
50, err: 0)
> Feb  8 13:19:40 myhost kernel: hda: completing PM request, suspend
> Feb  8 13:19:40 myhost kernel: PM: Entering state.
> Feb  8 13:19:40 myhost kernel:  hwsleep-0265 [992]
acpi_enter_sleep_state: Entering sleep state [S3]
> Feb  8 13:19:40 myhost kernel: Back to C!
> Feb  8 13:19:40 myhost kernel: PM: Finishing up.
> Feb  8 13:19:40 myhost kernel: PCI: Enabling device 0000:00:1f.5 (0005
- -> 0007)
> Feb  8 13:19:40 myhost kernel: PCI: Setting latency timer of device
0000:00:1f.5 to 64
> Feb  8 13:19:40 myhost kernel: AC'97 warm reset still in progress?
[0xffffffff]
> Feb  8 13:19:40 myhost kernel: codec_semaphore: semaphore is not ready
[0xff][0xffffffff]
<cut>
> Feb  8 13:19:40 myhost kernel: codec_write 0: semaphore is not ready
for register 0x26
> Feb  8 13:19:40 myhost kernel: codec_semaphore: semaphore is not ready
[0xff][0xffffffff]
> Feb  8 13:19:40 myhost kernel: codec_write 0: semaphore is not ready
for register 0x0
> Feb  8 13:19:40 myhost kernel: codec_semaphore: semaphore is not ready
[0xff][0xffffffff]
You don't have all this error with your previous hack in the
agp_intel_resume function in intel-agp.c: does it mean something?

> So it seems that the "soft suspend" functions (S1, S3) simply don't work
> with Kernel 2.6.x and Centrino (Intel 855GM chipset) notebooks.
I don't agree: S1 works on mine, but with no USB and no ALSA.

> *** Suspend to disk
Never tried, I'll give it a try.

> P.S. Oh, and enabling ACPI & Local APIC now crashes (instant reboot
> instead of freeze) the machine on boot.
2.6.2 and 2.6.3-rc1 + ACPI 20041116 with ACPI & Local APIC boot
correctly on my ASUS M3N.

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAJsXlVAp7Xm10JmkRAg5UAKCIg6hKWVjUVrJ6URnPHt6LUrrKWQCfV/Zg
lO7ZAT3d9JlGGSDernfp7Ms=
=5JQ2
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
