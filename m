From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI fail in kernel 2.4.25 and 2.6.3
Date: 25 Feb 2004 16:06:58 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1077742905.5913.475.camel@dhcppc4>
References: <A6974D8E5F98D511BB910002A50A6647615F316E@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F316E-N2PTB0HCzHJF3Yvz3xaN/VDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Javier Gonzalez <javi-UMxcb9VqC+E@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Javier,
yes, we've seen this regression on other systems.
Perhaps you can help us debug it -- we need the output of acpidmp from a
failing system attached to this bug report.

Battery status regression -- AE_ALREADY_EXISTS
http://bugme.osdl.org/show_bug.cgi?id=3D2066

thanks,
-Len

On Tue, 2004-02-24 at 18:09, Javier Gonzalez wrote:
> Hi!
>=20
> Recently I have upgraded my kernel from 2.4.22-AlanCoxPatch. I have an
> Acer Travelmate 290LMi laptop (Centrino). All worked well with 2.4.22
> but i have problems with new kernels.
>=20
> With 2.4.25 + cpufreq patch from
> ftp://ftp.linux.org.uk/pub/linux/cpufreq/ and a few minutes after boot
> (when i try to know battery state with acpi command) i get this
> "bucle"
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
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
