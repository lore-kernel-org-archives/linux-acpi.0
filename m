From: Daniel =?ISO-8859-1?Q?St=F6ckner?= <d.stoeckner-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Inspiron 2650 video dies in S3 (suspend to ram)
Date: Sat, 17 Jul 2004 04:30:52 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1090031452.8567.10.camel@lapp31000.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
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

Hi,=20

I have an Ati Radeon 9700 mobility on an Acer Extensa 2902LMi Notebook,
but I have exactly the same problem.
I tried the radeontool http://fdd.com/software/radeon/ which can turn
the backlight on and off, but after suspend, it does not work either.
I don't use any ATI-specific driver and no framebuffers at all.
Here is some ACPI-DEBUG information. I entered S3 and resumed:

Jul 17 04:13:20 lapp31000 PM: Preparing system for suspend
Jul 17 04:13:20 lapp31000 Stopping tasks: =3D=3D=3D=3D<7>parport0: BUSY tim=
eout
(-4) in compat_write_block_pio
Jul 17 04:13:20 lapp31000 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
Jul 17 04:13:20 lapp31000 PM: Entering state.
Jul 17 04:13:20 lapp31000 hwsleep-0304 [29] acpi_enter_sleep_state:
Entering sleep state [S3]
Jul 17 04:13:20 lapp31000 Back to C!
Jul 17 04:13:20 lapp31000 evevent-0286: *** Error: No installed handler
for fixed event [00000002]
Jul 17 04:13:20 lapp31000 PM: Finishing up.
Jul 17 04:13:20 lapp31000 ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 10
(level, low) -> IRQ 10
Jul 17 04:13:20 lapp31000 PCI: Setting latency timer of device
0000:00:1d.0 to 64
Jul 17 04:13:20 lapp31000 ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 10
(level, low) -> IRQ 10
Jul 17 04:13:20 lapp31000 PCI: Setting latency timer of device
0000:00:1d.1 to 64
Jul 17 04:13:20 lapp31000 ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 10
(level, low) -> IRQ 10
Jul 17 04:13:20 lapp31000 PCI: Setting latency timer of device
0000:00:1d.2 to 64
Jul 17 04:13:20 lapp31000 ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 10
(level,
low) -> IRQ 10
Jul 17 04:13:20 lapp31000 PCI: Setting latency timer of device
0000:00:1d.7 to 64
Jul 17 04:13:20 lapp31000 ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 10
(level, low) -> IRQ 10
Jul 17 04:13:20 lapp31000 ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10
(level, low) -> IRQ 10
Jul 17 04:13:20 lapp31000 PCI: Setting latency timer of device
0000:00:1f.5 to 64
Jul 17 04:13:20 lapp31000 ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 10
(level, low) -> IRQ 10
Jul 17 04:13:20 lapp31000 eth0: link down
Jul 17 04:13:20 lapp31000 Restarting tasks... done
Jul 17 04:13:25 lapp31000 MCE: The hardware reports a non fatal,
correctable incident occurred on CPU 0.
Jul 17 04:13:25 lapp31000 Bank 1: e2000000000001f5

lspci -vvv -s 01:00.0:
0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV350
[Mobility Radeon 9600 M10] (prog-if 00 [VGA])
        Subsystem: Acer Incorporated [ALI]: Unknown device 005a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 255 (2000ns min), cache line size 04
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at a8000000 (32-bit, prefetchable)
        Region 1: I/O ports at c100 [size=3D256]
        Region 2: Memory at e0010000 (32-bit, non-prefetchable)
[size=3D64K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=3D80 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=3Dx1,x2,x4
                Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA+ AGP- GART64- 64bit- =
FW-
Rate=3D<none>
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-


/proc/interrupts:
           CPU0
  0:     832635          XT-PIC  timer
  1:       2899          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  7:          1          XT-PIC  parport0
  8:          3          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:       1908          XT-PIC  Intel 82801DB-ICH4, uhci_hcd, eth0,
uhci_hcd, uhci_hcd, ehci_hcd, ohci1394, yenta
 12:     113920          XT-PIC  i8042
 14:       9546          XT-PIC  ide0
 15:         12          XT-PIC  ide1
NMI:          0
LOC:     832554
ERR:          0
MIS:          0

Any hint greatly appreciated!

Greetings

-Daniel St=F6ckner


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
