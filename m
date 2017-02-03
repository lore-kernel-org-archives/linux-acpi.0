From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 2/4] device property: constify property arrays values
Date: Fri, 3 Feb 2017 07:12:21 -0800
Message-ID: <20170203151221.GB3868@dtor-ws>
References: <20170203014128.317-1-dmitry.torokhov@gmail.com>
 <20170203014128.317-3-dmitry.torokhov@gmail.com>
 <1486122183.2133.373.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33661 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751074AbdBCPMZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2017 10:12:25 -0500
Content-Disposition: inline
In-Reply-To: <1486122183.2133.373.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>

On Fri, Feb 03, 2017 at 01:43:03PM +0200, Andy Shevchenko wrote:
> On Thu, 2017-02-02 at 17:41 -0800, Dmitry Torokhov wrote:
> > Data that is fed into property arrays should not be modified, so let's
> > mark
> > relevant pointers as const. This will allow us making source arrays as
> > const/__initconst.
> > 
> 
> > @@ -718,7 +718,8 @@ static void pset_free_set(struct property_set
> > *pset)
> >  static int pset_copy_entry(struct property_entry *dst,
> >  			   const struct property_entry *src)
> >  {
> > -	const char **d, **s;
> > +	const char * const *s;
> > +	char **d;
> 
> You removed const here

Yes I did. It is hard to assign value to a constant otherwise.

> 
> >  	size_t i, nval;
> >  
> >  	dst->name = kstrdup(src->name, GFP_KERNEL);
> > @@ -731,12 +732,11 @@ static int pset_copy_entry(struct property_entry
> > *dst,
> >  
> >  		if (src->is_string) {
> >  			nval = src->length / sizeof(const char *);
> > -			dst->pointer.str = kcalloc(nval, sizeof(const
> > char *),
> > -						   GFP_KERNEL);
> > -			if (!dst->pointer.str)
> > +			d = kcalloc(nval, sizeof(const char *),
> > GFP_KERNEL);
> 
> But left it here. Do we need to remove const?

I do not know why we had it in the first place: the size is the samei
between constant and variable of the same type.

Ideally we'd use sizeof(*d), I can do it after this batch is accepted.

> 
> > +			if (!d)
> >  				return -ENOMEM;
> >  
> > -			d = dst->pointer.str;
> > +			dst->pointer.raw_data = d;
> >  			s = src->pointer.str;
> 
> So, overall, do we need these changes at all? Nothing in commit message
> sheds a light on it.

The compiler insists in them though.

> 
> >  			for (i = 0; i < nval; i++) {
> >  				d[i] = kstrdup(s[i], GFP_KERNEL);

Thanks.

-- 
Dmitry
