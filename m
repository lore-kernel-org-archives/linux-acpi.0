From: Dustin Byford <dustin@cumulusnetworks.com>
Subject: Re: [PATCH 0/6] ACPI / properties: Hierarchical properties support
Date: Thu, 27 Aug 2015 17:10:48 -0700
Message-ID: <20150828001048.GA10729@cumulusnetworks.com>
References: <1596179.pGEt0Ullqu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1596179.pGEt0Ullqu@vostro.rjw.lan>
Sender: linux-gpio-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Darren Hart <darren.hart@intel.com>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, David Woodhouse <dwmw2@infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu Aug 27 04:34, Rafael J. Wysocki wrote:

Hi Rafael,

> The issue at hand is that we need to be able to support hierarchical device
> properties in ACPI, like when the set of properties of an entity called "Fred"
> may include a subset called "dog" containing the properties of the Fred's dog
> rather than those of Fred himself.  And it may make sense to have the same
> property, like "hair color", for both Fred and the dog, but with different
> values.

OK.  I have a couple of questions.

> We (I, Darren and Dave at least) have explored many possible ways to deal with
> that in ACPI, but the majority of them turned out to be unattractive for various
> reasons.  Our first take was to use ACPI device objects to make the "child"
> property sets available via _DSD, but that approach is generally incompatible
> with the PnP Manager in Windows following the notion that all device objects
> in ACPI tables are supposed to represent real devices.  It can still be made
> work by adding _STA that returns 0 to those "property-only" device objects,
> but that leads to complications in other places and is error prone (if the _STA
> is forgotten, for example).  Moreover, it adds quite a bit of overhead even in
> Linux (an ACPICA representation, struct acpi_device, driver core mechanics etc)
> for things that are only supposed to represent sets of device properties.  And,
> in addition to that, we'd need to figure out how to give those things arbitrary
> names in a consistent way.  All of that caused us to drop the approach based on
> device objects and look for other options.

What's the overhead/effect on Windows for an ACPI object without a _HID (_ADR
only)?  That seems like a case where the OS shouldn't be expecting to load
another driver for the ACPI object and the _ADR gives each node a unique name
(even if it is an unfriendly integer)

> The idea is that _DSD may return a package containing the properties of the
> device it belongs to along with a directory of objects that need to be evaluated
> in order to obtain the "child" property sets of it.  That directory needs to be
> present in a separate section of the _DSD package (after the new UUID defined in
> the above document) and is a list of two-element sub-packages (entries) where
> the first element is the name of the entry (the name of the "child" property set
> represented by it) and the second element is a "pointer" (essentially, a path
> or "namestring" in the ACPI terminology) to the control method or a static
> data package that needs to be evaluated to obtain the entry's data.  The data
> returned by it is then interpreted in the same way as a _DSD return package,
> so it may also contain properties and a directory of its own "child" property
> sets.

Do you expect there to be cases where using an ACPI device object is more
desirable than hierarchical properties?  Or is it just impossible given the PNP
manager in Windows?

The best example I can think of is perhaps a multi function device where each
sub-function really does look like a separate device and you probably want to
reference that sub-device, as a device, in other ASL code.

Stating the above more generally, by taking this approach you loose the ability
to reference these child nodes as a device object.  In this LED example, I
think it would be nice to set the "trigger" for the led by adding a reference
to the LED from another device (such as a NIC).

Device (NIC0)
{
    ...
    Name (_DSD, Package () {
        ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
        Package () {
            Package () {"activity-led", LEDS.LEDM },
            Package () {"link-led", LEDS.LEDH },
        },
    }
}

I'm not sure that's even supported in devicetree or LEDs are the best example
of this, but the pattern seems generally useful.

Without a device you're also forced to use a "label" property instead of a
_STR.

> As an example, consider the following ASL from an experimental MinnowBoard
> firmware:
> 
>         Device (LEDS)
>         {
>             Name (_HID, "PRP0001")
> 
>             Name (_CRS, ResourceTemplate () {
>                 GpioIo (Exclusive, PullDown, 0, 0, IoRestrictionOutputOnly,
>                         "\\_SB.PCI0.LPC", 0, ResourceConsumer) {10}
>                 GpioIo (Exclusive, PullDown, 0, 0, IoRestrictionOutputOnly,
>                         "\\_SB.PCI0.LPC", 0, ResourceConsumer) {11}
>             })
> 
>             Name (_DSD, Package () {
>                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                 Package () {
>                     Package () {"compatible", Package () {"gpio-leds"}},
>                 },
>                 // Data extension
>                 ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
>                 Package () {
>                     Package () {"heartbeat", "LEDH"},
>                     Package () {"mmc-activity", "LEDM"},

I guess LEDH and LEDM have to be strings here.  It would be nice if the
compiler could verify the path resolves.  I suppose it's more incentive to keep
these in the same scope.

>            Name (LEDH, Package () {
>                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                Package () {
>                    Package () {"label", "Heartbeat"},
>                    Package () {"gpios", Package () {^LEDS, 0, 0, 0}},
>                    Package () {"linux,default-trigger", "heartbeat"},
>                    Package () {"linux,default-state", "off"},
>                    Package () {"linux,retain-state-suspended", 1},
>                }
>            })
>            
>            Name (LEDM, Package () {
>                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                Package () {
>                    Package () {"label", Package () {"MMC0 Activity"}},
>                    Package () {"gpios", Package () {^LEDS, 1, 0, 0}},
>                    Package () {"linux,default-trigger", Package () {"mmc0"}},
>                    Package () {"linux,default-state", "off"},
>                    Package () {"linux,retain-state-suspended", 1},
>                }
>            })
>        }

I suspect you've thought of all of this.  Thanks in advance for any
explanations.

                --Dustin
