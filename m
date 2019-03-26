From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 3/6] device property: Add a function to obtain a
 node's prefix
Date: Tue, 26 Mar 2019 15:16:26 +0200
Message-ID: <20190326131626.GZ9224@smile.fi.intel.com>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
 <20190326124106.27694-4-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190326124106.27694-4-sakari.ailus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, rafael@kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 26, 2019 at 02:41:03PM +0200, Sakari Ailus wrote:
> The prefix is used for printing purpose before a node, and it also works
> as a separator between two nodes.
> 

One nit below.

> +static const char *
> +acpi_fwnode_get_name_prefix(const struct fwnode_handle *fwnode)
> +{
> +	struct fwnode_handle *parent;
> +

> +	parent = fwnode_get_parent(fwnode);
> +	/* Root node. */

I guess a comment could be easier to read if it goes before parent assignment
line.

> +	if (!parent)
> +		return "";
> +
> +	parent = fwnode_get_next_parent(parent);
> +	/* Second node from the root; no prefix here either. */

Ditto.

> +	if (!parent)
> +		return "";
> +
> +	fwnode_handle_put(parent);
> +
> +	/* ACPI device or data node. */
> +	return ".";
> +}

-- 
With Best Regards,
Andy Shevchenko
