From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH 0/4] Add ACPI support for pinctrl configuration
Date: Wed, 6 Apr 2016 01:01:33 +0100
Message-ID: <20160406000130.GB8903@svinekod>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
 <20160404225200.GA1615@svinekod>
 <1F3AC3675D538145B1661F571FE1805F2F2342A6@irsmsx105.ger.corp.intel.com>
 <20160405181625.GA3064@svinekod>
 <CAE1zot+kyANCTPHGmj2W26f4LbS9Nkgt_9DNon-=0nsqRpT3Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54246 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754007AbcDFABk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Apr 2016 20:01:40 -0400
Content-Disposition: inline
In-Reply-To: <CAE1zot+kyANCTPHGmj2W26f4LbS9Nkgt_9DNon-=0nsqRpT3Rw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: "Tirdea, Irina" <irina.tirdea@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Ciocan, Cristina" <cristina.ciocan@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "charles.garcia-tobin@arm.com" <charles.garcia-tobin@arm.com>

On Tue, Apr 05, 2016 at 11:09:34PM +0300, Octavian Purdila wrote:
> On Tue, Apr 5, 2016 at 9:16 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > * The firmware is to some extent expected to manage pinctrl today (for power
> >   management of devices it does know about), and hence a pinctrl device is
> >   potentially under shared management of ACPI and the OS.
> >
> > * The ACPI specification says nothing about this style of pinctrl management,
> >   so it is unclear what the expectations are:
> 
> Does it say anything at all about pinctrl management?

To the best of my knowledge the ACPI spec does not explicitly mention pinctrl.
In another reply it was mentioned that there is work in progress for pinmuxing,
so evidently it is on the ASWG radar and within the scope of ACPI.

I was trying to point out that it is _implicitly_ firmware's responsibility to
do any pinctrl today, due to the ACPI model for power management, and the lack
of an existing ACPI mechanisms to provide pinctrl data.

In practice, firmware configures pinctrl at boot, and may modify pinctrl as
part of the runtime power management firmware is put in charge of.

The lack of any statement about pinctrl would mean that there is effectively no
reasonable limitation on what firmware might do with pinctrl, and we cannot
assume specific behaviour from the firmware.

[...]

> Since our focus is for open-ended configurations and for hardware that
> it is not know to firmware we only considered the case where the pins
> are not touched after the system boots.
> 
> Now I wonder what are the cases were the firmware changes the pin
> configuration after boot.

Device power management and suspend/resume seem like the obvious cases.

Thanks,
Mark
