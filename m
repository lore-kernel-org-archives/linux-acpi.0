From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: GPIO bindings guidelines (Was: Re: [PATCH v5 10/12] gpio: Support for unified device properties interface)
Date: Tue, 21 Oct 2014 09:54:45 +0200
Message-ID: <4582579.9WMrIMALsy@wuerfel>
References: <CAAVeFuLW6fucvDxQvY5DDfnhPrgYM+1pi7WoHfBQa_BgYnc_Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAVeFuLW6fucvDxQvY5DDfnhPrgYM+1pi7WoHfBQa_BgYnc_Cw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Courbot <gnurou@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Darren Hart <dvhart@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 21 October 2014 14:14:02 Alexandre Courbot wrote:
> >
> > We have enforced naming things for the dmaengine binding, which has
> > just led to everyone calling things "rx" and "tx". My fear is that
> > if we start to enforce giving a name, we'd end up with lots of
> > drivers that use a "gpio-gpios" property or something silly.
> 
> Checking the bindings is also part of the review process.  Things
> like "gpio-gpios" should simply not be accepted to begin with.
> 
> This sounds like a good chance to finally land some guidelines
> regarding GPIO bindings. Let's summarize the situation:
> - GPIO bindings can be defined using both DT and ACPI (both interfaces
> nicely abstracted by the interface introduced by this series)
> - Both firmware interfaces support indexed GPIOs
> - Both firmware interfaces support named GPIO properties, with an
> optional index (can we absolutely take this for granted on ACPI now?)

The developers working on it have said that they definitely want to
be compatible with the existing bindings, so the answer to your question
is yes.

> - For DT bindings, both foo-gpio and foo-gpios are valid properties
> for the GPIO "foo".

I would like to see the documentation recommend one over the other for
new bindings. Most other subsystems use the plural form even for
properties that only have one entry, so I'd like to see "foo-gpios"
become the canonical form for named gpio lines. Drivers that use
existing bindings with the "foo-gpio" form (or worse, "foo-somethingelse"
can use the same internal interface as the drivers that use name plus
index. Do you see a problem using what I suggested for the combined
API:

__gpiod_get(dev, propname, index); // use property name plus index
gpiod_get(dev, index); // use "gpios" plus index
gpiod_get_named(dev, "name"); use "name-gpios" with index 0

plus all fwprop/devm/flags/of/... variations of that

	Arnd
