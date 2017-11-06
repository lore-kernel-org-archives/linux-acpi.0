From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3 1/5] iio: proximity: sx9500: Assign interrupt from
 GpioIo()
Date: Mon, 6 Nov 2017 11:35:56 +0200
Message-ID: <20171106093556.GR2283@lahna.fi.intel.com>
References: <20171103130340.42459-1-andriy.shevchenko@linux.intel.com>
 <20171104031119.00006e56@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171104031119.00006e56-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Nov 04, 2017 at 03:11:19AM +0000, Jonathan Cameron wrote:
> On Fri, 3 Nov 2017 15:03:36 +0200
> Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> 
> > The commit 0f0796509c07
> > 
> > ("iio: remove gpio interrupt probing from drivers that use a single
> > interrupt")
> > 
> > removed custom IRQ assignment for the drivers which are enumerated via
> > ACPI or OF. Unfortunately, some ACPI tables have IRQ line defined as
> > GpioIo() resource and thus automatic IRQ allocation will fail.
> 
> I'll ask the obvious question - is this allowed under the ACPI spec?

Yes, it is perfectly fine.

> > Partially revert the commit 0f0796509c07 to restore original
> > behaviour.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> 
> I really don't like scattering fixes for broken ACPI tables through
> drivers...  Is there really no better solution to this?

This is not about broken ACPI tables. We just currently have
"convenience" stuff in the kernel that translates trivial things like a
single ACPI GpioInt() resource directly to a device interrupt. If the
table has multiple GpioInt()s or uses GpioIo() then it is up to the
driver to handle device specific details.

> On patches like this best to pull in ACPI and GPIO on the cc list.
> 
> Also cc'd Mika who made the original change to support gpioint.

The patch looks fine to me,

Acked-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
