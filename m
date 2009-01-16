From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] PM: Fix compilation warning in kernel/power/main.c
Date: Fri, 16 Jan 2009 18:14:07 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901161813480.31281@localhost.localdomain>
References: <200901170010.45699.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:47643 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763597AbZAPXOL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jan 2009 18:14:11 -0500
In-reply-to: <200901170010.45699.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

applied

thanks,
--
Len Brown, Intel Open Source Technology Center

On Sat, 17 Jan 2009, Rafael J. Wysocki wrote:

> 
> Reorder the code in kernel/power/main.c to fix compilation warning
> triggered by unsetting CONFIG_SUSPEND.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  kernel/power/main.c |   26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> Index: linux-2.6/kernel/power/main.c
> ===================================================================
> --- linux-2.6.orig/kernel/power/main.c
> +++ linux-2.6/kernel/power/main.c
> @@ -57,16 +57,6 @@ int pm_notifier_call_chain(unsigned long
>  #ifdef CONFIG_PM_DEBUG
>  int pm_test_level = TEST_NONE;
>  
> -static int suspend_test(int level)
> -{
> -	if (pm_test_level == level) {
> -		printk(KERN_INFO "suspend debug: Waiting for 5 seconds.\n");
> -		mdelay(5000);
> -		return 1;
> -	}
> -	return 0;
> -}
> -
>  static const char * const pm_tests[__TEST_AFTER_LAST] = {
>  	[TEST_NONE] = "none",
>  	[TEST_CORE] = "core",
> @@ -125,14 +115,24 @@ static ssize_t pm_test_store(struct kobj
>  }
>  
>  power_attr(pm_test);
> -#else /* !CONFIG_PM_DEBUG */
> -static inline int suspend_test(int level) { return 0; }
> -#endif /* !CONFIG_PM_DEBUG */
> +#endif /* CONFIG_PM_DEBUG */
>  
>  #endif /* CONFIG_PM_SLEEP */
>  
>  #ifdef CONFIG_SUSPEND
>  
> +static int suspend_test(int level)
> +{
> +#ifdef CONFIG_PM_DEBUG
> +	if (pm_test_level == level) {
> +		printk(KERN_INFO "suspend debug: Waiting for 5 seconds.\n");
> +		mdelay(5000);
> +		return 1;
> +	}
> +#endif /* !CONFIG_PM_DEBUG */
> +	return 0;
> +}
> +
>  #ifdef CONFIG_PM_TEST_SUSPEND
>  
>  /*
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
