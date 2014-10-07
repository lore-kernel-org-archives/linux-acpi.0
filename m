From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH 11/13] gpio: Support for unified device properties interface
Date: Tue, 7 Oct 2014 19:52:02 +0900
Message-ID: <CAAVeFuL_fNdavtAnG9fWOo6Qin8YG+f1x1QG-5Z37YRC4nQByQ@mail.gmail.com>
References: <2660541.BycO7TFnA2@vostro.rjw.lan> <2052507.JjE2hdgEYc@vostro.rjw.lan>
 <CAAVeFuJwONbZ30jk6B1jPDdUUMSkh7Va4BZFt08+w60yoO=NBw@mail.gmail.com> <20141007104021.GN1583@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141007104021.GN1583@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Darren Hart <dvhart@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Oct 7, 2014 at 7:40 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Tue, Oct 07, 2014 at 07:22:13PM +0900, Alexandre Courbot wrote:
>> On Tue, Oct 7, 2014 at 9:18 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > From: Mika Westerberg <mika.westerberg@linux.intel.com>
>> >
>> > Some drivers need to deal with only firmware representation of its
>> > GPIOs. An example would be a GPIO button array driver where each button
>> > is described as a separate firmware node in device tree. Typically these
>> > child nodes do not have physical representation in the Linux device
>> > model.
>> >
>> > In order to help device drivers to handle such firmware child nodes we
>> > add dev[m]_get_named_gpiod_from_child() that takes a child firmware
>> > node pointer as its second argument (the first one is the parent device
>> > itself), finds the GPIO using whatever is the underlying firmware
>> > method, and requests the GPIO properly.
>> >
>> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> ...
>>
>> > +/* Child properties interface */
>> > +struct gpio_desc *dev_get_named_gpiod_from_child(struct device *dev, void *child,
>> > +                                                const char *propname, int index);
>> > +struct gpio_desc *devm_get_named_gpiod_from_child(struct device *dev, void *child,
>> > +                                                 const char *propname, int index);
>>
>> I see the reason for these functions and am not opposed to them.
>> However, I wonder if we could not replace propname by a con_id that
>> would be resolved to one of con_id-gpio for DT and whatever naming
>> convention ACPI is using?
>
> The code in gpio-leds.c and gpio_keys_polled.c refers to "gpios" as the
> property name. If we can change that somehow to work with con_id-gpio
> instead without breaking things, then why not.
>
>> This would prevent users to name GPIOs outside of the conventions
>> defined in the bindings and be generally safer. Is there a particular
>> reason (used by some old code?) for the current direct property
>> access? If not, maybe we could call a slightly-modified of_find_gpio()
>> to resolve the GPIO property for DT, and the equivalent function for
>> ACPI?
>
> Only reason I can think of is support for the existing properties that
> are used directly. Drivers using gpiod_get() and friends do not need
> dev_get_named_gpiod_from_child() anyway.

Right. Another thing is that the property handling code (active low
only for now) is duplicated again, but that can be addressed
separately.

I will have a look at gpio-leds and gpio_keys_polled to see if we
cannot make this work at a higher level. It's easier to have the
bindings respected if the code itself enforces them.
