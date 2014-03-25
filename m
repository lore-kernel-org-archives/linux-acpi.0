From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [bisected] NULL pointer dereference in acpi_gpiochip_add (on
 modprobe ssb)
Date: Tue, 25 Mar 2014 09:25:30 +0200
Message-ID: <20140325072530.GP19349@intel.com>
References: <20140324154944.GB25669@kria>
 <20140324180033.GM19349@intel.com>
 <20140324181112.GN19349@intel.com>
 <20140324183111.GC25669@kria>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140324183111.GC25669@kria>
Sender: linux-gpio-owner@vger.kernel.org
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 24, 2014 at 07:31:11PM +0100, Sabrina Dubroca wrote:
> > Actually gpiolib seems to handle ->dev as optional. Can you try this patch
> > instead? Thanks.
> > 
> > diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> > index bf0f8b476696..642b2bf3360e 100644
> > --- a/drivers/gpio/gpiolib-acpi.c
> > +++ b/drivers/gpio/gpiolib-acpi.c
> > @@ -501,6 +501,9 @@ void acpi_gpiochip_add(struct gpio_chip *chip)
> >  	acpi_handle handle;
> >  	acpi_status status;
> >  
> > +	if (!chip || !chip->dev)
> > +		return;
> > +
> >  	handle = ACPI_HANDLE(chip->dev);
> >  	if (!handle)
> >  		return;
> > @@ -531,6 +534,9 @@ void acpi_gpiochip_remove(struct gpio_chip *chip)
> >  	acpi_handle handle;
> >  	acpi_status status;
> >  
> > +	if (!chip || !chip->dev)
> > +		return;
> > +
> >  	handle = ACPI_HANDLE(chip->dev);
> >  	if (!handle)
> >  		return;
> 
> Thanks, this patch solves the problem.

Great thanks for testing. Can I add your tested-by to the patch?

I'll submit a formal patch for this next week as I'm currently on vacation.
