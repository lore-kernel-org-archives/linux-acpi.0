From: pinotj-fBIn7JHAfCbUKx/7vDf7Bw@public.gmane.org
Subject: PROBLEM/FIX: ACPI break USB detection on i386 (linux-2.4.22)
Date: Wed,  3 Sep 2003 20:05:54 CEST
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <mnet2.1062612354.26146.pinotj@club-internet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

My first bug report, be gentle ;-)

=5B1.=5D PROBLEM/FIX: ACPI break USB detection on i386 (linux-2.4.22). Inc=
lude a fall-back patch

=5B2.=5D Switching from 2.4.21 to 2.4.22 break USB detection on some i386 =
computers. When plug-in an USB device, there is no detection but a time-ou=
t. Problem was introduce between 2.4.22-rc2 and 2.4.22-rc3 (see =5B8.1.=5D=
)

=5B3.=5D ACPI, USB, detection, ohci, time-out, 2.4.22, mpparse.c, pci=5Fir=
q.c, pci=5Flink.c, acpi=5Fdrivers.h

=5B4.=5D Linux version 2.4.22 (root=40gegenux) (gcc version 3.2.1) =231 We=
d Sep 3 06:15:42 KST 2003

=5B5.=5D Kernel output, example of usb-key

=23 Linux 2.4.21, 2.4.22-pre7, 2.4.22-rc1, 2.4.22-rc2 -> OK:
--
Aug 30 11:34:09 gegenux kernel: hub.c: new USB device 00:02.3-1, assigned =
address 2
Aug 30 11:34:09 gegenux kernel: scsi1 : SCSI emulation for USB Mass Storag=
e devices
Aug 30 11:34:09 gegenux kernel:   Vendor: KMIT      Model: UNI DRIVE      =
   Rev: 1.00
Aug 30 11:34:09 gegenux kernel:   Type:   Direct-Access                   =
   ANSI SCSI revision: 02
Aug 30 11:34:09 gegenux kernel: Attached scsi removable disk sda at scsi1,=
 channel 0, id 0, lun 0
Aug 30 11:34:09 gegenux kernel: SCSI device sda: 522432 512-byte hdwr sect=
ors (267 MB)
Aug 30 11:34:09 gegenux kernel: sda: Write Protect is off
Aug 30 11:34:09 gegenux kernel:  sda: sda1
Aug 30 11:34:09 gegenux kernel: WARNING: USB Mass Storage data integrity n=
ot assured
Aug 30 11:34:09 gegenux kernel: USB Mass Storage device found at 2
--

=23 Linux 2.4.22-rc3, 2.4.22, 2.4.23-pre2 -> broken:
--
Aug 30 12:36:20 gegenux kernel: hub.c: port 1, portstatus 101, change 1, 1=
2 Mb/s
Aug 30 12:36:20 gegenux kernel: hub.c: port 1 connection change
Aug 30 12:36:20 gegenux kernel: hub.c: port 1, portstatus 101, change 1, 1=
2 Mb/s
Aug 30 12:36:21 gegenux kernel: hub.c: port 1, portstatus 101, change 0, 1=
2 Mb/s
Aug 30 12:36:21 gegenux last message repeated 3 times
Aug 30 12:36:21 gegenux kernel: hub.c: port 1, portstatus 103, change 10, =
12 Mb/s
Aug 30 12:36:21 gegenux kernel: hub.c: new USB device 00:02.3-1, assigned =
address 2
Aug 30 12:36:26 gegenux kernel: usb=5Fcontrol/bulk=5Fmsg: timeout
Aug 30 12:36:26 gegenux kernel: host/usb-ohci.c: unlink URB timeout
Aug 30 12:36:26 gegenux kernel: usb.c: USB device not accepting new addres=
s=3D2 (error=3D-110)
Aug 30 12:36:26 gegenux kernel: hub.c: port 1, portstatus 103, change 10, =
12 Mb/s
Aug 30 12:36:26 gegenux kernel: hub.c: new USB device 00:02.3-1, assigned =
address 3
Aug 30 12:36:31 gegenux kernel: usb=5Fcontrol/bulk=5Fmsg: timeout
Aug 30 12:36:31 gegenux kernel: host/usb-ohci.c: unlink URB timeout
Aug 30 12:36:31 gegenux kernel: usb.c: USB device not accepting new addres=
s=3D3 (error=3D-110)
Aug 30 12:36:31 gegenux kernel: hub.c: port 2, portstatus 100, change 0, 1=
2 Mb/s
Aug 30 12:36:31 gegenux kernel: hub.c: port 3, portstatus 100, change 0, 1=
2 Mb/s
Aug 30 12:36:31 gegenux kernel: hub.c: port 1, portstatus 101, change 0, 1=
2 Mb/s
Aug 30 12:36:31 gegenux kernel: hub.c: port 2, portstatus 100, change 0, 1=
2 Mb/s
Aug 30 12:36:31 gegenux kernel: hub.c: port 3, portstatus 100, change 0, 1=
2 Mb/s
--

