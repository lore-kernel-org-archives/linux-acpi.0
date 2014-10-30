From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: GPIO bindings guidelines (Was: Re: [PATCH v5 10/12] gpio: Support
 for unified device properties interface)
Date: Thu, 30 Oct 2014 16:11:13 +0100
Message-ID: <CACRpkdYfEgC0iZCb=juBewpnCos+wbDVD14veRxXGSyBExAfEQ@mail.gmail.com>
References: <CAAVeFuLW6fucvDxQvY5DDfnhPrgYM+1pi7WoHfBQa_BgYnc_Cw@mail.gmail.com>
	<4582579.9WMrIMALsy@wuerfel>
	<CAAVeFuJzZJdh+Z7hY-Ws3orxyO=PSqCB_eBphbWk3nRb15op2w@mail.gmail.com>
	<2964475.27LDgQTJ7C@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:52588 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760309AbaJ3PLO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Oct 2014 11:11:14 -0400
Received: by mail-ie0-f171.google.com with SMTP id x19so5411388ier.2
        for <linux-acpi@vger.kernel.org>; Thu, 30 Oct 2014 08:11:14 -0700 (PDT)
In-Reply-To: <2964475.27LDgQTJ7C@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Darren Hart <dvhart@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>

On Thu, Oct 23, 2014 at 2:25 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 23 October 2014 15:02:46 Alexandre Courbot wrote:
>> On Tue, Oct 21, 2014 at 4:54 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Tuesday 21 October 2014 14:14:02 Alexandre Courbot wrote:
>
>> > Drivers that use
>> > existing bindings with the "foo-gpio" form (or worse, "foo-somethingelse"
>> > can use the same internal interface as the drivers that use name plus
>> > index. Do you see a problem using what I suggested for the combined
>> > API:
>> >
>> > __gpiod_get(dev, propname, index); // use property name plus index
>> > gpiod_get(dev, index); // use "gpios" plus index
>> > gpiod_get_named(dev, "name"); use "name-gpios" with index 0
>>
>> Apart from the loosy naming practices which we sometimes see (and
>> which should be caught during review), do you have something against
>> requiring a name for all new GPIO bindings, i.e. for ensuring that all
>> new properties are "name-gpio" and forbidding "gpios"?
>
> Most other subsystems don't require a name, and traditionally we only
> had anonymous indexed properties for a lot of things (registers,
> interrupts, ...).
>
> I still like the idea of using anonymous references for simple things,
> but if you and Linus feel that it's better to mandate names from now on,
> I won't complain.

I think names are nice since it appears in <debugfs>/gpio and makes
device tree using platforms easier to debug.

Moving things into DT already made information hard to follow at
times...

In difference from other things like IRQs or DMAs, GPIOs very often
have a very specific function, does not repeat itself, and thus can
be given a suitable name.

Yours,
Linus Walleij
