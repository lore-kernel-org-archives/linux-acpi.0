From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: [PATCH] ACPI poweroff fixes for 2.4.26-pre2
Date: Mon, 15 Mar 2004 22:23:54 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1079389434.3695.2.camel@darkstar>
References: <20040308163452.GE5352@openzaurus.ucw.cz>
	 <Pine.LNX.4.44.0403081515190.10436-100000@dmt.cyclades>
	 <20040308183228.GD484@elf.ucw.cz> <20040308201411.GA18636@alpha.home.local>
	 <20040308205444.GH484@elf.ucw.cz> <20040309233325.GA22953@alpha.home.local>
	 <1079279490.10225.10.camel@darkstar>
	 <20040315210729.GA19306@alpha.home.local>
Reply-To: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040315210729.GA19306-HkMpAodKYdnXX8ko2wsARw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Willy Tarreau <willy-tRhHnHjXm5DYtjvyW6yDsg@public.gmane.org>
Cc: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi=20
On Mon, 2004-03-15 at 21:07, Willy Tarreau wrote:
> --- linux-2.4.26-pre3-acpi/drivers/acpi/system.c	Mon Mar 15 21:54:55 2004
> +++ linux-2.4.26-pre3-acpi-pwoff/drivers/acpi/system.c	Mon Mar 15 21:57:3=
2 2004
> @@ -46,13 +46,6 @@
>  #include <linux/mc146818rtc.h>
>  #include <linux/irq.h>
>  #include <asm/hw_irq.h>
> -
> -acpi_status acpi_system_save_state(u32);
> -#else
> -static inline acpi_status acpi_system_save_state(u32 state)
> -{
> -	return AE_OK;
> -}
>  #endif /* !CONFIG_ACPI_SLEEP */
> =20
>  #define _COMPONENT		ACPI_SYSTEM_COMPONENT
> @@ -102,7 +95,8 @@
>  		BUG();
>  	/* Some SMP machines only can poweroff in boot CPU */
>  	set_cpus_allowed(current, 1UL << cpu_logical_map(0));
> -	acpi_system_save_state(ACPI_STATE_S5);
> +	pm_send_all(PM_SAVE_STATE, (void *)3);
> +	pm_send_all(PM_SUSPEND, (void *)3);
>  	acpi_enter_sleep_state_prep(ACPI_STATE_S5);
>  	ACPI_DISABLE_IRQS();
>  	acpi_enter_sleep_state(ACPI_STATE_S5);


and status =3D acpi_system_save_state(state);=20
on line 341 of drivers/acpi/system.c ?
    =20
--=20
S=E9rgio M. B.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
