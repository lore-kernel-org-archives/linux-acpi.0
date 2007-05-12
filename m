From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 3/3] clockevents: Fix resume logic - updated version
Date: Sat, 12 May 2007 09:51:45 -0700
Message-ID: <20070512095145.0cf58a57.akpm@linux-foundation.org>
References: <20070430102837.748238000@linutronix.de>
	<20070511132846.5ebf4437.akpm@linux-foundation.org>
	<200705112302.47726.rjw@sisk.pl>
	<200705112309.15996.rjw@sisk.pl>
	<20070511235607.83ad0eb5.akpm@linux-foundation.org>
	<1178959563.22481.126.camel@localhost.localdomain>
	<20070512020056.a24cf472.akpm@linux-foundation.org>
	<1178961489.22481.133.camel@localhost.localdomain>
	<20070512030754.90488f79.akpm@linux-foundation.org>
	<1178970253.22481.143.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:40078 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751580AbXELQws (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 May 2007 12:52:48 -0400
In-Reply-To: <1178970253.22481.143.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tglx@linutronix.de
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, John Stultz <johnstul@us.ibm.com>, linux-acpi@vger.kernel.org

On Sat, 12 May 2007 13:44:13 +0200 Thomas Gleixner <tglx@linutronix.de> wrote:

> lockdep complains about the lock nesting of clocksource and watchdog
> lock in the resume path. Move watchdog resume out of the clocksource
> lock.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Index: linux-2.6.21/kernel/time/clocksource.c
> ===================================================================
> --- linux-2.6.21.orig/kernel/time/clocksource.c
> +++ linux-2.6.21/kernel/time/clocksource.c
> @@ -151,9 +151,11 @@ static void clocksource_watchdog(unsigne
>  }
>  static void clocksource_resume_watchdog(void)
>  {
> -	spin_lock(&watchdog_lock);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&watchdog_lock, flags);
>  	watchdog_resumed = 1;
> -	spin_unlock(&watchdog_lock);
> +	spin_unlock_irqrestore(&watchdog_lock, flags);
>  }
>  
>  static void clocksource_check_watchdog(struct clocksource *cs)
> @@ -224,9 +226,9 @@ void clocksource_resume(void)
>  			cs->resume();
>  	}
>  
> -	clocksource_resume_watchdog();
> -
>  	spin_unlock_irqrestore(&clocksource_lock, flags);
> +
> +	clocksource_resume_watchdog();
>  }
>  

The locking in clocksource_resume_watchdog looks pretty pointless anyway.
Can't we just delete it?

The only thing it can race against is, conceivably,

        resumed = watchdog_resumed;
        if (unlikely(resumed))
                watchdog_resumed = 0;

which could be solved by using test_and_clear_bit().

Does anyone have any theories about my lockdep warning?
