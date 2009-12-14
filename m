From: Suresh Siddha <suresh.b.siddha@intel.com>
Subject: Re: [PATCH] acpi: fix for lapic_timer_propagate_broadcast()
Date: Mon, 14 Dec 2009 10:37:22 -0800
Message-ID: <1260815843.4243.1.camel@sbs-t61.sc.intel.com>
References: <4B25F2DE.4000703@jp.fujitsu.com>
Reply-To: Suresh Siddha <suresh.b.siddha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:42110 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750870AbZLNSin (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Dec 2009 13:38:43 -0500
In-Reply-To: <4B25F2DE.4000703@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>

On Mon, 2009-12-14 at 00:10 -0800, Hidetoshi Seto wrote:
> I got following warning on ia64 box:
>   In function 'acpi_processor_power_verify':
>   642: warning: passing argument 2 of 'smp_call_function_single' from
>   incompatible pointer type
> 
> This smp_call_function_single() was introduced by a commit
> f833bab87fca5c3ce13778421b1365845843b976:
> 
>  > @@ -162,8 +162,9 @@
>  >               pr->power.timer_broadcast_on_state = state;
>  >  }
>  >
>  > -static void lapic_timer_propagate_broadcast(struct acpi_processor *pr)
>  > +static void lapic_timer_propagate_broadcast(void *arg)
>  >  {
>  > +       struct acpi_processor *pr = (struct acpi_processor *) arg;
>  >         unsigned long reason;
>  >
>  >         reason = pr->power.timer_broadcast_on_state < INT_MAX ?
>  > @@ -635,7 +636,8 @@
>  >                 working++;
>  >         }
>  >
>  > -       lapic_timer_propagate_broadcast(pr);
>  > +       smp_call_function_single(pr->id, lapic_timer_propagate_broadcast,
>  > +                                pr, 1);
>  >
>  >         return (working);
>  >  }
> 
> The problem is that the lapic_timer_propagate_broadcast() has 2 versions:
> One is real code that modified in the above commit, and the other is NOP
> code that used when !ARCH_APICTIMER_STOPS_ON_C3:
> 
>   static void lapic_timer_propagate_broadcast(struct acpi_processor *pr) { }
> 
> So I got warning because of !ARCH_APICTIMER_STOPS_ON_C3.
> 
> We really want to do nothing here on !ARCH_APICTIMER_STOPS_ON_C3, so
> modify lapic_timer_propagate_broadcast() of real version to use
> smp_call_function_single() in it.
> 
> Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

Acked-by: Suresh Siddha <suresh.b.siddha@intel.com>

Len, please push this in to your tree.

thanks,
suresh

