From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH 0/4] Add ACPI support for pinctrl configuration
Date: Thu, 7 Apr 2016 20:01:45 +0200
Message-ID: <CACRpkdYbap1AM6pnQnqjfvsGbuU35ZcnMf_XEq81HQYwKcRS8Q@mail.gmail.com>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
	<20160404225200.GA1615@svinekod>
	<D3292CBB.662A8%charles.garcia-tobin@arm.com>
	<5704519F.5030906@redhat.com>
	<20160406104900.GA2820@xora-haswell.xora.org.uk>
	<CAE1zot+C7asvCfs2m=wNCBAKTHLpjYsPnmxQx_+inh9o0sPLwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:33180 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757341AbcDGSBq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Apr 2016 14:01:46 -0400
Received: by mail-ob0-f176.google.com with SMTP id tz8so52427017obc.0
        for <linux-acpi@vger.kernel.org>; Thu, 07 Apr 2016 11:01:45 -0700 (PDT)
In-Reply-To: <CAE1zot+C7asvCfs2m=wNCBAKTHLpjYsPnmxQx_+inh9o0sPLwg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: Graeme Gregory <gg@slimlogic.co.uk>, ahs3@redhat.com, Charles Garcia-Tobin <charles.garcia-tobin@arm.com>, Mark Rutland <mark.rutland@arm.com>, Irina Tirdea <irina.tirdea@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Cristina Ciocan <cristina.ciocan@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Apr 7, 2016 at 4:17 PM, Octavian Purdila
<octavian.purdila@intel.com> wrote:
> On Wed, Apr 6, 2016 at 1:49 PM, Graeme Gregory <gg@slimlogic.co.uk> wrote:

>> Why has there been no attempt in ASWG to make these sort of features a
>> 1st class citizen of ACPI so they can interact correctly with the other
>> features?
>
> IMO having an ASWG pinctrl specification and using _DSD for Linux are
> orthogonal approaches. The latter is very specific to Linux and we
> want it so that we can support the Linux pinctrl model as best as
> possible and I doubt it is a common denominator for all OSes that ACPI
> supports.

Sob, I tried so hard to implement pin control referring to generic
concepts that everyone should be able to reuse. E.g. stressing SI
units to be used all over the place, neutral scientific terms for all
config options and what not.

The multiplexing with groups and functions is a simple (aehm,
OK, super-complicated) matter of mapping disjunct sets onto each
other, so that comes from logic.

Not even the GPIO ranges that map GPIOs to pin ranges are very
Linux-specific: it is a property of the hardware that sometimes
GPIO is "behind" the pin, in a distinct hardware unit. (See pinctrl.txt
for the GPIO pitfalls.)

If I was to rewrite pin control and GPIO from scratch I would make it
one subsystem instead of two. This is more of an architectural
choice. GPIO would still be a stand-alone part of it.

Yours,
Linus Walleij
