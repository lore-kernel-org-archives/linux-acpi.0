From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 22/53] PNP: factor pnp_init_resource_table() and pnp_clean_resource_table()
Date: Fri, 18 Apr 2008 21:57:32 -0600
Message-ID: <200804182157.34313.bjorn.helgaas@hp.com>
References: <20080418204955.342963315@ldl.fc.hp.com> <20080418205051.704761191@ldl.fc.hp.com> <480920BB.9010506@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:30301 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbYDSEC7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Apr 2008 00:02:59 -0400
In-Reply-To: <480920BB.9010506@keyaccess.nl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

On Friday 18 April 2008 4:29:15 pm Rene Herman wrote:
> On 18-04-08 22:50, Bjorn Helgaas wrote:
> > Move the common part of pnp_init_resource_table() and
> > pnp_clean_resource_table() into a new pnp_init_resource().
> > This reduces a little code duplication and will be
> > useful later to initialize an individual resource.
>
> This can't be right, can it? :
> > +void pnp_init_resource(struct resource *res)
> > +{
> > +	unsigned long type;
> > +
> > +	type = res->flags & (IORESOURCE_IO  | IORESOURCE_MEM |
> > +			     IORESOURCE_IRQ | IORESOURCE_DMA);
> > +
> > +	res->name = NULL;
> > +	res->flags = type | IORESOURCE_AUTO | IORESOURCE_UNSET;
> > +	if (type == IORESOURCE_IRQ || type == IORESOURCE_DMA) {
> > +		res->start = -1;
> > +		res->end = -1;
> > +	} else {
> > +		res->start = 0;
> > +		res->end = 0;
> > +	}
> > +}
>
> This depends on the type already being set in res->flags, yet:

Yep, you're right.  I fixed it, but it requires changes to a couple
other patches down the line, so I'll wait to repost the series until
next week in case you find more problems.

I think this is only a problem for bisection.  By the time you
apply the whole series, we start with an empty resource list, and
every time we add one, we set the type in pnp_new_resource().

That makes me wonder whether pnp_init_resources() should just
free the whole list, so we just start again with an empty list.

Bjorn
