From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH 0/4] Add ACPI support for pinctrl configuration
Date: Wed, 6 Apr 2016 11:39:27 +0100
Message-ID: <20160406103925.GA31110@svinekod>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
 <20160404225200.GA1615@svinekod>
 <1F3AC3675D538145B1661F571FE1805F2F2342A6@irsmsx105.ger.corp.intel.com>
 <20160405181625.GA3064@svinekod>
 <CAE1zot+kyANCTPHGmj2W26f4LbS9Nkgt_9DNon-=0nsqRpT3Rw@mail.gmail.com>
 <20160406000130.GB8903@svinekod>
 <CAE1zotJ4OiQ_tMvCDm-KoF8cTJ9Z-n09FX7KR75j0DyAcsznLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35230 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755796AbcDGP5s (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Apr 2016 11:57:48 -0400
Content-Disposition: inline
In-Reply-To: <CAE1zotJ4OiQ_tMvCDm-KoF8cTJ9Z-n09FX7KR75j0DyAcsznLA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: "Tirdea, Irina" <irina.tirdea@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Ciocan, Cristina" <cristina.ciocan@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "charles.garcia-tobin@arm.com" <charles.garcia-tobin@arm.com>

On Thu, Apr 07, 2016 at 03:11:53PM +0300, Octavian Purdila wrote:
> On Wed, Apr 6, 2016 at 3:01 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Tue, Apr 05, 2016 at 11:09:34PM +0300, Octavian Purdila wrote:
> >> On Tue, Apr 5, 2016 at 9:16 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> >> > * The firmware is to some extent expected to manage pinctrl today (for power
> >> >   management of devices it does know about), and hence a pinctrl device is
> >> >   potentially under shared management of ACPI and the OS.
> >> >
> >> > * The ACPI specification says nothing about this style of pinctrl management,
> >> >   so it is unclear what the expectations are:
> >>
> >> Does it say anything at all about pinctrl management?
> >
> > To the best of my knowledge the ACPI spec does not explicitly mention pinctrl.
> > In another reply it was mentioned that there is work in progress for pinmuxing,
> > so evidently it is on the ASWG radar and within the scope of ACPI.
> >
> > I was trying to point out that it is _implicitly_ firmware's responsibility to
> > do any pinctrl today, due to the ACPI model for power management, and the lack
> > of an existing ACPI mechanisms to provide pinctrl data.
> >
> > In practice, firmware configures pinctrl at boot, and may modify pinctrl as
> > part of the runtime power management firmware is put in charge of.
> >
> 
> AFAIK the firmware only uses the pinctrl at boot to set the initial
> values and the OS owns it after boot. The only interaction I know of
> after boot are GPIO signaled events, but those are executed under the
> control of the OS.
> 
> I don't understand the part about firmware being put in charge of
> runtime power management. Do you mean that the firmware directly
> accesses the pinctrl registers? Doesn't this contradict the ACPI goal
> of having the OS control power management? Or do you mean accessing
> pinctrl registers via _PSx and PowerResource._On/_Off?

I mostly mean the latter. Even if the OS is in charge of _when_ those happen,
that only solves mutual exclusion over the pinctrl registers. That does not
handle expectations regarding the current _state_ of the pinctrl configuation,
or the configurations the OS/FW can permit and/or require (e.g. there's no
refcounting between OS and FW for the state of shared pins).

It may also be that pinctrl gets altered in the background (e.g. in SMM),
outside of the OS's control also, but that's probably a rare/extreme case.

> > The lack of any statement about pinctrl would mean that there is effectively no
> > reasonable limitation on what firmware might do with pinctrl, and we cannot
> > assume specific behaviour from the firmware.
> 
> There is noting specified in the spec about other controllers, why is
> pinctrl special in this regard?

Because there are clear demonstrable cases why FW would want to touch pinctrl
today, that may clash with the pinctrl model you are importing from DT (where
the OS is assumed to have complete ownership and control over pinctrl).

The ACPI model implies FW-driven pinctrl management, so if we're going to put
the OS in direct control of pinctrl, we have to make clear what expectation FW
and OS can have.

> > [...]
> >
> >> Since our focus is for open-ended configurations and for hardware that
> >> it is not know to firmware we only considered the case where the pins
> >> are not touched after the system boots.
> >>
> >> Now I wonder what are the cases were the firmware changes the pin
> >> configuration after boot.
> >
> > Device power management and suspend/resume seem like the obvious cases.
> 
> I assume you are suggesting something like the following: we have a
> device that is powered via a GPIO and associated ACPI _PS3/_PS0
> methods are poking the pinctrl register to drive 0 or 1 to power on or
> off the device.

Potentially. In that case it's not clear what the FW is expected to do, and
what the OS is expected to do.

For things like system suspend/resume or hibernate, it's not clear what state
the FW is expected to save/restore, and what state might arbitrarily change.

> If that is the case, we can easily break that today, by changing that
> particular GPIO value via, e.g., sysfs.

Sure, but that is not part of the usual, automatic management of the system.

There are plenty of ways a user with sufficient privilege can bring easily down
a system. They are irrelevant.

Thanks,
Mark.
