From: "Joey Lee" <jlee@suse.com>
Subject: Re: Fwd: Brightness on HP EliteBook 8460p
Date: Sat, 04 Feb 2012 18:43:23 -0700
Message-ID: <4F2E796B0200002300007D7E@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part7F5110AB.2__="
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: pali.rohar@gmail.com
Cc: linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part7F5110AB.2__=
Content-Type: multipart/alternative; boundary="=__Part7F5110AB.3__="

--=__Part7F5110AB.3__=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Add Cc. to dri mail

Hi Pali,=20

=E6=96=BC =E4=BA=94=EF=BC=8C2012-02-03 =E6=96=BC 16:24 +0100=EF=BC=8CPali=
 Roh=C3=A1r =E6=8F=90=E5=88=B0=EF=BC=9A
> On Friday 20 January 2012 17:55:57 Pali Roh=C3=A1r wrote:
> > On Friday 20 January 2012 11:28:59 joeyli wrote:
> > > =E6=96=BC =E4=BA=94=EF=BC=8C2012-01-20 =E6=96=BC 11:12 +0800=EF=BC=8C=
joeyli =E6=8F=90=E5=88=B0=EF=BC=9A
> > >=20
> > > > Hi Pali,
> > > >=20
> > > > Sorry for I am late reply you.
> > > >=20
> > > > =E6=96=BC =E4=BA=8C=EF=BC=8C2012-01-17 =E6=96=BC 19:10 +0100=EF=BC=
=8CPali Roh=C3=A1r =E6=8F=90=E5=88=B0=EF=BC=9A
> > > >=20
> > > > > On Wednesday 21 December 2011 12:45:07 Pali Roh=C3=A1r wrote:
> > > > > > Hello,
> > > > > >=20
> > > > > > I tried to boot with all 3 strings in acpi_os_name, but nothi=
ng was
> > > > > > changed. I'm attaching dmesg outputs, one from BIOS mode, one=
 from
> > > > > > UEFI mode. Both are with "Microsoft Windows NT".
> > > > >=20
> > > > > Did you looked at my logs?
> > > >=20
> > > > I checked your dmesg log, found the acpi_os_name kernel parameter=
 is :
