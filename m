From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 3/4] driver property: constify property arrays values
Date: Thu, 02 Feb 2017 12:24:25 +0100
Message-ID: <1605853.brEpCT4tOG@aspire.rjw.lan>
References: <20170201173125.40354-1-dmitry.torokhov@gmail.com> <20170201173125.40354-4-dmitry.torokhov@gmail.com> <1485991803.22276.14.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:64728 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751245AbdBBL3I (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Feb 2017 06:29:08 -0500
In-Reply-To: <1485991803.22276.14.camel@perches.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>

On Wednesday, February 01, 2017 03:30:03 PM Joe Perches wrote:
> On Wed, 2017-02-01 at 09:31 -0800, Dmitry Torokhov wrote:
> > Data that is fed into property arrays should not be modified, so let's mark
> > relevant pointers as const. This will allow us making source arrays as
> > const/__initconst.
> 
> trivia:
> 
> > diff --git a/drivers/base/property.c b/drivers/base/property.c
> []
> > @@ -682,44 +682,66 @@ int fwnode_property_match_string(struct fwnode_handle *fwnode,
> >  }
> >  EXPORT_SYMBOL_GPL(fwnode_property_match_string);
> >  
> > +static int property_copy_string_array(struct property_entry *dst,
> > +				      const struct property_entry *src)
> > +{
> > +	char **d;
> > +	size_t nval = src->length / sizeof(*d);
> > +	size_t i;
> > +
> > +	d = kcalloc(nval, sizeof(*d), GFP_KERNEL);
> > +	if (!d)
> > +		return -ENOMEM;
> > +
> > +	for (i = 0; i < nval; i++) {
> > +		d[i] = kstrdup(src->pointer.str[i], GFP_KERNEL);
> > +		if (!d[i] && src->pointer.str[i]) {
> > +			while (--i >= 0)
> > +				kfree(d[i]);
> > +			kfree(d);
> > +			return -ENOMEM;
> > +		}
> > +	}
> > +
> > +	dst->pointer.str = (void *)d;
> > +	return 0;
> > +}
> > +
> >  static int property_entry_copy(struct property_entry *dst,
> >  			       const struct property_entry *src)
> >  {
> > -	const char **d, **s;
> > -	size_t i, nval;
> > +	int error;
> >  
> >  	dst->name = kstrdup(src->name, GFP_KERNEL);
> >  	if (!dst->name)
> >  		return -ENOMEM;
> >  
> >  	if (src->is_array) {
> > -		if (!src->length)
> > -			return -ENODATA;
> > +		if (!src->length) {
> > +			error = -ENODATA;
> > +			goto out_free_name;
> > +		}
> >  
> >  		if (src->is_string) {
> > -			nval = src->length / sizeof(const char *);
> > -			dst->pointer.str = kcalloc(nval, sizeof(const char *),
> > -						   GFP_KERNEL);
> > -			if (!dst->pointer.str)
> > -				return -ENOMEM;
> > -
> > -			d = dst->pointer.str;
> > -			s = src->pointer.str;
> > -			for (i = 0; i < nval; i++) {
> > -				d[i] = kstrdup(s[i], GFP_KERNEL);
> > -				if (!d[i] && s[i])
> > -					return -ENOMEM;
> > +			error = property_copy_string_array(dst, src);
> > +			if (error) {
> > +				error = -ENOMEM;
> 
> An unnecessary set as the return from the above
> property_copy_string_array is either 0 or -ENOMEM

Even if it is not -ENOMEM, it still can be propagated to the caller.

I can fix this up unless Dmitry wants to send an updated patch.

Thanks,
Rafael

