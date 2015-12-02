From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC PATCH 1/4] acpi: property: Introduce helper
 acpi_dev_get_reference_device()
Date: Wed, 2 Dec 2015 11:20:39 +0200
Message-ID: <20151202092039.GL1593@lahna.fi.intel.com>
References: <1449047368-5768-1-git-send-email-wangkefeng.wang@huawei.com>
 <1449047368-5768-2-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53708 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756789AbbLBJVQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Dec 2015 04:21:16 -0500
Content-Disposition: inline
In-Reply-To: <1449047368-5768-2-git-send-email-wangkefeng.wang@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>, Hanjun Guo <hanjun.guo@linaro.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Dec 02, 2015 at 05:09:25PM +0800, Kefeng Wang wrote:
> Like of_parse_phandle() helper function to read and parse a phandle property
> and return a pointer to the resulting device_node, introduce helper function
> acpi_dev_get_reference_device() to read and parse a device properties(used in
> _DSD method) and return a pointer to the resulting acpi_device.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/acpi/property.c | 23 +++++++++++++++++++++++
>  include/linux/acpi.h    |  7 +++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 88f4306..e2e7754 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -398,6 +398,29 @@ int acpi_dev_get_property(struct acpi_device *adev, const char *name,
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_get_property);
>  
> +/**
> + * acpi_dev_get_reference_device  - return the acpi_device referenced
> + * @adev: ACPI device to get the property from.
> + * @name: Name of the property.
> + * @index: Index of the reference to return
> + *
> + * Returns referenced ACPI device pointer, or NULL if not found
> + */
> +struct acpi_device *acpi_dev_get_reference_device(struct acpi_device *adev,
> +						  const char *name, size_t index)
> +{
> +	struct acpi_reference_args args;
> +	int ret;
> +
> +	ret = acpi_node_get_property_reference(acpi_fwnode_handle(adev), name, index, &args);
> +
> +	if (ret)
> +		return NULL;
> +
> +	return args.adev;
> +}
> +EXPORT_SYMBOL(acpi_dev_get_reference_device);

This wrapper looks pretty useless honestly. Why not use
acpi_node_get_property_reference() directly if you need to get the
device reference?

Also you should use EXPORT_SYMBOL_GPL() here.
