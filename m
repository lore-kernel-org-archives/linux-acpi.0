From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: ACPI: S3 and PAE do not like each other for now, S3 disabled.
Date: Wed, 28 Jul 2004 11:45:13 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040728094513.GA20302@atrey.karlin.mff.cuni.cz>
References: <B44D37711ED29844BEA67908EAF36F036BD577@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <B44D37711ED29844BEA67908EAF36F036BD577-4yWAQGcml65pB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> The patch is very sample. Tested in one desktop (Dell precision
> 350).

Its wordwrapped, but looks good. If it worked once, its probably safe
;-).

								Pavel


> ===== arch/i386/kernel/acpi/sleep.c 1.4 vs edited =====
> --- 1.4/arch/i386/kernel/acpi/sleep.c	2003-08-06 02:29:57 +08:00
> +++ edited/arch/i386/kernel/acpi/sleep.c	2004-07-28 17:15:45
> +08:00
> @@ -77,10 +77,7 @@ void __init acpi_reserve_bootmem(void)
>  		printk(KERN_ERR "ACPI: Wakeup code way too big, S3
> disabled.\n");
>  		return;
>  	}
> -#ifdef CONFIG_X86_PAE
> -	printk(KERN_ERR "ACPI: S3 and PAE do not like each other for
> now, S3 disabled.\n");
> -	return;
> -#endif
> +
>  	acpi_wakeup_address = (unsigned
> long)alloc_bootmem_low(PAGE_SIZE);
>  	if (!acpi_wakeup_address)
>  		printk(KERN_ERR "ACPI: Cannot allocate lowmem, S3
> disabled.\n");
> 
> 
> >-----Original Message-----
> >From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> >admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Pavel Machek
> >Sent: Wednesday, July 28, 2004 4:29 PM
> >To: Li, Shaohua
> >Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >Subject: Re: [ACPI] ACPI: S3 and PAE do not like each other for now, S3
> >disabled.
> >
> >Hi!
> >
> >> I did test it in my desktop (disabling HT and removing the check),
> and
> >> it worked. Is there any special reason that you disabled it before?
> >
> >That reason no longer applies. Can you submit a patch?
> >								Pavel
> >
> >--
> >People were complaining that M$ turns users into beta-testers...
> >...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
> >
> >
> >-------------------------------------------------------
> >This SF.Net email is sponsored by BEA Weblogic Workshop
> >FREE Java Enterprise J2EE developer tools!
> >Get your free copy of BEA WebLogic Workshop 8.1 today.
> >http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
> >_______________________________________________
> >Acpi-devel mailing list
> >Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >https://lists.sourceforge.net/lists/listinfo/acpi-devel



-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
