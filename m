From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 2/3] spi / ACPI: add ACPI enumeration support
Date: Sat, 17 Nov 2012 12:18:59 +0200
Message-ID: <20121117101859.GD17774@intel.com>
References: <1352977397-2280-1-git-send-email-mika.westerberg@linux.intel.com>
 <1352977397-2280-3-git-send-email-mika.westerberg@linux.intel.com>
 <2716271.5hiFYsNu5c@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:38719 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753200Ab2KQKPt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 17 Nov 2012 05:15:49 -0500
Content-Disposition: inline
In-Reply-To: <2716271.5hiFYsNu5c@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, bhelgaas@google.com, mathias.nyman@linux.intel.com, linux-acpi@vger.kernel.org

On Sat, Nov 17, 2012 at 11:11:59AM +0100, Rafael J. Wysocki wrote:
> > +static acpi_status acpi_spi_add_device(acpi_handle handle, u32 level,
> > +				       void *data, void **return_value)
> > +{
> > +	struct spi_master *master = data;
> > +	struct resource_list_entry *rentry;
> > +	struct list_head resource_list;
> > +	struct acpi_device *adev;
> > +	struct spi_device *spi;
> > +	int ret;
> > +
> > +	if (acpi_bus_get_device(handle, &adev))
> > +		return AE_OK;
> > +	if (acpi_bus_get_status(adev) || !adev->status.present)
> > +		return AE_OK;
> > +
> > +	spi = spi_alloc_device(master);
> > +	if (!spi) {
> > +		dev_err(&master->dev, "failed to allocate SPI device for %s\n",
> > +			dev_name(&adev->dev));
> > +		return AE_NO_MEMORY;
> > +	}
> > +
> > +	INIT_LIST_HEAD(&resource_list);
> > +	ret = acpi_dev_get_resources(adev, &resource_list,
> > +				     acpi_spi_add_resource, spi);
> > +	if (ret < 0)
> > +		goto fail_put_dev;
> > +
> > +	list_for_each_entry(rentry, &resource_list, node) {
> > +		struct resource *r = &rentry->res;
> > +
> > +		if (resource_type(r) == IORESOURCE_IRQ) {
> > +			spi->irq = r->start;
> > +			break;
> > +		}
> > +	}
> > +
> > +	acpi_dev_free_resource_list(&resource_list);
> 
> A potential problem is lurking here, or rather two of them.
> 
> Suppose there are multiple IRQ resources for this device.  The code
> above will cause GSIs to be registered for all of them, but we'll
> use only one eventually.  Moreover, we'll use the last one, but
> perhaps we should use the first one instead?

Indeed we should use the first one.

> Maybe a better approach would be to make acpi_spi_add_resource()
> call acpi_dev_resource_interrupt(ares, 0, &r) directly and then skip all of
> the remaining IRQ resources if it finds one?
> 
> For example set spi->irq to -1 initially, assign it if an IRQ
> resource is found and skip all of the remaining IRQ resources if
> it is non-negative?

OK, will do. Thanks.