=5B6.=5D no program can trigger this problem

=5B7.=5D Environment (LFS 4.1 modified)
	=

=5B7.1.=5D =

	Linux gegenux 2.4.22 =231 Wed Sep 3 06:15:42 KST 2003 i686 unknown
 	=

	Gnu C                  3.2.1
	Gnu make               3.80
	util-linux             2.11z
	mount                  2.11z
	modutils               2.4.25
	e2fsprogs              1.32
	Linux C Library        2.3.1
	Dynamic linker (ldd)   2.3.1
	Linux C++ Library      5.0.1
	Procps                 3.1.5
	Net-tools              1.60
	Kbd                    1.08
	Sh-utils               2.0
	Modules Loaded         =

	=

=5B7.2.=5D
	processor	: 0
	vendor=5Fid	: AuthenticAMD
	cpu family	: 6
	model		: 4
	model name	: AMD Athlon(tm) Processor
	stepping	: 4
	cpu MHz		: 1194.943
	cache size	: 256 KB
	fdiv=5Fbug	: no
	hlt=5Fbug		: no
	f00f=5Fbug	: no
	coma=5Fbug	: no
	fpu		: yes
	fpu=5Fexception	: yes
	cpuid level	: 1
	wp		: yes
	flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pa=
t pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
	bogomips	: 2385.51
=5B7.3.=5D
	(no modules)
=5B7.4.=5D
	0000-001f : dma1
	0020-003f : pic1
	0040-005f : timer
	0060-006f : keyboard
	0070-007f : rtc
	0080-008f : dma page reg
	00a0-00bf : pic2
	00c0-00df : dma2
	00f0-00ff : fpu
	0170-0177 : ide1
	01f0-01f7 : ide0
	02f8-02ff : serial(auto)
	0376-0376 : ide1
	0378-037a : parport0
	03c0-03df : vesafb
	03f6-03f6 : ide0
	03f8-03ff : serial(auto)
	0cf8-0cff : PCI conf1
	d400-d41f : Creative Labs SB Live=21 EMU10k1
  	  d400-d41f : EMU10K1
	d800-d87f : 3Com Corporation 3c905C-TX/TX-M =5BTornado=5D
  	  d800-d87f : 00:0b.0
	dc00-dc07 : Creative Labs SB Live=21 MIDI/Game Port
  	  dc00-dc07 : emu10k1-gp
	ff00-ff0f : Silicon Integrated Systems =5BSiS=5D 5513 =5BIDE=5D
  	  ff00-ff07 : ide0
  	  ff08-ff0f : ide1
	=

	00000000-0009fbff : System RAM
	0009fc00-0009ffff : reserved
	000a0000-000bffff : Video RAM area
	000c0000-000c7fff : Video ROM
	000f0000-000fffff : System ROM
	00100000-0ffeffff : System RAM
  	  00100000-002f18bc : Kernel code
  	  002f18bd-004210a3 : Kernel data
	0fff0000-0fff7fff : ACPI Tables
	0fff8000-0fffffff : ACPI Non-volatile Storage
	bdc00000-cdcfffff : PCI Bus =2301
  	  c0000000-c7ffffff : nVidia Corporation NV15DDR =5BGeForce2 Ti=5D
    	    c0000000-c02fffff : vesafb
	cde00000-cfefffff : PCI Bus =2301
  	  ce000000-ceffffff : nVidia Corporation NV15DDR =5BGeForce2 Ti=5D
	cfffdf80-cfffdfff : 3Com Corporation 3c905C-TX/TX-M =5BTornado=5D
	cfffe000-cfffefff : Silicon Integrated Systems =5BSiS=5D USB 1.0 Controll=
