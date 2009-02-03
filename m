From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch]: fixing of pmtimer overflow that make Cx states time
 incorrect
Date: Mon, 2 Feb 2009 23:24:38 -0800
Message-ID: <20090202232438.d91d19f7.akpm@linux-foundation.org>
References: <1232342024.21839.6.camel@alexs-hp>
	<20090126225235.5e64d0ef.akpm@linux-foundation.org>
	<1233453863.3715.35.camel@localhost.localdomain>
	<1233539217.4069.24.camel@alexs-hp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60223 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751122AbZBCHYr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Feb 2009 02:24:47 -0500
In-Reply-To: <1233539217.4069.24.camel@alexs-hp>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: alex.shi@intel.com
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, linux-acpi@vger.kernel.org


(Cc: line rewritten.  What on earth is your email client doing??)

On Mon, 02 Feb 2009 09:46:57 +0800 "alex.shi" <alex.shi@intel.com> wrote:

> Yagui want to give a clear explanation to be used for commitment. So I resend
> this again. 
> 
>     On most boxes the ACPI PM timer is 24-bit counter that runs on 3.579545MHz
> clock. In such case the max C-state sleep time should be less than 4687ms when
> it is used to record C2/C3 duration time. 
>     But on some boxes the max C-state sleep time is more than 4687ms. In such
> case the overflow happens and the C-state duration time can't be counted
> accurately.
> 
>     Use clocksource to get the C-state time instead of ACPI PM timer. and use
> div64_u64 to convert US_TO_PM_TIME_TICKS in i386 mode.
> 

A minor thing..

> --- linux-2.6.29-rc3.orig/drivers/acpi/processor_idle.c
> +++ linux-2.6.29-rc3/drivers/acpi/processor_idle.c
> @@ -64,7 +64,8 @@
>  #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
>  ACPI_MODULE_NAME("processor_idle");
>  #define ACPI_PROCESSOR_FILE_POWER	"power"
> -#define US_TO_PM_TIMER_TICKS(t)		((t * (PM_TIMER_FREQUENCY/1000)) / 1000)
> +#define US_TO_PM_TIMER_TICKS(t)		div64_u64(\
> +	(t * (PM_TIMER_FREQUENCY/1000)), 1000ULL)

I suppose it doesn't matter much, but we could make this function more
accurate via

	(t * PM_TIMER_FREQUENCY) / 1000

Also, it would be nicer to implement this is a regular C function. 
There's no need at all for it to be an ugly all-caps macro.


