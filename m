From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [RFC PATCH 0/9] Add ACPI _DSD and unified device properties
 support
Date: Sat, 16 Aug 2014 09:06:05 -0700
Message-ID: <D014CE66.A19F5%dvhart@linux.intel.com>
References: <1408172039-32513-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45611 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527AbaHPQGY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 16 Aug 2014 12:06:24 -0400
In-Reply-To: <1408172039-32513-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Al Stone <al.stone@linaro.org>, Olof Johansson <olof@lixom.net>, Matthew Garrett <matthew.garrett@nebula.com>, Matt Fleming <matt.fleming@intel.com>, David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Josh Triplett <josh@joshtriplett.org>, Aaron Lu <aaron.lu@intel.com>, Max Eliaser <max.eliaser@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mark Brown <broonie@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-acpi@vg

On 8/15/14, 23:53, "Mika Westerberg" <mika.westerberg@linux.intel.com>
wrote:

>The recent publication of the ACPI 5.1 specification [1] adds a reserved
>name
>for Device Specific Data (_DSD, Section 6.2.5). This mechanism allows for
>passing arbitrary hardware description data to the OS. The exact format
>of the
>_DSD data is specific to the UUID paired with it [2].
>
>An ACPI Device Properties UUID has been defined [3] to provide a format
>compatible with existing device tree schemas. The purpose for this was to
>allow
>for the reuse of the existing schemas and encourage the development of
>firmware
>agnostic device drivers.
>
>This series accomplishes the following (as well as some other
>dependencies):
>
> * Add _DSD support to the ACPI core
>   This simply reads the UUID and the accompanying Package
>
> * Add ACPI Device Properties _DSD format support
>   This understands the hierarchical key:value pair structure
>   defined by the Device Properties UUID
>
> * Add a unified device properties API with ACPI and OF backends
>   This provides for the firmware agnostic device properties
>   Interface to be used by drivers
>
> * Provides 2 example drivers that were previously Device Tree aware that
>   can now be used with either Device Tree or ACPI Device Properties. The
>   both drivers use an arbitrary _HID.
>
>This has been tested on Minnowboard with relevant parts of the modified
>DSDT at the end of this email.


This eliminates the need for the board files that were the subject of my
"How not to write x86 platform drivers" talk at ELC-E last year. With
These ACPI core changes and the small changes to the two example drivers,
the Minnowboard can now use the GPIO buttons and LEDs through these
drivers by adding the ASL fragment below to the DSDT.

--
Darren

>
>------ DSDT For Minnowboard ------
>
>    Scope (\_SB.PCI0.LPC)
>    {
>        Device (LEDS)
>        {
>            Name (_HID, "MNW0001")
>
>            Name (_CRS, ResourceTemplate ()
>            {
>                GpioIo (Exclusive, PullDown, 0, 0,
>IoRestrictionOutputOnly,
>                        "\\_SB.PCI0.LPC", 0, ResourceConsumer) {10}
>                GpioIo (Exclusive, PullDown, 0, 0,
>IoRestrictionOutputOnly,
>                        "\\_SB.PCI0.LPC", 0, ResourceConsumer) {11}
>            })
>
>            Device (LEDH)
>            {
>                Name (_HID, "PRP0000")
>                Name (_DSD, Package ()
>                {
>                    ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                    Package ()
>                    {
>                        Package () {"label", "Heartbeat"},
>                        Package () {"gpios", Package () {^^LEDS, 0, 0,
>0}},
>                        Package () {"linux,default-trigger", "heartbeat"},
>                        Package () {"linux,default-state", "off"},
>                        Package () {"linux,retain-state-suspended", 1},
>                    }
>                })
>            }
>
>            Device (LEDM)
>            {
>                Name (_HID, "PRP0000")
>                Name (_DSD, Package ()
>                {
>                    ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                    Package ()
>                    {
>                        Package () {"label", "MMC0 Activity"},
>                        Package () {"gpios", Package () {^^LEDS, 1, 0,
>0}},
>                        Package () {"linux,default-trigger", "mmc0"},
>                        Package () {"linux,default-state", "on"},
>                        Package () {"linux,retain-state-suspended", 1},
>                    }
>                })
>            }
>        }
>        
>        Device (BTNS)
>        {
>            Name (_HID, "MNW0002")
>
>            Name (_CRS, ResourceTemplate ()
>            {
>                GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly,
>                        "\\_SB.PCI0.LPC", 0, ResourceConsumer) {0}
>                GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly,
>                        "\\_SB.PCI0.LPC", 0, ResourceConsumer) {1}
>                GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly,
>                        "\\_SB.PCI0.LPC", 0, ResourceConsumer) {2}
>                GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly,
>                        "\\_SB.PCI0.LPC", 0, ResourceConsumer) {3}
>            })
>
>            Name (_DSD, Package ()
>            {
>                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                Package ()
>                {
>                    Package () {"poll-interval", 100},
>                    Package () {"autorepeat", 1}
>                }
>            })
>
>            Device (BTN0)
>            {
>                Name (_HID, "PRP0000")
>                Name (_DSD, Package ()
>                {
>                    ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                    Package ()
>                    {
>                        Package () {"linux,code", 105},
>                        Package () {"linux,input-type", 1},
>                        Package () {"gpios", Package () {^^BTNS, 0, 0,
>1}},
>                    }
>                })
>            }
>
>            Device (BTN1)
>            {
>                Name (_HID, "PRP0000")
>                Name (_DSD, Package ()
>                {
>                    ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                    Package ()
>                    {
>                        Package () {"linux,code", 108},
>                        Package () {"linux,input-type", 1},
>                        Package () {"gpios", Package (4) {^^BTNS, 1, 0,
>1}},
>                    }
>                })
>            }
>            
>            Device (BTN2)
>            {
>                Name (_HID, "PRP0000")
>                Name (_DSD, Package ()
>                {
>                    ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                    Package ()
>                    {
>                        Package () {"linux,code", 103},
>                        Package () {"linux,input-type", 1},
>                        Package () {"gpios", Package () {^^BTNS, 2, 0,
>1}},
>                    }
>                })
>            }
>            
>            Device (BTN3)
>            {
>                Name (_HID, "PRP0000")
>                Name (_DSD, Package ()
>                {
>                    ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                    Package ()
>                    {
>                        Package () {"linux,code", 106},
>                        Package () {"linux,input-type", 1},
>                        Package () {"gpios", Package (4) {^^BTNS, 3, 0,
>1}},
>                    }
>                })
>            }
>
>        }
>
>    }
>
>-- 
>2.1.0.rc1
>
>


-- 
Darren Hart					Open Source Technology Center
darren.hart@intel.com				            Intel Corporation



