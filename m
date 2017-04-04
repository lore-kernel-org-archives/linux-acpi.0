From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 6/8] gpio: acpi: Explain how to get GPIO descriptors
 in ACPI case
Date: Tue, 04 Apr 2017 20:59:11 +0300
Message-ID: <1491328751.24567.2.camel@linux.intel.com>
References: <20170323194618.26548-1-andriy.shevchenko@linux.intel.com>
         <20170323194618.26548-7-andriy.shevchenko@linux.intel.com>
         <20170323202838.GA11818@dtor-ws> <1490719163.708.40.camel@linux.intel.com>
         <20170329071235.GB38261@dtor-ws> <1490799864.708.50.camel@linux.intel.com>
         <1491322277.708.129.camel@linux.intel.com> <20170404173108.GC29558@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170404173108.GC29558@dtor-ws>
Sender: linux-gpio-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2017-04-04 at 10:31 -0700, Dmitry Torokhov wrote:
> On Tue, Apr 04, 2017 at 07:11:17PM +0300, Andy Shevchenko wrote:
> > On Wed, 2017-03-29 at 18:04 +0300, Andy Shevchenko wrote:
> > > On Wed, 2017-03-29 at 00:12 -0700, Dmitry Torokhov wrote:
> > > > On Tue, Mar 28, 2017 at 07:39:23PM +0300, Andy Shevchenko wrote:
> > > > > On Thu, 2017-03-23 at 13:28 -0700, Dmitry Torokhov wrote:
> > > > > > On Thu, Mar 23, 2017 at 09:46:16PM +0200, Andy Shevchenko
> > > > > > wrote:

> > > Otherwise I'm reading something like this:
> > > "If we have platform driverX.c which has DT/platform and ACPI
> > > enumeration, we must split ACPI part out, duplicate a lot of code
> > > and
> > > use platform driver as a library."
> 
> No. You need to split the part that augments incomplete ACPI data, and
> move it somewhere (drivers/platform/x86/<platform>-crap.c; the driver
> stays the same: a driver that is useful across multiple platforms.

> > > Is that what you mean?

So, it means to spread IDs in two places. Looking into silead_dmi.c I
can say it looks as a hack, we aren't supposed to use "ACPIXXXX:YY" in
the drivers AFAIK. Besides the fact of notifier and arch_initcall().

It indeed feels like a crap and looks like a crap.

Rafael, Mika, what are your opinions about proposed approach?

> > > P.S. This all _CRS fallback shouldn't be allowed in the first
> > > place.
> 
> It does work in many cases. By disallowing it completely you force
> much
> more platform stuff knowledge in the kernel, whereas before you needed
> to deal with exceptions.

It works due to luck, not otherwise.


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
