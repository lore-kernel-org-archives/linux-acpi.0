From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 2/3] ACPI: property: Add acpi_fwnode_name()
Date: Mon, 26 Nov 2018 15:04:52 +0200
Message-ID: <20181126130452.GG10650@smile.fi.intel.com>
References: <20181126114752.69597-1-heikki.krogerus@linux.intel.com>
 <20181126114752.69597-3-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181126114752.69597-3-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 26, 2018 at 02:47:51PM +0300, Heikki Krogerus wrote:
> This implements the get_name fwnode op for ACPI.

> +static int
> +acpi_fwnode_get_name(const struct fwnode_handle *fwnode, char *buf, size_t len)
> +{
> +	struct acpi_buffer buffer;
> +	acpi_handle handle;
> +	acpi_status status;
> +
> +	if (is_acpi_data_node(fwnode)) {
> +		snprintf(buf, len, "%s", to_acpi_data_node(fwnode)->name);

Same question as per patch 1. How are we going to handle bigger strings?

> +		return 0;
> +	}
> +
> +	handle = to_acpi_device_node(fwnode)->handle;
> +

> +	buffer.length = min((size_t)ACPI_NAME_SIZE + 1, len);

Hmm...

 min_t(size_t, ...) ?


> +	buffer.pointer = buf;
> +
> +	status = acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer);

And same question here. Is it possible to get length of the name and check?

Perhaps, I would return -ENAMETOOLONG (-EOVERFLOW) or alike for such cases.

> +	if (ACPI_FAILURE(status))
> +		return -ENXIO;
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko
