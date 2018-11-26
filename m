From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 1/3] device property: Introduce fwnode_get_name()
Date: Mon, 26 Nov 2018 14:56:56 +0200
Message-ID: <20181126125656.GF10650@smile.fi.intel.com>
References: <20181126114752.69597-1-heikki.krogerus@linux.intel.com>
 <20181126114752.69597-2-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181126114752.69597-2-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 26, 2018 at 02:47:50PM +0300, Heikki Krogerus wrote:
> This helper returns the name of the node. The name is
> primarily expected to be returned from a new fwnode
> operation meant for this purpose, but when no name is
> returned, the helper will also attempt to read a device
> property "name".

> +int fwnode_get_name(const struct fwnode_handle *fwnode, char *buf, size_t len)
> +{
> +	const char *name;
> +	int ret;
> +
> +	if (!fwnode_call_int_op(fwnode, get_name, buf, len))
> +		return 0;
> +
> +	ret = fwnode_call_int_op(fwnode, property_read_string_array,
> +				 "name", &name, 1);
> +	if (!ret)
> +		snprintf(buf, len, "%s", name);

What are we going to do in case snprintf has found no room for entire string?

> +
> +	return ret;
> +}

-- 
With Best Regards,
Andy Shevchenko
