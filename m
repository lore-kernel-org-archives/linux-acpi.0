From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/5] iio: proximity: sx9500: Add GPIO ACPI mapping table
Date: Fri, 1 Dec 2017 11:04:00 +0100
Message-ID: <CACRpkdZf_O2OwK8rRnCtZ2kKADTorfD4D-ccmcnkz1Md3fJv8Q@mail.gmail.com>
References: <20171103130340.42459-1-andriy.shevchenko@linux.intel.com>
 <20171103130340.42459-2-andriy.shevchenko@linux.intel.com>
 <20171104031403.000073b0@huawei.com> <20171119152934.66a481c0@archlinux>
 <20171125142425.31dd862c@archlinux> <1511795292.25007.454.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1511795292.25007.454.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Jonathan Cameron <jic23-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>, Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 27, 2017 at 4:08 PM, Andy Shevchenko
<andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> On Sat, 2017-11-25 at 14:24 +0000, Jonathan Cameron wrote:
>> On Sun, 19 Nov 2017 15:29:34 +0000
>> Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
>> Hi Andy, any updates on the above?   I probably won't be sending
>> a fixes pull until next weekend, but would be good to know if this
>> should be in there or not by then!
>
> Yes, as you suggested I tried to add quirks to the core, so, this patch
> will be definitely changed.

The quirks mechanics are merged to the GPIO core and an
immutable branch is available, so Jonathan could "just" pull that in
and apply (elegent) fixes on top. I think.

Yours,
Linus Walleij