> > > >=20
> > > > [    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-3.2.0-4-generi=
c
> > > > root=3DUUID=3D4ec6272a-8551-40f3-a1b1-3e10984f3e69 ro pcie_aspm=3D=
force
> > > > acpi.debug_level=3D0x2 acpi.debug_layer=3D0xFFFFFFFF "acpi_os_nam=
e=3DMicrosoft
> > > > Windows NT" splash vt.handoff=3D7
> > > >=20
> > > > We still need by-pass the os name check in DSDT when test functio=
n key,
> > > >=20
> > > > please help to feed:
> > > > 	acpi_os_name=3D"Windows 2009"
> > > >=20
> > > > And,
> > > > looks like the acpi debug level not enough, please kindly change =
acpi
> > > >=20
> > > > debug parameter to:
> > > > 	acpi.debug_level=3D0xF acpi.debug_layer=3D0xFFFFFFFF log_buf_len=
=3D5M
> > > >=20
> > > > summary:
> > > > 	acpi.debug_level=3D0xF acpi.debug_layer=3D0xFFFFFFFF log_buf_len=
=3D5M
> > > > 	acpi_os_name=3D"Windows 2009"
> > >=20
> > > Forgot remind,
> > > please remember press brightness function key a couple of times bef=
ore
> > > you dump the dmesg and messages log.
> > >=20
> > >=20
> > > Thanks a lot!
> > > Joey Lee
> >=20
> > Hello,
> >=20
> > there was no acpi log, so I recompiled ubuntu kernel with
> > CONFIG_ACPI_DEBUG=3Dy and CONFIG_ACPI_DEBUG_FUNC_TRACE. Then I starte=
d kernel
> > with your params.
> >=20
> > Now I'm attaching very long debug output. I belive it will be now use=
full.
> >=20
> > Pressing brightness keys did not show anything in log.
> >=20
> > After writing 0 to /sys/class/backlight/acpi_video0/brightness in log
> > appear: [   57.675070] [ACPI Debug]  Integer 0x000000000000000B
> > ...
> >=20
> > And after writing 10:
> > [   99.865208] [ACPI Debug]  Integer 0x0000000000000048
> > [   99.865295]   evmisc-0120 [4294967289] ev_queue_notify_reques:
> > Dispatching Notify on [DGFX] Node ffff880136246c80 Value 0xD0 (**Devi=
ce
> > Specific**) [   99.865350]    video-1474 [4294967289] video_bus_notif=
y    =20
> > : Unsupported event [0xd0]
>=20
> Do you need more logs? Or is this enought?
>=20

Yes, as you point out, this is a doubt for video bus received 0xD0 event
but nobody take care it.

Traced dsdt of EliteBook 8460p from you, the _BCM like this:

    Method (_BCM, 1, Serialized)                /* ATI _BCM, per log, run=
 this _BCM */
    { =20
        Store (\_SB.BCM (Arg0), Local0)         /* set next level, normal=
ly return 0x1 if XP sp2 or later */
        If (Local0)                             /* if XP sp2 or later */
        { =20
            Store (BRID, Local1)
            If (LEqual (SBRV (), 0x00))         /* normally SBRV return 1=
, will not emit SMI */
            { =20
                \_SB.SSMI (0xEA74, 0x04, Local1, 0x00, 0x00)
            }

            Signal (\_SB.BEVT)          /* emit BEVT event, HKFR (HotkeyF=
unctionResponse) waiting it, but why? */
        }
    }

_BCM call SBRV to setup brightness value to variable ABRI:

Method (SBRV, 0, Serialized)            /* call by ATI _BCM */
{ =20
    Store (\_SB.SBRC (), ABRI)          /* SBRC() return the brightness v=
alue, why store to ABRI? only used in PEGP.DGFX.AFN2 */
    Or (PSBR, 0x80, PSBR)
    Notify (^, 0xD0)                    /* notify method's parent: PEGP.D=
GFX by 0xD0 */
    Return (0x01)                       /* normally return 1 */
}The PEGP.DGFX acpi device was binding to acpi/video driver, the above
ASL code emit a 0xD0 bus event to video.c but cann't process it. Even we
add a new bus event in video.c and generate a acpi event, there still
need another acpi driver should take care it.

I thought this acpi event might need take care by radeon drm, but I am
not good for radeon, need more help.

Per your acpi debug log, the brightness value was changed normally when
you access _BCM:

83133 Jan 20 17:17:51 Pali-EliteBook kernel: [   57.674669] ACPI: Execute=
 Method [\_SB_.PCI0.PEGP.DGFX.LCD_._BCM] (Node ffff8      801362472a8)		#=
 start test _BCM manually
83134 Jan 20 17:17:51 Pali-EliteBook kernel: [   57.674736] exregion-0199=
 [01] ex_system_memory_space: System-Memory (width 8      ) R/W 0 Address=
=3D00000000BF7ACE1C
83135 Jan 20 17:17:51 Pali-EliteBook kernel: [   57.674748] exregion-0199=
 [02] ex_system_memory_space: System-Memory (width 8      ) R/W 1 Address=
=3D00000000BF7ACE1C
...
83179 Jan 20 17:17:51 Pali-EliteBook kernel: [   57.675070] [ACPI Debug] =
 Integer 0x000000000000000B	# brightness value is 11
83180 Jan 20 17:17:51 Pali-EliteBook kernel: [   57.675090]   evmisc-0120=
 [4294967289] ev_queue_notify_reques: Dispatching No      tify on [DGFX] =
Node ffff880136246c80 Value 0xD0 (**Device Specific**)
83181 Jan 20 17:17:51 Pali-EliteBook kernel: [   57.675099]    video-1474=
 [4294967288] video_bus_notify      : Unsupported event [0xd0]
...
83197 Jan 20 17:18:33 Pali-EliteBook kernel: [   99.863593] ACPI: Execute=
 Method [\_SB_.PCI0.PEGP.DGFX.LCD_._BCM] (Node ffff8      801362472a8)
83198 Jan 20 17:18:33 Pali-EliteBook kernel: [   99.863817] exregion-0199=
 [01] ex_system_memory_space: System-Memory (width 8      ) R/W 0 Address=
=3D00000000BF7ACE1C
83243 Jan 20 17:18:33 Pali-EliteBook kernel: [   99.865208] [ACPI Debug] =
 Integer 0x0000000000000048	# brightness value is 72=20
83244 Jan 20 17:18:33 Pali-EliteBook kernel: [   99.865295]   evmisc-0120=
 [4294967289] ev_queue_notify_reques: Dispatching Notify on [DGFX] Node f=
fff880136246c80 Value 0xD0 (**Device Specific**)
83245 Jan 20 17:18:33 Pali-EliteBook kernel: [   99.865350]    video-1474=
 [4294967289] video_bus_notify      : Unsupported event [0xd0]

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





--=__Part7F5110AB.3__=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dutf-8"><META name=3D"Author" content=3D"Novell GroupWise =
WebAccess"></head><body style=3D'font-family: Helvetica, Arial, sans-serif;=
 font-size: 13px; '><div><pre>Add Cc. to dri mail

Hi Pali,=20

=E6=96=BC =E4=BA=94=EF=BC=8C2012-02-03 =E6=96=BC 16:24 +0100=EF=BC=8CPali =
Roh=C3=A1r =E6=8F=90=E5=88=B0=EF=BC=9A
&gt; On Friday 20 January 2012 17:55:57 Pali Roh=C3=A1r wrote:
&gt; &gt; On Friday 20 January 2012 11:28:59 joeyli wrote:
&gt; &gt; &gt; =E6=96=BC =E4=BA=94=EF=BC=8C2012-01-20 =E6=96=BC 11:12 =
+0800=EF=BC=8Cjoeyli =E6=8F=90=E5=88=B0=EF=BC=9A
&gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; Hi Pali,
&gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; Sorry for I am late reply you.
&gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; =E6=96=BC =E4=BA=8C=EF=BC=8C2012-01-17 =E6=96=BC 19:10 =
+0100=EF=BC=8CPali Roh=C3=A1r =E6=8F=90=E5=88=B0=EF=BC=9A
&gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; On Wednesday 21 December 2011 12:45:07 Pali =
Roh=C3=A1r wrote:
&gt; &gt; &gt; &gt; &gt; &gt; Hello,
&gt; &gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; &gt; I tried to boot with all 3 strings in =
acpi_os_name, but nothing was
&gt; &gt; &gt; &gt; &gt; &gt; changed. I'm attaching dmesg outputs, one =
from BIOS mode, one from
&gt; &gt; &gt; &gt; &gt; &gt; UEFI mode. Both are with "Microsoft Windows =
NT".
&gt; &gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; &gt; Did you looked at my logs?
&gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; I checked your dmesg log, found the acpi_os_name =
kernel parameter is :
&gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; [    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-3.2.=
0-4-generic
&gt; &gt; &gt; &gt; root=3DUUID=3D4ec6272a-8551-40f3-a1b1-3e10984f3e69 ro =
pcie_aspm=3Dforce
&gt; &gt; &gt; &gt; acpi.debug_level=3D0x2 acpi.debug_layer=3D0xFFFFFFFF =
"acpi_os_name=3DMicrosoft
&gt; &gt; &gt; &gt; Windows NT" splash vt.handoff=3D7
&gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; We still need by-pass the os name check in DSDT when =
test function key,
&gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; please help to feed:
&gt; &gt; &gt; &gt; 	acpi_os_name=3D"Windows 2009"
&gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; And,
&gt; &gt; &gt; &gt; looks like the acpi debug level not enough, please =
kindly change acpi
&gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; debug parameter to:
&gt; &gt; &gt; &gt; 	acpi.debug_level=3D0xF acpi.debug_layer=3D0xFFFFFFF=
F log_buf_len=3D5M
&gt; &gt; &gt; &gt;=20
&gt; &gt; &gt; &gt; summary:
&gt; &gt; &gt; &gt; 	acpi.debug_level=3D0xF acpi.debug_layer=3D0xFFFFFFF=
F log_buf_len=3D5M
&gt; &gt; &gt; &gt; 	acpi_os_name=3D"Windows 2009"
&gt; &gt; &gt;=20
&gt; &gt; &gt; Forgot remind,
&gt; &gt; &gt; please remember press brightness function key a couple of =
times before
&gt; &gt; &gt; you dump the dmesg and messages log.
&gt; &gt; &gt;=20
&gt; &gt; &gt;=20
&gt; &gt; &gt; Thanks a lot!
&gt; &gt; &gt; Joey Lee
&gt; &gt;=20
&gt; &gt; Hello,
&gt; &gt;=20
&gt; &gt; there was no acpi log, so I recompiled ubuntu kernel with
&gt; &gt; CONFIG_ACPI_DEBUG=3Dy and CONFIG_ACPI_DEBUG_FUNC_TRACE. Then I =
started kernel
&gt; &gt; with your params.
&gt; &gt;=20
&gt; &gt; Now I'm attaching very long debug output. I belive it will be =
now usefull.
&gt; &gt;=20
&gt; &gt; Pressing brightness keys did not show anything in log.
&gt; &gt;=20
&gt; &gt; After writing 0 to /sys/class/backlight/acpi_video0/brightness =
in log
&gt; &gt; appear: [   57.675070] [ACPI Debug]  Integer 0x000000000000000B
&gt; &gt; ...
&gt; &gt;=20
&gt; &gt; And after writing 10:
&gt; &gt; [   99.865208] [ACPI Debug]  Integer 0x0000000000000048
&gt; &gt; [   99.865295]   evmisc-0120 [4294967289] ev_queue_notify_reques:=

&gt; &gt; Dispatching Notify on [DGFX] Node ffff880136246c80 Value 0xD0 =
(**Device
&gt; &gt; Specific**) [   99.865350]    video-1474 [4294967289] video_bus_n=
otify    =20
&gt; &gt; : Unsupported event [0xd0]
&gt;=20
&gt; Do you need more logs? Or is this enought?
&gt;=20

Yes, as you point out, this is a doubt for video bus received 0xD0 event
but nobody take care it.

Traced dsdt of EliteBook 8460p from you, the _BCM like this:

    Method (_BCM, 1, Serialized)                /* ATI _BCM, per log, run =
this _BCM */
    { =20
        Store (\_SB.BCM (Arg0), Local0)         /* set next level, =
normally return 0x1 if XP sp2 or later */
        If (Local0)                             /* if XP sp2 or later */
        { =20
            Store (BRID, Local1)
            If (LEqual (SBRV (), 0x00))         /* normally SBRV return 1, =
will not emit SMI */
            { =20
                \_SB.SSMI (0xEA74, 0x04, Local1, 0x00, 0x00)
            }

            Signal (\_SB.BEVT)          /* emit BEVT event, HKFR (HotkeyFun=
ctionResponse) waiting it, but why? */
        }
    }

_BCM call SBRV to setup brightness value to variable ABRI:

Method (SBRV, 0, Serialized)            /* call by ATI _BCM */
{ =20
    Store (\_SB.SBRC (), ABRI)          /* SBRC() return the brightness =
value, why store to ABRI? only used in PEGP.DGFX.AFN2 */
    Or (PSBR, 0x80, PSBR)
    Notify (^, 0xD0)                    /* notify method's parent: =
PEGP.DGFX by 0xD0 */
    Return (0x01)                       /* normally return 1 */
}

The PEGP.DGFX acpi device was binding to acpi/video driver, the above
ASL code emit a 0xD0 bus event to video.c but cann't process it. Even we
add a new bus event in video.c and generate a acpi event, there still
need another acpi driver should take care it.

I thought this acpi event might need take care by radeon drm, but I am
not good for radeon, need more help.

Per your acpi debug log, the brightness value was changed normally when
you access _BCM:

83133 Jan 20 17:17:51 Pali-EliteBook kernel: [   57.674669] ACPI: Execute =
Method [\_SB_.PCI0.PEGP.DGFX.LCD_._BCM] (Node ffff8      801362472a8)		=
# start test _BCM manually
83134 Jan 20 17:17:51 Pali-EliteBook kernel: [   57.674736] exregion-0199 =
[01] ex_system_memory_space: System-Memory (width 8      ) R/W 0 Address=3D=
00000000BF7ACE1C
83135 Jan 20 17:17:51 Pali-EliteBook kernel: [   57.674748] exregion-0199 =
[02] ex_system_memory_space: System-Memory (width 8      ) R/W 1 Address=3D=
00000000BF7ACE1C
...
83179 Jan 20 17:17:51 Pali-EliteBook kernel: [   57.675070] [ACPI Debug]  =
Integer 0x000000000000000B	# brightness value is 11
83180 Jan 20 17:17:51 Pali-EliteBook kernel: [   57.675090]   evmisc-0120 =
[4294967289] ev_queue_notify_reques: Dispatching No      tify on [DGFX] =
Node ffff880136246c80 Value 0xD0 (**Device Specific**)
83181 Jan 20 17:17:51 Pali-EliteBook kernel: [   57.675099]    video-1474 =
[4294967288] video_bus_notify      : Unsupported event [0xd0]
...
83197 Jan 20 17:18:33 Pali-EliteBook kernel: [   99.863593] ACPI: Execute =
Method [\_SB_.PCI0.PEGP.DGFX.LCD_._BCM] (Node ffff8      801362472a8)
83198 Jan 20 17:18:33 Pali-EliteBook kernel: [   99.863817] exregion-0199 =
[01] ex_system_memory_space: System-Memory (width 8      ) R/W 0 Address=3D=
00000000BF7ACE1C
83243 Jan 20 17:18:33 Pali-EliteBook kernel: [   99.865208] [ACPI Debug]  =
Integer 0x0000000000000048	# brightness value is 72=20
83244 Jan 20 17:18:33 Pali-EliteBook kernel: [   99.865295]   evmisc-0120 =
[4294967289] ev_queue_notify_reques: Dispatching Notify on [DGFX] Node =
ffff880136246c80 Value 0xD0 (**Device Specific**)
83245 Jan 20 17:18:33 Pali-EliteBook kernel: [   99.865350]    video-1474 =
[4294967289] video_bus_notify      : Unsupported event [0xd0]

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
</pre>
<br></div></body></html>

--=__Part7F5110AB.3__=--

--=__Part7F5110AB.2__=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--=__Part7F5110AB.2__=--
