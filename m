From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI disappears silently if !CONFIG_X86_LOCAL_APIC
Date: Fri, 15 Aug 2003 13:40:04 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FC5B@hdsmsx402.hd.intel.com>
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

Dominik,
I think your patch is correct, and I'll include it in my next update.

CONFIG_ACPI_HT, as you can see, is really just an alias for
CONFIG_ACPI_BOOT.  It is necessary, but not suficient to enable HT.
CONFIG_SMP is also needed to enable > 1 processor, and it will bring
with it CONFIG_X86_LOCAL_APIC -- so CONFIG_ACPI_HT doesn't need to
depend on it -- and it should be possible to exclude LAPIC code and
still run ACPI.

Thanks for the catch.

-Len

Ps.
Does your laptop really have no LAPIC, or you just prefer to not use
LAPIC?
Note that even if the system has no IOAPIC, the LAPIC is used for timer
interrupts.  On a laptop w/o IOAPIC, you'd see this in the boot
messages:

Found and enabled local APIC!
...
Using local APIC timer interrupts.
calibrating APIC timer ...

> -----Original Message-----
> From: Dominik Brodowski [mailto:linux-JhLEnvuH02M@public.gmane.org]=20
> Sent: Friday, August 15, 2003 11:34 AM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Grover, Andrew
> Subject: [ACPI] ACPI disappears silently if !CONFIG_X86_LOCAL_APIC
>=20
>=20
> On some systems where ACPI used to work fine, APIC support is=20
> not really=20
> needed in the kernel because the mobile chipset/processor=20
> doesn't support
> it. Nonetheless, in 2.6.0-test3-bk-current, CONFIG_ACPI depends on
> CONFIG_X86_LOCAL_APIC. As it's only a requirement for=20
> ACPI_HT, this patch
> should be fine [it compiles and it works on my notebook].
>=20
> 	Dominik
>=20
> --- linux-2.6.0-test3+2/drivers/acpi/Kconfig.original=09
> 2003-08-15 16:48:16.000000000 +0200
> +++ linux-2.6.0-test3+2/drivers/acpi/Kconfig	2003-08-15=20
> 16:53:56.000000000 +0200
> @@ -30,7 +30,7 @@
>  	bool "Full ACPI Support"
>  	depends on !X86_VISWS
>  	depends on !IA64_HP_SIM
> -	depends on IA64 || (X86 && ACPI_HT)
> +	depends on IA64 || (X86 && ACPI_HT) || (X86 && !X86_LOCAL_APIC)
>  	default y
>  	---help---
>  	  Advanced Configuration and Power Interface (ACPI) support for=20
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
