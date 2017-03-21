From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] gpio: acpi: Call enable_irq_wake for _IAE GpioInts with
 Wake set
Date: Tue, 21 Mar 2017 14:21:52 +0200
Message-ID: <1490098912.19767.122.camel@linux.intel.com>
References: <20170318233524.5047-1-hdegoede@redhat.com>
         <1489937116.19767.92.camel@linux.intel.com>
         <c9801c6a-b773-b5fd-25dc-6e19053512ac@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <c9801c6a-b773-b5fd-25dc-6e19053512ac@redhat.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 2017-03-20 at 18:20 +0100, Hans de Goede wrote:
> Hi,
> 
> On 19-03-17 16:25, Andy Shevchenko wrote:
> > On Sun, 2017-03-19 at 00:35 +0100, Hans de Goede wrote:
> > > On baytrail / cherrytrail systems with a LID switch the LID switch
> > > is
> > > often connect to a gpioint handled by an _IAE event handler.
> > > Before this commit such systems would not wake up when opening the
> > > lid,
> > > requiring the powerbutton to be pressed after opening the lid to
> > > wakeup.
> > > 
> > > This commit calls enable_irq_wake() for _IAE GpioInts with a valid
> > > event handler which have their Wake flag set. This fixes such
> > > systems
> > > not waking up when opening the lid.
> > 
> > I perhaps give up on my nits against Capital Letters :-), though for
> > consistency, please, use Baytrail, Cherry Trail.
> 
> Will fix for v2.
> 
> > 
> > > +		if (event->irq_wake_enabled)
> > 
> > You may use irqd_is_wakeup_set() instead. IRQ framework keeps this
> > state
> > already.
> 
> That requires having irq_data which is only (normally) available to
> irq_chip drivers, so that is not going to work here.

Which you can get easily from IRQ line number.

  data = irq_get_irq_data(irq);
  if (irqd_is_wakeup_set(data))

Would this work?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
