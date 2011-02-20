From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 5/6] printk: Minimize time zero output
Date: Sat, 19 Feb 2011 17:51:15 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1102191733220.27722@chino.kir.corp.google.com>
References: <20110219024705.308511527@gulag1.americas.sgi.com> <20110219024706.121740209@gulag1.americas.sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:4138 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754602Ab1BTBvV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Feb 2011 20:51:21 -0500
Received: from wpaz37.hot.corp.google.com (wpaz37.hot.corp.google.com [172.24.198.101])
	by smtp-out.google.com with ESMTP id p1K1pJ7x006729
	for <linux-acpi@vger.kernel.org>; Sat, 19 Feb 2011 17:51:19 -0800
Received: from pzk26 (pzk26.prod.google.com [10.243.19.154])
	by wpaz37.hot.corp.google.com with ESMTP id p1K1pHO1017885
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Sat, 19 Feb 2011 17:51:18 -0800
Received: by pzk26 with SMTP id 26so253480pzk.1
        for <linux-acpi@vger.kernel.org>; Sat, 19 Feb 2011 17:51:17 -0800 (PST)
In-Reply-To: <20110219024706.121740209@gulag1.americas.sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mike Travis <travis@sgi.com>
Cc: Ingo Molnar <mingo@elte.hu>, Jack Steiner <steiner@sgi.com>, Robin Holt <holt@sgi.com>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Yinghai Lu <yhlu.kernel@gmail.com>, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org

On Fri, 18 Feb 2011, Mike Travis wrote:

> Reduce the length for time zero messages by only printing "[0] ".
> 
> v2: updated to apply to x86-tip
> 
> Signed-off-by: Mike Travis <travis@sgi.com>
> Reviewed-by: Jack Steiner <steiner@sgi.com>
> Reviewed-by: Robin Holt <holt@sgi.com>
> ---
>  kernel/printk.c |   11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> --- linux.orig/kernel/printk.c
> +++ linux/kernel/printk.c
> @@ -735,9 +735,14 @@ static inline int printk_emit_time(void)
>  	unsigned long microsec_rem;
>  
>  	t = cpu_clock(printk_cpu);
> -	microsec_rem = do_div(t, 1000000000) / 1000;
> -	tlen = sprintf(tbuf, "[%5lu.%06lu] ", (unsigned long)t, microsec_rem);
> -
> +	if (likely(t)) {
> +		microsec_rem = do_div(t, 1000000000) / 1000;
> +		tlen = sprintf(tbuf, "[%5lu.%06lu] ",
> +					(unsigned long)t, microsec_rem);

The definition of microsec_rem can become local to this clause.

> +	} else {
> +		/* reduce byte count in log when time is zero */
> +		tlen = sprintf(tbuf, "[0] ");

If we know the padding when cpu_clock() is non-zero, then why not make 
sure the kernel log is aligned properly by using the same padding here?

> +	}
>  	for (tp = tbuf; tp < tbuf + tlen; tp++)
>  		emit_log_char(*tp);
>  
