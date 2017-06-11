From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v1 2/3] gpio: Add support for TPS68470 GPIOs
Date: Sun, 11 Jun 2017 14:30:07 +0300
Message-ID: <20170611113007.GV1019@valkosipuli.retiisi.org.uk>
References: <1496750118-5570-1-git-send-email-rajmohan.mani@intel.com>
 <1496750118-5570-3-git-send-email-rajmohan.mani@intel.com>
 <CAHp75Vc6PSDqc=Vxj2z-d49p+E-7tciunhki=8a7HPjQGuSwXQ@mail.gmail.com>
 <6F87890CF0F5204F892DEA1EF0D77A59725BF110@FMSMSX114.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6F87890CF0F5204F892DEA1EF0D77A59725BF110@FMSMSX114.amr.corp.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: "Mani, Rajmohan" <rajmohan.mani@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Rajmohan and Andy,

On Sun, Jun 11, 2017 at 03:49:18AM +0000, Mani, Rajmohan wrote:
> Hi Andy,
> 
> Thanks for the reviews and patience.
> 
> > 
> > On Tue, Jun 6, 2017 at 2:55 PM, Rajmohan Mani <rajmohan.mani@intel.com>
> > wrote:
> > > This patch adds support for TPS68470 GPIOs.
> > > There are 7 GPIOs and a few sensor related GPIOs.
> > > These GPIOs can be requested and configured as appropriate.
> > 
> > Besides my below comments, just put it here that I recommended earlier to
> > provide 2 GPIO chips (one per bank of GPIOs).
> > It's up to Linus to decide since you didn't follow the recommendation.
> > 
> 
> Ack.
> Did you mean to add this in Kconfig or this source file?
> 
> Here's some more details on these GPIOs.
> Each of these 7 GPIOs has 2 registers to control the mode, level, drive strength, polarity, hysteresis control among other things. Also there are GPDI and GPDO registers to control the input and output values of these 7 GPIOs. These GPIOs are numbered 0 through 6.
> The remaining 3 GPIOs are more of special purpose GPIOs that are output only, with one register to control all of their output values and drive strengths. These GPIOs are named with a special purpose (ENABLE, IDLE and RESET of the sensor).
> 
> > > +#include <linux/gpio.h>
> > > +#include <linux/gpio/machine.h>
> > 
> > These shouldn't be in the driver.
> > Instead use
> > #include <linux/gpio/driver.h>
> > 
> 
> Ack
> 
> > > +#include <linux/mfd/tps68470.h>
> > > +#include <linux/module.h>
> > > +#include <linux/platform_device.h>
> > 
> > > +       if (offset >= TPS68470_N_REGULAR_GPIO) {
> > > +               offset -= TPS68470_N_REGULAR_GPIO;
> > > +               reg = TPS68470_REG_SGPO;
> > > +       }
> > 
> > Two GPIO chips makes this gone.

Again, I'm not really worried about this driver, but the ACPI tables. How
does the difference show there?

The outputs (s_enable, s_idle and s_resetn) are not numbered in the
documentation. There grouped, though, but the order in that grouping varies.

> > > +struct gpiod_lookup_table gpios_table = {
> > > +       .dev_id = NULL,
> > > +       .table = {
> > > +                 GPIO_LOOKUP("tps68470-gpio", 0, "gpio.0", GPIO_ACTIVE_HIGH),
> > > +                 GPIO_LOOKUP("tps68470-gpio", 1, "gpio.1", GPIO_ACTIVE_HIGH),
> > > +                 GPIO_LOOKUP("tps68470-gpio", 2, "gpio.2", GPIO_ACTIVE_HIGH),
> > > +                 GPIO_LOOKUP("tps68470-gpio", 3, "gpio.3", GPIO_ACTIVE_HIGH),
> > > +                 GPIO_LOOKUP("tps68470-gpio", 4, "gpio.4", GPIO_ACTIVE_HIGH),
> > > +                 GPIO_LOOKUP("tps68470-gpio", 5, "gpio.5", GPIO_ACTIVE_HIGH),
> > > +                 GPIO_LOOKUP("tps68470-gpio", 6, "gpio.6", GPIO_ACTIVE_HIGH),
> > > +                 GPIO_LOOKUP("tps68470-gpio", 7, "s_enable",
> > GPIO_ACTIVE_HIGH),
> > > +                 GPIO_LOOKUP("tps68470-gpio", 8, "s_idle", GPIO_ACTIVE_HIGH),
> > > +                 GPIO_LOOKUP("tps68470-gpio", 9, "s_resetn",
> > GPIO_ACTIVE_HIGH),
> > > +                 {},
> > > +       },
> > > +};
> > 
> > This doesn't belong to the driver.
> > 
> 
> Ack
> I have moved this code to the MFD driver

This information should come from the ACPI tables, it should not be present
in drivers. Why do you need it?

> > > +       /*
> > > +        * Initialize all the GPIOs to 0, just to make sure all
> > > +        * GPIOs start with known default values. This protects against
> > > +        * any GPIOs getting set with a value of 1, after TPS68470
> > > + reset
> > 
> > So, this is hardware bug. Right? Or misconfiguration of the chip we may avoid?
> > 
> 
> The tps68470 PMIC upon reset, does not have the "power on reset" values.
> We just initialize the GPIOs with their known default values.

If that was the case, I bet you could expect interesting behaviour from the
hardware connected to these pins.

For what it's worth, the chip documentation states that the reset value for
the SGPO and GPDO registers is zero, as well as that GPIOs are configured as
input and the reset value of the s_* outputs is low.

In other words, I don't think that explicitly setting the values to zero has
an effect.

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
