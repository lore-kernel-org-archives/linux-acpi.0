From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [resend PATCH] driver core: property: support for generic
 property
Date: Mon, 16 Mar 2015 09:25:20 +0200
Message-ID: <20150316072520.GA31564@kuha.fi.intel.com>
References: <1422278260-108175-1-git-send-email-heikki.krogerus@linux.intel.com>
 <2095371.SrUNK6JsDO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34745 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751964AbbCPHZX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Mar 2015 03:25:23 -0400
Content-Disposition: inline
In-Reply-To: <2095371.SrUNK6JsDO@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org

> > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > index c458458..4ea6d27 100644
> > --- a/drivers/base/property.c
> > +++ b/drivers/base/property.c
> > @@ -15,6 +15,108 @@
> >  #include <linux/acpi.h>
> >  #include <linux/of.h>
> >  
> > +static struct dev_gen_prop *dev_prop_get(struct device *dev, const char *name)
> > +{
> > +	struct dev_gen_prop *prop;
> > +
> > +	if (!dev->gen_prop)
> > +		return NULL;
> > +
> > +	for (prop = dev->gen_prop; prop->name; prop++)
> > +		if (!strcmp(name, prop->name))
> > +			return prop;
> > +	return NULL;
> > +}
> > +
> > +static int dev_prop_copy_array_u8(u8 *src, u8 *val, size_t nval)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < nval; i++)
> > +		val[i] = src[i];
> 
> Use memcpy() perhaps?  And below too?  And then you may not need these
> helpers any more.

OK.

<snip>

> > @@ -780,6 +782,7 @@ struct device {
> >  
> >  	struct device_node	*of_node; /* associated device tree node */
> >  	struct acpi_dev_node	acpi_node; /* associated ACPI device node */
> > +	struct dev_gen_prop	*gen_prop; /* generic device property */
> 
> That doesn't seem to go in the right direction to be honest.
> 
> Actually, having introduced struct fwnode_handle, we should perhaps try to
> replace both of_node and acpi_node with a single struct fwnode_handle pointer
> and then add a new fwnode_type for the "pdata" stuff.
> 
> If you don't want to deal with of_node, which I can understand easily, it
> may be worth trying with acpi_node alone at this point and once you have
> the fwnode_handle pointer, you might use it for both ACPI and "pdata"?

It sounds like a better Idea to me too.


Thanks,

-- 
heikki
