From: Mark Lord <lkml@rtr.ca>
Subject: Re: + restore-missing-sysfs-max_cstate-attr.patch added to -mm tree
Date: Sun, 06 Jan 2008 16:34:16 -0500
Message-ID: <47814958.3070208@rtr.ca>
References: <20071130142058.816d1693.akpm@linux-foundation.org> <924EFEDD5F540B4284297C4DC59F3DEE2FAEAF@orsmsx423.amr.corp.intel.com> <4750CC78.9070105@rtr.ca> <20071130190227.1976e682@laptopd505.fenrus.org> <4750D180.6080001@rtr.ca> <20071130191816.3e744205@laptopd505.fenrus.org> <4750D585.1030200@rtr.ca> <477C2143.8090406@rtr.ca> <924EFEDD5F540B4284297C4DC59F3DEE4FC485@orsmsx423.amr.corp.intel.com> <477C622F.6010304@rtr.ca> <20080104021619.GA15409@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2422 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753029AbYAFVeU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 6 Jan 2008 16:34:20 -0500
In-Reply-To: <20080104021619.GA15409@linux-os.sc.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Venki Pallipadi <venkatesh.pallipadi@intel.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Arjan van de Ven <arjan@infradead.org>, abelay@novell.com, lenb@kernel.org, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl

Venki Pallipadi wrote:
> Reintroduce run time configurable max_cstate for !CPU_IDLE case.
> 
> Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> 
> Index: linux-2.6.24-rc/drivers/acpi/processor_idle.c
> ===================================================================
> --- linux-2.6.24-rc.orig/drivers/acpi/processor_idle.c
> +++ linux-2.6.24-rc/drivers/acpi/processor_idle.c
> @@ -76,7 +76,11 @@ static void (*pm_idle_save) (void) __rea
>  #define PM_TIMER_TICKS_TO_US(p)		(((p) * 1000)/(PM_TIMER_FREQUENCY/1000))
>  
>  static unsigned int max_cstate __read_mostly = ACPI_PROCESSOR_MAX_POWER;
> +#ifdef CONFIG_CPU_IDLE
>  module_param(max_cstate, uint, 0000);
> +#else
> +module_param(max_cstate, uint, 0644);
> +#endif
>  static unsigned int nocst __read_mostly;
>  module_param(nocst, uint, 0000);
>  
..

Can we get this patch upstream so that a stock 2.6.24 will work here?

Thanks
