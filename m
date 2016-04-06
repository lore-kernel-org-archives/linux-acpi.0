From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH 0/4] Add ACPI support for pinctrl configuration
Date: Wed, 6 Apr 2016 09:52:57 +0100
Message-ID: <20160406085257.GA22341@red-moon>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
 <20160404225200.GA1615@svinekod>
 <CACRpkdb=Ef1-g-r9NW-4_xeKdke0FFhnN+JYPjVKog3L4At8Lg@mail.gmail.com>
 <20160405165935.GA5456@sirena.org.uk>
 <CAE1zot+-=JQkMqRPpNtCk1MksRf9kOQ1G216kSXszDjn2z4d=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55695 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932189AbcDFIu1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Apr 2016 04:50:27 -0400
Content-Disposition: inline
In-Reply-To: <CAE1zot+-=JQkMqRPpNtCk1MksRf9kOQ1G216kSXszDjn2z4d=g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Irina Tirdea <irina.tirdea@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Cristina Ciocan <cristina.ciocan@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Charles Garcia-Tobin <charles.garcia-tobin@arm.com>

On Tue, Apr 05, 2016 at 10:37:14PM +0300, Octavian Purdila wrote:
> On Tue, Apr 5, 2016 at 7:59 PM, Mark Brown <broonie@kernel.org> wrote:

[...]

> Lets look at this from a different perspective. The proposal is not
> about importing the DT model into ACPI but importing the Linux pinctrl
> model into ACPI. That will allow us to use the Linux pinctrl drivers
> to their full potential.

Yes we understood that, and in the process you are bypassing the eg ACPI
power management model completely, but since all you are after is using
the Linux pinctrl kernel driver with ACPI _today_ without going through
the ASWG (and without booting with a device tree instead of ACPI) and
define a specification that has a chance to co-exist with the ACPI power
management model this proposal is the end result, it is a shortcut fraught
with problems.

> That doesn't stop the development of other, more OS independent, ACPI
> models for pinmuxing. Which we can also support.
> 
> I know that there are some discussions for pinmux configuration in the
> ASWG, but it does not match the Linux pinctrl model. So we will end up
> with a pinctrl driver that offers groups, functions and pin names and
> a totally different ACPI description that we can't map to the pinctrl
> driver.

If you know that there are some discussions please take place in those
discussions and work towards a solution that takes into account
other parts of ACPI specifications that can be affected, it may
take longer to get you there but that's true for everyone who
wants to contribute to ACPI specifications I am afraid.

Thank you,
Lorenzo
