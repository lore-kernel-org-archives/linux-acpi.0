From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 3/3] i2c / ACPI: add ACPI enumeration support
Date: Fri, 16 Nov 2012 22:09:34 +0200
Message-ID: <20121116200934.GA17774@intel.com>
References: <1352977397-2280-1-git-send-email-mika.westerberg@linux.intel.com>
 <20121116144256.55b49cae@endymion.delvare>
 <20121116141729.GS17774@intel.com>
 <5908031.ZEcDQlG5EW@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5908031.ZEcDQlG5EW@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jean Delvare <khali@linux-fr.org>, ben-linux@fluff.org, w.sang@pengutronix.de, linux-kernel@vger.kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, bhelgaas@google.com, mathias.nyman@linux.intel.com, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 16, 2012 at 09:02:36PM +0100, Rafael J. Wysocki wrote:
> Ah, that's what's called by acpi_dev_get_resources().  But what about writing
> it this way:
> 
> static int acpi_i2c_find_child_address(struct acpi_resource *ares, void *data)
> {
> 
>        if (ares->type == ACPI_RESOURCE_TYPE_SERIAL_BUS) {
>        	struct acpi_resource_i2c_serialbus *sb;
> 
>        	sb = &ares->data.i2c_serial_bus;
>        	if (sb->type == ACPI_RESOURCE_SERIAL_TYPE_I2C) {
>        		struct acpi_i2c_find *i2c_find = data;
> 
>        		if (sb->slave_address == i2c_find->addr)
> 				i2c_find->found = true;
> 		}
> 	}
> 
> 	/* Tell the ACPI core to skip this resource. */
> 	return 1;
> }

Not a problem at all, I'll do it like above and also with the SPI case.
I'll wait til tomorrow for more comments and post v3 unless there are
objections.
