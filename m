From: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Subject: Re: Fwd: Brightness on HP EliteBook 8460p
Date: Tue, 20 Mar 2012 23:03:35 +0100
Message-ID: <1631921.mapqS8Vd5c@pali>
References: <4F2E8FE40200002300007D85@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3679102.tDJQFhKX6S"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: quoted-printable
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4F2E8FE40200002300007D85@novprvlin0050.provo.novell.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Joey Lee <jlee@suse.com>
Cc: dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Artur Flinta <aflinta@gmail.com>
List-Id: linux-acpi@vger.kernel.org


--nextPart3679102.tDJQFhKX6S
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Saturday 04 February 2012 20:19:16 Joey Lee wrote:
> Add Cc. to dri mail
>=20
> Hi Pali,
>=20
> =E6=96=BC =E4=BA=94=EF=BC=8C2012-02-03 =E6=96=BC 16:24 +0100=EF=BC=8C=
Pali Roh=C3=A1r =E6=8F=90=E5=88=B0=EF=BC=9A
>=20
> > On Friday 20 January 2012 17:55:57 Pali Roh=C3=A1r wrote:
> > > On Friday 20 January 2012 11:28:59 joeyli wrote:
> > > > =E6=96=BC =E4=BA=94=EF=BC=8C2012-01-20 =E6=96=BC 11:12 +0800=EF=
=BC=8Cjoeyli =E6=8F=90=E5=88=B0=EF=BC=9A
> > > >=20
> > > > > Hi Pali,
> > > > >=20
> > > > > Sorry for I am late reply you.
> > > > >=20
> > > > > =E6=96=BC =E4=BA=8C=EF=BC=8C2012-01-17 =E6=96=BC 19:10 +0100=EF=
=BC=8CPali Roh=C3=A1r =E6=8F=90=E5=88=B0=EF=BC=9A
> > > > >=20
> > > > > > On Wednesday 21 December 2011 12:45:07 Pali Roh=C3=A1r wrot=
e:
> > > > > > > Hello,
> > > > > > >=20
> > > > > > > I tried to boot with all 3 strings in acpi_os_name, but
> > > > > > > nothing was
> > > > > > > changed. I'm attaching dmesg outputs, one from BIOS
> > > > > > > mode, one from
> > > > > > > UEFI mode. Both are with "Microsoft Windows NT".
> > > > > >=20
> > > > > > Did you looked at my logs?
> > > > >=20
> > > > > I checked your dmesg log, found the acpi_os_name kernel
> > > > > parameter is :
> > > > >=20
> > > > > [    0.000000] Command line:
> > > > > BOOT_IMAGE=3D/vmlinuz-3.2.0-4-generic
> > > > > root=3DUUID=3D4ec6272a-8551-40f3-a1b1-3e10984f3e69 ro
> > > > > pcie_aspm=3Dforce
> > > > > acpi.debug_level=3D0x2 acpi.debug_layer=3D0xFFFFFFFF
> > > > > "acpi_os_name=3DMicrosoft Windows NT" splash vt.handoff=3D7
> > > > >=20
> > > > > We still need by-pass the os name check in DSDT when test
> > > > > function key,> > > >=20
> > > > > please help to feed:
> > > > > =09acpi_os_name=3D"Windows 2009"
> > > > >=20
> > > > > And,
> > > > > looks like the acpi debug level not enough, please kindly
> > > > > change acpi> > > >=20
> > > > > debug parameter to:
> > > > > =09acpi.debug_level=3D0xF acpi.debug_layer=3D0xFFFFFFFF
> > > > > =09log_buf_len=3D5M
> > > > >=20
> > > > > summary:
> > > > > =09acpi.debug_level=3D0xF acpi.debug_layer=3D0xFFFFFFFF
> > > > > =09log_buf_len=3D5M
> > > > > =09acpi_os_name=3D"Windows 2009"
> > > >=20
> > > > Forgot remind,
> > > > please remember press brightness function key a couple of
> > > > times before you dump the dmesg and messages log.
> > > >=20
> > > >=20
> > > > Thanks a lot!
> > > > Joey Lee
> > >=20
> > > Hello,
> > >=20
> > > there was no acpi log, so I recompiled ubuntu kernel with
> > > CONFIG_ACPI_DEBUG=3Dy and CONFIG_ACPI_DEBUG_FUNC_TRACE. Then I
> > > started kernel with your params.
> > >=20
> > > Now I'm attaching very long debug output. I belive it will be
> > > now usefull.
> > >=20
> > > Pressing brightness keys did not show anything in log.
> > >=20
> > > After writing 0 to /sys/class/backlight/acpi_video0/brightness
> > > in log appear: [   57.675070] [ACPI Debug]  Integer
> > > 0x000000000000000B ...
> > >=20
> > > And after writing 10:
> > > [   99.865208] [ACPI Debug]  Integer 0x0000000000000048
> > > [   99.865295]   evmisc-0120 [4294967289]
> > > ev_queue_notify_reques:
> > > Dispatching Notify on [DGFX] Node ffff880136246c80 Value 0xD0
> > > (**Device Specific**) [   99.865350]    video-1474 [4294967289]
> > > video_bus_notify> >=20
> > > : Unsupported event [0xd0]
> >=20
> > Do you need more logs? Or is this enought?
>=20
> Yes, as you point out, this is a doubt for video bus received 0xD0
> event but nobody take care it.
>=20
> Traced dsdt of EliteBook 8460p from you, the _BCM like this:
>=20
>     Method (_BCM, 1, Serialized)                /* ATI _BCM, per
> log, run this _BCM */ {
>         Store (\_SB.BCM (Arg0), Local0)         /* set next level,
> normally return 0x1 if XP sp2 or later */ If (Local0)             =20=

>               /* if XP sp2 or later */ {
>             Store (BRID, Local1)
>             If (LEqual (SBRV (), 0x00))         /* normally SBRV
> return 1, will not emit SMI */ {
>                 \_SB.SSMI (0xEA74, 0x04, Local1, 0x00, 0x00)
>             }
>=20
>             Signal (\_SB.BEVT)          /* emit BEVT event, HKFR
> (HotkeyFunctionResponse) waiting it, but why? */ }
>     }
>=20
> _BCM call SBRV to setup brightness value to variable ABRI:
>=20
> Method (SBRV, 0, Serialized)            /* call by ATI _BCM */
> {
>     Store (\_SB.SBRC (), ABRI)          /* SBRC() return the
> brightness value, why store to ABRI? only used in PEGP.DGFX.AFN2 */
> Or (PSBR, 0x80, PSBR)
>     Notify (^, 0xD0)                    /* notify method's parent:
> PEGP.DGFX by 0xD0 */ Return (0x01)                       /*
> normally return 1 */ }The PEGP.DGFX acpi device was binding to
> acpi/video driver, the above ASL code emit a 0xD0 bus event to
> video.c but cann't process it. Even we add a new bus event in
> video.c and generate a acpi event, there still need another acpi
> driver should take care it.
>=20
> I thought this acpi event might need take care by radeon drm, but I
> am not good for radeon, need more help.
>=20
> Per your acpi debug log, the brightness value was changed normally
> when you access _BCM:
>=20
> 83133 Jan 20 17:17:51 Pali-EliteBook kernel: [   57.674669] ACPI:
> Execute Method [\_SB_.PCI0.PEGP.DGFX.LCD_._BCM] (Node ffff8    =20
> 801362472a8)=09=09# start test _BCM manually 83134 Jan 20 17:17:51
> Pali-EliteBook kernel: [   57.674736] exregion-0199 [01]
> ex_system_memory_space: System-Memory (width 8      ) R/W 0
> Address=3D00000000BF7ACE1C 83135 Jan 20 17:17:51 Pali-EliteBook
> kernel: [   57.674748] exregion-0199 [02] ex_system_memory_space:
> System-Memory (width 8      ) R/W 1 Address=3D00000000BF7ACE1C ...
> 83179 Jan 20 17:17:51 Pali-EliteBook kernel: [   57.675070] [ACPI
> Debug]  Integer 0x000000000000000B=09# brightness value is 11 83180
> Jan 20 17:17:51 Pali-EliteBook kernel: [   57.675090]   evmisc-0120
> [4294967289] ev_queue_notify_reques: Dispatching No      tify on
> [DGFX] Node ffff880136246c80 Value 0xD0 (**Device Specific**) 83181
> Jan 20 17:17:51 Pali-EliteBook kernel: [   57.675099]    video-1474
> [4294967288] video_bus_notify      : Unsupported event [0xd0] ...
> 83197 Jan 20 17:18:33 Pali-EliteBook kernel: [   99.863593] ACPI:
> Execute Method [\_SB_.PCI0.PEGP.DGFX.LCD_._BCM] (Node ffff8    =20
> 801362472a8) 83198 Jan 20 17:18:33 Pali-EliteBook kernel: [ =20
> 99.863817] exregion-0199 [01] ex_system_memory_space: System-Memory
> (width 8      ) R/W 0 Address=3D00000000BF7ACE1C 83243 Jan 20
> 17:18:33 Pali-EliteBook kernel: [   99.865208] [ACPI Debug]=20
> Integer 0x0000000000000048=09# brightness value is 72 83244 Jan 20
> 17:18:33 Pali-EliteBook kernel: [   99.865295]   evmisc-0120
> [4294967289] ev_queue_notify_reques: Dispatching Notify on [DGFX]
> Node ffff880136246c80 Value 0xD0 (**Device Specific**) 83245 Jan 20
> 17:18:33 Pali-EliteBook kernel: [   99.865350]    video-1474
> [4294967289] video_bus_notify      : Unsupported event [0xd0]
>=20
> The brightness values are 11(0x0B) and 72(0x48), that means the BCM
> method return a good value and set to ABRI, ABRI waiting the guy who
> take the 0xD0 event to read then change brightness.
>=20
> Another doubt is the latest statement in _BCM, it emit a BEVT event:
>=20
> Signal (\_SB.BEVT)
>=20
> Only HKFR(HotkeyFunctionResponse) method is waiting this event, it
> should related to how the HP implement brightness function key on
> Windows through wmi.
>=20
> Of course this issue really close related to video driver, even
> more, we might need to know hp wmi for how to implement on Windows.
>=20
> Unfortunately, sorry for I don't have any solution to you, now, I
> will continue to trace and find any support from other experts.
>=20
>=20
> Thanks a lot!
> Joey Lee