er
  	  cfffe000-cfffefff : usb-ohci
	cffff000-cfffffff : Silicon Integrated Systems =5BSiS=5D USB 1.0 Controll=
er (=232)
  	  cffff000-cfffffff : usb-ohci
	d0000000-d3ffffff : Silicon Integrated Systems =5BSiS=5D 735 Host
	fec00000-fec00fff : reserved
	fee00000-fee00fff : reserved
	ffee0000-ffefffff : reserved
	fffc0000-ffffffff : reserved

=5B7.5.=5D

00:00.0 Host bridge: Silicon Integrated Systems =5BSiS=5D 735 Host (rev 01=
)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbor=
t- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at d0000000 (32-bit, non-prefetchable) =5Bsize=3D64M=5D
	Capabilities: =5Bc0=5D AGP version 2.0
		Status: RQ=3D31 SBA+ 64bit- FW- Rate=3Dx1,x2,x4
		Command: RQ=3D0 SBA- AGP- 64bit- FW- Rate=3Dx4

00:01.0 PCI bridge: Silicon Integrated Systems =5BSiS=5D 5591/5592 AGP (pr=
og-if 00 =5BNormal decode=5D)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-=
 <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: cde00000-cfefffff
	Prefetchable memory behind bridge: bdc00000-cdcfffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:02.0 ISA bridge: Silicon Integrated Systems =5BSiS=5D 85C503/5513
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepp=
ing- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR-
	Latency: 0

00:02.2 USB Controller: Silicon Integrated Systems =5BSiS=5D 7001 (rev 07)=
 (prog-if 10 =5BOHCI=5D)
	Subsystem: Elitegroup Computer Systems: Unknown device 0a14
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepp=
ing- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max), cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 0: Memory at cfffe000 (32-bit, non-prefetchable) =5Bsize=3D4K=5D

00:02.3 USB Controller: Silicon Integrated Systems =5BSiS=5D 7001 (rev 07)=
 (prog-if 10 =5BOHCI=5D)
	Subsystem: Elitegroup Computer Systems: Unknown device 0a14
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepp=
ing- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at cffff000 (32-bit, non-prefetchable) =5Bsize=3D4K=5D

00:02.5 IDE interface: Silicon Integrated Systems =5BSiS=5D 5513 =5BIDE=5D=
 (rev d0) (prog-if 80 =5BMaster=5D)
	Subsystem: Silicon Integrated Systems =5BSiS=5D SiS5513 EIDE Controller (=
A,B step)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-=
 <MAbort- >SERR- <PERR-
	Latency: 128
	Region 4: I/O ports at ff00 =5Bsize=3D16=5D

00:0b.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M =5BTornado=5D=
 (rev 78)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NI=
C
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepp=
ing- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at d800 =5Bsize=3D128=5D
	Region 1: Memory at cfffdf80 (32-bit, non-prefetchable) =5Bsize=3D128=5D
	Expansion ROM at cffc0000 =5Bdisabled=5D =5Bsize=3D128K=5D
	Capabilities: =5Bdc=5D Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3co=
ld+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

00:11.0 Multimedia audio controller: Creative Labs SB Live=21 EMU10k1 (rev=
 07)
	Subsystem: Creative Labs SBLive=21 Player 5.1
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at d400 =5Bsize=3D32=5D
	Capabilities: =5Bdc=5D Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3co=
