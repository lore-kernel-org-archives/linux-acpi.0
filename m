From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Fw: ACPI fail in kernel 2.4.25 and 2.6.3
Date: Wed, 25 Feb 2004 10:50:34 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401CBB6E2@PDSMSX403.ccr.corp.intel.com>
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
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

To identify whether this is regression, I suggest to have kernel =
2.6.0-test11=20
with the following patches a try. =20

1) http://bugzilla.kernel.org/attachment.cgi?id=3D1690&action=3Dview
2) http://bugzilla.kernel.org/attachment.cgi?id=3D1774&action=3Dview
3) http://bugzilla.kernel.org/attachment.cgi?id=3D1796&action=3Dview

--Luming

> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
> Andrew Morton
> Sent: Wednesday, February 25, 2004 9:26 AM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] Fw: ACPI fail in kernel 2.4.25 and 2.6.3
>=20
>=20
>=20
>=20
> Begin forwarded message:
>=20
> Date: Wed, 25 Feb 2004 00:09:27 +0100
> From: Javier Gonzalez <javi-UMxcb9VqC+E@public.gmane.org>
> To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: ACPI fail in kernel 2.4.25 and 2.6.3
>=20
>=20
> Hi!
>=20
> Recently I have upgraded my kernel from 2.4.22-AlanCoxPatch. I have an
> Acer Travelmate 290LMi laptop (Centrino). All worked well with 2.4.22
> but i have problems with new kernels.
>=20
> With 2.4.25 + cpufreq patch from
> ftp://ftp.linux.org.uk/pub/linux/cpufreq/ and a few minutes after boot
> (when i try to know battery state with acpi command) i get=20
> this "bucle"
> error:
>=20
> Feb 24 23:47:00 localhost kernel: acpi_battery-0195 [1619]
> acpi_battery_get_statu: Error evaluating _BST
> Feb 24 23:47:01 localhost kernel:  dswload-0279: *** Error: Looking up
> [PBST] in namespace, AE_ALREADY_EXISTS
> Feb 24 23:47:01 localhost kernel:  psparse-0588 [1626]
> ps_parse_loop         : During name lookup/catalog, AE_ALREADY_EXISTS
> Feb 24 23:47:01 localhost kernel:  psparse-1120: *** Error: Method
> execution failed [\_SB_.PCI0.LPC0.BAT1._BST] (Node c1562528),
> AE_ALREADY_EXISTS
>=20
> I tried with 2.6.3 and y get the same error :-(=20
>=20
> I have twho friends with diferents laptops who have the same problem.
>=20
> Thank for your help.
>=20
> --=20
> Un saludo:
>=20
>                             Javier Gonz=E1lez
>                    GNU/Linux registered user #302650
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20
>=20
>=20
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id=1356&alloc_id438&op=3Dick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
