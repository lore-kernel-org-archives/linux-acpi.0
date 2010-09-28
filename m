From: "Joey Lee" <jlee@novell.com>
Subject: Re: MSI GX723 notebook - ACPI problem with Fn keys
Date: Tue, 28 Sep 2010 10:48:45 -0600
Message-ID: <4CA2A90D0200002300020F8E@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartE7CA047D.1__="
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: patrol@sinus.cz
Cc: linux-acpi@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartE7CA047D.1__=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Hi Pavel, 

於 一，2010-09-27 於 16:17 +0200，Pavel Troller 提到：
> Hi Joey,
> 
> > Hi Pavel, 
> > 
> > ??? ??????2010-09-25 ??? 14:44 +0200???Pavel Troller ?????????
> > > Hi!
> > >   I'm a fresh owner of GX723 notebook by MSI. It looks relatively
> > > linux-friendly, but I've found some ACPI-related issues.
> > >   1) Booting 2.6.35.5 kernel natively, the Fn keys (brightness control,
> > > video switching) are non-functional and even a single keypress causes,
> > > that ACPI events (like AC adapter status changes or lid switch operation) are
> > > not generated anymore. After a while (about 10 minutes), the following
> > > lines pop to the system log:
> > > Sep 25 13:53:18 beam kernel: ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.SBRG.EC__._QB7] (Node ffff88013fc1ff00), AE_AML_INFINITE_LOOP
> > > Sep 25 13:42:23 beam kernel: ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.SBRG.EC__._QB8] (Node ffff88013fc1ff20), AE_AML_INFINITE_LOOP
> > 
> > In _QB7 and _QB8 have the following infinite while loop:
> > 
> >                         If (_OSI ("Windows 2006"))
> >                         {  
> >                             If (LEqual (^^^P0P2.VGA.VVID, 0x10DE))
> >                             {  
> >                                 Store (One, ^^^P0P2.VGA.MSIB)
> >                                 Store (Zero, ^^^P0P2.VGA.MSIM)
> >                                 Store (One, ^^^P0P2.VGA.MSIE) /* defalut
> > is one */
> >                                 Sleep (0x0A)
> >                                 Notify (^^^P0P2.VGA, 0xCB)
> >                                 While (^^^P0P2.VGA.MSIE)  /* infinite */
> >                                 {
> >                                     Sleep (0x0A)
> >                                 }
> >                             }
> >                         }
> > 
> > The MSIE is just a named object declared in VGA device but it's not any
> > hardware register. So, kernel's acpi parser is right, it's a infinite
> > loop.
> 
> I've seen it, but I was not sure, whether the MSIE object could change its
> state back to zero by some external event... But in Linux, it definitely
> doesn't.
> 

There have a NVIF method in VGA device, it will set MSIE to zero. I
thought it call by Nvida vista driver, but have don't know how to verify
it.

The attached is the patch I add MSI GX723 DMI information to blacklist.
If possible, could you please test it?
I just simply check your DSDT, please make sure the following features
work fine after you applied the attached blacklist patch:

 - brightness up/down hotkey
 - switch to external monitor
 - unplug ac-power event
 - battery information


Thank's a lot!
Joey Lee


--=__PartE7CA047D.1__=
Content-Type: text/plain; name="0001-DMI-to-disable-Vista-compatibility-on-MSI-GX723-Note.PATCH"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="0001-DMI-to-disable-Vista-compatibility-on-MSI-GX723-Note.PATCH"

>From 580c3c8d894121e82dfbe6c2fdb7b320b4abd85d Mon Sep 17 00:00:00 =
2001=0AFrom: Lee, Chun-Yi <jlee@novell.com>=0ADate: Wed, 29 Sep 2010 =
00:30:08 +0800=0ASubject: [PATCH] DMI to disable Vista compatibility on =
MSI GX723 Notebook=0A=0AThe brightness control hotkey don't work with =
Vista compatibility=0A, because MSI GX723 included a infinite while loop =
in DSDT when=0Abrightness control hotkey pressed.=0AMSI GX723 used Nvida =
video card, the infinite while loop must be a=0Aworkaround with Nvidia's =
Vista driver.=0A=0ASigned-off-by: Lee, Chun-Yi <jlee@novell.com>=0A---=0A =
drivers/acpi/blacklist.c |    8 ++++++++=0A 1 files changed, 8 insertions(+=
), 0 deletions(-)=0A=0Adiff --git a/drivers/acpi/blacklist.c b/drivers/acpi=
/blacklist.c=0Aindex 2bb28b9..3e644d8 100644=0A--- a/drivers/acpi/blacklist=
.c=0A+++ b/drivers/acpi/blacklist.c=0A@@ -226,6 +226,14 @@ static struct =
dmi_system_id acpi_osi_dmi_table[] __initdata =3D {=0A 		},=0A 	=
},=0A 	{=0A+	.callback =3D dmi_disable_osi_vista,=0A+	.ident =3D =
"MSI GX723",=0A+	.matches =3D {=0A+		     DMI_MATCH(DMI_=
SYS_VENDOR, "Micro-Star International"),=0A+		     DMI_MATCH(DMI_=
PRODUCT_NAME, "GX723"),=0A+		},=0A+	},=0A+	{=0A 	.callback =
=3D dmi_disable_osi_win7,=0A 	.ident =3D "ASUS K50IJ",=0A 	.matches =
=3D {=0A-- =0A1.6.0.2=0A=0A
--=__PartE7CA047D.1__=--
