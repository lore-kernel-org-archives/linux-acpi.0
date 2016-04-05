From: Octavian Purdila <octavian.purdila@intel.com>
Subject: Re: [RFC PATCH 0/4] Add ACPI support for pinctrl configuration
Date: Tue, 5 Apr 2016 23:09:34 +0300
Message-ID: <CAE1zot+kyANCTPHGmj2W26f4LbS9Nkgt_9DNon-=0nsqRpT3Rw@mail.gmail.com>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
	<20160404225200.GA1615@svinekod>
	<1F3AC3675D538145B1661F571FE1805F2F2342A6@irsmsx105.ger.corp.intel.com>
	<20160405181625.GA3064@svinekod>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20160405181625.GA3064@svinekod>
Sender: linux-gpio-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Tirdea, Irina" <irina.tirdea@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Ciocan, Cristina" <cristina.ciocan@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "charles.garcia-tobin@arm.com" <charles.garcia-tobin@arm.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 5, 2016 at 9:16 PM, Mark Rutland <mark.rutland@arm.com> wrote:

>>
>> Right, there is an overlap of the pinctrl "sleep" state with the ACPI power
>> management model.
>>
>> However, the main reason for implementing this is setting initial pin multiplexing
>> and configuration. This is normally done by BIOS, but there is currently no way of
>> changing the default configuration (except for a BIOS update). This is a problem
>> when using boards like MinnowBoard, where it is expected to get the board and
>> to be able to add various devices to its exported GPIO pins.
>
> In the absence of a BIOS update, how is it expected that the relevant pinctrl
> settings for a given device will be known? Does the device provide ACPI
> fragments like an SSDT? Does it simply identify itself in some manner, and
> leave the rest to the kernel? Is this entirely user-driven?
>

See this patch set I just proposed: https://lkml.org/lkml/2016/3/31/334

>> We need a way to change default pin multiplexing to enable the functionality
>> required by a specific device. In some cases we also need to set the bias to
>> get things like interrupts working.
>>
>> Another use case for pinctrl states is using custom reset pin configurations that need
>> to be controlled from the driver.
>
> To be clear, I'm not stating that having pinctrl under the OS is necessarily
> wrong, and I can see why the firmware may not have all the relevant knowledge
> in advance. I can certainly see why having the OS in control can be preferable.
>
> My concern is that there is a conflict with the ACPI model, and potential
> fragility, given that:
>
> * The firmware does not have the relevant information in advance for a given
>   device that may be connected (i.e. how devices may change the pinctrl setup
>   is unknown).
>
> * The firmware is to some extent expected to manage pinctrl today (for power
>   management of devices it does know about), and hence a pinctrl device is
>   potentially under shared management of ACPI and the OS.
>
> * The ACPI specification says nothing about this style of pinctrl management,
>   so it is unclear what the expectations are:
>

Does it say anything at all about pinctrl management?

>   - Is a given pinctrl device under shared ownership by the firmware and
>     kernel, or is a given device entirely under the control of just one?
>
>   - How shared access to the pinctrl device is mediated, e.g. is any locking or
>     signalling mechanism required to ensure that firmware and kernel do not
>     access the device simultaneously in a manner that causes problems.
>
>   - Is the firmware permitted to perform power management of devices for which
>     the kernel handles pinctrl? What states can either expect, and when is such
>     management permitted? e.g. must the OS ensure that a device is in its
>     default state? Can it only call power management calls from particular
>     states? What is the restored state?
>
>   - What the expectations are w.r.t. ownership of pins, e.g. must the firmware
>     never change the state of certain pins? Must it save/restore their state in
>     system-wide power-management scenarios like suspend or hibernate?
>
> I think this needs to be raised with the ASWG, and some level of model needs to
> be defined for this, to cater for the issues raised above.
>
> That might be very simple, e.g. pins are never shared, the pinctrl management
> device must permit concurrent accesses by FW and kernel, the kernel is
> responsible for all management of those pins after system reset.
>
> In the absence of that, this is liable to become fragmented and fragile, and is
> practically impossible to rectify post-hoc.
>

All very good points.

Since our focus is for open-ended configurations and for hardware that
it is not know to firmware we only considered the case where the pins
are not touched after the system boots.

Now I wonder what are the cases were the firmware changes the pin
configuration after boot.
