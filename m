From: John M Trostel <john.trostel-+vhbC7un7QRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Overriding DSDT Tables with external files - 2 Methods
Date: Fri, 06 Sep 2002 10:02:29 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1031320950.1891.1.camel@jtsdell>
References: <1031252226.3011.76.camel@jtsdell>
 <1031291181.3918.12.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1031291181.3918.12.camel-4/PLUo9XfK/yXfm4dIG/yWZHpeb/A1Y/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Cc: ACPI-list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

And method #1 was the one I ended up using.  And it works :-)

Thanks to all who made suggestions, I appreciate the help.

On Fri, 2002-09-06 at 01:46, S=E9rgio Monteiro Basto wrote:
> I prefer the method 1 because with gcc of RedHat doesn't include .hex
> files=20
>=20
> On Thu, 2002-09-05 at 14:57, John M Trostel wrote:
> > There seem to be 2 closely related methods of overriding the DSDT in a
> > BIOS with your own files.
> >=20
> > My question is... Do they both work? If they do both work, is one
> > prefered over the other?
> >=20
> > ***********************************
> > Method 1 (from http://www.cpqlinux.com/acpi-howto.html and others)
> >=20
> > 1. get the dsdt.hex file
> >=20
> > 2. cp -a dsdt.hex to drivers/acpi/tables/acpi_dsdt.c
> >=20
> > 3. apply  the following patch
> >=20
> > --- linux/drivers/acpi/osl.c    Sat Jul 13 16:16:25 2002
> > +++ linux-2.4.18-xfs-acpi/drivers/acpi/osl.c    Sat Jul 13 14:33:09 200=
2
> > @@ -70,6 +70,7 @@
> >  static OSD_HANDLER acpi_irq_handler =3D NULL;
> >  static void *acpi_irq_context =3D NULL;
> >=20
> > +extern unsigned char AmlCode[];
> >=20
> >  acpi_status
> >  acpi_os_initialize(void)
> > @@ -221,7 +222,10 @@
> >         if (!existing_table || !new_table)
> >                 return AE_BAD_PARAMETER;
> >=20
> > -       *new_table =3D NULL;
> > +       if (strncmp(existing_table->signature, "DSDT", 4) =3D=3D 0)
> > +               *new_table =3D (acpi_table_header*)AmlCode;
> > +       else
> > +               *new_table =3D NULL;
> >         return AE_OK;
> >  }
> >=20
> >=20

--=20
John M. Trostel
Senior Software Engineer
Quantum Corp.
john.trostel-+vhbC7un7QRBDgjK7y7TUQ@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