ld-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.1 Input device controller: Creative Labs SB Live=21 MIDI/Game Port (=
rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: I/O ports at dc00 =5Bsize=3D8=5D
	Capabilities: =5Bdc=5D Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3co=
ld-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV15 =5BGeForce2 Ti=5D=
 (rev a4) (prog-if 00 =5BVGA=5D)
	Subsystem: LeadTek Research Inc.: Unknown device 2847
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at ce000000 (32-bit, non-prefetchable) =5Bsize=3D16M=5D
	Region 1: Memory at c0000000 (32-bit, prefetchable) =5Bsize=3D128M=5D
	Expansion ROM at cfef0000 =5Bdisabled=5D =5Bsize=3D64K=5D
	Capabilities: =5B60=5D Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3co=
ld-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: =5B44=5D AGP version 2.0
		Status: RQ=3D31 SBA- 64bit- FW+ Rate=3Dx1,x2,x4
		Command: RQ=3D0 SBA- AGP- 64bit- FW- Rate=3D<none>

=5B7.7.=5D (I wanted to send dsdt but it's binary so...)

=5B8.=5D Extended informations

=5B8.1.=5D how I did

Well, I'm not a c0d3rz so when I saw that USB detection was broken in 2.4.=
22, with, of course, same configuration as the working 2.4.21, I decided t=
o follow Documentation/BUG-HUNTING. It took me a long time and didn't work=
=2E I was quite sure the problem comes from usb drivers but I couldn't cor=
rect anything. So, I downloaded all the pre-release patch of 2.4.22 to fin=
d where was the missing step. By dichotomia, I found the problem occured d=
uring passage from 2.4.22-rc2 to 2.4.22-rc3. So I worked on the diff
patch between these two pre-release in order to isolate the problem. It to=
ok long time too but now, I got a patch that make USB working with 2.4.22 =
and 2.4.23-pre2. It's not really a patch but mostly a fall-back diff that =
make things working. I'm sure it is not optimized and that maybe 80% is us=
eless/bad/break=5Fsomething=5Felse but I thought it could help you a lot t=
o make a nicer patch for the 2.4.23. Finally, I'm surprise that :
  a) nobody found this problem before (I have a so strange hardware ?)
  b) acpi can cause usb problem
  =

=5B8.2.=5D The fall-back patch

<---------- cut here -----------------------------------------------------=
--->
diff -ru linux-2.4.22-rc3/arch/i386/kernel/mpparse.c linux-2.4.22-rc2/arch=
/i386/kernel/mpparse.c
--- linux-2.4.22-rc3/arch/i386/kernel/mpparse.c	2003-09-03 02:14:22.000000=
000 +0900
+++ linux-2.4.22-rc2/arch/i386/kernel/mpparse.c	2003-09-03 02:32:54.000000=
000 +0900
=40=40 -1276,16 +1273,12 =40=40
 =

 		/* Need to get irq for dynamic entry */
 		if (entry->link.handle) =7B
-			irq =3D acpi=5Fpci=5Flink=5Fget=5Firq(entry->link.handle, entry->link.=
index, &edge=5Flevel, &active=5Fhigh=5Flow);
+			irq =3D acpi=5Fpci=5Flink=5Fget=5Firq(entry->link.handle, entry->link.=
index);
 			if (=21irq)
 				continue;
 		=7D
-		else =7B
-			/* Hardwired IRQ. Assume PCI standard settings */
+		else
 			irq =3D entry->link.index;
-			edge=5Flevel =3D 1;
-			active=5Fhigh=5Flow =3D 1;
-		=7D
 =

 		/* Don't set up the ACPI SCI because it's already set up */
 		if (acpi=5Ffadt.sci=5Fint =3D=3D irq)
