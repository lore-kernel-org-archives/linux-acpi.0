From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH 0/4] Add ACPI support for pinctrl configuration
Date: Tue, 5 Apr 2016 11:00:50 +0200
Message-ID: <CACRpkdZW83kOADo1WcYT=mc++ro3Xb7PS15zh+RkLnSxmbTZAQ@mail.gmail.com>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
	<20160404214034.GL2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35428 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757594AbcDEJAv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Apr 2016 05:00:51 -0400
Received: by mail-oi0-f51.google.com with SMTP id p188so9459986oih.2
        for <linux-acpi@vger.kernel.org>; Tue, 05 Apr 2016 02:00:51 -0700 (PDT)
In-Reply-To: <20160404214034.GL2350@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Irina Tirdea <irina.tirdea@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Octavian Purdila <octavian.purdila@intel.com>, Cristina Ciocan <cristina.ciocan@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Apr 4, 2016 at 11:40 PM, Mark Brown <broonie@kernel.org> wrote:
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
> Without getting into the binding at all here it seems like this is not
> solving the problem at the right abstraction level.  It's exposing the
> pins on the SoC directly without any tie in with the functionality that
> goes over those pins.  This means that any binding of a board to an ACPI
> using system that just uses this is going to be entirely specific to the
> particular combination of base and expansion board even if the
> electrical connections are standard.

I have seen the same need beyond strictly embedded (MinnowBoard)
from the Intel camp.

These chips with funny Atom-specific codenames (baytrail, cherryview,
broxton, sunrisepoint etc) are not just used for these IoT use cases
but also for e.g. laptops of the ChromeBook form factor, and the same
pin control needs arise there, just at a different cadence related to
product cycle.

I bet they also have funny product-specific kernel trees :(

> This is something that people are currently looking at for DT, there the
> discussion has been about defining the connectors as entities and hiding
> the details of the muxing on the SoC behind that along with higher level
> concepts like instantiation of buses like I2C and SPI.  It seems like if
> we do want to try to share between DT and ACPI we should be doing it at
> that level rather than dealing with pinmuxing at the extremely low level
> that pinctrl does.

Agree: work is needed here. It is a big confusion, the whole model is
based around the configuration being pretty static as I recently
realized when just wanting to add a runtime-detected LCD panel
to a certain driver. No runtime patching of the DT or overlays or any
of the sort deliver what is really needed.

The only thing I heard which was actually doing something sensible
was when Matthew Garret once told that apple mice provide a
device tree fragment to the OS on how to handle it during bus
discovery.

I think that for random complex hotpluggable devices like what
greybus is trying to achieve this is needed too, despite the standard
USB-like device classes in all their glory.

> Obviously for the more general ACPI use case the idiomatic way of
> handling this is that the OS should never see anything about the
> pin muxing.  With DT we need to really know what's going on with the
> pinbox because the model is that even for things built into a single
> board the OS is responsible for managing the pins but that's really not
> how ACPI is expected to work.

See my previous mail for some kind of answer to this.

Yours,
Linus Walleij
