From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 2/5] device property: Add fwnode_get_name for returning
 the name of a node
Date: Sun, 24 Mar 2019 10:21:17 -0700
Message-ID: <7b29c2ef-c74b-e94d-6add-88c5db34dce7@infradead.org>
References: <20190322152930.16642-1-sakari.ailus@linux.intel.com>
 <20190322152930.16642-3-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322152930.16642-3-sakari.ailus@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, rafael@kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On 3/22/19 8:29 AM, Sakari Ailus wrote:
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 3f5ff6b23ae4..7ee3786bcde3 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -533,6 +533,18 @@ int device_add_properties(struct device *dev,
>  EXPORT_SYMBOL_GPL(device_add_properties);
>  
>  /**
> + * fwnode_get_name - Return the name of a node
> + *
> + * @fwnode - The firmware node

s/-/:/

> + *
> + * Returns a pointer to the node name.
> + */
> +const char *fwnode_get_name(const struct fwnode_handle *fwnode)
> +{
> +	return fwnode_call_ptr_op(fwnode, get_name);
> +}
> +
> +/**
>   * fwnode_get_parent - Return parent firwmare node
>   * @fwnode: Firmware whose parent is retrieved
>   *


-- 
~Randy
