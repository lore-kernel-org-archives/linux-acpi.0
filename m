From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: All 2.4.22 patches after 09-16 broken?
Date: Thu, 20 Nov 2003 22:55:30 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE00147D323@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Marcel Meckel <acpi-X2Xph2rMQzhn68oJJulU0Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thanks for reporting this one Marcel, and thanks for the quick response
Matt!

Turns out this fix went into 2.4.23 in October.  As it went directly to
Marcelo instead of through me, it wasn't in our 2.4.22 ACPI patch.  So
I've updated the 2.4.22 ACPI patch on kernel.org, and will update the
2.4.22 release tree on bkbits when the nice person pulling it via modem
finishes and unlocks the repo...)

Thanks,
-Len


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
> Matthew Wilcox
> Sent: Thursday, November 20, 2003 11:32 AM
> To: Marcel Meckel
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] All 2.4.22 patches after 09-16 broken?
>=20
>=20
> On Thu, Nov 20, 2003 at 08:53:16AM +0100, Marcel Meckel wrote:
> > I patched vanilla 2.4.22 kernel with acpi-20031002-2.4.22.diff, ran=20
> > make xconfig. In menu "character devices" i see option
> > "/dev/agpgart (AGP Support)" twice, one as bool one as=20
> tristate option.=20
> > Without changing an option (and without .config of course)=20
> i get this=20
> > error after pressing "Save and Exit" Button:
> >=20
> > Error in Tcl Script
> > Error: can't read "CONFIG_SCSI": no such variable
> >=20
> > ERROR - Attempting to write value for unconfigured variable=20
> > (CONFIG_PARPORT_PC_CML1).
>=20
> Maybe the tk program is having trouble parsing this:
>=20
> +  else if [ "$CONFIG_SMP" =3D "y" ]; then
>=20
> Can you try changing that line in drivers/acpi/Config.in by putting a
> new line between the `else' and the `if'?  ie make it look like:
>   else
>     if [ "$CONFIG_SMP" =3D "y" ]; then
>=20
> --=20
> "It's not Hollywood.  War is real, war is primarily not about=20
> defeat or
> victory, it is about death.  I've seen thousands and=20
> thousands of dead bodies.
> Do you think I want to have an academic debate on this=20
> subject?" -- Robert Fisk
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
