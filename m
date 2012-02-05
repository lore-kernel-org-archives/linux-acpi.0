From: "Joey Lee" <jlee@suse.com>
Subject: Re: Fwd: Brightness on HP EliteBook 8460p
Date: Sat, 04 Feb 2012 20:19:16 -0700
Message-ID: <4F2E8FE40200002300007D85@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
Sender: platform-driver-x86-owner@vger.kernel.org
To: pali.rohar@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Add Cc. to dri mail

Hi Pali,=20

=E6=96=BC =E4=BA=94=EF=BC=8C2012-02-03 =E6=96=BC 16:24 +0100=EF=BC=8CPa=
li Roh=C3=A1r =E6=8F=90=E5=88=B0=EF=BC=9A
> On Friday 20 January 2012 17:55:57 Pali Roh=C3=A1r wrote:
> > On Friday 20 January 2012 11:28:59 joeyli wrote:
> > > =E6=96=BC =E4=BA=94=EF=BC=8C2012-01-20 =E6=96=BC 11:12 +0800=EF=BC=
=8Cjoeyli =E6=8F=90=E5=88=B0=EF=BC=9A
> > >=20
> > > > Hi Pali,
> > > >=20
> > > > Sorry for I am late reply you.
> > > >=20
> > > > =E6=96=BC =E4=BA=8C=EF=BC=8C2012-01-17 =E6=96=BC 19:10 +0100=EF=
=BC=8CPali Roh=C3=A1r =E6=8F=90=E5=88=B0=EF=BC=9A
> > > >=20
> > > > > On Wednesday 21 December 2011 12:45:07 Pali Roh=C3=A1r wrote:
> > > > > > Hello,
> > > > > >=20
> > > > > > I tried to boot with all 3 strings in acpi_os_name, but not=
hing was
> > > > > > changed. I'm attaching dmesg outputs, one from BIOS mode, o=
ne from
> > > > > > UEFI mode. Both are with "Microsoft Windows NT".
> > > > >=20
> > > > > Did you looked at my logs?
> > > >=20
> > > > I checked your dmesg log, found the acpi_os_name kernel paramet=
er is :
> > > >=20
> > > > [    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-3.2.0-4-gene=
ric
> > > > root=3DUUID=3D4ec6272a-8551-40f3-a1b1-3e10984f3e69 ro pcie_aspm=
=3Dforce
> > > > acpi.debug_level=3D0x2 acpi.debug_layer=3D0xFFFFFFFF "acpi_os_n=
ame=3DMicrosoft
> > > > Windows NT" splash vt.handoff=3D7
> > > >=20
> > > > We still need by-pass the os name check in DSDT when test funct=
ion key,
> > > >=20
> > > > please help to feed:
> > > > 	acpi_os_name=3D"Windows 2009"
> > > >=20
> > > > And,
> > > > looks like the acpi debug level not enough, please kindly chang=
e acpi
> > > >=20
> > > > debug parameter to:
> > > > 	acpi.debug_level=3D0xF acpi.debug_layer=3D0xFFFFFFFF log_buf_l=
en=3D5M
> > > >=20
> > > > summary:
> > > > 	acpi.debug_level=3D0xF acpi.debug_layer=3D0xFFFFFFFF log_buf_l=
en=3D5M
> > > > 	acpi_os_name=3D"Windows 2009"
> > >=20
> > > Forgot remind,
> > > please remember press brightness function key a couple of times b=
efore
> > > you dump the dmesg and messages log.
> > >=20
> > >=20
> > > Thanks a lot!
> > > Joey Lee
> >=20
> > Hello,
> >=20
> > there was no acpi log, so I recompiled ubuntu kernel with
> > CONFIG_ACPI_DEBUG=3Dy and CONFIG_ACPI_DEBUG_FUNC_TRACE. Then I star=
ted kernel
> > with your params.
> >=20
> > Now I'm attaching very long debug output. I belive it will be now u=
sefull.
> >=20
> > Pressing brightness keys did not show anything in log.
> >=20
> > After writing 0 to /sys/class/backlight/acpi_video0/brightness in l=
og
> > appear: [   57.675070] [ACPI Debug]  Integer 0x000000000000000B
> > ...
> >=20
> > And after writing 10:
> > [   99.865208] [ACPI Debug]  Integer 0x0000000000000048
> > [   99.865295]   evmisc-0120 [4294967289] ev_queue_notify_reques:
> > Dispatching Notify on [DGFX] Node ffff880136246c80 Value 0xD0 (**De=
vice
> > Specific**) [   99.865350]    video-1474 [4294967289] video_bus_not=
ify    =20
> > : Unsupported event [0xd0]
>=20
> Do you need more logs? Or is this enought?
>=20

Yes, as you point out, this is a doubt for video bus received 0xD0 even=
t
but nobody take care it.

Traced dsdt of EliteBook 8460p from you, the _BCM like this:

    Method (_BCM, 1, Serialized)                /* ATI _BCM, per log, r=
un this _BCM */
    { =20
        Store (\_SB.BCM (Arg0), Local0)         /* set next level, norm=
ally return 0x1 if XP sp2 or later */
        If (Local0)                             /* if XP sp2 or later *=
/
        { =20
            Store (BRID, Local1)
            If (LEqual (SBRV (), 0x00))         /* normally SBRV return=
 1, will not emit SMI */
            { =20
                \_SB.SSMI (0xEA74, 0x04, Local1, 0x00, 0x00)
            }

            Signal (\_SB.BEVT)          /* emit BEVT event, HKFR (Hotke=
yFunctionResponse) waiting it, but why? */
        }
    }