diff -ru linux-2.4.22-rc3/drivers/acpi/pci=5Firq.c linux-2.4.22-rc2/driver=
s/acpi/pci=5Firq.c
--- linux-2.4.22-rc3/drivers/acpi/pci=5Firq.c	2003-09-03 02:14:27.00000000=
0 +0900
+++ linux-2.4.22-rc2/drivers/acpi/pci=5Firq.c	2003-09-03 02:32:57.00000000=
0 +0900
=40=40 -258,7 +253,7 =40=40
 	=7D
 =

 	if (=21entry->irq && entry->link.handle) =7B
-		entry->irq =3D acpi=5Fpci=5Flink=5Fget=5Firq(entry->link.handle, entry-=
>link.index, NULL, NULL);
+		entry->irq =3D acpi=5Fpci=5Flink=5Fget=5Firq(entry->link.handle, entry-=
>link.index);
 		if (=21entry->irq) =7B
 			ACPI=5FDEBUG=5FPRINT((ACPI=5FDB=5FWARN, =22Invalid IRQ link routing en=
try=5Cn=22));
 			return=5FVALUE(0);
diff -ru linux-2.4.22-rc3/drivers/acpi/pci=5Flink.c linux-2.4.22-rc2/drive=
rs/acpi/pci=5Flink.c
--- linux-2.4.22-rc3/drivers/acpi/pci=5Flink.c	2003-09-03 02:14:27.0000000=
00 +0900
+++ linux-2.4.22-rc2/drivers/acpi/pci=5Flink.c	2003-09-03 02:32:57.0000000=
00 +0900
=40=40 -65,9 +65,6 =40=40
 =

 struct acpi=5Fpci=5Flink=5Firq =7B
 	u8			active;			/* Current IRQ */
-	u8			edge=5Flevel;		/* All IRQs */
-	u8			active=5Fhigh=5Flow;	/* All IRQs */
-	u8			setonboot;
 	u8			possible=5Fcount;
 	u8			possible=5BACPI=5FPCI=5FLINK=5FMAX=5FPOSSIBLE=5D;
 =7D;
=40=40 -117,8 +114,6 =40=40
 			link->irq.possible=5Bi=5D =3D p->interrupts=5Bi=5D;
 			link->irq.possible=5Fcount++;
 		=7D
-		link->irq.edge=5Flevel =3D p->edge=5Flevel;
-		link->irq.active=5Fhigh=5Flow =3D p->active=5Fhigh=5Flow;
 		break;
 	=7D
 	case ACPI=5FRSTYPE=5FEXT=5FIRQ:
=40=40 -137,8 +132,6 =40=40
 			link->irq.possible=5Bi=5D =3D p->interrupts=5Bi=5D;
 			link->irq.possible=5Fcount++;
 		=7D
-		link->irq.edge=5Flevel =3D p->edge=5Flevel;
-		link->irq.active=5Fhigh=5Flow =3D p->active=5Fhigh=5Flow;
 		break;
 	=7D
 	default:
=40=40 -296,33 +290,28 =40=40
 	if (=21link =7C=7C =21irq)
 		return=5FVALUE(-EINVAL);
 =

-	/* We don't check irqs the first time around */
-	if (link->irq.setonboot) =7B
-		/* See if we're already at the target IRQ. */
-		if (irq =3D=3D link->irq.active)
-			return=5FVALUE(0);
-
-		/* Make sure the target IRQ in the list of possible IRQs. */
-		for (i=3D0; i<link->irq.possible=5Fcount; i++) =7B
-			if (irq =3D=3D link->irq.possible=5Bi=5D)
-				valid =3D 1;
-		=7D
-		if (=21valid) =7B
-			ACPI=5FDEBUG=5FPRINT((ACPI=5FDB=5FERROR, =22Target IRQ %d invalid=5Cn=22=
, irq));
-			return=5FVALUE(-EINVAL);
-		=7D
+	/* See if we're already at the target IRQ. */
+	if (irq =3D=3D link->irq.active)
+		return=5FVALUE(0);
+
+	/* Make sure the target IRQ in the list of possible IRQs. */
+	for (i=3D0; i<link->irq.possible=5Fcount; i++) =7B
+		if (irq =3D=3D link->irq.possible=5Bi=5D)
+			valid =3D 1;
+	=7D
+	if (=21valid) =7B
+		ACPI=5FDEBUG=5FPRINT((ACPI=5FDB=5FERROR, =22Target IRQ %d invalid=5Cn=22=
, irq));
+		return=5FVALUE(-EINVAL);
 	=7D
 =

 	memset(&resource, 0, sizeof(resource));
 =

