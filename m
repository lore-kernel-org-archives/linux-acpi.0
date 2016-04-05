From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH 0/4] Add ACPI support for pinctrl configuration
Date: Tue, 5 Apr 2016 19:16:26 +0100
Message-ID: <20160405181625.GA3064@svinekod>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
 <20160404225200.GA1615@svinekod>
 <1F3AC3675D538145B1661F571FE1805F2F2342A6@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52952 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751053AbcDES0g (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Apr 2016 14:26:36 -0400
Content-Disposition: inline
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F2342A6@irsmsx105.ger.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Tirdea, Irina" <irina.tirdea@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Purdila, Octavian" <octavian.purdila@intel.com>, "Ciocan, Cristina" <cristina.ciocan@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "charles.garcia-tobin@arm.com" <charles.garcia-tobin@arm.com>

On Tue, Apr 05, 2016 at 03:33:43PM +0000, Tirdea, Irina wrote:
> > -----Original Message-----
> > From: Mark Rutland [mailto:mark.rutland@arm.com]
> > On Thu, Mar 31, 2016 at 02:44:41PM +0300, Irina Tirdea wrote:
> > > This is a proposal for adding ACPI support for pin controller
> > > configuration.
> > >
> > > It has been developed to enable the MinnowBoard and IoT community
> > > by providing an easy way to specify pin multiplexing and
> > > pin configuration.
> > >
> > > This proposal is based on using _DSD properties to specify device
> > > states and configuration nodes and it follows closely the device
> > > tree model. Device states are defined using the Device Properties
> > > format and the configuration nodes are defined using the
> > > Hierarchical Properties Extension format. The generic properties
> > > for the configuration nodes are the same as the ones for device
> > > tree, while pincontroller drivers can also define custom ones.
> > 
> > From a look of the Documentation addition, and of the current uses of
> > pinctrl-names in device tree bindings, one reason for requiring multiple
> > pinctrl states is power management. Given that, I'm somewhat concerned by this,
> > as it goes against the usual ACPI model of abstracting this sort of thing
> > behind power control methods.
> > 
> 
> Right, there is an overlap of the pinctrl "sleep" state with the ACPI power
> management model. 
> 
> However, the main reason for implementing this is setting initial pin multiplexing
> and configuration. This is normally done by BIOS, but there is currently no way of
> changing the default configuration (except for a BIOS update). This is a problem
> when using boards like MinnowBoard, where it is expected to get the board and
> to be able to add various devices to its exported GPIO pins.

In the absence of a BIOS update, how is it expected that the relevant pinctrl
settings for a given device will be known? Does the device provide ACPI
fragments like an SSDT? Does it simply identify itself in some manner, and
leave the rest to the kernel? Is this entirely user-driven?

> We need a way to change default pin multiplexing to enable the functionality
> required by a specific device. In some cases we also need to set the bias to
> get things like interrupts working.
> 
> Another use case for pinctrl states is using custom reset pin configurations that need
> to be controlled from the driver.

To be clear, I'm not stating that having pinctrl under the OS is necessarily
wrong, and I can see why the firmware may not have all the relevant knowledge
in advance. I can certainly see why having the OS in control can be preferable.

My concern is that there is a conflict with the ACPI model, and potential
fragility, given that:

* The firmware does not have the relevant information in advance for a given
  device that may be connected (i.e. how devices may change the pinctrl setup
  is unknown).

* The firmware is to some extent expected to manage pinctrl today (for power
  management of devices it does know about), and hence a pinctrl device is
  potentially under shared management of ACPI and the OS.

* The ACPI specification says nothing about this style of pinctrl management,
  so it is unclear what the expectations are:

  - Is a given pinctrl device under shared ownership by the firmware and
    kernel, or is a given device entirely under the control of just one?

  - How shared access to the pinctrl device is mediated, e.g. is any locking or
    signalling mechanism required to ensure that firmware and kernel do not
    access the device simultaneously in a manner that causes problems.

  - Is the firmware permitted to perform power management of devices for which
    the kernel handles pinctrl? What states can either expect, and when is such
    management permitted? e.g. must the OS ensure that a device is in its
    default state? Can it only call power management calls from particular
    states? What is the restored state?

  - What the expectations are w.r.t. ownership of pins, e.g. must the firmware
    never change the state of certain pins? Must it save/restore their state in
    system-wide power-management scenarios like suspend or hibernate?

I think this needs to be raised with the ASWG, and some level of model needs to
be defined for this, to cater for the issues raised above.

That might be very simple, e.g. pins are never shared, the pinctrl management
device must permit concurrent accesses by FW and kernel, the kernel is
responsible for all management of those pins after system reset.

In the absence of that, this is liable to become fragmented and fragile, and is
practically impossible to rectify post-hoc.

> Since we have the pinctrl infrastructure and the all Intel ACPI pinctrl drivers already
> support it, this seems the most straightforward way to implement it.

I do not disagree that this is expedient. I am concerned that it permits a very
large set of avoidable problems, and I believe that we need to be somewhat
stricter from the outset.

> > Additionally, pinctrl has some cross-cutting concerns (e.g. mutually exclusive
> > device usage due to a shared pin), and I can imagine that may interact poorly
> > with any AML or firmware assumptions about the state of the world, as there's
> > no mechanism present to notify those of changes to pins.
> 
> This is a problem with any modification we would make to the ACPI tables. 
> It is true that pinctrl configuration could create conflicts when changing
> pin multiplexing, but that could be avoided by using only the pinctrl states that
> make sense for the entire ACPI configuration.

I think that "makes sense for the entire ACPI configuration" needs to be
defined, and then mandated, which implies an ACPI spec addition.

Thanks,
Mark.
