From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/6] gpiolib: Allow GPIO chips to request their own GPIOs
Date: Wed, 26 Feb 2014 11:05:42 +0200
Message-ID: <20140226090542.GT5018@intel.com>
References: <1393257611-18031-1-git-send-email-mika.westerberg@linux.intel.com>
 <1393257611-18031-2-git-send-email-mika.westerberg@linux.intel.com>
 <1491992.y6nTRlJ009@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1491992.y6nTRlJ009@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Lan Tianyu <tianyu.lan@intel.com>, Lv Zheng <lv.zheng@intel.com>, Alan Cox <alan.cox@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Feb 25, 2014 at 03:10:24PM +0100, Rafael J. Wysocki wrote:
> On Monday, February 24, 2014 06:00:06 PM Mika Westerberg wrote:
> > Sometimes it is useful to allow GPIO chips themselves to request GPIOs they
> > own through gpiolib API. One usecase is ACPI ASL code that should be able
> > to toggle GPIOs through GPIO operation regions.
> > 
> > We can't really use gpio_request() and its counterparts because it will pin
> > the module to the kernel forever (as it calls module_get()). Instead we
> > provide a gpiolib internal functions gpiochip_request/free_own_desc() that
> > work the same as gpio_request() but don't manipulate module refrence count.
> > 
> > Since it's the GPIO chip driver who requests the GPIOs in the first place
> > we can be sure that it cannot be unloaded without the driver knowing about
> > that. Furthermore we only limit this functionality to be available only
> > inside gpiolib.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/gpio/gpiolib.c | 57 +++++++++++++++++++++++++++++++++++++++++++-------
> >  drivers/gpio/gpiolib.h |  3 +++
> >  2 files changed, 53 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > index f60d74bc2fce..489a63524eb6 100644
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -1458,7 +1458,8 @@ EXPORT_SYMBOL_GPL(gpiochip_remove_pin_ranges);
> >   * on each other, and help provide better diagnostics in debugfs.
> >   * They're called even less than the "set direction" calls.
> >   */
> > -static int gpiod_request(struct gpio_desc *desc, const char *label)
> > +static int __gpiod_request(struct gpio_desc *desc, const char *label,
> > +			   bool module_refcount)
> >  {
> >  	struct gpio_chip	*chip;
> >  	int			status = -EPROBE_DEFER;
> > @@ -1475,8 +1476,10 @@ static int gpiod_request(struct gpio_desc *desc, const char *label)
> >  	if (chip == NULL)
> >  		goto done;
> >  
> > -	if (!try_module_get(chip->owner))
> > -		goto done;
> > +	if (module_refcount) {
> > +		if (!try_module_get(chip->owner))
> > +			goto done;
> > +	}
> 
> I'm wondering why you're not moving the module refcount manipulation entirely
> to gpiod_request()?
> 
> I guess that's because of the locking, but I suppose that desc->chip will never
> be NULL in gpiochip_request_own_desc(), so you don't even need to check it there?
> 
> So it looks like gpiochip_request_own_desc() can do something like
> 
> 	lock
> 	__gpiod_request(stuff)
> 	unlock
> 
> where __gpiod_request() is just the internal part starting at the "NOTE" comment.

Sounds good. Only thing I'm not sure about is the fact that
__gpiod_request() releases the lock when it calls chip driver callbacks
(and takes it back of course). Is that acceptable practice to take the lock
outside of a function and release it inside for a while?
