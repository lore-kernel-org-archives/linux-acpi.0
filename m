From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 1/4] device property: allow to constify properties
Date: Fri, 3 Feb 2017 07:09:07 -0800
Message-ID: <20170203150907.GA3868@dtor-ws>
References: <20170203014128.317-1-dmitry.torokhov@gmail.com>
 <20170203014128.317-2-dmitry.torokhov@gmail.com>
 <1486122021.2133.371.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36087 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbdBCPJL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2017 10:09:11 -0500
Content-Disposition: inline
In-Reply-To: <1486122021.2133.371.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>

On Fri, Feb 03, 2017 at 01:40:21PM +0200, Andy Shevchenko wrote:
> On Thu, 2017-02-02 at 17:41 -0800, Dmitry Torokhov wrote:
> > There is no reason why statically defined properties should be
> > modifiable,
> > so let's make device_add_properties() and the rest of pset_*()
> > functions to
> > take const pointers to properties.
> > 
> > This will allow us to mark properties as const/__initconst at
> > definition
> > sites.
> > 
> 
> Looks good to me.
> 
> FWIW:
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Though, nitpicks below.
>  
> >  static struct property_set *pset_copy_set(const struct property_set
> > *pset)
> >  {
> > -	const struct property_entry *entry;
> > +	struct property_entry *props;
> 
> Can we leave the name?
>  
> > -	p->properties = kcalloc(n + 1, sizeof(*entry), GFP_KERNEL);
> > 
> > +	p->properties = props = kcalloc(n + 1, sizeof(*props),
> > GFP_KERNEL);
> >  	if (!p->properties) {
> >  		kfree(p);
> >  		return ERR_PTR(-ENOMEM);
> >  	}
> >  
> >  	for (i = 0; i < n; i++) {
> 
> > -		int ret = pset_copy_entry(&p->properties[i],
> > +		int ret = pset_copy_entry(&props[i],
> >  					  &pset->properties[i]);
> 
> Do we need these changes?

Didn't want to wrap the line, the name is restored later anyway.

Thanks.

-- 
Dmitry
