From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] ACPI / PMIC: xpower: Do pinswitch magic when reading
 GPADC
Date: Sun, 23 Jul 2017 15:28:01 +0300
Message-ID: <1500812881.29303.192.camel@linux.intel.com>
References: <20170708134008.13930-1-hdegoede@redhat.com>
         <1499522283.22624.309.camel@linux.intel.com>
         <2622139.O89ILp39X7@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:59335 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751346AbdGWM2F (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 23 Jul 2017 08:28:05 -0400
In-Reply-To: <2622139.O89ILp39X7@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Fri, 2017-07-21 at 23:12 +0200, Rafael J. Wysocki wrote:
> On Saturday, July 08, 2017 04:58:03 PM Andy Shevchenko wrote:
> > On Sat, 2017-07-08 at 15:40 +0200, Hans de Goede wrote:
> > > Testing has shown that the TS-pin's bias-current needs to be
> > > disabled
> > > when reading the GPIO0 pin in GPADC mode.
> > > 
> > > It seems that there is only 1 bias current source and to be able
> > > to
> > > use it
> > > for the GPIO0 pin in GPADC mode it must be temporarily turned off
> > > for
> > > the
> > > TS pin, but the datasheet does not mention this.
> > > 
> > > This commit adds the necessary writes to turn the TS pin BIAS
> > > current
> > > off before and back on after reading the GPADC. This fixes the
> > > GPADC
> > > always returning a reading of 0.
> > > 
> > > 
> > > +	/* After switching to the GPADC pin give things some time
> > > to
> > > settle */
> > > +	usleep_range(6000, 10000);
> > 
> > msleep(6); ?
> > 
> Is this the only issue you have with the $subject patch?

As Hans explained to me there is no issue.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
