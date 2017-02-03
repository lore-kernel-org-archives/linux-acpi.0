From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 1/4] device property: allow to constify properties
Date: Fri, 03 Feb 2017 13:40:21 +0200
Message-ID: <1486122021.2133.371.camel@linux.intel.com>
References: <20170203014128.317-1-dmitry.torokhov@gmail.com>
         <20170203014128.317-2-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:31610 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751878AbdBCLk0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 3 Feb 2017 06:40:26 -0500
In-Reply-To: <20170203014128.317-2-dmitry.torokhov@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>

On Thu, 2017-02-02 at 17:41 -0800, Dmitry Torokhov wrote:
> There is no reason why statically defined properties should be
> modifiable,
> so let's make device_add_properties() and the rest of pset_*()
> functions to
> take const pointers to properties.
> 
> This will allow us to mark properties as const/__initconst at
> definition
> sites.
> 

Looks good to me.

FWIW:
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Though, nitpicks below.
 
>  static struct property_set *pset_copy_set(const struct property_set
> *pset)
>  {
> -	const struct property_entry *entry;
> +	struct property_entry *props;

Can we leave the name?
 
> -	p->properties = kcalloc(n + 1, sizeof(*entry), GFP_KERNEL);
> 
> +	p->properties = props = kcalloc(n + 1, sizeof(*props),
> GFP_KERNEL);
>  	if (!p->properties) {
>  		kfree(p);
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
>  	for (i = 0; i < n; i++) {

> -		int ret = pset_copy_entry(&p->properties[i],
> +		int ret = pset_copy_entry(&props[i],
>  					  &pset->properties[i]);

Do we need these changes?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
