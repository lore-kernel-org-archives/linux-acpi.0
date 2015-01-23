From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/6] ACPI/EC: Cleanup transaction wakeup code
Date: Fri, 23 Jan 2015 16:22:13 +0100
Message-ID: <3990740.ASGPvp6Gzq@vostro.rjw.lan>
References: <cover.1418966602.git.lv.zheng@intel.com> <10635172.oMTtcxH2fm@vostro.rjw.lan> <1AE640813FDE7649BE1B193DEA596E88026BA171@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61856 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750829AbbAWO7d (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Jan 2015 09:59:33 -0500
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88026BA171@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Friday, January 23, 2015 02:18:10 AM Zheng, Lv wrote:
> Hi, Rafael
> 
> I'm sorry something is wrong in my previous reply.
> Let me correct it.
> 
> > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > Sent: Friday, January 23, 2015 12:01 AM
> > 
> > On Thursday, January 22, 2015 06:37:28 AM Zheng, Lv wrote:
> > > Hi, Rafael
> > >
> > > > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > > > Sent: Thursday, January 22, 2015 6:17 AM
> > > >
> > > > On Wednesday, January 14, 2015 07:28:22 PM Lv Zheng wrote:
> 
> <skip>
> 
> > > > > @@ -262,14 +262,16 @@ err:
> > > > >  		if (in_interrupt() && t)
> > > > >  			++t->irq_count;
> > > > >  	}
> > > > > -	return wakeup;
> > > > > +out:
> > > > > +	if (wakeup && in_interrupt())
> > > > > +		wake_up(&ec->wait);
> > > > >  }
> > > > >
> 
> I forgot this diff block.
> The wake_up() is still invoked for the advance_transaction() invoked in
> the GPE handler because of in_interrupt() check.
> For the 2 task context invocations, wake_up() won't be invoked.
> 
> > > > >  static void start_transaction(struct acpi_ec *ec)
> > > > >  {
> > > > >  	ec->curr->irq_count = ec->curr->wi = ec->curr->ri = 0;
> > > > >  	ec->curr->flags = 0;
> > > > > -	(void)advance_transaction(ec);
> > > > > +	advance_transaction(ec);
> > > > >  }
> > > > >
> > > > >  static int acpi_ec_sync_query(struct acpi_ec *ec, u8 *data);
> > > >
> > > > Well, this looks like a functional change, because we wouldn't call
> > > > wake_up(&ec->wait) here before.
> > >
> > > Ah, Yes.
> > > But here, since the only advancement that can happen here is to send
> > > the EC command and there are always further advancements
> > > until transaction completion, the wake_up() won't be invoked at this point.
> > > So IMO, there is no functional changes here.
> 
> Thus I didn't change the logic here.
> 
> > > > > @@ -304,7 +306,7 @@ static int ec_poll(struct acpi_ec *ec)
> > > > >  					return 0;
> > > > >  			}
> > > > >  			spin_lock_irqsave(&ec->lock, flags);
> > > > > -			(void)advance_transaction(ec);
> > > > > +			advance_transaction(ec);
> > > >
> > > > Ditto.
> > >
> > > Yes. I changed this logic.
> 
> And I didn't change the logic here.
> 
> > > By invoking wake_up() here, we can break the ec_poll() loop.
> > > Because if the transaction has completed due to the polling advancement, we really don't need to wait for another interrupt.
> 
> This statement is also wrong.
> After checking include/linux/wait.h I realized that we originally broke
> ec_poll() loop because of ec_transaction_complete() check.
> 
> See include/linux/wait.h:
> The condition is checked in __wait_cond_timeout() prior than doing
> __wait_event_timeout() which may put the task in the wait queue.
> So if the condition is matched, wait_event_timeout() just returns.
> 
> For the above 2 advance_transaction() invocations, they are both
> invoked in the task that might be put into the wait queue.
> But at this point, the task is already in the run queue, so wake_up()
> takes no effect to this and wait_event_timeout() can break ec_poll()
> because of the condition check (ec_transaction_complete()).
> 
> As a conclusion, in fact, even there is no in_interrupt() check made
> before wake_up(), the modification can still be a no-op.
> 
> > > So this new logic makes this patch more like a race fix, not a simple cleanup.
> > > And IMO, it might also be a stable material.
> > > I didn't notice this race bug because there is no bug report against this.
> 
> There is no bug because ec_poll() is broken with ec_transaction_complete()
> check. Thus this is not a bug fix and cannot be a stable candidate.
> 
> > > Should I change the description around this and re-send the patch?
> 
> Thus I needn't change the description for this patch.
> 
> > Yes, please.
> 
> It seems I needn't to change anything.

OK, I see.  Thanks for the analysis.

> So it might not be suitable to re-send the patchset because of the above discussion.
> My bad sorry for the mistake.
> 
> Could you help to check the rest patches of this revision.

I will, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
