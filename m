From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: latest ACPI CA Patch (20040311) - Where??
Date: Sat, 13 Mar 2004 02:03:10 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1079143284.4097.10.camel@darkstar>
References: <C386328088ED7F4E9F81AFBABDDF60DA04A92629@wdmyexch02.my.asia.wdc.com>
Reply-To: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <C386328088ED7F4E9F81AFBABDDF60DA04A92629-Yw6hFe9C1vnHQcBQSaPqJq0fmWJ9l57d0E9HWUfgJXw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ow Mun Heng <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Well, you have to wait for patch be integrated in kernel.
But you can begin teste new ACPICA sub system and see if can read
correctly your DSDT or if not, you can override the DSDT write in your
computer BIOS(?).
in http://developer.intel.com/technology/iapc/acpi/downloads.htm
basically in Unix ACPI CA - Unix Build Environment
and you have to wait that Intel updates his page :)
you have to do:
cd compiler=20
make
to get iasl tool
cheers,
On Fri, 2004-03-12 at 03:32, Ow Mun Heng wrote:
> Hi All,
>=20
> Received this  based on bug #2066
>=20
> http://bugme.osdl.org/show_bug.cgi?id=3D2066
>=20
> I would like to try it out. I can't seem to find it on the DL/sourceforge
> site. All I could find was 20040220 based on 2.6.4 kernel.
>=20
> BTW, I'm using 2.6.3 and 20040211 patch and the few patches from Luming=20
> for this bug.
>=20
> ------- Additional Comments From Robert.Moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org  2004-03-11 14:55
> -------
>=20
> Should be fixed in CA version 20040311:
>=20
>=20
> Fixed a problem where errors occurring during the parse phase of control=20
> method execution did not abort cleanly.  For example, objects created and=
=20
> installed in the namespace were not deleted.  This caused all subsequent=20
> invocations of the method to return the AE_ALREADY_EXISTS exception.
>=20
> Implemented a mechanism to force a control method to "Serialized" executi=
on
> if=20
> the method attempts to create namespace objects. (The root of the=20
> AE_ALREADY_EXISTS problem.)
>=20
> =3D----------------------------------
>=20
> Cheers,                                                 .^.
> Mun Heng, Ow                                            /V\
> H/M Engineering                                       /(   )\
> Western Digital M'sia                                  ^^-^^
> DID : 03-7870 5168                          The Linux Advocate
>=20
>        =20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=3Dclick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
--=20
S=E9rgio M. B.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
