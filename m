From: Martin Siegert <siegert-z1KUqvL5UUQ@public.gmane.org>
Subject: Re: [Fwd: [PATCH] ACPI poweroff fixes for 2.4.26-pre2]
Date: Thu, 11 Mar 2004 15:00:47 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040311230047.GA20345@stikine.ucs.sfu.ca>
References: <1079031999.3679.1.camel@darkstar>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1079031999.3679.1.camel-4/PLUo9XfK8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thanks!

I tried to combine the two patches to apply to 2.4.25 and came up
with

--- linux-2.4.25/drivers/acpi/system.c.orig     Fri Nov 28 10:26:19 2003
+++ linux-2.4.25/drivers/acpi/system.c  Thu Mar 11 13:12:11 2004
@@ -40,6 +40,7 @@
 #include <asm/acpi.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
+#include <linux/sched.h>

 #ifdef CONFIG_X86
 #ifdef CONFIG_ACPI_SLEEP
@@ -95,6 +96,12 @@
 {
        if (unlikely(in_interrupt()))
                BUG();
+#ifdef CONFIG_SMP
+       /* Some SMP machines only can poweroff in boot CPU */
+       set_cpus_allowed(current, 1 << cpu_logical_map(0));
+#endif
+       pm_send_all(PM_SAVE_STATE, (void *)3);
+       pm_send_all(PM_SUSPEND, (void *)3);
        acpi_enter_sleep_state_prep(ACPI_STATE_S5);
        ACPI_DISABLE_IRQS();
        acpi_enter_sleep_state(ACPI_STATE_S5);

however, this still fails to poweroff the box.
Furthermore, I found the patch

--- 2.4.25/drivers/acpi/system.c        2004-03-08 09:29:30.925538440 +08=
00
+++ b/drivers/acpi/system.c     2004-03-08 09:36:19.813378040 +0800
@@ -40,6 +40,7 @@
 #include <asm/acpi.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
+#include <linux/sched.h>

 #ifdef CONFIG_X86
 #ifdef CONFIG_ACPI_SLEEP
@@ -95,6 +96,8 @@ acpi_power_off (void)
 {
        if (unlikely(in_interrupt()))
                BUG();
+       /* Some SMP machines only can poweroff in boot CPU */
+       set_cpus_allowed(current, 1UL << cpu_logical_map(0));
        acpi_enter_sleep_state_prep(ACPI_STATE_S5);
        ACPI_DISABLE_IRQS();
        acpi_enter_sleep_state(ACPI_STATE_S5);

which does not poweroff the system either (although CONFIG_ACPI_SLEEP=3Dy
is set in .config).=20

Martin

On Thu, Mar 11, 2004 at 07:07:14PM +0000, S=E9rgio Monteiro Basto wrote:
> you can try this one=20
>=20
> -----Forwarded Message-----
> > From: Willy Tarreau <willy-tRhHnHjXm5DYtjvyW6yDsg@public.gmane.org>
> > To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> > Cc: Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>, acpi-devel@lists.=
sourceforge.net, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
> > Subject: [ACPI] [PATCH] ACPI poweroff fixes for 2.4.26-pre2
> > Date: Wed, 10 Mar 2004 00:33:25 +0100
> >=20
> > Hi Pavel,
> >=20
> > On Mon, Mar 08, 2004 at 09:54:44PM +0100, Pavel Machek wrote:
> > > Can you replace
> > >=20
> > > acpi_system_save_state() with
> > >=20
> > >         pm_send_all(PM_SAVE_STATE, (void *)3);
> > >         pm_send_all(PM_SUSPEND, (void *)3);
> > >=20
> > > ?
> > >=20
> > > That should fix it, too, and does not depend on CONFIG_ACPI_SLEEP.
> >=20
> > Just checked, and I still can poweroff (which was a bit expected anyw=
ay, but
> > now confirmed). So with this little patch against 2.4.26-pre2, powero=
ff does
> > not depend on CONFIG_ACPI_SLEEP anymore, as you fairly requested (tha=
nk you
> > for having insisted).
> >=20
> >=20
> > diff -urN linux-2.4.26-pre2/drivers/acpi/system.c linux-2.4.26-pre2-p=
woff/drivers/acpi/system.c
> > --- linux-2.4.26-pre2/drivers/acpi/system.c	Wed Mar 10 00:36:20 2004
> > +++ linux-2.4.26-pre2-pwoff/drivers/acpi/system.c	Wed Mar 10 00:43:48=
 2004
> > @@ -45,13 +45,6 @@
> >  #include <linux/mc146818rtc.h>
> >  #include <linux/irq.h>
> >  #include <asm/hw_irq.h>
> > -
> > -acpi_status acpi_system_save_state(u32);
> > -#else
> > -static inline acpi_status acpi_system_save_state(u32 state)
> > -{
> > -	return AE_OK;
> > -}
> >  #endif /* !CONFIG_ACPI_SLEEP */
> > =20
> >  #define _COMPONENT		ACPI_SYSTEM_COMPONENT
> > @@ -99,7 +92,8 @@
> >  {
> >  	if (unlikely(in_interrupt()))=20
> >  		BUG();
> > -	acpi_system_save_state(ACPI_STATE_S5);
> > +	pm_send_all(PM_SAVE_STATE, (void *)3);
> > +	pm_send_all(PM_SUSPEND, (void *)3);
> >  	acpi_enter_sleep_state_prep(ACPI_STATE_S5);
> >  	ACPI_DISABLE_IRQS();
> >  	acpi_enter_sleep_state(ACPI_STATE_S5);
> >=20
> >=20
> > Len, do you have any objection against this one ?
> > BTW, did you get the previous one dedicated to SMP ? Here it is
> > rediffed after this one, just in case :
> >=20
> >=20
> > diff -urN linux-2.4.26-pre2-pwoff/drivers/acpi/system.c linux-2.4.26-=
pre2-pwoff-smp/drivers/acpi/system.c
> > --- linux-2.4.26-pre2-pwoff/drivers/acpi/system.c	Wed Mar 10 00:43:48=
 2004
> > +++ linux-2.4.26-pre2-pwoff-smp/drivers/acpi/system.c	Wed Mar 10 00:4=
4:26 2004
> > @@ -40,6 +40,7 @@
> >  #include <asm/acpi.h>
> >  #include <acpi/acpi_bus.h>
> >  #include <acpi/acpi_drivers.h>
> > +#include <linux/sched.h>
> > =20
> >  #ifdef CONFIG_ACPI_SLEEP
> >  #include <linux/mc146818rtc.h>
> > @@ -92,6 +93,10 @@
> >  {
> >  	if (unlikely(in_interrupt()))=20
> >  		BUG();
> > +#ifdef CONFIG_SMP
> > +	/* Some SMP machines only can poweroff in boot CPU */
> > +	set_cpus_allowed(current, 1 << cpu_logical_map(0));
> > +#endif
> >  	pm_send_all(PM_SAVE_STATE, (void *)3);
> >  	pm_send_all(PM_SUSPEND, (void *)3);
> >  	acpi_enter_sleep_state_prep(ACPI_STATE_S5);
> >=20
> >=20
> > Cheers,
> > Willy
> >=20
>=20
> --=20
> S=E9rgio M. B.
>=20

--=20
Martin Siegert
Manager, Research Services
WestGrid Site Manager
Academic Computing Services                        phone: (604) 291-4691
Simon Fraser University                            fax:   (604) 291-4242
Burnaby, British Columbia                          email: siegert-z1KUqvL5UUQ@public.gmane.org
Canada  V5A 1S6


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
