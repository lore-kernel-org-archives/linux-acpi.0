From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode for a DELL Vostro 1000 laptop
Date: Wed, 23 Jan 2008 21:52:31 -0500
Message-ID: <200801232152.31186.lenb@kernel.org>
References: <200708151528.11138.alexander@wright-family.me.uk> <200801182218.27992.lenb@kernel.org> <200801231432.45438.alexander@wright-family.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60711 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691AbYAXCwo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Jan 2008 21:52:44 -0500
In-Reply-To: <200801231432.45438.alexander@wright-family.me.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexander Wright <alexander@wright-family.me.uk>
Cc: linux-acpi@vger.kernel.org

On Wednesday 23 January 2008 09:32, Alexander Wright wrote:
> On Saturday 19 January 2008 03:18:27 you wrote:
> > On Wednesday 15 August 2007 10:28, Alexander Wright wrote:
> > > System Information
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Manufacturer: Del=
l Inc.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Product Name: Vos=
tro =C2=A0 1000
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Version: Not Spec=
ified =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Serial Number: 97=
CG23J
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UUID: 44454C4C-37=
00-1043-8047-B9C04F32334A
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Wake-up Type: Pow=
er Switch
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SKU Number: Not S=
pecified
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Family: Not Speci=
fied
> > >
> > > Handle 0x0003, DMI type 2, 8 bytes
> > > Base Board Information
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Manufacturer: Del=
l Inc.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Product Name: 0WY=
383
> >
> > Thanks for the dmidecode output.
> >
> > Do you notice any functional difference when booting with
> >
> > "acpi_osi=3DLinux"        (default for 2.6.22 and earlier)
> > vs.
> > "acpi_osi=3D!Linux"       (default for 2.6.23 and later)
> >

thanks for the acpidump output
OSI(Linux) is a NOP on this system.

                    If (\_OSI ("Windows 2006"))
                    {
                        Store (0x40, ^OSTB)
                        Store (0x40, ^TPOS)
                    }

                    If (\_OSI ("Linux"))
                    {
                        Store (0x01, LINX) // NOP - set but not referen=
ced
                        Store (0x80, ^OSTB) // NOP, only compared to > =
4
                        Store (0x80, ^TPOS) // NOP, only compared to > =
4
                    }n



> I seem to be getting more of these errors with acpi_osi=3DLinux than =
without,=20
> but its a little hard to tell.

the difference must be caused by something other than OSI(Linux).

> ACPI: EC: acpi_ec_wait timeout, status =3D 0, expect_event =3D 1
> ACPI: EC: read timeout, command =3D 128
> ACPI Exception (evregion-0420): AE_TIME, Returned by Handler for=20
> [EmbeddedControl] [20070126]
> ACPI Exception (dswexec-0462): AE_TIME, While resolving operands for=20
> [OpcodeName unavailable] [20070126]
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.LID_.=
_LID]=20
> (Node ffff8100013622e0), AE_TIME
> =20

please reproduce this with 2.6.24-rc.
if it still happens, then please open a bug here:
http://bugzilla.kernel.org/enter_bug.cgi?product=3DACPI
and then attach the acpidump output to it.

Please note the latest kernel that did not see this issue,
and the earliest kernel that does see this issue.

please note if you see any functional issues with the batter info
or the lid.

thanks,
-Len

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