_BCM call SBRV to setup brightness value to variable ABRI:

Method (SBRV, 0, Serialized)            /* call by ATI _BCM */
{ =20
    Store (\_SB.SBRC (), ABRI)          /* SBRC() return the brightness=
 value, why store to ABRI? only used in PEGP.DGFX.AFN2 */
    Or (PSBR, 0x80, PSBR)
    Notify (^, 0xD0)                    /* notify method's parent: PEGP=
=2EDGFX by 0xD0 */
    Return (0x01)                       /* normally return 1 */
}The PEGP.DGFX acpi device was binding to acpi/video driver, the above
ASL code emit a 0xD0 bus event to video.c but cann't process it. Even w=
e
add a new bus event in video.c and generate a acpi event, there still
need another acpi driver should take care it.

I thought this acpi event might need take care by radeon drm, but I am
not good for radeon, need more help.

Per your acpi debug log, the brightness value was changed normally when
you access _BCM:

83133 Jan 20 17:17:51 Pali-EliteBook kernel: [   57.674669] ACPI: Execu=
te Method [\_SB_.PCI0.PEGP.DGFX.LCD_._BCM] (Node ffff8      801362472a8=
)		# start test _BCM manually
83134 Jan 20 17:17:51 Pali-EliteBook kernel: [   57.674736] exregion-01=
99 [01] ex_system_memory_space: System-Memory (width 8      ) R/W 0 Add=
ress=3D00000000BF7ACE1C
83135 Jan 20 17:17:51 Pali-EliteBook kernel: [   57.674748] exregion-01=
99 [02] ex_system_memory_space: System-Memory (width 8      ) R/W 1 Add=
ress=3D00000000BF7ACE1C
=2E..
83179 Jan 20 17:17:51 Pali-EliteBook kernel: [   57.675070] [ACPI Debug=
]  Integer 0x000000000000000B	# brightness value is 11
83180 Jan 20 17:17:51 Pali-EliteBook kernel: [   57.675090]   evmisc-01=
20 [4294967289] ev_queue_notify_reques: Dispatching No      tify on [DG=
=46X] Node ffff880136246c80 Value 0xD0 (**Device Specific**)
83181 Jan 20 17:17:51 Pali-EliteBook kernel: [   57.675099]    video-14=
74 [4294967288] video_bus_notify      : Unsupported event [0xd0]
=2E..
83197 Jan 20 17:18:33 Pali-EliteBook kernel: [   99.863593] ACPI: Execu=
te Method [\_SB_.PCI0.PEGP.DGFX.LCD_._BCM] (Node ffff8      801362472a8=
)
83198 Jan 20 17:18:33 Pali-EliteBook kernel: [   99.863817] exregion-01=
99 [01] ex_system_memory_space: System-Memory (width 8      ) R/W 0 Add=
ress=3D00000000BF7ACE1C
83243 Jan 20 17:18:33 Pali-EliteBook kernel: [   99.865208] [ACPI Debug=
]  Integer 0x0000000000000048	# brightness value is 72=20
83244 Jan 20 17:18:33 Pali-EliteBook kernel: [   99.865295]   evmisc-01=
20 [4294967289] ev_queue_notify_reques: Dispatching Notify on [DGFX] No=
de ffff880136246c80 Value 0xD0 (**Device Specific**)
83245 Jan 20 17:18:33 Pali-EliteBook kernel: [   99.865350]    video-14=
74 [4294967289] video_bus_notify      : Unsupported event [0xd0]

The brightness values are 11(0x0B) and 72(0x48), that means the BCM
method return a good value and set to ABRI, ABRI waiting the guy who
take the 0xD0 event to read then change brightness.

Another doubt is the latest statement in _BCM, it emit a BEVT event:

Signal (\_SB.BEVT)

Only HKFR(HotkeyFunctionResponse) method is waiting this event, it
should related to how the HP implement brightness function key on
Windows through wmi.

Of course this issue really close related to video driver, even more,
we might need to know hp wmi for how to implement on Windows.

Unfortunately, sorry for I don't have any solution to you, now, I will
continue to trace and find any support from other experts.


Thanks a lot!
Joey Lee
