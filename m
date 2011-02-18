From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 4/5] printk: Minimize time zero output
Date: Fri, 18 Feb 2011 08:34:02 +0100
Message-ID: <20110218073402.GF11404@elte.hu>
References: <20110217185131.960038922@gulag1.americas.sgi.com>
 <20110217185132.576051720@gulag1.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:54314 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753027Ab1BRHeM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Feb 2011 02:34:12 -0500
Content-Disposition: inline
In-Reply-To: <20110217185132.576051720@gulag1.americas.sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mike Travis <travis@sgi.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>, Yinghai Lu <yhlu.kernel@gmail.com>, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org


* Mike Travis <travis@sgi.com> wrote:

> Reduce the length for time zero messages by only printing "[0] ".
> 
> v2: updated to apply to x86-tip
> 
> Signed-off-by: Mike Travis <travis@sgi.com>
> Reviewed-by: Jack Steiner <steiner@sgi.com>
> Reviewed-by: Robin Holt <holt@sgi.com>
> ---
>  kernel/printk.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> --- linux.orig/kernel/printk.c
> +++ linux/kernel/printk.c
> @@ -818,11 +818,13 @@ asmlinkage int vprintk(const char *fmt,
>  				unsigned long nanosec_rem;
>  
>  				t = cpu_clock(printk_cpu);
> -				nanosec_rem = do_div(t, 1000000000);
> -				tlen = sprintf(tbuf, "[%5lu.%06lu] ",
> +				if (likely(t)) {
> +					nanosec_rem = do_div(t, 1000000000);
> +					tlen = sprintf(tbuf, "[%5lu.%06lu] ",
>  						(unsigned long) t,
>  						nanosec_rem / 1000);

The excessive number of very ugly linebreaks in this statement should have told you 
that the whole printk_time function wants to be broken out of vsprintk(), into a 
helper function.

Please make it two patches: one cleanup-only patch that factors out the code, the 
second one that modifies it materially.

Thanks,

	Ingo
