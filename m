From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 3/4] driver property: constify property arrays values
Date: Wed, 1 Feb 2017 16:42:33 +0200
Message-ID: <20170201144233.GN17297@lahna.fi.intel.com>
References: <20170201021130.20586-1-dmitry.torokhov@gmail.com>
 <20170201021130.20586-4-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170201021130.20586-4-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 31, 2017 at 06:11:29PM -0800, Dmitry Torokhov wrote:
> Data that is fed into property arrays should not be modified, so let's mark
> relevant pointers as const. This will allow us making source arrays as
> const/__initconst.
> 
> Also fix memory leaks on errors in property_entry_copy().
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/base/property.c  | 65 +++++++++++++++++++++++++++++++++---------------
>  include/linux/property.h | 12 ++++-----
>  2 files changed, 51 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index edc09854520b..fd91e0891665 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -682,44 +682,65 @@ int fwnode_property_match_string(struct fwnode_handle *fwnode,
>  }
>  EXPORT_SYMBOL_GPL(fwnode_property_match_string);
>  
> +static int property_copy_string_array(struct property_entry *dst,
> +				      const struct property_entry *src)
> +{
> +	char **d;
> +	size_t nval = src->length / sizeof(*d);
> +	size_t i;
> +
> +	d = kcalloc(nval, sizeof(*d), GFP_KERNEL);
> +	if (!d)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < nval; i++) {
> +		d[i] = kstrdup(src->pointer.str[i], GFP_KERNEL);
> +		if (!d[i] && src->pointer.str[i]) {
> +			while (--i >= 0)
> +				kfree(d[i]);

Should we free d as well here?

> +			return -ENOMEM;
> +		}
> +	}
> +
> +	dst->pointer.str = (void *)d;
> +	return 0;
> +}
