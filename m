From: Mark Lord <lkml@rtr.ca>
Subject: Re: + restore-missing-sysfs-max_cstate-attr.patch added to -mm tree
Date: Thu, 03 Jan 2008 22:16:57 -0500
Message-ID: <477DA529.4000500@rtr.ca>
References: <20071130142058.816d1693.akpm@linux-foundation.org> <924EFEDD5F540B4284297C4DC59F3DEE2FAEAF@orsmsx423.amr.corp.intel.com> <4750CC78.9070105@rtr.ca> <20071130190227.1976e682@laptopd505.fenrus.org> <4750D180.6080001@rtr.ca> <20071130191816.3e744205@laptopd505.fenrus.org> <4750D585.1030200@rtr.ca> <477C2143.8090406@rtr.ca> <924EFEDD5F540B4284297C4DC59F3DEE4FC485@orsmsx423.amr.corp.intel.com> <477C622F.6010304@rtr.ca> <20080104021619.GA15409@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755533AbYADDRO@vger.kernel.org>
In-Reply-To: <20080104021619.GA15409@linux-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, abelay@novell.com, lenb@kernel.org, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl
List-Id: linux-acpi@vger.kernel.org

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

I'll try and re-test with this on Friday.

Meanwhile, can you give a short summary of how behaviour differs
between CONFIG_CPU_IDLE and !CONFIG_CPU_IDLE  ??

I'm not at all clear on how this really affects things.

Thanks.
