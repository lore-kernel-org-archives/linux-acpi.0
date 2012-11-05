From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/3] spi / ACPI: add ACPI enumeration support
Date: Mon, 5 Nov 2012 12:56:02 +0200
Message-ID: <20121105105602.GC24532@intel.com>
References: <1351928793-14375-1-git-send-email-mika.westerberg@linux.intel.com>
 <20121103201310.GQ16648@intel.com>
 <1535917.BaYBBNgGy0@vostro.rjw.lan>
 <4052192.ry8JrGTr6H@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4052192.ry8JrGTr6H@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, mathias.nyman@linux.intel.com, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 05, 2012 at 11:31:19AM +0100, Rafael J. Wysocki wrote:
> The general idea is to move the _CRS parsing routine from acpi_platform.c
> to scan.c and make it attach resource objects to struct acpi_device.
> 
> I'm thinking about adding a list head to struct acpi_device pointing to a
> list of entries like:
> 
> struct resource_list_entry {
> 	struct list_head node;
> 	struct resource *resources;
> 	unsigned int count;
> };
> 
> where "resources" is an array of resources (e.g. interrupts) in the given
> entry and count is the size of that array.
> 
> That list would contain common resources like ACPI_RESOURCE_TYPE_FIXED_MEMORY32,
> ACPI_RESOURCE_TYPE_IRQ, ACPI_RESOURCE_TYPE_ADDRESS32, ACPI_RESOURCE_TYPE_EXTENDED_IRQ.
> I think adding it would allow us to make acpi_create_platform_device(),
> acpi_spi_add_resources() and acpi_i2c_add_resources() more straightforward (and
> remove some code duplication between the last two routines).

This certainly sounds good to me.

> In addition to that, I'd add an entry containing serial bus information, if
> applicable, for the given struct acpi_device, something like:
> 
> union acpi_resource_serial_bus {
> 	struct acpi_resource_common_serialbus;
> 	struct acpi_resource_spi_serialbus;
> 	struct acpi_resource_i2c_serialbus;
> 	struct acpi_resource_uart_serialbus;
> };
> 
> struct acpi_device {
> 	...
> 	union acpi_resource_serial_bus *serial;
> 	...
> };

It is also possible to have several serial bus connectors on a single
device (although we've seen only one connector per device but it should not
be limited to that).

> Then, things like acpi_spi_add_resources() and acpi_i2c_add_resources() would
> be able to use struct acpi_device objects directly without running any AML.
> That could be done on top of the current series and I'm going to prepare a patch
> for that in the next few days if I find some time between the LCE sessions.

Cool :-) Let me know if you need any help, like testing the patches etc.
