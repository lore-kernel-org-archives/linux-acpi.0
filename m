From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: acpi-problem with samsung x10 1700
Date: Fri, 19 Dec 2003 10:43:06 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC892F@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "D. S." <silent.bob-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

AML is like C -- if there is no return statement from a routine (method)
then nothing gets returned.

Unfortunately the microsoft implementation of the AML interpreter
behaves as if there is a return statement, and so bugs in AML get
through windows validation.

For this to work on the ACPICA AML interpreter, you need to insert the
missing return statements in the AML -- we don't have a workaround for
this type of BIOS bug.

-Len

> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of D. S.
> Sent: Friday, December 19, 2003 10:10 AM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] acpi-problem with samsung x10 1700
>=20
>=20
> hi folks,
> maybe you folks could help me out.
> i fixed the dsdt.aml so far that iasl compiles without an error.
> so far so good.
>=20
> now dmesg gives me the following:
>=20
> acpi-1121: error:method execution failed [\SB_.ADP1._STA] (Node
> c1613920), AE_AML_NO_RETURN_VALUE
> acpi-1121: error:method execution failed [\SB_.BAT1._STA] (Node
> c1613a20), AE_AML_NO_RETURN_VALUE
>=20
> this means, if i'm correct, that the stats for battery and ac-adapter
> can't be read.
> i am not sure where to correct this and how.
>=20
> so you maybe need some info on the machine/dist.
> samsung x10 xtc1700
> bios 06ye (samsung orginal shipped)
> suse 9.0 (wich is patched already for reading dsdt)
>=20
> help would be great!
>=20
> regards
> d.
>=20
> Some programming languages manage to absorb change, but withstand
> progress. -- Epigrams in Programming, ACM SIGPLAN Sept. 1982
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign=20
> up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell=20
> to sys admin.
> Click now! =
http://ads.osdn.com/?ad_id=3D1278&alloc_id=3D3371&op=3Dclick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
