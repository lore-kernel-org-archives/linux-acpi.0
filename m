From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] be more silent if !CONFIG_ACPI_BOOT
Date: Fri, 15 Aug 2003 13:05:18 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FC5A@hdsmsx402.hd.intel.com>
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
To: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Good catch.
Indeed, more than the printk's can be #ifdef'd out in this case -- I'll
do so in my next update.

Thanks,
-Len


> -----Original Message-----
> From: Dominik Brodowski [mailto:linux-JhLEnvuH02M@public.gmane.org]=20
> Sent: Friday, August 15, 2003 11:35 AM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Grover, Andrew
> Subject: [ACPI] [PATCH] be more silent if !CONFIG_ACPI_BOOT
>=20
>=20
> A message "ACPI disabled" makes no sense if ACPI isn't even=20
> compiled into
> the kernel.
>=20
> 	Dominik
>=20
> --- linux-2.6.0-test3+2/arch/i386/kernel/dmi_scan.c.original=09
> 2003-08-15 17:02:04.000000000 +0200
> +++ linux-2.6.0-test3+2/arch/i386/kernel/dmi_scan.c=09
> 2003-08-15 17:04:42.000000000 +0200
> @@ -1014,8 +1014,10 @@
>  			else if (year < 1 || (year > 90 && year <=3D 99))
>  				disable =3D 1;=20
>  			if (disable && !acpi_force) {=20
> +#ifdef ACPI_BOOT	=09
>  				printk(KERN_NOTICE "ACPI=20
> disabled because your bios is from %s and too old\n", s);
>  				printk(KERN_NOTICE "You can=20
> enable it with acpi=3Dforce\n");
> +#endif	// CONFIG_ACPI_BOOT
>  				acpi_disabled =3D 1;=20
>  			}=20
>  		}
>=20
>=20
> -------------------------------------------------------
> This SF.Net email sponsored by: Free pre-built ASP.NET sites including
> Data Reports, E-commerce, Portals, and Forums are available now.
> Download today and enter to win an XBOX or Visual Studio .NET.
> http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet
> _072303_01/01
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