-	/* NOTE: PCI interrupts are always level / active=5Flow / shared. But no=
t all
-	   interrupts > 15 are PCI interrupts. Rely on the ACPI IRQ definition f=
or =

-	   parameters */
+	/* NOTE: PCI interrupts are always level / active=5Flow / shared. */
 	if (irq <=3D 15) =7B
 		resource.res.id =3D ACPI=5FRSTYPE=5FIRQ;
 		resource.res.length =3D sizeof(struct acpi=5Fresource);
-		resource.res.data.irq.edge=5Flevel =3D link->irq.edge=5Flevel;
-		resource.res.data.irq.active=5Fhigh=5Flow =3D link->irq.active=5Fhigh=5F=
low;
+		resource.res.data.irq.edge=5Flevel =3D ACPI=5FLEVEL=5FSENSITIVE;
+		resource.res.data.irq.active=5Fhigh=5Flow =3D ACPI=5FACTIVE=5FLOW;
 		resource.res.data.irq.shared=5Fexclusive =3D ACPI=5FSHARED;
 		resource.res.data.irq.number=5Fof=5Finterrupts =3D 1;
 		resource.res.data.irq.interrupts=5B0=5D =3D irq;
=40=40 -331,8 +320,8 =40=40
 		resource.res.id =3D ACPI=5FRSTYPE=5FEXT=5FIRQ;
 		resource.res.length =3D sizeof(struct acpi=5Fresource);
 		resource.res.data.extended=5Firq.producer=5Fconsumer =3D ACPI=5FCONSUME=
R;
-		resource.res.data.extended=5Firq.edge=5Flevel =3D link->irq.edge=5Fleve=
l;
-		resource.res.data.extended=5Firq.active=5Fhigh=5Flow =3D link->irq.acti=
ve=5Fhigh=5Flow;
+		resource.res.data.extended=5Firq.edge=5Flevel =3D ACPI=5FLEVEL=5FSENSIT=
IVE;
+		resource.res.data.extended=5Firq.active=5Fhigh=5Flow =3D ACPI=5FACTIVE=5F=
LOW;
 		resource.res.data.extended=5Firq.shared=5Fexclusive =3D ACPI=5FSHARED;
 		resource.res.data.extended=5Firq.number=5Fof=5Finterrupts =3D 1;
 		resource.res.data.extended=5Firq.interrupts=5B0=5D =3D irq;
=40=40 -438,23 +424,23 =40=40
 		=7D
 	=7D
 =

-	return=5FVALUE(0);
-=7D
-
-static int acpi=5Fpci=5Flink=5Fallocate(struct acpi=5Fpci=5Flink* link) =7B
-	int irq;
-	int i;
+	/*
+	 * Pass =232: Enable boot-disabled Links at 'best' IRQ.
+	 */
+	list=5Ffor=5Feach(node, &acpi=5Flink.entries) =7B
+		int		irq =3D 0;
+		int		i =3D 0;
 =

-	ACPI=5FFUNCTION=5FTRACE(=22acpi=5Fpci=5Flink=5Fallocate=22);
+		link =3D list=5Fentry(node, struct acpi=5Fpci=5Flink, node);
+		if (=21link =7C=7C =21link->irq.possible=5Fcount) =7B
+			ACPI=5FDEBUG=5FPRINT((ACPI=5FDB=5FERROR, =22Invalid link context=5Cn=22=
));
+			continue;
+		=7D
 =

-	if (link->irq.setonboot)
-		return=5FVALUE(0);
+		if (link->irq.active)
+			continue;
 =

