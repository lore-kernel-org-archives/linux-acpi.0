From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: the patch of restore-pci-config-space-on-resume break S1 on ASUS2400 NE
Date: Thu, 23 Dec 2004 20:04:49 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84069D52F2@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Arjan van de Ven <arjanv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


The following is S1 suspend and resume log for one working case.=20

With 2.6.7, after several times of S1 suspend and resume cycle, the box =
eventually hang on resume.
With 2.6.10-rc3, after One time of successful S1 suspend and resume =
cycle, the box hang on resume.
With your patch, I always saw S1 resume hang so far.

After applying patch filed at bugzilla
http://bugzilla.kernel.org/show_bug.cgi?id=3D1588
to 2.6.7 kernel, the second time of S1 resume by hitting power button =
cause power off . :-(

>From these experience, I'm thinking S1 is totally broken on this box. =
:-(

Thanks,
Luming=20

 PM: Preparing system for suspend
Stopping tasks: =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D|
 device name =3D Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
---> ignored
 device name =3D Ricoh Co Ltd R5C552 IEEE 1394 Controller
---> ignored
 device name =3D Ricoh Co Ltd RL5c476 II (#2)
---> ignored
 device name =3D Ricoh Co Ltd RL5c476 II
---> ignored
 device name =3D Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 =
Modem Controller
---> ignored
 device name =3D Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 =
Audio Controller
---> ignored
 device name =3D Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus =
Controller
---> ignored
 device name =3D Intel Corp. 82801DBM (ICH4) Ultra ATA Storage =
Controller
---> ignored
 device name =3D Intel Corp. 82801DBM LPC Interface Controller
 device name =3D Intel Corp. 82801 PCI Bridge
 device name =3D Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI =
Controller
---> ignored
 device name =3D Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB =
UHCI Controller #3
---> ignored
 device name =3D Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB =
UHCI Controller #2
---> ignored
 device name =3D Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB =
UHCI Controller #1
---> ignored
 device name =3D Intel Corp. 82852/855GM Integrated Graphics Device (#2)
 device name =3D Intel Corp. 82852/855GM Integrated Graphics Device
 device name =3D Intel Corp. 855GM/GME GMCH Configuration Process =
Registers
 device name =3D Intel Corp. 855GM/GME GMCH Memory I/O Control Registers
 device name =3D Intel Corp. 82852/855GM Host Bridge
---> ignored
PM: Entering state.
 hwsleep-0315 [04] acpi_enter_sleep_state: Entering sleep state [S1]
Back to C!
PM: Finishing up.
 device name =3D Intel Corp. 82852/855GM Host Bridge
---> ignored
 device name =3D Intel Corp. 855GM/GME GMCH Memory I/O Control Registers
 device name =3D Intel Corp. 855GM/GME GMCH Configuration Process =
Registers
 device name =3D Intel Corp. 82852/855GM Integrated Graphics Device
 device name =3D Intel Corp. 82852/855GM Integrated Graphics Device (#2)
 device name =3D Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB =
UHCI Controller #1
---> ignored
 device name =3D Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB =
UHCI Controller #2
---> ignored
 device name =3D Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB =
UHCI Controller #3
---> ignored
 device name =3D Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI =
Controller
---> ignored
 device name =3D Intel Corp. 82801 PCI Bridge
 device name =3D Intel Corp. 82801DBM LPC Interface Controller
 device name =3D Intel Corp. 82801DBM (ICH4) Ultra ATA Storage =
Controller
---> ignored
 device name =3D Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus =
Controller
---> ignored
 device name =3D Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 =
Audio Controller
---> ignored
 device name =3D Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 =
Modem Controller
---> ignored
 device name =3D Ricoh Co Ltd RL5c476 II
---> ignored
 device name =3D Ricoh Co Ltd RL5c476 II (#2)
---> ignored
 device name =3D Ricoh Co Ltd R5C552 IEEE 1394 Controller
---> ignored
 device name =3D Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
---> ignored
Restarting tasks... done


#lspci
0000:00:00.0 Host bridge: Intel Corp. 82852/855GM Host Bridge (rev 02)
0000:00:00.1 System peripheral: Intel Corp.: Unknown device 3584 (rev =
02)
0000:00:00.3 System peripheral: Intel Corp.: Unknown device 3585 (rev =
02)
0000:00:02.0 VGA compatible controller: Intel Corp. 82852/855GM =
Integrated Graphics Device (rev 02)
0000:00:02.1 Display controller: Intel Corp. 82852/855GM Integrated =
Graphics Device (rev 02)
0000:00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 03)
0000:00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 03)
0000:00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 03)
0000:00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 03)
0000:00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 83)
0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller =
(rev 03)
0000:00:1f.1 IDE interface: Intel Corp. 82801DBM Ultra ATA Storage =
Controller (rev 03)
0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBM SMBus Controller (rev 03)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 =
Audio Controller (rev 03)
0000:00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem Controller (rev 03)
0000:01:03.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a9)
0000:01:03.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a9)
0000:01:03.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 =
Controller (rev 01)
0000:01:04.0 Ethernet controller: Realtek Semiconductor Co., Ltd. =
RTL-8139/8139C/8139C+ (rev 10)


-----Original Message-----
From: Arjan van de Ven [mailto:arjanv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]=20
Sent: 2004=C4=EA12=D4=C223=C8=D5 17:05
To: Yu, Luming
Cc: Brown, Len; Li, Shaohua; Pallipadi, Venkatesh; =
linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Re: the patch of restore-pci-config-space-on-resume break S1 on =
ASUS2400 NE

On Thu, Dec 23, 2004 at 04:51:09PM +0800, Yu, Luming wrote:
>  Hi,
>=20
> Since 2.6.7, the Changes for drivers/pci/pci-driver.c@1.37 make my
> ASUS 2400NE hang on S1 resume.=20

we need to figure out which device can't take the pci config space
restore...



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
