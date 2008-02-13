From: Len Brown <lenb@kernel.org>
Subject: Re: Fwd: FSC Esprimo Mobile V5505 - dmidecode
Date: Tue, 12 Feb 2008 23:16:19 -0500
Message-ID: <200802122316.19918.lenb@kernel.org>
References: <200710122357.46851.dl9pf@gmx.de> <200802121500.25986.lenb@kernel.org> <200802122132.48419.dl9pf@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34446 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752010AbYBMEQf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Feb 2008 23:16:35 -0500
In-Reply-To: <200802122132.48419.dl9pf@gmx.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan-Simon =?utf-8?q?M=C3=B6ller?= <dl9pf@gmx.de>
Cc: linux-acpi@vger.kernel.org

On Tuesday 12 February 2008 15:32, Jan-Simon M=C3=B6ller wrote:
> Am Dienstag 12 Februar 2008 21:00:25 schrieb Len Brown:
> [...]
> >
> > thanks for the acpidump in http://bugzilla.kernel.org/show_bug.cgi?=
id=3D9939
> >
> > This BIOS makes heavy use of TRAP's into SMM, Windows version-speci=
fic
> > hooks, and WMI -- all bad news for Linux.

> Its a Phoenix BIOS btw.=20


> For the WMI: Could acer_wmi be extended for this as Alex suggested ?
> Another FSC model is listed in their hw-db.

yes, but rather than extending acer_wmi, it would probably be more appr=
opriate
to fork it into fsc_wmi...

> Atm this is fine for me - being able to adjust the brightness in "som=
e" way.
> But this is not good for user/newbie xyz. How should he know the=20
> kernel-cmdline.

I saw your comments in bugzilla 9939.
One possibility is that we could add a DMI entry
that automatically does acpi_osi=3D"!Windows 2006" for you.

> Sidenote:
> I don't like this BIOS - there are just no features in it. I'm also s=
truggling=20
> with vmx being disabled by the bios - and no menu to enable it.
>=20
> > But OSI(Linux) itself is a NOP on this box, since LINX is set and n=
ever
> > referenced, per below.
> >
> > -Len
> >
> >        Method (_INI, 0, NotSerialized)
> >         {
> >             If (DTSE)
> >             {
> >                 TRAP (0x47)
> >             }
> >
> >             Store (0x07D0, OSYS)
> >             If (CondRefOf (_OSI, Local0))
> >             {
> >                 If (_OSI ("Linux"))
> >                 {
> >                     Store (0x01, LINX)
> >                 }
> >
> >                 If (_OSI ("Windows 2001"))
> >                 {
> >                     Store (0x07D1, OSYS)
> >                 }
> >
> >                 If (_OSI ("Windows 2001 SP1"))
> >                 {
> >                     Store (0x07D1, OSYS)
> >                 }
> >
> >                 If (_OSI ("Windows 2001 SP2"))
> >                 {
> >                     Store (0x07D2, OSYS)
> >                 }
> >
> >                 If (_OSI ("Windows 2006"))
> >                 {
> >                     Store (0x07D6, OSYS)
> >                 }
> >             }
> >
> >             If (LAnd (MPEN, LEqual (OSYS, 0x07D1)))
> >             {
> >                 TRAP (0x3D)
> >             }
> TRAP 0x3D is the Windows WMI code then ?

only "Windows 2001 SP1" -- so it must be a pretty targeted SMM entry po=
int...

> >
> >             TRAP (0x2B)
> >             TRAP (0x32)
> I wonder what these two are ;)

There is no way to tell.  The code (that I didn't show) is littered wit=
h TRAPs...

cheers,
-Len

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
