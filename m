From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: Re: [PATCH 5/5] processor: jiffies-based bm_check, bugfixes
Date: Fri, 24 Dec 2004 10:45:24 +0100
Message-ID: <20041224094524.GA8246@dominikbrodowski.de>
References: <20041223201334.GA19292@dominikbrodowski.de> <20041223134118.A24497@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041223134118.A24497-39QZ/XbsZ5/mO6KZMuUCQVaTQe2KTcn/@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Dec 23, 2004 at 01:41:18PM -0800, Venkatesh Pallipadi wrote:
> 
> 
> The patch below helps us maintain a proper bm_activity history. We monitor
> the bm_activity every 10mS. Using the current 32 bit bm_activity we can store
> the history of upto 320mS.

While this information may be useful, the side effects are very problematic:
advancing the kernel to be "tickless" won't save much any more: the idle
code itself will make sure the system is woken up every 10ms. And that in
addition to the overhead if the CPU isn't idle...

> @@ -710,6 +810,7 @@ static void acpi_processor_power_verify_
>  	cx->valid = 1;
>  	cx->latency_ticks = US_TO_PM_TIMER_TICKS(cx->latency);
>  	pr->flags.bm_check = 1;
> +	setup_periodic_bm_status_check(BM_CHECK_START);

This can be called multiple times, though the BM_CHECK_STOP in _power_exit()

> @@ -985,5 +1086,8 @@ int acpi_processor_power_exit(struct acp
>  		synchronize_kernel();
>  	}
>  
> +	if (pr->flags.bm_check == 1)
> +		setup_periodic_bm_status_check(BM_CHECK_STOP);
> +

will only be called one time per processor. This means the bm_check handler
isn't unregistered but still called, which can cause oopses.

Merry Christmas,

	Dominik


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
