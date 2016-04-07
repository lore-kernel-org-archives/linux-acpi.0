From: Octavian Purdila <octavian.purdila@intel.com>
Subject: Re: [RFC PATCH 0/4] Add ACPI support for pinctrl configuration
Date: Thu, 7 Apr 2016 17:17:23 +0300
Message-ID: <CAE1zot+C7asvCfs2m=wNCBAKTHLpjYsPnmxQx_+inh9o0sPLwg@mail.gmail.com>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
	<20160404225200.GA1615@svinekod>
	<D3292CBB.662A8%charles.garcia-tobin@arm.com>
	<5704519F.5030906@redhat.com>
	<20160406104900.GA2820@xora-haswell.xora.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20160406104900.GA2820@xora-haswell.xora.org.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Graeme Gregory <gg@slimlogic.co.uk>
Cc: ahs3@redhat.com, Charles Garcia-Tobin <charles.garcia-tobin@arm.com>, Mark Rutland <mark.rutland@arm.com>, Irina Tirdea <irina.tirdea@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Cristina Ciocan <cristina.ciocan@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 6, 2016 at 1:49 PM, Graeme Gregory <gg@slimlogic.co.uk> wrote:

>>
>> I have to echo Mark's concern: wholesale importation of portions of current
>> DT bindings simply because it's expedient is one of the things I've been hoping
>> to avoid.  These patches seem to be just that.
>>
>> And while the latest version mentioned above describes a bit of a review
>> process to handle this case, I don't recall the kernel community at large
>> agreeing to it, nor to it having been implemented.  If I missed that part,
>> my apologies; please let me know where it was decided.  If I haven't, then
>> perhaps this needs to be the first test case of that process.
>>
>
> My concern over this is similar to Mark/Als this looks like a quick hack
> to "solve" an issue that has been worked on in Linux for at least 10
> years now. And thats how to describe a non descoverable card that is
> plugged into random busses on a SoC.
>
> The issue I see with a quick hack of DT pinctrl into _DSD is that this
> does not take into account the power model of ACPI. As far as I can see
> the core code has no manner to tell a pin/function allocated through
> _DSD actually has effects on the power of other devices. So the core
> could end up powering down devices when it should not. This is very
> relevent to your intended use of IoT devices where power control is key.
>

It is not clear to me how this could happen - core powering down
devices when it should not, unless pins are shared.  And if I am not
missing something, pinctrl is designed to handle this case by only by
switching to idle/suspend/default states from the controller drivers
in the suspend/resume routine. ACPI _Sx calls also happens at the same
time so there does not seem to be a contention point.

Perhaps I am missing something and an example of such issue would make
it more clear.

And, as our primary use case is to set the initial muxing, we can
easily remove the suspend/resume functionality if this turns out to be
the issue.

> Why has there been no attempt in ASWG to make these sort of features a
> 1st class citizen of ACPI so they can interact correctly with the other
> features?
>

IMO having an ASWG pinctrl specification and using _DSD for Linux are
orthogonal approaches. The latter is very specific to Linux and we
want it so that we can support the Linux pinctrl model as best as
possible and I doubt it is a common denominator for all OSes that ACPI
supports.
