From: Octavian Purdila <octavian.purdila@intel.com>
Subject: Re: [RFC PATCH 0/4] Add ACPI support for pinctrl configuration
Date: Tue, 5 Apr 2016 15:51:18 +0300
Message-ID: <CAE1zotLcLFACKFaPgp2QUK=6qhWvUGu7hmbK+-XuL7+5arBXVg@mail.gmail.com>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
	<20160404214034.GL2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160404214034.GL2350@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Irina Tirdea <irina.tirdea@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Cristina Ciocan <cristina.ciocan@intel.com>, devicetree@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 5, 2016 at 12:40 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Mar 31, 2016 at 02:44:41PM +0300, Irina Tirdea wrote:
>
>> This is a proposal for adding ACPI support for pin controller
>> configuration.
>
>> It has been developed to enable the MinnowBoard and IoT community
>> by providing an easy way to specify pin multiplexing and
>> pin configuration.
>
> So this is mainly targeted at modules being added to base boards?

That is the main use case, yes. Velocity of platform
debugging/enabling is another one.

> Without getting into the binding at all here it seems like this is not
> solving the problem at the right abstraction level.  It's exposing the
> pins on the SoC directly without any tie in with the functionality that
> goes over those pins.

This is not completely true. The pinctrl drivers are exposing
functionality in terms of function groups (e.g., i2c1_grp, spi1_grp,
pwm1_grp, etc.) It is not enough, but it is a step in the right
direction for standard bindings and for tools that can build on top of
this.

>  This means that any binding of a board to an ACPI
> using system that just uses this is going to be entirely specific to the
> particular combination of base and expansion board even if the
> electrical connections are standard.
>

This can be solved by tools that work with high level abstractions and
generate this specific information.

> This is something that people are currently looking at for DT, there the
> discussion has been about defining the connectors as entities and hiding
> the details of the muxing on the SoC behind that along with higher level
> concepts like instantiation of buses like I2C and SPI.  It seems like if
> we do want to try to share between DT and ACPI we should be doing it at
> that level rather than dealing with pinmuxing at the extremely low level
> that pinctrl does.
>

At some point we still need to poke registers. We already have a
drivers that do this (pinctrl) and a standard configuration interface
(the pinctrl device tree bindings). It seems natural to build on top
of this for those higher level concepts / tools.

> Obviously for the more general ACPI use case the idiomatic way of
> handling this is that the OS should never see anything about the
> pin muxing. With DT we need to really know what's going on with the
> pinbox because the model is that even for things built into a single
> board the OS is responsible for managing the pins but that's really not
> how ACPI is expected to work.

Maybe. But we already expose pin control / muxing in
drivers/pinctrl/intel, yes, read-only at this point. Very useful for
debugging. Having write access would make debugging even more useful,
not to mention fast prototyping.
