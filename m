Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A099E49B5A0;
	Fri, 11 Sep 2026 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142515; cv=none; b=qith6GTZbXWunZxNVex5mIww4X8TwPOLLwqxmtpa6gOLr3kyArUlEdIQxaH/nyUYcXUpFF0Ub/XeGeltWe7/GSGlbfj6JC42R6U/s117Ic5ycYzBnUj/StygTqG1CUq8jreSIQoExqSmBA5aVYTtrsr2KKf9SN1GrlS1agKmJqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142515; c=relaxed/simple;
	bh=ujc4gahDkCicEOOqjPUihWYFOIFiCd+3SQ8TizbLmes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1dQrkb/LgbpqW+EI3d+3OxjaL1oEvrmgSlXvhQuadspKoXCqH3Z+WyQtYRgyoWz+0afwWJ2mo5IZciFIrtsRfLCqzisjg68uD+nQN6vyWqAellGxKr2F3mn9ePZFXVghwiF5kvbAGikjmGtt3rBpICXTNN0uTpSeWOaWi/TT04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MEmN1Xy7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MEmN1Xy7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789142514; x=1820678514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ujc4gahDkCicEOOqjPUihWYFOIFiCd+3SQ8TizbLmes=;
  b=MEmN1Xy7o4zLQd0KDhJf3XaF1iOy3VlLwQSc5fTJBqjvG3DFmSqVwhEK
   0pTKGThJ9Ollxkc0KlUhRmDOOXrgiGAhHi6WQ8k7G2eqcqGEQPL7iN4uM
   ZBiJVhPIKjk/I2mmfjyKuJR/RSO1mCiY9o72DCXAlP60Kg7SxP26gPoQA
   VXNCN8yGkaweexMCjW66NaotMO+xUgQHE+xerd8+E+6ndisxGIICFArtA
   eKCMqrIrl0x82X2lv8W2zlA/D66jVNSSj0h9zY7dmnyZIfjI0hv37pAzn
   yboeRwx+Mc8fnIQx0ot3qQdS5bj0N9goEfmt3m1XuP7G7HiMg+RiqVVP0
   Q==;
X-CSE-ConnectionGUID: L0K8H5Z4TRSiK+vmhbTXog==
X-CSE-MsgGUID: 4wNGNnkHRTazl1fTh9QnlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="93302427"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="93302427"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 09:01:53 -0700
X-CSE-ConnectionGUID: AdFjuv8aQxO8uw/zlLU2MQ==
X-CSE-MsgGUID: jNTTNQIRR6CgxOPbx5OxGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="270190829"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.80])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 09:01:50 -0700
Date: Fri, 11 Sep 2026 19:01:47 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/4] ACPI: glue: Rearrange acpi_bind_one() to avoid
 breakage
Message-ID: <aqQl6wYLlMpHYgDy@ashevche-desk.local>
References: <12995802.O9o76ZdvQC@rafael.j.wysocki>
 <3465482.44csPzL39Z@rafael.j.wysocki>
 <aqOwUynzp3APwfYS@ashevche-desk.local>
 <CAJZ5v0jD4KvoBgcR1gysK1g7y48aM+w0=eNt1oq2QkbbS1vv7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jD4KvoBgcR1gysK1g7y48aM+w0=eNt1oq2QkbbS1vv7Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 11, 2026 at 12:24:16PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Fri, Sep 11, 2026 at 9:40 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Sep 10, 2026 at 07:56:10PM +0200, Rafael J. Wysocki wrote:

...

