From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: [PATCH] ACPI poweroff fixes for 2.4.26-pre2
Date: Sun, 14 Mar 2004 15:51:31 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1079279490.10225.10.camel@darkstar>
References: <20040308163452.GE5352@openzaurus.ucw.cz>
	 <Pine.LNX.4.44.0403081515190.10436-100000@dmt.cyclades>
	 <20040308183228.GD484@elf.ucw.cz> <20040308201411.GA18636@alpha.home.local>
	 <20040308205444.GH484@elf.ucw.cz> <20040309233325.GA22953@alpha.home.local>
Reply-To: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040309233325.GA22953-HkMpAodKYdnXX8ko2wsARw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Willy Tarreau <willy-tRhHnHjXm5DYtjvyW6yDsg@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Martin Siegert <siegert-z1KUqvL5UUQ@public.gmane.org>, hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-03-09 at 23:33, Willy Tarreau wrote:
> On Mon, Mar 08, 2004 at 09:54:44PM +0100, Pavel Machek wrote:
> > Can you replace
> >=20
> > acpi_system_save_state() with
> >         pm_send_all(PM_SAVE_STATE, (void *)3);
> >         pm_send_all(PM_SUSPEND, (void *)3);
> > ?
> > That should fix it, too, and does not depend on CONFIG_ACPI_SLEEP.

Patch 1:
> diff -urN linux-2.4.26-pre2/drivers/acpi/system.c linux-2.4.26-pre2-pwoff=
/drivers/acpi/system.c
> --- linux-2.4.26-pre2/drivers/acpi/system.c	Wed Mar 10 00:36:20 2004
> +++ linux-2.4.26-pre2-pwoff/drivers/acpi/system.c	Wed Mar 10 00:43:48 200=
4
> @@ -45,13 +45,6 @@
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
> @@ -99,7 +92,8 @@
>  {
>  	if (unlikely(in_interrupt()))=20
>  		BUG();
> -	acpi_system_save_state(ACPI_STATE_S5);
> +	pm_send_all(PM_SAVE_STATE, (void *)3);
> +	pm_send_all(PM_SUSPEND, (void *)3);
>  	acpi_enter_sleep_state_prep(ACPI_STATE_S5);
>  	ACPI_DISABLE_IRQS();
>  	acpi_enter_sleep_state(ACPI_STATE_S5);
>=20
>=20
> Len, do you have any objection against this one ?
> BTW, did you get the previous one dedicated to SMP ? Here it is
> rediffed after this one, just in case :

Patch 2:
> diff -urN linux-2.4.26-pre2-pwoff/drivers/acpi/system.c linux-2.4.26-pre2=
-pwoff-smp/drivers/acpi/system.c
> --- linux-2.4.26-pre2-pwoff/drivers/acpi/system.c	Wed Mar 10 00:43:48 200=
4
> +++ linux-2.4.26-pre2-pwoff-smp/drivers/acpi/system.c	Wed Mar 10 00:44:26=
 2004
> @@ -40,6 +40,7 @@
>  #include <asm/acpi.h>
>  #include <acpi/acpi_bus.h>
>  #include <acpi/acpi_drivers.h>
> +#include <linux/sched.h>
> =20
>  #ifdef CONFIG_ACPI_SLEEP
>  #include <linux/mc146818rtc.h>
> @@ -92,6 +93,10 @@
>  {
>  	if (unlikely(in_interrupt()))=20
>  		BUG();
> +#ifdef CONFIG_SMP
> +	/* Some SMP machines only can poweroff in boot CPU */
> +	set_cpus_allowed(current, 1 << cpu_logical_map(0));
> +#endif
>  	pm_send_all(PM_SAVE_STATE, (void *)3);
>  	pm_send_all(PM_SUSPEND, (void *)3);
>  	acpi_enter_sleep_state_prep(ACPI_STATE_S5);

Hi=20
the patch 1 can't be applied because=20
we still have on line 341 of drivers/acpi/system.c :
    status =3D acpi_system_save_state(state);

the patch 2 has been applied on acpi-20040311-2.4.26.diff.gz,
   [ACPI] SMP poweroff (David Shaohua Li)
   http://bugzilla.kernel.org/show_bug.cgi?id=3D1141
and is a little different:
+       /* Some SMP machines only can poweroff in boot CPU */
+       set_cpus_allowed(current, 1UL << cpu_logical_map(0));
                                  ^^^

have you some suggestion for correction of patch 1 ?

thanks
--=20
S=E9rgio M. B.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
