From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 3/4] device property: constify property arrays values
Date: Thu, 02 Feb 2017 19:52:58 +0200
Message-ID: <1486057978.2133.369.camel@linux.intel.com>
References: <20170201173125.40354-1-dmitry.torokhov@gmail.com>
         <20170201173125.40354-4-dmitry.torokhov@gmail.com>
         <1485991803.22276.14.camel@perches.com> <1605853.brEpCT4tOG@aspire.rjw.lan>
         <20170202163918.GA21924@dtor-ws>
         <1486054110.2133.366.camel@linux.intel.com>
         <C3BEC996-015E-4536-AE2F-DB0819631789@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:27764 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751224AbdBBRxC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 Feb 2017 12:53:02 -0500
In-Reply-To: <C3BEC996-015E-4536-AE2F-DB0819631789@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Joe Perches <joe@perches.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>

On Thu, 2017-02-02 at 09:07 -0800, Dmitry Torokhov wrote:
> On February 2, 2017 8:48:30 AM PST, Andy Shevchenko <andriy.shevchenko
> @linux.intel.com> wrote:
> > On Thu, 2017-02-02 at 08:39 -0800, Dmitry Torokhov wrote:
> > > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > 
> > > Data that is fed into property arrays should not be modified, so
> > 
> > let's
> > > mark
> > > relevant pointers as const. This will allow us making source
> > > arrays
> > 
> > as
> > > const/__initconst.
> > > 
> > > Also fix memory leaks on errors in property_entry_copy().
> > 
> > While the code looks okay, I'm not sure what memory leaks you are
> > referring to. The idea as far as I remember was to run *free()
> > function
> > if *copy() fails.
> 
> That could have been OK for internal function, but will not work for
> public API, as it goes against normal pattern.
> 
> You will be old and grey and still correcting patches that would be
> getting it wrong :)

Yes, which sounds not exactly as "we have memory leaks and here we are
fixing them". So, my comment regarding to phrasing of the commit
message. Someone might mistakenly think that it needs to be ported as
earlier as this had been introduced.


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