Hi!

now I found that ALS button which enable/disable ambient light sensor=20=

working with linux and ALS can also decrease/increase brightness.

ALS can be enabled or disabled via WMI (acpi) on linux too. I found=20
function which enable ALS in linux kernel. See source code of function=20=

set_als in hp-wmi.c: http://tomoyo.sourceforge.jp/cgi-
bin/lxr/source/drivers/platform/x86/hp-wmi.c#L443

This function can enable ALS which can decrease brightness (but only=20=

to specific one level) via WMI. And WMI is ACPI extension, so maybe it=20=

is really possible to change brightness via acpi without DRI support.

But I do not WMI, ACPI and DSDT code. Can you try to decode what is=20
called in acpi when that set_als function in hp-wmi is called? I think=20=

here in acpi can be some magic which can manipulate with display=20
brightness. At least ACPI must call somewhat to change brightness...

Note: Enabling ALS on my notebook change brightness to some specific=20=

level and disabling ALS will revert brightness back. From userspace=20
ALS can be enabled/disabled via this sysfs entry:=20
/sys/devices/platform/hp-wmi/als

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--nextPart3679102.tDJQFhKX6S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk9o/rcACgkQi/DJPQPkQ1LcGgCbBCHPXvfUjONuZ2aJ6+bCVsUe
hBgAn17ICVVhtIkhHdZA+rrCR9wKA00m
=le7S
-----END PGP SIGNATURE-----

--nextPart3679102.tDJQFhKX6S--