> > >  int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
> > >  {
> > >       struct acpi_device_physical_node *physical_node, *pn;
> > > +     struct acpi_device *comp_dev = ACPI_COMPANION(dev);
> > >       char physical_node_name[PHYSICAL_NODE_NAME_SIZE];
> > >       struct list_head *physnode_list;
> > >       unsigned int node_id;
> > >       int retval = -EINVAL;
> > >
> > > -     if (has_acpi_companion(dev)) {
> > > -             if (acpi_dev) {
> > > -                     dev_warn(dev, "ACPI companion already set\n");
> > > +     if (!acpi_dev) {
> > > +             if (!comp_dev)
> > >                       return -EINVAL;
> > > -             } else {
> > > -                     acpi_dev = ACPI_COMPANION(dev);
> > > -             }
> > > -     }
> > > -     if (!acpi_dev)
> > > -             return -EINVAL;
> > >
> > > -     acpi_dev_get(acpi_dev);
> > > -     get_device(dev);
> > > -     physical_node = kzalloc_obj(*physical_node);
> > > -     if (!physical_node) {
> > > -             retval = -ENOMEM;
> > > -             goto err;
> > > +             /* If the companion has been set upfront, pick it up. */
> > > +             acpi_dev = comp_dev;
> > > +     }
> > > +     if (comp_dev && comp_dev != acpi_dev) {
> > > +             dev_warn(dev, "ACPI companion already set to %s which is not %s\n",
> > > +                      acpi_dev_name(comp_dev), acpi_dev_name(acpi_dev));
> > > +             return -EEXIST;
> > >       }
> >
> > I would rewrite the above to look as following (if I got the logic right)
> >
> > int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
> > {
> >         struct acpi_device_physical_node *physical_node, *pn;
> >         char physical_node_name[PHYSICAL_NODE_NAME_SIZE];
> >         struct list_head *physnode_list;
> >         struct acpi_device *comp_dev;
> >         unsigned int node_id;
> >         int retval = -EINVAL;
> >
> >         comp_dev = ACPI_COMPANION(dev);
> >         if (comp_dev) {
> >                 if (acpi_dev) {
> >                         if (comp_dev != acpi_dev) {
> >                                 dev_warn(dev, "ACPI companion already set to %s which is not %s\n",
> >                                          acpi_dev_name(comp_dev), acpi_dev_name(acpi_dev));
> >                                 return -EEXIST;
> >                 } else {
> >                         /* If the companion has been set upfront, pick it up. */
> >                         acpi_dev = comp_dev;
> >                 }
> >         } else if (!acpi_dev) {
> >                 return -EINVAL;
> >         }
> >
> > The rationale is to avoid assignment and known-to-be-false test later on. Also
> > split assignment that is going to be validated and moved it closer to the user
> > (this helps with maintenance in a long term). Unfortunately double test of comp_dev
> > against NULL just replaced with a double check of acpi_dev against NULL, no gain
> > here.
> >
> > TL;DR: original and proposed pieces have their pros and cons.
> 
> There are reasons why I prefer the original changes.

Thanks for clarification. Yes, your variant (as put below) sounds good enough
to me.

> There's fewer indentation levels and fewer lines of code there and
> !acpi_dev is actually the most common case because acpi_bind_one() is
> called with acpi_dev == NULL for every device, so it is better to deal
> with it upfront.
> 
> However, it can be observed that the condition in the second "if ()"
> (in the original $subject patch) is obviously false if acpi_dev is
> NULL, so it can be moved to an "else" branch in the first "if ()":
> 
> if (!acpi_dev) {
>     if (!comp_dev)
>         return -EINVAL;
> 
>     /* If the companion has been set upfront, pick it up. */
>     acpi_dev = comp_dev;
> } else if (acpi_dev != comp_dev && comp_dev) {
>     dev_warn(dev, "ACPI companion already set to %s which is not %s\n",
>              acpi_dev_name(comp_dev), acpi_dev_name(acpi_dev));
>     return -EEXIST;
> }
> 
> and that avoids a redundant check when acpi_dev is NULL to start with
> (and is one code line less even).
> 
> I'll make this change, but I'd rather not send a whole v2 of the
> series for this, so I'll do it when applying the patch.

-- 
With Best Regards,
Andy Shevchenko


