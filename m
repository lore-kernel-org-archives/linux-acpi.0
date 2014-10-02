From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 04/15] ACPI: Document ACPI device specific properties
Date: Thu, 02 Oct 2014 16:29:03 +0200
Message-ID: <3986527.L7rDZAb4g5@wuerfel>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com> <15893883.nvuW3ndylz@wuerfel> <20141002133654.GP1786@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:54362 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbaJBO3P (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Oct 2014 10:29:15 -0400
In-Reply-To: <20141002133654.GP1786@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Grant Likely <grant.likely@linaro.org>, Aaron Lu <aaron.lu@intel.com>, Darren Hart <dvhart@linux.intel.com>

On Thursday 02 October 2014 16:36:54 Mika Westerberg wrote:
> 
> > Even if you want to do automatic translation between DT and ACPI,
> > I think it would be possible to treat these two the same:
> > 
> > (forgive any syntax errors)
> > 
> >       Name (_DSD, Package () {
> >               ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >               Package () {
> >                       Package () { "pwms" { "led-red", ^PWM0, 0, 10 },
> >                                           { "led-green", ^PWM0, 1, 20 }},
> 
> Even though the above would fit better in ACPI, it is not allowed to
> have multiple values for a single property. One reason for that is that
> we validate each property and check that they match what is expected and
> having strict set of possible values makes it easier.

Ok, so you basically have the same limitation that we have in DT.

We have syntactical sugar in dtc that allows us to write


	pwms = <&pwm0 0 10>, <&pwm1 1 20>;

or

	pwms = <&pwm0 0 10   &pwm1 1 20>;

but the binary representation of the two is the same. This is the
only reason why we need the #size-cells property and I guess you
do too.	

> Putting everything to a single package results this:
> 
>                 Package () { "pwms", Package () {"led-red", ^PWM0, 0, 10, "led-green", ^PWM0, 1, 10 }}
> 
> But I think the below looks better:
> 
>                 Package () { "pwms", Package () {^PWM0, 0, 10, ^PWM0, 1, 10 }}
>                 Package () { "pwm-names", Package () {"led-red", "led-green"}}

Ok, if you have no way to separate the individual entries in a list of
references, I don't care much, and I can see the "pwm-names" as being more
consistent with the DT syntax.

Is this a limitation in the way that the AML syntax and compiler works,
or is this a decision you made specifically for the _DSD syntax and that
could still be changed if there is an overwhelming interest?

	Arnd
