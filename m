From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/3] spi / ACPI: add ACPI enumeration support
Date: Wed, 7 Nov 2012 11:56:08 +0200
Message-ID: <20121107095608.GX24532@intel.com>
References: <1351928793-14375-1-git-send-email-mika.westerberg@linux.intel.com>
 <3455360.Z6cZSC3BtR@vostro.rjw.lan>
 <CAErSpo5xEO4M_Fb0dJ6w7Qxck-0RcKKwQjKj1QZgFxhof7X5Rw@mail.gmail.com>
 <1523215.Pon1eKPQDb@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1523215.Pon1eKPQDb@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, mathias.nyman@linux.intel.com, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 06, 2012 at 11:18:11PM +0100, Rafael J. Wysocki wrote:
> > How is the SPI controller different than this?  Is there some logical
> > difference that requires a different framework?  Or are you proposing
> > that we get rid of acpi_bus_register_driver() and migrate everything
> > to this new framework?
> 
> Yes, I do, but let's just do it gradually.

Bjorn, here is a concrete example how this is supposed to be used.

Lets say we have an existing SPI slave driver that we want to extend to
support enumeration from ACPI. Instead of writing acpi_driver glue for that
(and registering it using acpi_bus_register_driver()) what we do is simple
add these to the existing SPI driver:

	#ifdef CONFIG_ACPI
	static struct acpi_device_id my_spidrv_match[] = {
		/* ACPI IDs here */
		{ }
	};
	MODULE_DEVICE_TABLE(acpi, my_spidrv_match);
	#endif

	static struct spi_driver my_spidrv = {
		...
		.driver = {
			.acpi_match_table = ACPI_PTR(my_spidrv_match),
		},
	};

The same thing works with platform, I2c and SPI drivers and can be extented
to others as well. If the driver needs to do some ACPI specific
configuration it can get the ACPI handle using its dev->acpi_handle.

The above example now supports both, normal SPI (where the devices are
enumerated by populating spi_board_info()) and ACPI. Adding support for
Device Tree is similar than ACPI so a single driver can support all three
easily at the same time.
