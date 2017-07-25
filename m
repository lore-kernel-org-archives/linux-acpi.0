From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / watchdog: Fix init failure with overlapping
 register regions
Date: Tue, 25 Jul 2017 12:37:31 +0300
Message-ID: <20170725093731.GE2369@lahna.fi.intel.com>
References: <20170715214818.24979-1-ryan5544@gmail.com>
 <2680739.BCCY7oeAKy@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:22761 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750781AbdGYJl5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Jul 2017 05:41:57 -0400
Content-Disposition: inline
In-Reply-To: <2680739.BCCY7oeAKy@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ryan Kennedy <ryan5544@gmail.com>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Mon, Jul 24, 2017 at 10:37:17PM +0200, Rafael J. Wysocki wrote:
> On Saturday, July 15, 2017 05:48:18 PM Ryan Kennedy wrote:
> > Partially overlapping regions cause platform device creation
> > to fail. The latter of two overlapping resources will fail to be
> > reserved. Fix this by merging overlapping resource ranges while
> > enumerating WDAT table entries.
> > 
> > Signed-off-by: Ryan Kennedy <ryan5544@gmail.com>
> > ---
> >  drivers/acpi/acpi_watchdog.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/acpi_watchdog.c b/drivers/acpi/acpi_watchdog.c
> > index 8c4e0a1..bf22c29 100644
> > --- a/drivers/acpi/acpi_watchdog.c
> > +++ b/drivers/acpi/acpi_watchdog.c
> > @@ -86,7 +86,12 @@ void __init acpi_watchdog_init(void)
> >  
> >  		found = false;
> >  		resource_list_for_each_entry(rentry, &resource_list) {
> > -			if (resource_contains(rentry->res, &res)) {
> > +			if (rentry->res->flags == res.flags &&
> > +			    resource_overlaps(rentry->res, &res)) {
> > +				if (res.start < rentry->res->start)
> > +					rentry->res->start = res.start;
> > +				if (res.end > rentry->res->end)
> > +					rentry->res->end = res.end;
> >  				found = true;
> >  				break;
> >  			}
> > 
> 
> Mika, can you have a look at this, please?

I wonder why we need to do this?

+                           if (res.start < rentry->res->start)
+                                   rentry->res->start = res.start;
+                           if (res.end > rentry->res->end)
+                                   rentry->res->end = res.end;

IIRC we don't use rentry for anything else when we go out of the loop.
Tuning those limits seems unnecessary.
