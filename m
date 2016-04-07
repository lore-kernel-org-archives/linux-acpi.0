From: Octavian Purdila <octavian.purdila@intel.com>
Subject: Re: [RFC PATCH 0/4] Add ACPI support for pinctrl configuration
Date: Thu, 7 Apr 2016 15:11:53 +0300
Message-ID: <CAE1zotJ4OiQ_tMvCDm-KoF8cTJ9Z-n09FX7KR75j0DyAcsznLA@mail.gmail.com>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
	<20160404225200.GA1615@svinekod>
	<1F3AC3675D538145B1661F571FE1805F2F2342A6@irsmsx105.ger.corp.intel.com>
	<20160405181625.GA3064@svinekod>
	<CAE1zot+kyANCTPHGmj2W26f4LbS9Nkgt_9DNon-=0nsqRpT3Rw@mail.gmail.com>
	<20160406000130.GB8903@svinekod>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160406000130.GB8903@svinekod>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Tirdea, Irina" <irina.tirdea@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Ciocan, Cristina" <cristina.ciocan@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "charles.garcia-tobin@arm.com" <charles.garcia-tobin@arm.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 6, 2016 at 3:01 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Apr 05, 2016 at 11:09:34PM +0300, Octavian Purdila wrote:
>> On Tue, Apr 5, 2016 at 9:16 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> > * The firmware is to some extent expected to manage pinctrl today (for power
>> >   management of devices it does know about), and hence a pinctrl device is
>> >   potentially under shared management of ACPI and the OS.
>> >
>> > * The ACPI specification says nothing about this style of pinctrl management,
>> >   so it is unclear what the expectations are:
>>
>> Does it say anything at all about pinctrl management?
>
> To the best of my knowledge the ACPI spec does not explicitly mention pinctrl.
> In another reply it was mentioned that there is work in progress for pinmuxing,
> so evidently it is on the ASWG radar and within the scope of ACPI.
>
> I was trying to point out that it is _implicitly_ firmware's responsibility to
> do any pinctrl today, due to the ACPI model for power management, and the lack
> of an existing ACPI mechanisms to provide pinctrl data.
>
> In practice, firmware configures pinctrl at boot, and may modify pinctrl as
> part of the runtime power management firmware is put in charge of.
>

AFAIK the firmware only uses the pinctrl at boot to set the initial
values and the OS owns it after boot. The only interaction I know of
after boot are GPIO signaled events, but those are executed under the
control of the OS.

I don't understand the part about firmware being put in charge of
runtime power management. Do you mean that the firmware directly
accesses the pinctrl registers? Doesn't this contradict the ACPI goal
of having the OS control power management? Or do you mean accessing
pinctrl registers via _PSx and PowerResource._On/_Off?

> The lack of any statement about pinctrl would mean that there is effectively no
> reasonable limitation on what firmware might do with pinctrl, and we cannot
> assume specific behaviour from the firmware.
>

There is noting specified in the spec about other controllers, why is
pinctrl special in this regard?

> [...]
>
>> Since our focus is for open-ended configurations and for hardware that
>> it is not know to firmware we only considered the case where the pins
>> are not touched after the system boots.
>>
>> Now I wonder what are the cases were the firmware changes the pin
>> configuration after boot.
>
> Device power management and suspend/resume seem like the obvious cases.

I assume you are suggesting something like the following: we have a
device that is powered via a GPIO and associated ACPI _PS3/_PS0
methods are poking the pinctrl register to drive 0 or 1 to power on or
off the device.

If that is the case, we can easily break that today, by changing that
particular GPIO value via, e.g., sysfs.
