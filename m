From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Compaq Evo 510SFF and ACPI
Date: Sun, 13 Jul 2003 17:33:09 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EE86@orsmsx401.jf.intel.com>
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
To: Scott Duplichan <sduplichan-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, Alexander Hoogerhuis <alexh-rpjHciJLgqZBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, gone-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

from include/linux/acpi.h:

struct acpi_table_rsdt {
	struct acpi_table_header header;
	u32			entry[8];
} __attribute__ ((packed));

The RSDT actually contains an arbitrary number of entries. The precise
number is determined by the length, which is in the header. The typical
C way to accommodate this is to define an array of length 1 and then
using the (theoretically) undefined behavior of accessing beyond the end
of the array to access subsequent elements.

So, the correct fix is that that should be "entry[1]" above, and the
length check in srat.c can just go away, I think.

Regards -- Andy

> -----Original Message-----
> From: Scott Duplichan [mailto:sduplichan-/E1597aS9LQAvxtiuMwx3w@public.gmane.org]=20
> Sent: Friday, July 04, 2003 4:58 AM
> To: Alexander Hoogerhuis
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] Compaq Evo 510SFF and ACPI
>=20
>=20
>=20
> --- Alexander Hoogerhuis <alexh-rpjHciJLgqZBDgjK7y7TUQ@public.gmane.org> wrote:
> > Scott Duplichan <sduplichan-/E1597aS9LQAvxtiuMwx3w@public.gmane.org> writes:
> >=20
> > > Alexander Hoogerhuis <alexh-KJKxBnNiUAU@public.gmane.org> wrote:
> > >=20
> > > >I have a few Compaq Evo's that show the same symptom:
> > > >=20
> > > > ACPI: Searched entire block, no RSDP was found.
> > > > ACPI: RSDP located at physical address c00eaa10
> > > > RSD PTR  v0 [COMPAQ]
> > > > __va_range(0xf7f7b40, 0x68): idx=3D10 mapped at ffff5000
> > > > ACPI table found: RSDT v1 [COMPAQ CPQ0050  8194.4656]
> > > > ACPI: Too big length in RSDT: 120
> > >=20
> > > 120 bytes minus 36 bytes leaves 84 bytes, or 21 table pointers.
> > > I think some versions of Linux have a limit on the number of
> > > tables that is smaller than 21. The ACPI spec lacks, among other
> > > things, any guideline on what the maximum number of tables is.
> > >=20
> >=20
> > Here's the offending piece of code:
> >=20
> >         /*
> >          * The number of tables is computed by taking the
> >          * size of all entries (header size minus total
> >          * size of RSDT) divided by the size of each entry
> >          * (4-byte table pointers).
> >          */
> >         tables =3D (header->length - sizeof(acpi_table_header)) / 4;
> >                                                            =20
>                    =20
> >         memcpy(&saved_rsdt, rsdt, sizeof(saved_rsdt));
> >                                                            =20
>                    =20
> >         if (saved_rsdt.header.length > sizeof(saved_rsdt)) {
> >                 printk(KERN_WARNING "ACPI: Too big length=20
> in RSDT: %d\n",
> > saved_rsdt.header.length);
> >                 return -ENODEV;
> >         }
> >=20
> > ...which then basically says what it found doesnt add up to what it
> > thinks it has?
> >=20
> > mvh,
> > A
> > --=20
> > Alexander Hoogerhuis                               |=20
> alexh-rpjHciJLgqZBDgjK7y7TUQ@public.gmane.org
> > CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
> > "You have zero privacy anyway. Get over it."  --Scott McNealy
>=20
> I believe the problem is that 'saved_rsdt' is smaller than=20
> the EVO rsdt.
> If I am looking at the correct source code, the maximum number of
> tables supported is ACPI_TABLE_COUNT, which is 17. That number is
> based on the assumption that there is at most one table of each type.
> But that assumption is not valid for the EVO 510, because it has many
> SSDT tables, for a total of 21 tables.
>=20
> --=20
> Scott
>=20
>=20
> __________________________________
> Do you Yahoo!?
> SBC Yahoo! DSL - Now only $29.95 per month!
> http://sbc.yahoo.com
>=20
>=20
> -------------------------------------------------------
> This SF.Net email sponsored by: Free pre-built ASP.NET sites including
> Data Reports, E-commerce, Portals, and Forums are available now.
> Download today and enter to win an XBOX or Visual Studio .NET.
> http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_06
> 1203_01/01
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
