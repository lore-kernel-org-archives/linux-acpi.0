From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: acpi_serialize not working?
Date: Thu, 9 Sep 2004 15:55:13 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <37F890616C995246BE76B3E6B2DBE05501F537BE@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andreas Dieling <snow-1pFVYSAoaJAREI5ypv3d1g@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The implementation of the forced serialization is straightforward:

    if (AcpiGbl_AllMethodsSerialized)
    {
        ObjDesc->Method.Concurrency =3D 1;
        ObjDesc->Method.MethodFlags |=3D AML_METHOD_SERIALIZED;
    }

I would be interested in more information on the failure.


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Andreas Dieling
> Sent: Thursday, September 09, 2004 6:15 AM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] acpi_serialize not working?
>=20
> Hi,
>=20
> i have an Asus M6N notebook. Me and other M6N users have the problem
that
> the
> fan sometimes stops working which results in an overheating of the
system.
> The problem occurs under Linux and under Windows.
>=20
> After much investigation i could figure out the problem:
>=20
> It is a problem with concurrently appearing acpi events. If i am
reading
> cpu
> temperature via acpi in an endless loop and the fan is switching on
> collateral the fan controll and temperature readout is crashing and
left
> non-functional.
>=20
> After i patched the dsdt and marked all aml methods as "Serialized"
the
> problem doesn't occur anymore :-)
>=20
> Since other M6N users may not want to patch their dsdt i tested
> acpi_serialize
> as a kernel option. I thought it should have the same effect, but it
> doesn't
> seem to work because the fan/temperatur problem occured again...
>=20
> Is this a bug or has the acpi_serialize option a different purpose?
>=20
> thx Andreas
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by BEA Weblogic Workshop
> FREE Java Enterprise J2EE developer tools!
> Get your free copy of BEA WebLogic Workshop 8.1 today.
> http://ads.osdn.com/?ad_id=3D5047&alloc_id=3D10808&op=3Dclick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
