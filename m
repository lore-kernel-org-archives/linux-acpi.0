From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 04/15] ACPI: Document ACPI device specific properties
Date: Thu, 02 Oct 2014 14:46:30 +0200
Message-ID: <15893883.nvuW3ndylz@wuerfel>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com> <2466832.0XJezjdvYs@wuerfel> <20141002121508.GM1786@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:64707 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbaJBMql (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Oct 2014 08:46:41 -0400
In-Reply-To: <20141002121508.GM1786@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Grant Likely <grant.likely@linaro.org>, Aaron Lu <aaron.lu@intel.com>, Darren Hart <dvhart@linux.intel.com>

On Thursday 02 October 2014 15:15:08 Mika Westerberg wrote:
> > I thought when we had discussed the subsystem specific bindings, the
> > consensus there was to have subsystem specific accessors and
> > properties/tables.
> > 
> > I would argue that for everything that ACPI already has (interrupts,
> > registers, gpio, dmaengine, ...) the native method should be used,
> > possibly using _DSD to provide naming for otherwise anonymous references.
> 
> Absolutely. That's precisely what we do in the GPIO patch of this
> series. E.g we use ACPI GpioIo/GpioInt _CRS resources but give name to
> the GPIOs with the help of _DSD.

Ok, I've looked at the example again:

+       Device (DEV0)
+       {
+               Name (_CRS, ResourceTemplate () {
+                       GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly,
+                               "\\_SB.PCI0.LPC", 0, ResourceConsumer) {0}
+                       GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly,
+                               "\\_SB.PCI0.LPC", 0, ResourceConsumer) {1}
+                       ...
+               })
+
+               Name (_DSD, Package () {
+                       ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+                       Package () {
+                               Package () {"reset-gpio", {^DEV0, 0, 0, 0}},
+                               Package () {"shutdown-gpio", {^DEV0, 1, 0, 0}},
+                       }
+               })
+       }

tell me if I'm interpreting this right: you use _CRS to define a reference
to the actual GPIO controller here, but then in your _DSD you have something
that is a bit like the DT gpio binding, except that it doesn't refer to
a GPIO controller but to the GPIO using device itself.

When a driver calls dev_get_named_gpiod_from_child, you then lookup the
"reset-gpio" (or other) properties to find the reference to the _CRS.

Why can't you instead have a "gpio-names" property in _DSD that just
links from a string to an index as we do in all the other bindings?
It sounds to me like that would be simpler and more consistent with
the way things are done in ACPI, and have no effect that would be visible
to the driver.
 
> For things that don't have correspondence in ACPI but have well defined
> existing DT schema, like PWMs, we should follow that.

Only for stuff that is visible to drivers. I think it's important
that a driver calling pwm_get() today should keep working with
ACPI when the pwm subsystem is extended to support that.

However, that does not necessarily mean using #pwm-cells and pwm-names
properties when there is a better way to express the same in ACPI
syntax. AFAICT, the #foo-names is completely redundant for ACPI
as the length of a property in a list of similar elements is part
of the binary data (if not, please correct me), and I already commented
that I think the foo-names stuff could be encoded in the package
directly in a way we can't do in DT.

Even if you want to do automatic translation between DT and ACPI,
I think it would be possible to treat these two the same:

(forgive any syntax errors)

	Name (_DSD, Package () {
		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
		Package () {
			Package () { "pwms" { "led-red", ^PWM0, 0, 10 },
					    { "led-green", ^PWM0, 1, 20 }},
	}

vs.

	pwm-slave {
		pwms = <&pwm0 0 10>, <&pwm1 1 20>;
		pwm-names = "led-red", "led-green";
	};


	Arnd
