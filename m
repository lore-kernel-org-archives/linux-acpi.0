From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/6] ACPI / properties: Hierarchical properties support
Date: Thu, 27 Aug 2015 04:34:07 +0200
Message-ID: <1596179.pGEt0Ullqu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Darren Hart <darren.hart@intel.com>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, David Woodhouse <dwmw2@infradead.org>, Dustin Byford <dustin@cumulusnetworks.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Everyone,

This has been in the works for some time, but the official document it is
based on was not quite ready before the last week.  It now is available at

http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.pdf

The issue at hand is that we need to be able to support hierarchical device
properties in ACPI, like when the set of properties of an entity called "Fred"
may include a subset called "dog" containing the properties of the Fred's dog
rather than those of Fred himself.  And it may make sense to have the same
property, like "hair color", for both Fred and the dog, but with different
values.

We (I, Darren and Dave at least) have explored many possible ways to deal with
that in ACPI, but the majority of them turned out to be unattractive for various
reasons.  Our first take was to use ACPI device objects to make the "child"
property sets available via _DSD, but that approach is generally incompatible
with the PnP Manager in Windows following the notion that all device objects
in ACPI tables are supposed to represent real devices.  It can still be made
work by adding _STA that returns 0 to those "property-only" device objects,
but that leads to complications in other places and is error prone (if the _STA
is forgotten, for example).  Moreover, it adds quite a bit of overhead even in
Linux (an ACPICA representation, struct acpi_device, driver core mechanics etc)
for things that are only supposed to represent sets of device properties.  And,
in addition to that, we'd need to figure out how to give those things arbitrary
names in a consistent way.  All of that caused us to drop the approach based on
device objects and look for other options.

One of those was to nest the "child" property sets within _DSD packages, but it
follows from experience that this is error prone too (firmware people tend to have
problems with getting deeply nested packages right in ASL) and we wanted to be
able to visually distinguish those sets as separate entities in ASL code.  That
led us to the directory concept defined by the document mentioned above.

The idea is that _DSD may return a package containing the properties of the
device it belongs to along with a directory of objects that need to be evaluated
in order to obtain the "child" property sets of it.  That directory needs to be
present in a separate section of the _DSD package (after the new UUID defined in
the above document) and is a list of two-element sub-packages (entries) where
the first element is the name of the entry (the name of the "child" property set
represented by it) and the second element is a "pointer" (essentially, a path
or "namestring" in the ACPI terminology) to the control method or a static
data package that needs to be evaluated to obtain the entry's data.  The data
returned by it is then interpreted in the same way as a _DSD return package,
so it may also contain properties and a directory of its own "child" property
sets.

As an example, consider the following ASL from an experimental MinnowBoard
firmware:

        Device (LEDS)
        {
            Name (_HID, "PRP0001")

            Name (_CRS, ResourceTemplate () {
                GpioIo (Exclusive, PullDown, 0, 0, IoRestrictionOutputOnly,
                        "\\_SB.PCI0.LPC", 0, ResourceConsumer) {10}
                GpioIo (Exclusive, PullDown, 0, 0, IoRestrictionOutputOnly,
                        "\\_SB.PCI0.LPC", 0, ResourceConsumer) {11}
            })

            Name (_DSD, Package () {
                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                Package () {
                    Package () {"compatible", Package () {"gpio-leds"}},
                },
                // Data extension
                ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
                Package () {
                    Package () {"heartbeat", "LEDH"},
                    Package () {"mmc-activity", "LEDM"},
                }
            })

            Name (LEDH, Package () {
                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                Package () {
                    Package () {"label", "Heartbeat"},
                    Package () {"gpios", Package () {^LEDS, 0, 0, 0}},
                    Package () {"linux,default-trigger", "heartbeat"},
                    Package () {"linux,default-state", "off"},
                    Package () {"linux,retain-state-suspended", 1},
                }
            })

            Name (LEDM, Package () {
                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                Package () {
                    Package () {"label", Package () {"MMC0 Activity"}},
                    Package () {"gpios", Package () {^LEDS, 1, 0, 0}},
                    Package () {"linux,default-trigger", Package () {"mmc0"}},
                    Package () {"linux,default-state", "off"},
                    Package () {"linux,retain-state-suspended", 1},
                }
            })
        }

where each LED in a GPIO LED array is represented by a "child" property set of
the master device object LEDS.  There are two "child" sets called "heartbeat"
and "mmc-activity" whose data come from the LEDH and LEDM static data
packages under LEDS, respectively. 

The patch series introduces an infrastructure allowing "child" property
sets like the above to be accessed via the generic device properties API.
It represents those property sets as structures extending struct fwnode_handle
with the new type FWNODE_ACPI_DATA and reworks the ACPI property handling
code to do the right thing if an fwnode_handle of that type is passed to it
(please refer to the patch changelogs for details).

Please note that this new mechanism is not a replacement for anything.  It
simply adds general support for representing hierarchical properties of
devices in a new way, but things that worked previously should still work.

Also please let me know if you have objections agaist this approach or
suggestions on improving the code.

Although the 4.3 merge window has not officially opened yet, I'm not regarding
this as 4.3 material unless someone wants it in 4.3 really badly, in which
case please let me know ASAP as well.

Thanks,
Rafael
