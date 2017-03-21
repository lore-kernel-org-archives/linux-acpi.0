From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] gpio: acpi: Call enable_irq_wake for _IAE GpioInts
 with Wake set
Date: Tue, 21 Mar 2017 14:40:14 +0200
Message-ID: <1490100014.19767.126.camel@linux.intel.com>
References: <20170320173221.3397-1-hdegoede@redhat.com>
         <1490099423.19767.124.camel@linux.intel.com>
         <CAJZ5v0jrq_AUysuLuyhUqWXOYm8X-koq8ra=rgrjUo+bFMyw9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:30163 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757191AbdCUMrF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 21 Mar 2017 08:47:05 -0400
In-Reply-To: <CAJZ5v0jrq_AUysuLuyhUqWXOYm8X-koq8ra=rgrjUo+bFMyw9w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-gpio@vger.kernel.org

On Tue, 2017-03-21 at 13:36 +0100, Rafael J. Wysocki wrote:
> On Tue, Mar 21, 2017 at 1:30 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, 2017-03-20 at 18:32 +0100, Hans de Goede wrote:

> > > +     bool irq_wake_enabled;
> > > 
> > > +             if (event->irq_wake_enabled)
> > > 
> > 
> > Same (new) comment as in v1.
> 
> Why not just check for agpio->wake_capable == ACPI_WAKE_CAPABLE
> instead as I said?

Ah, yes, it could work as well as far as I can see from the code point
of view.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
