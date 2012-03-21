From: joeyli <jlee@suse.com>
Subject: Re: Fwd: Brightness on HP EliteBook 8460p
Date: Wed, 21 Mar 2012 12:16:31 +0800
Message-ID: <1332303391.10557.391.camel@linux-s257.site>
References: <4F2E8FE40200002300007D85@novprvlin0050.provo.novell.com>
	 <1631921.mapqS8Vd5c@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1631921.mapqS8Vd5c@pali>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Artur Flinta <aflinta@gmail.com>
List-Id: linux-acpi@vger.kernel.org

=E6=96=BC =E4=BA=8C=EF=BC=8C2012-03-20 =E6=96=BC 23:03 +0100=EF=BC=8CPa=
li Roh=C3=A1r =E6=8F=90=E5=88=B0=EF=BC=9A
> >=20
> > Another doubt is the latest statement in _BCM, it emit a BEVT event=
:
> >=20
> > Signal (\_SB.BEVT)
> >=20
> > Only HKFR(HotkeyFunctionResponse) method is waiting this event, it
> > should related to how the HP implement brightness function key on
> > Windows through wmi.
> >=20
> > Of course this issue really close related to video driver, even
> > more, we might need to know hp wmi for how to implement on Windows.
> >=20
> > Unfortunately, sorry for I don't have any solution to you, now, I
> > will continue to trace and find any support from other experts.
> >=20
> >=20
> > Thanks a lot!
> > Joey Lee
>=20
> Hi!
>=20
> now I found that ALS button which enable/disable ambient light sensor=
=20
> working with linux and ALS can also decrease/increase brightness.
>=20
> ALS can be enabled or disabled via WMI (acpi) on linux too. I found=20
> function which enable ALS in linux kernel. See source code of functio=
n=20
> set_als in hp-wmi.c: http://tomoyo.sourceforge.jp/cgi-
> bin/lxr/source/drivers/platform/x86/hp-wmi.c#L443
>=20
> This function can enable ALS which can decrease brightness (but only=20
> to specific one level) via WMI. And WMI is ACPI extension, so maybe i=
t=20
> is really possible to change brightness via acpi without DRI support.
>=20
> But I do not WMI, ACPI and DSDT code. Can you try to decode what is=20
> called in acpi when that set_als function in hp-wmi is called? I thin=
k=20
> here in acpi can be some magic which can manipulate with display=20
> brightness. At least ACPI must call somewhat to change brightness...
>=20
> Note: Enabling ALS on my notebook change brightness to some specific=20
> level and disabling ALS will revert brightness back. From userspace=20
> ALS can be enabled/disabled via this sysfs entry:=20
> /sys/devices/platform/hp-wmi/als
>=20
> --=20
> Pali Roh=C3=A1r
> pali.rohar@gmail.com

Traced the your dsdt from 8460p.

Let's see "set ALS" first, when set ALS enable, BIOS didn't _eat_ any
input value for brightness level:


    Method (WHCM, 2, NotSerialized)
    {
        CreateDWordField (Arg1, 0x00, SNIN)     /* signature */
        CreateDWordField (Arg1, 0x04, COMD)     /* command =3D write ? =
0x2 : 0x1 */
        CreateDWordField (Arg1, 0x08, CMTP)     /* commandtype */
        CreateDWordField (Arg1, 0x0C, DASI)
        Store ("HandleWMICommand Enter", Debug)
=2E..
    If (LEqual (COMD, 0x02))            /* command write */
    {
        Store ("write BIOS command", Debug)
=2E...
        If (LEqual (CMTP, 0x03))        /* write HPWMI_ALS_QUERY 0x3 */
        {
            Store (^WSAL (DDWD), Local2)  /* call ^WSAL and feed DDWD *=
/
            Store (0x00, RTCD)
        }


            Method (WSAL, 1, NotSerialized)     /* write HPWMI_ALS_QUER=
Y 0x3 */
            {
                If (LEqual (PRDT, 0x03))=20
                {
                    Return (Package (0x02)
                    {
                        0x04,
                        0x00
                    })
                }

                \_SB.SSMI (0xEA75, 0x02, 0x03, 0x574D4953, 0x00)   /* e=
mit SMI, BIOS code take job but didn't feed Arg0 to BIOS */
                Return (WFDA ())
            }

Everything handle by BIOS function after emit SMI event, and it didn't
give BIOS any input value of brightness.
So, didn't find any way to change brightness through set ALS.


Then, I found another interesting command for 'write brightness', hp-wm=
i
doesn't have implementation for this command:=20

        If (LEqual (CMTP, 0x06))        /* set brightness? */
        {
            Store ("write Brightness", Debug)
            Store (^SBBC (DDWD), Local2)	/* call DDWD */
            Store (Local2, Debug)
            Store (0x00, RTCD)
        }

            Method (SBBC, 1, NotSerialized)     /* write brighenss? did=
n't do anything? */
            {
                Return (Package (0x02)		/* just only return a package *=
/
                {
                    0x04,
                    0x00
                })
            }


Unfortunately, the 0x06 command also doesn't do anything for change
brightness on your machine.

Sorry! Didn't find any way can change brightness on your machine unless
we have drm driver support ATI acpi events.


Thanks a lot!
Joey Lee
