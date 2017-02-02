From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 3/4] device property: constify property arrays values
Date: Thu, 02 Feb 2017 18:48:30 +0200
Message-ID: <1486054110.2133.366.camel@linux.intel.com>
References: <20170201173125.40354-1-dmitry.torokhov@gmail.com>
         <20170201173125.40354-4-dmitry.torokhov@gmail.com>
         <1485991803.22276.14.camel@perches.com> <1605853.brEpCT4tOG@aspire.rjw.lan>
         <20170202163918.GA21924@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:39812 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751377AbdBBQuQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 Feb 2017 11:50:16 -0500
In-Reply-To: <20170202163918.GA21924@dtor-ws>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Joe Perches <joe@perches.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>

On Thu, 2017-02-02 at 08:39 -0800, Dmitry Torokhov wrote:
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Data that is fed into property arrays should not be modified, so let's
> mark
> relevant pointers as const. This will allow us making source arrays as
> const/__initconst.
> 

> Also fix memory leaks on errors in property_entry_copy().

While the code looks okay, I'm not sure what memory leaks you are
referring to. The idea as far as I remember was to run *free() function
if *copy() fails.

> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> Not sending the rest of the series as to not clutter mailing lists too
> much...
> 
>  drivers/base/property.c  |   66 +++++++++++++++++++++++++++++++----
> -----------
>  include/linux/property.h |   12 ++++----
>  2 files changed, 51 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index edc09854520b..09fb9757e086 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -682,44 +682,64 @@ int fwnode_property_match_string(struct
> fwnode_handle *fwnode,
>  }
>  EXPORT_SYMBOL_GPL(fwnode_property_match_string);
>  
> +static int property_copy_string_array(struct property_entry *dst,
> +				      const struct property_entry
> *src)
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
>  static int property_entry_copy(struct property_entry *dst,
>  			       const struct property_entry *src)
>  {
> -	const char **d, **s;
> -	size_t i, nval;
> +	int error;
>  
>  	dst->name = kstrdup(src->name, GFP_KERNEL);
>  	if (!dst->name)
>  		return -ENOMEM;
>  
>  	if (src->is_array) {
> -		if (!src->length)
> -			return -ENODATA;
> +		if (!src->length) {
> +			error = -ENODATA;
> +			goto out_free_name;
> +		}
>  
>  		if (src->is_string) {
> -			nval = src->length / sizeof(const char *);
> -			dst->pointer.str = kcalloc(nval, sizeof(const
> char *),
> -						   GFP_KERNEL);
> -			if (!dst->pointer.str)
> -				return -ENOMEM;
> -
> -			d = dst->pointer.str;
> -			s = src->pointer.str;
> -			for (i = 0; i < nval; i++) {
> -				d[i] = kstrdup(s[i], GFP_KERNEL);
> -				if (!d[i] && s[i])
> -					return -ENOMEM;
> -			}
> +			error = property_copy_string_array(dst, src);
> +			if (error)
> +				goto out_free_name;
>  		} else {
>  			dst->pointer.raw_data = kmemdup(src-
> >pointer.raw_data,
>  							src->length,
> GFP_KERNEL);
> -			if (!dst->pointer.raw_data)
> -				return -ENOMEM;
> +			if (!dst->pointer.raw_data) {
> +				error = -ENOMEM;
> +				goto out_free_name;
> +			}
>  		}
>  	} else if (src->is_string) {
>  		dst->value.str = kstrdup(src->value.str, GFP_KERNEL);
> -		if (!dst->value.str && src->value.str)
> -			return -ENOMEM;
> +		if (!dst->value.str && src->value.str) {
> +			error = -ENOMEM;
> +			goto out_free_name;
> +		}
>  	} else {
>  		dst->value.raw_data = src->value.raw_data;
>  	}
> @@ -729,6 +749,10 @@ static int property_entry_copy(struct
> property_entry *dst,
>  	dst->is_string = src->is_string;
>  
>  	return 0;
> +
> +out_free_name:
> +	kfree(dst->name);
> +	return error;
>  }
>  
>  /**
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 5746e9927016..64e3a9c6d95f 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -160,12 +160,12 @@ struct property_entry {
>  	bool is_string;
>  	union {
>  		union {
> -			void *raw_data;
> -			u8 *u8_data;
> -			u16 *u16_data;
> -			u32 *u32_data;
> -			u64 *u64_data;
> -			const char **str;
> +			const void *raw_data;
> +			const u8 *u8_data;
> +			const u16 *u16_data;
> +			const u32 *u32_data;
> +			const u64 *u64_data;
> +			const char * const *str;
>  		} pointer;
>  		union {
>  			unsigned long long raw_data;

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
