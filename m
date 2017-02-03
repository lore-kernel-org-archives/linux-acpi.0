From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 2/4] device property: constify property arrays values
Date: Fri, 03 Feb 2017 13:43:03 +0200
Message-ID: <1486122183.2133.373.camel@linux.intel.com>
References: <20170203014128.317-1-dmitry.torokhov@gmail.com>
         <20170203014128.317-3-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:13285 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751878AbdBCLnH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 3 Feb 2017 06:43:07 -0500
In-Reply-To: <20170203014128.317-3-dmitry.torokhov@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>

On Thu, 2017-02-02 at 17:41 -0800, Dmitry Torokhov wrote:
> Data that is fed into property arrays should not be modified, so let's
> mark
> relevant pointers as const. This will allow us making source arrays as
> const/__initconst.
> 

> @@ -718,7 +718,8 @@ static void pset_free_set(struct property_set
> *pset)
>  static int pset_copy_entry(struct property_entry *dst,
>  			   const struct property_entry *src)
>  {
> -	const char **d, **s;
> +	const char * const *s;
> +	char **d;

You removed const here

>  	size_t i, nval;
>  
>  	dst->name = kstrdup(src->name, GFP_KERNEL);
> @@ -731,12 +732,11 @@ static int pset_copy_entry(struct property_entry
> *dst,
>  
>  		if (src->is_string) {
>  			nval = src->length / sizeof(const char *);
> -			dst->pointer.str = kcalloc(nval, sizeof(const
> char *),
> -						   GFP_KERNEL);
> -			if (!dst->pointer.str)
> +			d = kcalloc(nval, sizeof(const char *),
> GFP_KERNEL);

But left it here. Do we need to remove const?

> +			if (!d)
>  				return -ENOMEM;
>  
> -			d = dst->pointer.str;
> +			dst->pointer.raw_data = d;
>  			s = src->pointer.str;

So, overall, do we need these changes at all? Nothing in commit message
sheds a light on it.

>  			for (i = 0; i < nval; i++) {
>  				d[i] = kstrdup(s[i], GFP_KERNEL);

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
