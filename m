From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] gpio: merrifield: Fix build err without CONFIG_ACPI
Date: Fri, 12 Apr 2019 01:09:17 +0200
Message-ID: <2719325.nu6fPkO1U5@kreacher>
References: <20190404103925.25652-1-yuehaibing@huawei.com> <20190405142112.26592-1-yuehaibing@huawei.com> <20190405145009.GD9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190405145009.GD9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Yue Haibing <yuehaibing@huawei.com>, linus.walleij@linaro.org, bgolaszewski@baylibre.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Friday, April 5, 2019 4:50:09 PM CEST Andy Shevchenko wrote:
> On Fri, Apr 05, 2019 at 10:21:12PM +0800, Yue Haibing wrote:
> > From: YueHaibing <yuehaibing@huawei.com>
> > 
> > When building CONFIG_ACPI is not set
> > gcc warn this:
> > 
> > drivers/gpio/gpio-merrifield.c: In function
> > mrfld_gpio_get_pinctrl_dev_name: drivers/gpio/gpio-merrifield.c:388:19:
> > error: dereferencing pointer to incomplete type struct acpi_device> 
> >    put_device(&adev->dev);
> >    
> >                    ^
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Fixes:d00d2109c367 ("gpio: merrifield: Convert to use
> > acpi_dev_get_first_match_dev()") Signed-off-by: YueHaibing
> > <yuehaibing@huawei.com>
> 
> Thank you for an update, I have a comment below, but before sending v3, let
> Rafael to have a chance to look at it.
> 
> >  #ifdef CONFIG_ACPI
> >  extern int acpi_platform_notify(struct device *dev, enum kobject_action
> >  action);> 
> > +
> > +static inline void put_acpi_device(struct acpi_device *adev)
> > +{
> > +	put_device(&adev->dev);
> > +}
> 
> This should probably go to acpi_bus.h under acpi_dev_get_first_match_dev().
> And talking to Mika we agreed that naming would be better as acpi_dev_put().

Agreed on both accounts.

Thanks!
