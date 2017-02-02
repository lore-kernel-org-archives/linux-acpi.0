From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 3/4] device property: constify property arrays values
Date: Thu, 2 Feb 2017 10:38:31 -0800
Message-ID: <20170202183831.GA32759@dtor-ws>
References: <20170201173125.40354-1-dmitry.torokhov@gmail.com>
 <20170201173125.40354-4-dmitry.torokhov@gmail.com>
 <1485991803.22276.14.camel@perches.com>
 <1605853.brEpCT4tOG@aspire.rjw.lan>
 <20170202163918.GA21924@dtor-ws>
 <1486054110.2133.366.camel@linux.intel.com>
 <C3BEC996-015E-4536-AE2F-DB0819631789@gmail.com>
 <1486057978.2133.369.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1486057978.2133.369.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Joe Perches <joe@perches.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-acpi@vger.kernel.org

On Thu, Feb 02, 2017 at 07:52:58PM +0200, Andy Shevchenko wrote:
> On Thu, 2017-02-02 at 09:07 -0800, Dmitry Torokhov wrote:
> > On February 2, 2017 8:48:30 AM PST, Andy Shevchenko <andriy.shevchenko
> > @linux.intel.com> wrote:
> > > On Thu, 2017-02-02 at 08:39 -0800, Dmitry Torokhov wrote:
> > > > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > 
> > > > Data that is fed into property arrays should not be modified, so
> > > 
> > > let's
> > > > mark
> > > > relevant pointers as const. This will allow us making source
> > > > arrays
> > > 
> > > as
> > > > const/__initconst.
> > > > 
> > > > Also fix memory leaks on errors in property_entry_copy().
> > > 
> > > While the code looks okay, I'm not sure what memory leaks you are
> > > referring to. The idea as far as I remember was to run *free()
> > > function
> > > if *copy() fails.
> > 
> > That could have been OK for internal function, but will not work for
> > public API, as it goes against normal pattern.
> > 
> > You will be old and grey and still correcting patches that would be
> > getting it wrong :)
> 
> Yes, which sounds not exactly as "we have memory leaks and here we are
> fixing them". So, my comment regarding to phrasing of the commit
> message. Someone might mistakenly think that it needs to be ported as
> earlier as this had been introduced.

OK, I'll leave it up to Rafael to massage the commit message as he sees
fit.

Thanks.

-- 
Dmitry
