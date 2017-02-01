From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3 3/4] driver property: constify property arrays values
Date: Wed, 01 Feb 2017 15:30:03 -0800
Message-ID: <1485991803.22276.14.camel@perches.com>
References: <20170201173125.40354-1-dmitry.torokhov@gmail.com>
         <20170201173125.40354-4-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170201173125.40354-4-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2017-02-01 at 09:31 -0800, Dmitry Torokhov wrote:
> Data that is fed into property arrays should not be modified, so let's mark
> relevant pointers as const. This will allow us making source arrays as
> const/__initconst.

trivia:

> diff --git a/drivers/base/property.c b/drivers/base/property.c
[]
> @@ -682,44 +682,66 @@ int fwnode_property_match_string(struct fwnode_handle *fwnode,
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
> +			kfree(d);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	dst->pointer.str = (void *)d;
> +	return 0;
> +}
> +
>  static int property_entry_copy(struct property_entry *dst,
>  			       const struct property_entry *src)
>  {
> -	const char **d, **s;
> -	size_t i, nval;
> +	int error;
>  
>  	dst->name = kstrdup(src->name, GFP_KERNEL);
>  	if (!dst->name)
>  		return -ENOMEM;
>  
>  	if (src->is_array) {
> -		if (!src->length)
> -			return -ENODATA;
> +		if (!src->length) {
> +			error = -ENODATA;
> +			goto out_free_name;
> +		}
>  
>  		if (src->is_string) {
> -			nval = src->length / sizeof(const char *);
> -			dst->pointer.str = kcalloc(nval, sizeof(const char *),
> -						   GFP_KERNEL);
> -			if (!dst->pointer.str)
> -				return -ENOMEM;
> -
> -			d = dst->pointer.str;
> -			s = src->pointer.str;
> -			for (i = 0; i < nval; i++) {
> -				d[i] = kstrdup(s[i], GFP_KERNEL);
> -				if (!d[i] && s[i])
> -					return -ENOMEM;
> +			error = property_copy_string_array(dst, src);
> +			if (error) {
> +				error = -ENOMEM;

An unnecessary set as the return from the above
property_copy_string_array is either 0 or -ENOMEM
