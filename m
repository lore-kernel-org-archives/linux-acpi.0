From: Jim Chisholm <jim-DIx0nqDsXdibEFZj9N6lJdEOdMfwgy+6@public.gmane.org>
Subject: ACPI on Clevo/Kapok/Eurocom/Sager D500 anyone?
Date: Sat, 07 Feb 2004 12:05:22 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40250CC2.9090909@electron.phys.dal.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

(Also X-posted to c.o.l.p)

Hi Folks..
I have a Eurocom D500 P4 2.4 HT Radeon 9600 laptop also marketed by various
companies such as Clevo, Kapok,Sager and a couple others.
It's a beautiful fast laptop but for the life of me I cannot get ACPI 
sleep/suspend/hibernate
to work..other ACPI functions (battery, buttons,temperature etc are fine)
I'm currently running 2.6.2, as SMP is a no-no with suspend/sleep I run 
it with nosmp.
Any suspend/sleep/hibernate funtions even from runlevel 1 with no wifi, 
network or daemons
running start to do something but then I quickly returns (alive) to the 
prompt.
Here's my lspci:

00:00.0 Host bridge: Intel Corp. 82865G/PE/P Processor to I/O Controller 
(rev 02)
00:01.0 PCI bridge: Intel Corp. 82865G/PE/P Processor to AGP Controller 
(rev 02)00:1d.0 USB Controller: Intel Corp. 82801EB USB (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801EB USB (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801EB USB (rev 02)
00:1d.3 USB Controller: Intel Corp. 82801EB USB (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801EB USB2 (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corp. 82801EB LPC Interface Controller (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller 
(rev 02)00:1f.3 SMBus: Intel Corp. 82801EB SMBus Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801EB AC'97 Audio 
Controller (rev 02)
00:1f.6 Modem: Intel Corp. 82801EB AC'97 Modem Controller (rev 02)
01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4e50
03:00.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller
03:01.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 
IEEE-1394a-2000 Controller (PHY/Link)
03:03.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 
(rev 10)

While I'm at it (OT I know, sorry) but I can also not enable DMA for 
/dev/hda

/dev/hda:
 
 Model=TOSHIBA MK6022GAX, FwRev=HB002A, SerialNo=83OJ1455T
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=46
 BuffType=unknown, BuffSize=0kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=117210240
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2 udma3 udma4 udma5
 AdvancedPM=yes: unknown setting WriteCache=enabled
 Drive conforms to: device does not report version:

Any tips would be greatly appreciated!

Thanks
Jim

-- 

=======================================================
Jim Chisholm <Jim-k++L/YzVFum/BKVR8R4IgNEOdMfwgy+6@public.gmane.org>
Dalhousie University, Dept. Physics Halifax N.S. Canada
Halifax Regional Fire and Emergency Service
Deputy Chief, Station 59 Bay Road
=======================================================




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
