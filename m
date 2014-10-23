From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: GPIO bindings guidelines (Was: Re: [PATCH v5 10/12] gpio: Support for unified device properties interface)
Date: Thu, 23 Oct 2014 14:25:19 +0200
Message-ID: <2964475.27LDgQTJ7C@wuerfel>
References: <CAAVeFuLW6fucvDxQvY5DDfnhPrgYM+1pi7WoHfBQa_BgYnc_Cw@mail.gmail.com> <4582579.9WMrIMALsy@wuerfel> <CAAVeFuJzZJdh+Z7hY-Ws3orxyO=PSqCB_eBphbWk3nRb15op2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:63510 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143AbaJWMZd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2014 08:25:33 -0400
In-Reply-To: <CAAVeFuJzZJdh+Z7hY-Ws3orxyO=PSqCB_eBphbWk3nRb15op2w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexandre Courbot <gnurou@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Darren Hart <dvhart@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>

On Thursday 23 October 2014 15:02:46 Alexandre Courbot wrote:
> On Tue, Oct 21, 2014 at 4:54 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 21 October 2014 14:14:02 Alexandre Courbot wrote:

> > Drivers that use
> > existing bindings with the "foo-gpio" form (or worse, "foo-somethingelse"
> > can use the same internal interface as the drivers that use name plus
> > index. Do you see a problem using what I suggested for the combined
> > API:
> >
> > __gpiod_get(dev, propname, index); // use property name plus index
> > gpiod_get(dev, index); // use "gpios" plus index
> > gpiod_get_named(dev, "name"); use "name-gpios" with index 0
> 
> Apart from the loosy naming practices which we sometimes see (and
> which should be caught during review), do you have something against
> requiring a name for all new GPIO bindings, i.e. for ensuring that all
> new properties are "name-gpio" and forbidding "gpios"?

Most other subsystems don't require a name, and traditionally we only
had anonymous indexed properties for a lot of things (registers, 
interrupts, ...).

I still like the idea of using anonymous references for simple things,
but if you and Linus feel that it's better to mandate names from now on,
I won't complain.

> Requiring a proper name for all GPIOs makes a lot of sense IMHO, it
> makes drivers easier to understand and is less error-prone than long
> arrays of GPIOs. The API would then be basically what we have today:
> 
> gpiod_get(dev, name) // use "name-gpios" with index 0
> gpiod_get_index(dev, name, index) // for the rare case where several
> GPIOs serve the same function. Not to be used lightly.
> 
> ... with stronger guidelines for the definition of new bindings, and a
> big warning in the kerneldoc of gpiod_get_index().
> 
> ACPI drivers that may use tables without _DSD should then use a way to
> bind GPIO names to indexes as a fallback for older hardware.

Ok.

	Arnd
