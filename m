From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] ACPI: remove unnecessary INIT_LIST_HEAD
Date: Tue, 27 Nov 2012 11:49:21 +0200
Message-ID: <1354009761.20110.61.camel@smile>
References: <1354007025-8334-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20121127092458.GO3867@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50904 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758419Ab2K0Jtb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Nov 2012 04:49:31 -0500
In-Reply-To: <20121127092458.GO3867@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Westerberg, Mika" <mika.westerberg@intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org

On Tue, 2012-11-27 at 11:24 +0200, Westerberg, Mika wrote: 
> On Tue, Nov 27, 2012 at 11:03:45AM +0200, Andy Shevchenko wrote:
> > There is no need to initialize the node before appending it to the list.
> 
> I might be missing something but why do we then have macros like:
> list_del_init() etc?

list_del_init(&list->node) allows to reuse &list->node as a new list.
I guess the often use case of that when you extract the leaf node from
the list of lists and create a new list based on it.

In our case we just add a node to the existed list.


> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/acpi/resource.c |    1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> > index 4107c00..a3868f6 100644
> > --- a/drivers/acpi/resource.c
> > +++ b/drivers/acpi/resource.c
> > @@ -426,7 +426,6 @@ static acpi_status acpi_dev_new_resource_entry(struct resource *r,
> >  		c->error = -ENOMEM;
> >  		return AE_NO_MEMORY;
> >  	}
> > -	INIT_LIST_HEAD(&rentry->node);
> >  	rentry->res = *r;
> >  	list_add_tail(&rentry->node, c->list);
> >  	c->count++;
> > -- 
> > 1.7.10.4

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
