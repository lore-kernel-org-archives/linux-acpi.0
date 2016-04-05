From: "Tirdea, Irina" <irina.tirdea@intel.com>
Subject: RE: [RFC PATCH 0/4] Add ACPI support for pinctrl configuration
Date: Tue, 5 Apr 2016 15:33:43 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F2342A6@irsmsx105.ger.corp.intel.com>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
 <20160404225200.GA1615@svinekod>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:37714 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758661AbcDEPdt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Apr 2016 11:33:49 -0400
In-Reply-To: <20160404225200.GA1615@svinekod>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Purdila, Octavian" <octavian.purdila@intel.com>, "Ciocan, Cristina" <cristina.ciocan@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "charles.garcia-tobin@arm.com" <charles.garcia-tobin@arm.com>



> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland@arm.com]
> Sent: 05 April, 2016 1:52
> To: Tirdea, Irina
> Cc: Rafael J. Wysocki; Len Brown; Mika Westerberg; Linus Walleij; linux-gpio@vger.kernel.org; linux-acpi@vger.kernel.org; Rob
> Herring; Heikki Krogerus; Andy Shevchenko; Purdila, Octavian; Ciocan, Cristina; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; charles.garcia-tobin@arm.com
> Subject: Re: [RFC PATCH 0/4] Add ACPI support for pinctrl configuration
> 
> Hi,

Hi Mark,

> 
> On Thu, Mar 31, 2016 at 02:44:41PM +0300, Irina Tirdea wrote:
> > This is a proposal for adding ACPI support for pin controller
> > configuration.
> >
> > It has been developed to enable the MinnowBoard and IoT community
> > by providing an easy way to specify pin multiplexing and
> > pin configuration.
> >
> > This proposal is based on using _DSD properties to specify device
> > states and configuration nodes and it follows closely the device
> > tree model. Device states are defined using the Device Properties
> > format and the configuration nodes are defined using the
> > Hierarchical Properties Extension format. The generic properties
> > for the configuration nodes are the same as the ones for device
> > tree, while pincontroller drivers can also define custom ones.
> 
> From a look of the Documentation addition, and of the current uses of
> pinctrl-names in device tree bindings, one reason for requiring multiple
> pinctrl states is power management. Given that, I'm somewhat concerned by this,
> as it goes against the usual ACPI model of abstracting this sort of thing
> behind power control methods.
> 

Right, there is an overlap of the pinctrl "sleep" state with the ACPI power
management model. 

However, the main reason for implementing this is setting initial pin multiplexing
and configuration. This is normally done by BIOS, but there is currently no way of
changing the default configuration (except for a BIOS update). This is a problem
when using boards like MinnowBoard, where it is expected to get the board and
to be able to add various devices to its exported GPIO pins. We need a way to
change default pin multiplexing to enable the functionality required by a specific
device. In some cases we also need to set the bias to get things like interrupts working.

Another use case for pinctrl states is using custom reset pin configurations that need
to be controlled from the driver.

Since we have the pinctrl infrastructure and the all Intel ACPI pinctrl drivers already
support it, this seems the most straightforward way to implement it.

> To the best of my knowledge, that goes against the ASWG's expectations on how
> _DSD will be used (per [1]). Charles, please correct me if that document is no
> longer representative.
> 
> Additionally, pinctrl has some cross-cutting concerns (e.g. mutually exclusive
> device usage due to a shared pin), and I can imagine that may interact poorly
> with any AML or firmware assumptions about the state of the world, as there's
> no mechanism present to notify those of changes to pins.
> 

This is a problem with any modification we would make to the ACPI tables. 
It is true that pinctrl configuration could create conflicts when changing
pin multiplexing, but that could be avoided by using only the pinctrl states that
make sense for the entire ACPI configuration.

> I think that this is a class of problem which needs to be raised with the ASWG,
> and solved in an ACPI-native fashion, rather than simply copying properties
> from DT using _DSD. If nothing else, the restrictions on FW and AML would need
> to be specified.

I agree this should be at least mentioned in the Documentation. I'll update it accordingly.


Thanks,
Irina

> 
> Thanks,
> Mark.
> 
> [1] https://lists.acpica.org/pipermail/dsd/2015-September/000019.html
