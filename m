From: "Ow Mun Heng" <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Subject: RE: Suspend to ram broken for me with 2.6.5-mm3 (2.6.4 worked)
Date: Mon, 12 Apr 2004 09:36:34 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C386328088ED7F4E9F81AFBABDDF60DA04F67BF3@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: crazy-b-Mmb7MZpHnFY@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org]On Behalf Of=20
> Peter Meier
> Sent: Saturday, April 10, 2004 11:22 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] Suspend to ram broken for me with 2.6.5-mm3 (2.6.4
> worked)
>=20
>=20
> Hi,                                                          =20
>                                                                   =20
> actually, I'm not abled to wake up from suspend to ram with 2.6.5-mm3.
> Monitor stays black, fans are making noise forever, but=20
> nothing. Network
> is dead, too.
>                                                              =20
>                                                              =20
>   I had no problems with suspend to ram untill 2.6.4 (X with=20
> in10, unload usb and sound before sleep, use the fixpci=20
> script of Stefan D=F6singer to get sound working after a wake=20
> up). I did not change any kernel configuration options or=20
> anything else. 2.6.5-rc2-mm5, 2.6.5-rc3-mm4 have the same=20
> problems, as 2.6.5-rc3-mm1, as all 2.6.5-mm*. So somewhere=20
> between 2.6.4 and 2.6.5-rc2 something changed which broke it for me.

Same experience here with 2.6.5-rc2-mm5.
I've asked around and it's stated that there's some problem code
on the vm (or something, I can't remember)

Still on 2.6.3


>=20
> The only difference I noticed so far is, with the 'broken' kernels, I
> see "PM Entering state" as last thing before the system goes to sleep.
> With the working kernels, I see more lines before the "PM Entering
> state" and system goes to sleep (something with hda, acpi,=20
> etc., several
> lines)
>=20
> Notebook is an Acer Travelmate 803 (Radeon Mobility 9000, Centrino).
> I'll provide further details on request.
>=20
> With best regards,
> Peter
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> =
administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dcli=
ck
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
