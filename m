From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: the patch of restore-pci-config-space-on-resume break S1 on ASUS2400 NE
Date: Mon, 27 Dec 2004 18:14:00 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8406A26924@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261421AbUL0KOi@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjanv@redhat.com>, Pavel Machek <pavel@ucw.cz>
Cc: "Brown, Len" <len.brown@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net, "Fu, Michael" <michael.fu@intel.com>
List-Id: linux-acpi@vger.kernel.org

 Actually, the kernel (after removing restore-pci-config-space-on-resum=
e patch) with option "ide=3Dnodma"=20
can work with S1 suspend/resume without any hang so far.
  So my suggestion for IDE driver is to disable DMA before entering S1,=
 and enable
DMA after resuming from S1 if DMA was enabled.  I need help from IDE gu=
ys to confirm it.
 =20
Thanks,
Luming

-----Original Message-----
=46rom: Yu, Luming=20
Sent: 2004=C4=EA12=D4=C223=C8=D5 20:05
To: 'Arjan van de Ven'
Cc: Brown, Len; Li, Shaohua; Pallipadi, Venkatesh; linux-kernel@vger.ke=
rnel.org; 'acpi-devel@lists.sourceforge.net'
Subject: RE: the patch of restore-pci-config-space-on-resume break S1 o=
n ASUS2400 NE


The following is S1 suspend and resume log for one working case.=20

With 2.6.7, after several times of S1 suspend and resume cycle, the box=
 eventually hang on resume.
With 2.6.10-rc3, after One time of successful S1 suspend and resume cyc=
le, the box hang on resume.
With your patch, I always saw S1 resume hang so far.

After applying patch filed at bugzilla
http://bugzilla.kernel.org/show_bug.cgi?id=3D1588
to 2.6.7 kernel, the second time of S1 resume by hitting power button c=
ause power off . :-(

=46rom these experience, I'm thinking S1 is totally broken on this box.=
 :-(

Thanks,
Luming=20

 PM: Preparing system for suspend
Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
 device name =3D Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
---> ignored
 device name =3D Ricoh Co Ltd R5C552 IEEE 1394 Controller
---> ignored
 device name =3D Ricoh Co Ltd RL5c476 II (#2)
---> ignored
 device name =3D Ricoh Co Ltd RL5c476 II
---> ignored
 device name =3D Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97=
 Modem Controller
---> ignored
 device name =3D Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97=
 Audio Controller
---> ignored
 device name =3D Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus=
 Controller
---> ignored
 device name =3D Intel Corp. 82801DBM (ICH4) Ultra ATA Storage Controll=
er
---> ignored
 device name =3D Intel Corp. 82801DBM LPC Interface Controller
 device name =3D Intel Corp. 82801 PCI Bridge
 device name =3D Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Con=
troller
---> ignored
 device name =3D Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB U=
HCI Controller #3
---> ignored
 device name =3D Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB U=
HCI Controller #2
---> ignored
 device name =3D Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB U=
HCI Controller #1
---> ignored
 device name =3D Intel Corp. 82852/855GM Integrated Graphics Device (#2=
)
 device name =3D Intel Corp. 82852/855GM Integrated Graphics Device
 device name =3D Intel Corp. 855GM/GME GMCH Configuration Process Regis=
ters
 device name =3D Intel Corp. 855GM/GME GMCH Memory I/O Control Register=
s
 device name =3D Intel Corp. 82852/855GM Host Bridge
---> ignored
PM: Entering state.
 hwsleep-0315 [04] acpi_enter_sleep_state: Entering sleep state [S1]
Back to C!
PM: Finishing up.
 device name =3D Intel Corp. 82852/855GM Host Bridge
---> ignored
 device name =3D Intel Corp. 855GM/GME GMCH Memory I/O Control Register=
s
 device name =3D Intel Corp. 855GM/GME GMCH Configuration Process Regis=
ters
 device name =3D Intel Corp. 82852/855GM Integrated Graphics Device
 device name =3D Intel Corp. 82852/855GM Integrated Graphics Device (#2=
)
 device name =3D Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB U=
HCI Controller #1
---> ignored
 device name =3D Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB U=
HCI Controller #2
---> ignored
 device name =3D Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB U=
HCI Controller #3
---> ignored
 device name =3D Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Con=
troller
---> ignored
 device name =3D Intel Corp. 82801 PCI Bridge
 device name =3D Intel Corp. 82801DBM LPC Interface Controller
 device name =3D Intel Corp. 82801DBM (ICH4) Ultra ATA Storage Controll=
er
---> ignored
 device name =3D Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus=
 Controller
---> ignored
 device name =3D Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97=
 Audio Controller
---> ignored
 device name =3D Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97=
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
0000:00:00.1 System peripheral: Intel Corp.: Unknown device 3584 (rev 0=
2)
0000:00:00.3 System peripheral: Intel Corp.: Unknown device 3585 (rev 0=
2)
0000:00:02.0 VGA compatible controller: Intel Corp. 82852/855GM Integra=
ted Graphics Device (rev 02)
0000:00:02.1 Display controller: Intel Corp. 82852/855GM Integrated Gra=
phics Device (rev 02)
0000:00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 03)
0000:00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 03)
0000:00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 03)
0000:00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 03)
0000:00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 83)
0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller =
(rev 03)
0000:00:1f.1 IDE interface: Intel Corp. 82801DBM Ultra ATA Storage Cont=
roller (rev 03)
0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBM SMBus Controller (rev 03)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Aud=
io Controller (rev 03)
0000:00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem Controller (rev 03)
0000:01:03.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a9)
0000:01:03.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a9)
0000:01:03.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Contro=
ller (rev 01)
0000:01:04.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8=
139/8139C/8139C+ (rev 10)


-----Original Message-----
=46rom: Arjan van de Ven [mailto:arjanv@redhat.com]=20
Sent: 2004=C4=EA12=D4=C223=C8=D5 17:05
To: Yu, Luming
Cc: Brown, Len; Li, Shaohua; Pallipadi, Venkatesh; linux-kernel@vger.ke=
rnel.org
Subject: Re: the patch of restore-pci-config-space-on-resume break S1 o=
n ASUS2400 NE

On Thu, Dec 23, 2004 at 04:51:09PM +0800, Yu, Luming wrote:
>  Hi,
>=20
> Since 2.6.7, the Changes for drivers/pci/pci-driver.c@1.37 make my
> ASUS 2400NE hang on S1 resume.=20

we need to figure out which device can't take the pci config space
restore...
