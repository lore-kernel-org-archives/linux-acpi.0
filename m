From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Inconsistent contents of /proc/acpi/sleep and /sys/power/state
Date: Thu, 4 Aug 2005 23:43:33 +0200
Message-ID: <20050804214333.GE1780@elf.ucw.cz>
References: <20050725090421.GA24084@tangens.sinus.cz> <20050725160531.GB1046@openzaurus.ucw.cz> <20050803174846.GA17023@tangens.sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050803174846.GA17023-hxMeMO63rIAUgFT2KJq8fg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > >   I would like to ask, why the contents of /proc/acpi/sleep and /sys/power/state
> > > is different:
> > > 
> > > root@miro:~# cat /proc/acpi/sleep
> > > S0 S3 S4 S5
> > > root@miro:~# cat /sys/power/state
> > > standby mem disk
> > > 
> > >   The first one corresponds with a real functionality - for example, in dmesg
> > > there is the line
> > > ACPI: (supports S0 S3 S4 S5)
> > > on my notebook.
> > >   The second one seems to be wrong: There is "standby", although I have neither
> > > S1 nor S2 capable system - and it's really not working, and S5 is missing
> > > (should there be something like "off" in /sys/power/state ?).
> > >   I'm asking because /proc/acpi/sleep has been obsoletized in latest kernels and
> > > IMHO /sys/power/state is not a fully-featured and working replacement.
> > > 
> > 
> > Agreed, feel free to submit a patch.
> > 				Pavel
> Hi!
>   OK, here it is.
>   It does 2 things:
>   1) It adds "on" (S0) and "off" (S5) state names. Maybe "on" is a bit
> questionable, because it doesn't add any real functionality, but it's there in
> /proc/acpi/sleep and I think that it is a valid system state, so it should be
> there, although requesting it has no sense.

"on" really should not be there.

>   2) It disables printout as well as processing of states which are not
> supported by the system. However, I know how to get the list of supported S
> states only from the acpi/sleep subsystem, by reading sleep_states[], defined
> in acpi/sleep/main.c. So this functionality is #ifdef'ed by CONFIG_ACPI_SLEEP.
> If there is a more generic method of getting this information, let me know and
> I will remake the patch.

It hooks with acpi in a pretty ugly way, and the code has changed in
-mm [I believe] that it will not apply, anyway. Also please make
patches applicable with -p1.
								Pavel


> --- main.c.org	2005-08-03 18:03:42.000000000 +0200
> +++ main.c	2005-08-03 19:22:12.000000000 +0200
> @@ -19,6 +19,10 @@
>  
>  #include "power.h"
>  
> +#ifdef CONFIG_ACPI_SLEEP
> +extern u8 sleep_states[];
> +#endif
> +
>  /*This is just an arbitrary number */
>  #define FREE_PAGE_NUMBER (100)
>  
> @@ -144,9 +148,11 @@
>  
>  
>  static char * pm_states[] = {
> +	[PM_SUSPEND_ON]		= "on",
>  	[PM_SUSPEND_STANDBY]	= "standby",
>  	[PM_SUSPEND_MEM]	= "mem",
>  	[PM_SUSPEND_DISK]	= "disk",
> +	[PM_SUSPEND_MAX]	= "off",
>  	NULL,
>  };
>  
> @@ -234,8 +240,12 @@
>  	int i;
>  	char * s = buf;
>  
> -	for (i = 0; i < PM_SUSPEND_MAX; i++) {
> +	for (i = 0; i <= PM_SUSPEND_MAX; i++) {
> +#ifdef CONFIG_ACPI_SLEEP
> +		if (pm_states[i] && sleep_states[i])
> +#else
>  		if (pm_states[i])
> +#endif
>  			s += sprintf(s,"%s ",pm_states[i]);
>  	}
>  	s += sprintf(s,"\n");
> @@ -253,11 +263,15 @@
>  	p = memchr(buf, '\n', n);
>  	len = p ? p - buf : n;
>  
> -	for (s = &pm_states[state]; state < PM_SUSPEND_MAX; s++, state++) {
> +	for (s = &pm_states[state]; state <= PM_SUSPEND_MAX; s++, state++) {
>  		if (*s && !strncmp(buf, *s, len))
>  			break;
>  	}
> +#ifdef CONFIG_ACPI_SLEEP
> +	if (*s && sleep_states[state])
> +#else
>  	if (*s)
> +#endif
>  		error = enter_state(state);
>  	else
>  		error = -EINVAL;


-- 
if you have sharp zaurus hardware you don't need... you know my address


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
