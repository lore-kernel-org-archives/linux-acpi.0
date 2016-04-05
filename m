From: Octavian Purdila <octavian.purdila@intel.com>
Subject: Re: [RFC PATCH 0/4] Add ACPI support for pinctrl configuration
Date: Tue, 5 Apr 2016 22:37:14 +0300
Message-ID: <CAE1zot+-=JQkMqRPpNtCk1MksRf9kOQ1G216kSXszDjn2z4d=g@mail.gmail.com>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
	<20160404225200.GA1615@svinekod>
	<CACRpkdb=Ef1-g-r9NW-4_xeKdke0FFhnN+JYPjVKog3L4At8Lg@mail.gmail.com>
	<20160405165935.GA5456@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36188 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933468AbcDEThQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Apr 2016 15:37:16 -0400
Received: by mail-wm0-f53.google.com with SMTP id v188so137657wme.1
        for <linux-acpi@vger.kernel.org>; Tue, 05 Apr 2016 12:37:15 -0700 (PDT)
In-Reply-To: <20160405165935.GA5456@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Irina Tirdea <irina.tirdea@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Cristina Ciocan <cristina.ciocan@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Charles Garcia-Tobin <charles.garcia-tobin@arm.com>

On Tue, Apr 5, 2016 at 7:59 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Apr 05, 2016 at 10:43:11AM +0200, Linus Walleij wrote:
>
>> And these products are only update-able
>> with hairy BIOS patches that need to be applied
>> using $SPECIAL_TOOL  that "normal users" do not want to
>> concern themselves with, as this is not an "apt-get upgrade"
>> kind of thing.
>
> This bit has been addressed in UEFI - there's now a mechanism for the OS
> to supply firmware updates to the BIOS via runtime sevices calls without
> needing to go to the hairy tools.

AFAIK there is still no standard way of updating just the ACPI tables.
You need various tools to "stitch" a full firmware image that can be
consumed by the update mechanism.

> There's also been facilities for some
> time which allow ACPI fragments to be loaded at runtime without patching
> the firmware (though they're not used so often at present).

And I just sent a separate patch series for "ACPI overlays", similar
with the dynamic DT, with the primary goal of supporting open-ended
hardware configurations.

But to be able to effectively use this we need a way to change pinmux settings.

>> And I think that is what is happening, it's just that so much
>> prestige is involved that no-one wants to officially admit it.
>
>> I was once poking fun at this development model accusing
>> firmware engineers of having a God complex when they claim
>> to be able to engineer in these complex use cases during
>
> That's not really a fair characterization of the situation.  The goal
> that ACPI has been trying to meet is allowing new hardware to work
> without needing software updates so people's installation experience
> isn't miserable.  The Windows monoculture that firmware developers have
> been targetting has hurt the achievement of that but it's the idea.
> It's a good model for some classes of device but not for all.
>
>> product firmware development. Now I just feel sad about this
>> situation and want things to "just work" for them. I think these
>> patches are good.
>
> See Mark Rutland's reply - there's a whole model behind how ACPI
> abstracts the system that needs to be taken into account, just stuffing
> the existing DT in through a mechanism intended for simple vendor
> specific key/value properties isn't guaranteed to give something that's
> coherent and sensible.  DT design decisions will obviously not have
> considered ACPI and exposing the full combination of the two system
> models to system integrators seems likely to lead to unfortunate
> corners, especially with things that happen to work right now but cause
> problems later on.
>
> Given the rush to shoehorn existing DT into ACPI at some point it's
> looking like it would be much more sensible for x86 to just do what
> arm64 has done and support both DT and ACPI in parallel and let people
> (either system integrators or end users) choose the most appropriate
> interface for their application.

Lets look at this from a different perspective. The proposal is not
about importing the DT model into ACPI but importing the Linux pinctrl
model into ACPI. That will allow us to use the Linux pinctrl drivers
to their full potential.

That doesn't stop the development of other, more OS independent, ACPI
models for pinmuxing. Which we can also support.

I know that there are some discussions for pinmux configuration in the
ASWG, but it does not match the Linux pinctrl model. So we will end up
with a pinctrl driver that offers groups, functions and pin names and
a totally different ACPI description that we can't map to the pinctrl
driver.