-	if (link->irq.active) =7B
-		irq =3D link->irq.active;
-	=7D else =7B
 		irq =3D link->irq.possible=5B0=5D;
-	=7D
 =

 		/* =

 		 * Select the best IRQ.  This is done in reverse to promote =

=40=40 -465,20 +451,16 =40=40
 				irq =3D link->irq.possible=5Bi=5D;
 		=7D
 =

-	/* Attempt to enable the link device at this IRQ. */
-	if (acpi=5Fpci=5Flink=5Fset(link, irq)) =7B
-		printk(PREFIX =22Unable to set IRQ for %s =5B%s=5D (likely buggy ACPI B=
IOS). Aborting ACPI-based IRQ routing. Try pci=3Dnoacpi or acpi=3Doff=5Cn=22=
,
-			acpi=5Fdevice=5Fname(link->device),
-			acpi=5Fdevice=5Fbid(link->device));
-		return=5FVALUE(-ENODEV);
-	=7D else =7B
+		/* Enable the link device at this IRQ. */
+		acpi=5Fpci=5Flink=5Fset(link, irq);
+
 		acpi=5Firq=5Fpenalty=5Blink->irq.active=5D +=3D 100;
+
 		printk(PREFIX =22%s =5B%s=5D enabled at IRQ %d=5Cn=22, =

 			acpi=5Fdevice=5Fname(link->device),
 			acpi=5Fdevice=5Fbid(link->device), link->irq.active);
 	=7D
 =

-	link->irq.setonboot =3D 1;
 	return=5FVALUE(0);
 =7D
 =

=40=40 -486,9 +468,7 =40=40
 int
 acpi=5Fpci=5Flink=5Fget=5Firq (
 	acpi=5Fhandle		handle,
-	int			index,
-	int*			edge=5Flevel,
-	int*			active=5Fhigh=5Flow)
+	int			index)
 =7B
 	int                     result =3D 0;
 	struct acpi=5Fdevice	*device =3D NULL;
=40=40 -514,17 +494,11 =40=40
 		return=5FVALUE(0);
 	=7D
 =

-	if (acpi=5Fpci=5Flink=5Fallocate(link)) =7B
-		return -ENODEV;
-	=7D
-	   =

 	if (=21link->irq.active) =7B
 		ACPI=5FDEBUG=5FPRINT((ACPI=5FDB=5FERROR, =22Link disabled=5Cn=22));
 		return=5FVALUE(0);
 	=7D
 =

-	if (edge=5Flevel) *edge=5Flevel =3D link->irq.edge=5Flevel;
-	if (active=5Fhigh=5Flow) *active=5Fhigh=5Flow =3D link->irq.active=5Fhig=
h=5Flow;
 	return=5FVALUE(link->irq.active);
 =7D
 =

diff -ru linux-2.4.22-rc3/include/acpi/acpi=5Fdrivers.h linux-2.4.22-rc2/i=
nclude/acpi/acpi=5Fdrivers.h
--- linux-2.4.22-rc3/include/acpi/acpi=5Fdrivers.h	2003-09-03 02:14:36.000=
000000 +0900
+++ linux-2.4.22-rc2/include/acpi/acpi=5Fdrivers.h	2003-09-03 02:33:04.000=
000000 +0900
=40=40 -174,7 +174,7 =40=40
 =23define ACPI=5FPCI=5FLINK=5FFILE=5FSTATUS	=22state=22
 =

 int acpi=5Fpci=5Flink=5Fcheck (void);
-int acpi=5Fpci=5Flink=5Fget=5Firq (acpi=5Fhandle handle, int index, int* =
edge=5Flevel, int* active=5Fhigh=5Flow);
+int acpi=5Fpci=5Flink=5Fget=5Firq (acpi=5Fhandle handle, int index);
 int acpi=5Fpci=5Flink=5Finit (void);
 void acpi=5Fpci=5Flink=5Fexit (void);
<---------- cut here -----------------------------------------------------=
--->

Regards,

Jerome Pinot
http://formol.sourceforge.net
http://lomc11.kaist.ac.kr



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
