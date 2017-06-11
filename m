From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1 2/3] gpio: Add support for TPS68470 GPIOs
Date: Sun, 11 Jun 2017 16:40:16 +0300
Message-ID: <CAHp75VeJaQjWb1834Nt7178GL72rcym=d3zV8tPpvJ5qKDuM_Q@mail.gmail.com>
References: <1496750118-5570-1-git-send-email-rajmohan.mani@intel.com>
 <1496750118-5570-3-git-send-email-rajmohan.mani@intel.com>
 <CAHp75Vc6PSDqc=Vxj2z-d49p+E-7tciunhki=8a7HPjQGuSwXQ@mail.gmail.com>
 <6F87890CF0F5204F892DEA1EF0D77A59725BF110@FMSMSX114.amr.corp.intel.com> <20170611113007.GV1019@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35236 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751679AbdFKOLG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Jun 2017 10:11:06 -0400
In-Reply-To: <20170611113007.GV1019@valkosipuli.retiisi.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: "Mani, Rajmohan" <rajmohan.mani@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

On Sun, Jun 11, 2017 at 2:30 PM, Sakari Ailus <sakari.ailus@iki.fi> wrote:
> On Sun, Jun 11, 2017 at 03:49:18AM +0000, Mani, Rajmohan wrote:
>> > On Tue, Jun 6, 2017 at 2:55 PM, Rajmohan Mani <rajmohan.mani@intel.com=
>
>> > wrote:

>> > Besides my below comments, just put it here that I recommended earlier=
 to
>> > provide 2 GPIO chips (one per bank of GPIOs).
>> > It's up to Linus to decide since you didn't follow the recommendation.

>> Did you mean to add this in Kconfig or this source file?
>>
>> Here's some more details on these GPIOs.
>> Each of these 7 GPIOs has 2 registers to control the mode, level, drive =
strength, polarity, hysteresis control among other things. Also there are G=
PDI and GPDO registers to control the input and output values of these 7 GP=
IOs. These GPIOs are numbered 0 through 6.
>> The remaining 3 GPIOs are more of special purpose GPIOs that are output =
only, with one register to control all of their output values and drive str=
engths. These GPIOs are named with a special purpose (ENABLE, IDLE and RESE=
T of the sensor).

>> > > +#include <linux/mfd/tps68470.h>
>> > > +#include <linux/module.h>
>> > > +#include <linux/platform_device.h>
>> >
>> > > +       if (offset >=3D TPS68470_N_REGULAR_GPIO) {
>> > > +               offset -=3D TPS68470_N_REGULAR_GPIO;
>> > > +               reg =3D TPS68470_REG_SGPO;
>> > > +       }
>> >
>> > Two GPIO chips makes this gone.
>
> Again, I'm not really worried about this driver, but the ACPI tables. How
> does the difference show there?

Same way. You will have common numbering over the chip [0, 9]. It will
be just an abstraction inside the driver.

> The outputs (s_enable, s_idle and s_resetn) are not numbered in the
> documentation. There grouped, though, but the order in that grouping vari=
es.

I don't get this. You are telling that the property of "always output"
can be assigned to any 3 out of 10?
Above states the opposite, so, it's clear to me that abstraction of 2
GPIO chips over 1 can be utilized here.

>> > > +struct gpiod_lookup_table gpios_table =3D {
>> > > +       .dev_id =3D NULL,
>> > > +       .table =3D {
>> > > +                 GPIO_LOOKUP("tps68470-gpio", 0, "gpio.0", GPIO_ACT=
IVE_HIGH),
>> > > +                 GPIO_LOOKUP("tps68470-gpio", 1, "gpio.1", GPIO_ACT=
IVE_HIGH),
>> > > +                 GPIO_LOOKUP("tps68470-gpio", 2, "gpio.2", GPIO_ACT=
IVE_HIGH),
>> > > +                 GPIO_LOOKUP("tps68470-gpio", 3, "gpio.3", GPIO_ACT=
IVE_HIGH),
>> > > +                 GPIO_LOOKUP("tps68470-gpio", 4, "gpio.4", GPIO_ACT=
IVE_HIGH),
>> > > +                 GPIO_LOOKUP("tps68470-gpio", 5, "gpio.5", GPIO_ACT=
IVE_HIGH),
>> > > +                 GPIO_LOOKUP("tps68470-gpio", 6, "gpio.6", GPIO_ACT=
IVE_HIGH),
>> > > +                 GPIO_LOOKUP("tps68470-gpio", 7, "s_enable",
>> > GPIO_ACTIVE_HIGH),
>> > > +                 GPIO_LOOKUP("tps68470-gpio", 8, "s_idle", GPIO_ACT=
IVE_HIGH),
>> > > +                 GPIO_LOOKUP("tps68470-gpio", 9, "s_resetn",
>> > GPIO_ACTIVE_HIGH),
>> > > +                 {},
>> > > +       },
>> > > +};
>> >
>> > This doesn't belong to the driver.

>> I have moved this code to the MFD driver
>
> This information should come from the ACPI tables, it should not be prese=
nt
> in drivers. Why do you need it?

+1 (asked same in review of new version)

>> > > +       /*
>> > > +        * Initialize all the GPIOs to 0, just to make sure all
>> > > +        * GPIOs start with known default values. This protects agai=
nst
>> > > +        * any GPIOs getting set with a value of 1, after TPS68470
>> > > + reset
>> >
>> > So, this is hardware bug. Right? Or misconfiguration of the chip we ma=
y avoid?

>> The tps68470 PMIC upon reset, does not have the "power on reset" values.
>> We just initialize the GPIOs with their known default values.
>
> If that was the case, I bet you could expect interesting behaviour from t=
he
> hardware connected to these pins.

+1. I don't believe the hardware / firmware doesn't care about clear
and always predictable state.

> For what it's worth, the chip documentation states that the reset value f=
or
> the SGPO and GPDO registers is zero, as well as that GPIOs are configured=
 as
> input and the reset value of the s_* outputs is low.
>
> In other words, I don't think that explicitly setting the values to zero =
has
> an effect.


--=20
With Best Regards,
Andy Shevchenko
