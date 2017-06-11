From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v1 2/3] gpio: Add support for TPS68470 GPIOs
Date: Sun, 11 Jun 2017 19:50:28 +0300
Message-ID: <20170611165028.GA12407@valkosipuli.retiisi.org.uk>
References: <1496750118-5570-1-git-send-email-rajmohan.mani@intel.com>
 <1496750118-5570-3-git-send-email-rajmohan.mani@intel.com>
 <CAHp75Vc6PSDqc=Vxj2z-d49p+E-7tciunhki=8a7HPjQGuSwXQ@mail.gmail.com>
 <6F87890CF0F5204F892DEA1EF0D77A59725BF110@FMSMSX114.amr.corp.intel.com>
 <20170611113007.GV1019@valkosipuli.retiisi.org.uk>
 <CAHp75VeJaQjWb1834Nt7178GL72rcym=d3zV8tPpvJ5qKDuM_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:42992 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751751AbdFKQug (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 11 Jun 2017 12:50:36 -0400
Content-Disposition: inline
In-Reply-To: <CAHp75VeJaQjWb1834Nt7178GL72rcym=d3zV8tPpvJ5qKDuM_Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Mani, Rajmohan" <rajmohan.mani@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

Hi Andy,

On Sun, Jun 11, 2017 at 04:40:16PM +0300, Andy Shevchenko wrote:
> On Sun, Jun 11, 2017 at 2:30 PM, Sakari Ailus <sakari.ailus@iki.fi> wrote:
> > On Sun, Jun 11, 2017 at 03:49:18AM +0000, Mani, Rajmohan wrote:
> >> > On Tue, Jun 6, 2017 at 2:55 PM, Rajmohan Mani <rajmohan.mani@intel.com>
> >> > wrote:
> 
> >> > Besides my below comments, just put it here that I recommended earlier to
> >> > provide 2 GPIO chips (one per bank of GPIOs).
> >> > It's up to Linus to decide since you didn't follow the recommendation.
> 
> >> Did you mean to add this in Kconfig or this source file?
> >>
> >> Here's some more details on these GPIOs.
> >> Each of these 7 GPIOs has 2 registers to control the mode, level, drive strength, polarity, hysteresis control among other things. Also there are GPDI and GPDO registers to control the input and output values of these 7 GPIOs. These GPIOs are numbered 0 through 6.
> >> The remaining 3 GPIOs are more of special purpose GPIOs that are output only, with one register to control all of their output values and drive strengths. These GPIOs are named with a special purpose (ENABLE, IDLE and RESET of the sensor).
> 
> >> > > +#include <linux/mfd/tps68470.h>
> >> > > +#include <linux/module.h>
> >> > > +#include <linux/platform_device.h>
> >> >
> >> > > +       if (offset >= TPS68470_N_REGULAR_GPIO) {
> >> > > +               offset -= TPS68470_N_REGULAR_GPIO;
> >> > > +               reg = TPS68470_REG_SGPO;
> >> > > +       }
> >> >
> >> > Two GPIO chips makes this gone.
> >
> > Again, I'm not really worried about this driver, but the ACPI tables. How
> > does the difference show there?
> 
> Same way. You will have common numbering over the chip [0, 9]. It will
> be just an abstraction inside the driver.

Oh, in that case that should be a non-issue.

> 
> > The outputs (s_enable, s_idle and s_resetn) are not numbered in the
> > documentation. There grouped, though, but the order in that grouping varies.
> 
> I don't get this. You are telling that the property of "always output"
> can be assigned to any 3 out of 10?

No, I'm telling you that the three (s_enable, s_idle and s_resetn) cannot be
configured as inputs --- instead they're always outputs. That's how the
hardware is implemented.

> Above states the opposite, so, it's clear to me that abstraction of 2
> GPIO chips over 1 can be utilized here.

Sounds fine to me, taken that this does not add complications to ACPI
tables.

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
