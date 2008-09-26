From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: EC: do transaction from interrupt context
Date: Fri, 26 Sep 2008 17:18:40 +0200
Message-ID: <200809261718.41641.rjw@sisk.pl>
References: <20080925170030.15311.27823.stgit@thinkpad> <200809261615.10488.rjw@sisk.pl> <48DCF75E.7030106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33185 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752188AbYIZPNP (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Fri, 26 Sep 2008 11:13:15 -0400
In-Reply-To: <48DCF75E.7030106@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: "Zhao, Yakui" <yakui.zhao@intel.com>, Sitsofe Wheeler <sitsofe@yahoo.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, LenBrown <lenb@kernel.org>, Linux-acpi@vger.kernel.org

On Friday, 26 of September 2008, Alexey Starikovskiy wrote:
> Rafael J. Wysocki wrote:
> > On Friday, 26 of September 2008, Zhao, Yakui wrote:
> >   
> >> Alan gives a suggestion that after processing the EC notification event, EC driver
> >> should continue to issue the query command and process the EC notification
> >> event until the query command returns zero. 
> >> But this suggestion will break my laptop. On my laptop when issuing the query
> >> command, a non-zero query event is  returned but it can't be processed.(There
> >> is no corresponding ACPI _Qxx object). At the same time the SCI_EVT bit won't
> >> be cleared. In such case OS can't exit the function of acpi_ec_query_handler,
> >> which causes that the acpid kernel thread can't work well.
> >>     
> >
> > Well, perhaps we should exit acpi_ec_query_handler() if SCI_EVT is clear _or_
> > the processing of an event fails due to the lack of a _Qxx object?  Alex?
> >
> >   
> 1. There is no such function acpi_ec_query_handler().
> 2. acpi_ec_gpe_query() does two things:
>     a) checks if EC returns non-zero query index. If EC has nothing to
>     query -- it return 0 and we stop.
>     b) we check index with stored available handlers, and if there is
>     such handler, we execute it.
> This function is scheduled to run in response to raised SCI_EVT, and
> as I know no EC which would clear SCI_EVT by itself (and it's against 
> spec),
> there is no reason to check if it's raised inside the function.
> SCI_EVT is cleared by EC in response to QUERY command issued by driver,
> and this is always done in acpi_ec_gpe_query().

OK

> We (Alan and me) already found that machines in 9998 would break if you try
> to do several QUERY commands for single raise of SCI_EVT in a hope to "clean
> the EC query buffer" -- EC would just return _same_ event over and over, 
> thus
> driver does not try to do this. Please not mix patch from Alan (with 
> above query loop)
> with my patch(it never had above query loop).
> >> In fact according to my analysis IMO Alexey's patch will break my laptop.
> >>     
> >
> > That obviously would be a regression.
> >   
> I highly suspect quality of such "analysis" based on 2 weeks of 
> conversation with
> Yakui. Feel free to make your own judgment though...

Well, I think your patch is correct.

However, I'd like it to be tested on the Zhao Yakui's box anyway.

> >> But now the laptop is not in my hand and I can't do the test. After I own the
> >> laptop again, I will do the test and attach the corresponding info.
> >>     
> >
> > OK, how much time is it going to take, approximately?
> >
> >   
> >> At the same time there are two generic issues in this patch:
> >>    a. spin_lock is overkill. When 2000 EC I/O read/write are executed, the
> >>    CPU interrupt will be disabled for about 1.5ms. This will affect the normal
> >>    laptops.
> >>     
> >
> > OTOH, I think we need _some_ locking in there in order to prevent races from
> > happening.
> >
> >   
> He used 1000 EC I/O per second before, and now it's raised to 2000
> just to make a good number. One full read of battery with SBS (most 
> irq-intensive)
> is in order of 100 GPEs. You need to update your battery state 20 times 
> per second
> to get this number.
> I will not try to doubt 0.7usec of inb/outb operation to EC, but my 
> understanding
> is that you don't wait while LPC transaction is over, so it is inb/outb 
> to south bridge
> which needs to be counted.
> Irq handler itself will disable interrupts as well, it will read several 
> ACPI GPE registers
> in order to find GPE bit, which caused interrupt (first delay).
> second, even the most dumb GPE EC handler needs to read status register 
> of EC
> (second delay).
> Now, my patch adds either read or write of EC data register to this 
> (third delay).
> 
> So, in the very worst case of 0.7usec access to EC register (and free 
> GPE register access),
>  we will disable interrupt for 1.5usec instead of 0.7usec.
> Notice, we enable interrupt between each of these 1.5usec intervals.
> Notice also, spinlock does not add anything to these timings.

OK, so the 2000 EC I/O operations per second are unrealistic and there's really
nothing to worry about (in theory).

> >>    b. the local variable that resides in process stack space is used in
> >>    interrupt-context.
> >>     
> >
> > Which one?
> >
> >   
> He refers to the ec->curr (former ec->t).

Hm, I'm not sure what the failing scenario in this case would be.

Thanks,
Rafael
