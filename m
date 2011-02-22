From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 5/6] printk: Minimize time zero output
Date: Mon, 21 Feb 2011 16:13:14 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1102211610300.23557@chino.kir.corp.google.com>
References: <20110219024705.308511527@gulag1.americas.sgi.com> <20110219024706.121740209@gulag1.americas.sgi.com> <alpine.DEB.2.00.1102191733220.27722@chino.kir.corp.google.com> <4D62D173.8040805@sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:21010 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115Ab1BVANT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Feb 2011 19:13:19 -0500
Received: from wpaz21.hot.corp.google.com (wpaz21.hot.corp.google.com [172.24.198.85])
	by smtp-out.google.com with ESMTP id p1M0DI4n012640
	for <linux-acpi@vger.kernel.org>; Mon, 21 Feb 2011 16:13:18 -0800
Received: from pwj9 (pwj9.prod.google.com [10.241.219.73])
	by wpaz21.hot.corp.google.com with ESMTP id p1M0CplD022615
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 21 Feb 2011 16:13:17 -0800
Received: by pwj9 with SMTP id 9so392505pwj.6
        for <linux-acpi@vger.kernel.org>; Mon, 21 Feb 2011 16:13:17 -0800 (PST)
In-Reply-To: <4D62D173.8040805@sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mike Travis <travis@sgi.com>
Cc: Ingo Molnar <mingo@elte.hu>, Jack Steiner <steiner@sgi.com>, Robin Holt <holt@sgi.com>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Yinghai Lu <yhlu.kernel@gmail.com>, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org

On Mon, 21 Feb 2011, Mike Travis wrote:

> > > Reduce the length for time zero messages by only printing "[0] ".
> > > 
> > > v2: updated to apply to x86-tip
> > > 
> > > Signed-off-by: Mike Travis <travis@sgi.com>
> > > Reviewed-by: Jack Steiner <steiner@sgi.com>
> > > Reviewed-by: Robin Holt <holt@sgi.com>
> > > ---
> > >  kernel/printk.c |   11 ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > > 
> > > --- linux.orig/kernel/printk.c
> > > +++ linux/kernel/printk.c
> > > @@ -735,9 +735,14 @@ static inline int printk_emit_time(void)
> > >  	unsigned long microsec_rem;
> > >   	t = cpu_clock(printk_cpu);
> > > -	microsec_rem = do_div(t, 1000000000) / 1000;
> > > -	tlen = sprintf(tbuf, "[%5lu.%06lu] ", (unsigned long)t, microsec_rem);
> > > -
> > > +	if (likely(t)) {
> > > +		microsec_rem = do_div(t, 1000000000) / 1000;
> > > +		tlen = sprintf(tbuf, "[%5lu.%06lu] ",
> > > +					(unsigned long)t, microsec_rem);
> > 
> > The definition of microsec_rem can become local to this clause.
> 
> Ok.
> > 
> > > +	} else {
> > > +		/* reduce byte count in log when time is zero */
> > > +		tlen = sprintf(tbuf, "[0] ");
> > 
> > If we know the padding when cpu_clock() is non-zero, then why not make sure
> > the kernel log is aligned properly by using the same padding here?
> 
> I'm not sure I understand what you are asking.  The whole point of this
> exercise is to remove bytes from the early log buffer so it does not
> overflow.  What would you like me to change?
> 

Based on your changelog, it looks like you're trying to avoid the time 
spent calculating the time (the divides), not trying to optimize for 
space, so I recommended "[    0.000000]" so the log is aligned.  If the 
patchset is reducing the number of lines emitted to the log, then this 
shouldn't be as significant of an issue?
