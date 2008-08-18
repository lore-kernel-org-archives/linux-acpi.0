From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] acpi_pm.c: check for monotonicity
Date: Mon, 18 Aug 2008 13:28:58 -0700
Message-ID: <20080818132858.b844a1d4.akpm@linux-foundation.org>
References: <20080818200017.GA11247@rhlx01.hs-esslingen.de>
	<20080810101730.GA10024@rhlx01.hs-esslingen.de>
	<20080810162920.GA9860@comet.dominikbrodowski.net>
	<20080810190759.GA1879@rhlx01.hs-esslingen.de>
	<20080818190325.GA12581@comet.dominikbrodowski.net>
	<20080818121924.6b61f7af.akpm@linux-foundation.org>
	<20080818193517.GA22097@isilmar.linta.de>
	<20080818124755.162f24d1.akpm@linux-foundation.org>
	<20080818200916.GA18209@comet.dominikbrodowski.net>
	<20080818201115.GC18209@comet.dominikbrodowski.net>
	<20080818201844.GA3506@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52138 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757863AbYHRU37 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Aug 2008 16:29:59 -0400
In-Reply-To: <20080818201844.GA3506@rhlx01.hs-esslingen.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: linux@dominikbrodowski.net, andi@lisas.de, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, johnstul@us.ibm.com, hirofumi@mail.parknet.co.jp, alan@lxorguk.ukuu.org.uk, arjan@infradead.org

On Mon, 18 Aug 2008 22:18:44 +0200
Andreas Mohr <andi@lisas.de> wrote:

> Hi,
> 
> On Mon, Aug 18, 2008 at 10:11:15PM +0200, Dominik Brodowski wrote:
> > +	if (good != 10) {
> > +		printk(KERN_INFO "PM-Timer had no reasonable result:"
> > +		       " 0x%#llx - aborting.\n", value1);
> > +		return -ENODEV;
> >  	}
> > -	printk(KERN_INFO "PM-Timer had no reasonable result:"
> > -			" 0x%#llx - aborting.\n", value1);
> > -	return -ENODEV;
> 
> Technically spoken this log message could now be considered partially
> outdated... (we're doing 10 evaluations after all, not one with a
> precise end result).
> 
> 
> Seeing a define for those several open-coded 10 loops values would be nice.
> 

Also it's a bit dodgy printing a cycle_t with %llx.  We don't _know_
that cycle_t was implemented with `long long' - if this was always
true, we wouldn't (or shouldn't) have a cycle_t at all.

But it seems that it happens to work for all architectures which
implement acpi.

