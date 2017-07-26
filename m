From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / PMIC: xpower: Do pinswitch magic when reading GPADC
Date: Wed, 26 Jul 2017 20:45:59 +0200
Message-ID: <3809229.UhEmXTYNx7@aspire.rjw.lan>
References: <20170708134008.13930-1-hdegoede@redhat.com> <2622139.O89ILp39X7@aspire.rjw.lan> <1500812881.29303.192.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57891 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750930AbdGZSx7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Jul 2017 14:53:59 -0400
In-Reply-To: <1500812881.29303.192.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Sunday, July 23, 2017 03:28:01 PM Andy Shevchenko wrote:
> On Fri, 2017-07-21 at 23:12 +0200, Rafael J. Wysocki wrote:
> > On Saturday, July 08, 2017 04:58:03 PM Andy Shevchenko wrote:
> > > On Sat, 2017-07-08 at 15:40 +0200, Hans de Goede wrote:
> > > > Testing has shown that the TS-pin's bias-current needs to be
> > > > disabled
> > > > when reading the GPIO0 pin in GPADC mode.
> > > > 
> > > > It seems that there is only 1 bias current source and to be able
> > > > to
> > > > use it
> > > > for the GPIO0 pin in GPADC mode it must be temporarily turned off
> > > > for
> > > > the
> > > > TS pin, but the datasheet does not mention this.
> > > > 
> > > > This commit adds the necessary writes to turn the TS pin BIAS
> > > > current
> > > > off before and back on after reading the GPADC. This fixes the
> > > > GPADC
> > > > always returning a reading of 0.
> > > > 
> > > > 
> > > > +	/* After switching to the GPADC pin give things some time
> > > > to
> > > > settle */
> > > > +	usleep_range(6000, 10000);
> > > 
> > > msleep(6); ?
> > > 
> > Is this the only issue you have with the $subject patch?
> 
> As Hans explained to me there is no issue.

OK, so patch applied.  Thanks!

