From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH V2 3/4] ACPI/ARM: Add ACPI to AMBA SPI driver
Date: Fri, 22 Nov 2013 22:16:44 +0000
Message-ID: <20131122221644.GF16735@n2100.arm.linux.org.uk>
References: <1385143964-22938-1-git-send-email-brandon.anderson@amd.com> <1385143964-22938-4-git-send-email-brandon.anderson@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43314 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755278Ab3KVWRA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Nov 2013 17:17:00 -0500
Content-Disposition: inline
In-Reply-To: <1385143964-22938-4-git-send-email-brandon.anderson@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Brandon Anderson <brandon.anderson@amd.com>
Cc: rjw@rjwysocki.net, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org

On Fri, Nov 22, 2013 at 12:12:43PM -0600, Brandon Anderson wrote:
> +#ifdef CONFIG_ACPI
> +static struct pl022_ssp_controller *
> +acpi_pl022_get_platform_data(struct device *dev)
> +{
> +	struct pl022_ssp_controller *pd, *ret;
> +	struct acpi_amba_dsm_entry entry;
> +
> +	pd = devm_kzalloc(dev, sizeof(struct pl022_ssp_controller), GFP_KERNEL);
> +	if (!pd) {
> +		dev_err(dev, "cannot allocate platform data memory\n");
> +		return NULL;
> +	}
> +	ret = pd;
> +
> +	pd->bus_id = -1;
> +	pd->enable_dma = 1;
> +	if (acpi_amba_dsm_lookup(ACPI_HANDLE(dev), "num-cs", 0, &entry) == 0) {
> +		if (kstrtou8(entry.value, 0, &pd->num_chipselect) != 0) {
> +			dev_err(dev, "invalid 'num-cs' in ACPI definition\n");
> +			ret = NULL;
> +		}
> +		kfree(entry.key);
> +		kfree(entry.value);
> +	}
> +	if (acpi_amba_dsm_lookup(ACPI_HANDLE(dev),
> +			"autosuspend-delay", 0, &entry) == 0) {
> +		if (kstrtoint(entry.value, 0, &pd->autosuspend_delay) != 0) {
> +			dev_err(dev, "invalid 'autosuspend-delay' in ACPI definition\n");
> +			ret = NULL;
> +		}
> +		kfree(entry.key);
> +		kfree(entry.value);
> +	}
> +	if (acpi_amba_dsm_lookup(ACPI_HANDLE(dev), "rt", 0, &entry) == 0) {
> +		pd->rt = (entry.value && strcmp(entry.value, "1") == 0);
> +		kfree(entry.key);
> +		kfree(entry.value);
> +	}
> +
> +	return ret;
> +}

I thought I'd already commented about this, and said if the properties
are the same as the DT stuff, this should be done in a common way
rather than modifing every driver.

For stuff like the above, it's really quite simple.

Rename the of_property_read_*() function to firmware_read_*() function
and make it take a struct device.

Then you can hide the of_property_read_*() if there's an OF node present
inside the firmware_read_*() function.  If not, and it has an ACPI handle,
then you can read it from ACPI.

That means the only modification that drivers see is a function rename
and a _slight_ change of argument, which is a lot saner for driver authors
to review rather than having to review an entire set of new parsing code.
