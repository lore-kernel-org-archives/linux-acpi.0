From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC PATCH 2/2] HISI LPC: Add PNP device support
Date: Fri, 20 Apr 2018 15:50:06 +0300
Message-ID: <1524228606.21176.472.camel@linux.intel.com>
References: <1524218846-169934-1-git-send-email-john.garry@huawei.com>
         <1524218846-169934-3-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524218846-169934-3-git-send-email-john.garry@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, lenb@kernel.org, mika.westerberg@linux.intel.com, lorenzo.pieralisi@arm.com
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, graeme.gregory@linaro.org, helgaas@kernel.org, linuxarm@huawei.com, z.liuxinliang@hisilicon.com
List-Id: linux-acpi@vger.kernel.org

On Fri, 2018-04-20 at 18:07 +0800, John Garry wrote:
> Currently the driver creates an per-ACPI device mfd_cell
> for child devices. This does not suit devices which are
> PNP-compatible, as we expect PNP-compatible devices to
> derive PNP devices.
> 
> To add PNP device support, we continue to allow the PNP
> scan code to create the PNP device (which have the
> enumeration_by_parent flag set), but expect the PNP
> scan to defer adding the device to allow the host probe
> code to do this. In addition, no longer do we create an
> mfd_cell (platform_device) for PNP-compatible devices.
> 
> We take this approach so that host probe code can
> translate the IO resources of the PNP device prior
> to adding the device.

> +	list_for_each_entry(child, &adev->children, node) {
> +		if (acpi_is_pnp_device(child))
> +			continue;

This is good candidate for a separate helper macro

#define for_each_acpi_non_pnp_device(child, adev) \
...

(see, for example, for_each_pci_bridge() implementation as an example)

 
> +	list_for_each_entry(child, &adev->children, node) {

> +		if (!acpi_is_pnp_device(child))
> +			continue;

Ditto.

> +		/*
> +		 * Prior to adding the device, we need to translate
> the
> +		 * resources to logical PIO addresses.
> +		 */
> +		list_for_each_entry(pnp_res, &pnp_dev->resources,
> list) {
> +			struct resource *res = &pnp_res->res;
> +

> +			if (res->flags | IORESOURCE_IO)

What does this mean?

> +				hisi_lpc_acpi_xlat_io_res(child,
> adev, res);
> +		}

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
