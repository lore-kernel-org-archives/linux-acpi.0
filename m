Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B083C4B83;
	Fri, 11 Sep 2026 07:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789112408; cv=none; b=qOU+R4x6jmO0BEAg7Gt6WoZaNbVonJM3lPqGcdZre+xZY8b0z2U7lLoRRGeZGjdtdP7KypHNPlTLALFFtlFB/xfJ2IFKg4EmH7CdCy0drNu8VMW9+9W3+4ldkIW1hJMATb5lnKYPBQVsnA2zU9gI4QeuD19k5SSDp4gCcWYQF7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789112408; c=relaxed/simple;
	bh=VslTrdeMrrokNQFQ7V8wDFJxZGml1M4BwrYqovAOfPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSL19SQB6mBaX1pC7CX0eZ9yy6kTAheJ+Es3pggzgirbaBQtazuNCWYv1QUEcMjwqbLiViybmCpUTbe4cAJ4heet5bNQ1qCC5MxHM9Dd0ZBU1aJ40RO8RHAK0/5bFWUrCMND0GzjZhCxGNQ0oqTlJ5pZSkERlMjyPBdWtVKumfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GsP11grm; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GsP11grm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789112407; x=1820648407;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VslTrdeMrrokNQFQ7V8wDFJxZGml1M4BwrYqovAOfPQ=;
  b=GsP11grmWT/nXZ+6iTdCcvzvNRq2J2PSYcH1uLYK4RtQT71lLS/vmXj7
   lR2zwnymcx9osa7KZCYGAsQZSydBw1y9fsm3IhdubyQKWMTIriw3ra+ho
   9olM/Lg5TowPcBg34AO/vB5N0OCYZP2Zf8OeHPNGC3PKcRIdcAxOtN4T2
   OFSNBdPrralMq0TAZBvwZ7YnAd60Gw/m+54XTT8pRcVuWlIomOMQLSHjn
   VEPgRLTDXzwVVo675pncLL2pAQ7oDFZRQ3zqh8kB2HuCymYvZibgvjLUY
   PTYjyx6SRlRO+ikjrZA41/Um59NrGb8bcWNqNJVqsdBAkoyw1MlWDeUpH
   g==;
X-CSE-ConnectionGUID: IPMJ6TyHT1uqvr/6KFI69w==
X-CSE-MsgGUID: LXn2D6RdQLKlil7GpFzggQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="100168174"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="100168174"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 00:40:06 -0700
X-CSE-ConnectionGUID: yNb2siJUS2W+T3MmjnuJcA==
X-CSE-MsgGUID: CBWkXubtQn6E84yH7Us98A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="272355239"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.80])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 00:40:05 -0700
Date: Fri, 11 Sep 2026 10:40:03 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/4] ACPI: glue: Rearrange acpi_bind_one() to avoid
 breakage
Message-ID: <aqOwUynzp3APwfYS@ashevche-desk.local>
References: <12995802.O9o76ZdvQC@rafael.j.wysocki>
 <3465482.44csPzL39Z@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3465482.44csPzL39Z@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 10, 2026 at 07:56:10PM +0200, Rafael J. Wysocki wrote:

> Rearange the code in acpi_bind_one() to avoid situations in which the
> existing ACPI companion of the given device would be replaced with NULL
> due to a memory allocation error or because somebody tries to bind a
> physical device with an ACPI companion to a different ACPI device
> erroneously.

...

>  int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
>  {
>  	struct acpi_device_physical_node *physical_node, *pn;
> +	struct acpi_device *comp_dev = ACPI_COMPANION(dev);
>  	char physical_node_name[PHYSICAL_NODE_NAME_SIZE];
>  	struct list_head *physnode_list;
>  	unsigned int node_id;
>  	int retval = -EINVAL;
>  
> -	if (has_acpi_companion(dev)) {
> -		if (acpi_dev) {
> -			dev_warn(dev, "ACPI companion already set\n");
> +	if (!acpi_dev) {
> +		if (!comp_dev)
>  			return -EINVAL;
> -		} else {
> -			acpi_dev = ACPI_COMPANION(dev);
> -		}
> -	}
> -	if (!acpi_dev)
> -		return -EINVAL;
>  
> -	acpi_dev_get(acpi_dev);
> -	get_device(dev);
> -	physical_node = kzalloc_obj(*physical_node);
> -	if (!physical_node) {
> -		retval = -ENOMEM;
> -		goto err;
> +		/* If the companion has been set upfront, pick it up. */
> +		acpi_dev = comp_dev;
> +	}
> +	if (comp_dev && comp_dev != acpi_dev) {
> +		dev_warn(dev, "ACPI companion already set to %s which is not %s\n",
> +			 acpi_dev_name(comp_dev), acpi_dev_name(acpi_dev));
> +		return -EEXIST;
>  	}

I would rewrite the above to look as following (if I got the logic right)

int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
{
	struct acpi_device_physical_node *physical_node, *pn;
	char physical_node_name[PHYSICAL_NODE_NAME_SIZE];
	struct list_head *physnode_list;
	struct acpi_device *comp_dev;
	unsigned int node_id;
	int retval = -EINVAL;

	comp_dev = ACPI_COMPANION(dev);
	if (comp_dev) {
		if (acpi_dev) {
			if (comp_dev != acpi_dev) {
				dev_warn(dev, "ACPI companion already set to %s which is not %s\n",
					 acpi_dev_name(comp_dev), acpi_dev_name(acpi_dev));
				return -EEXIST;
		} else {
			/* If the companion has been set upfront, pick it up. */
			acpi_dev = comp_dev;
		}
	} else if (!acpi_dev) {
		return -EINVAL;
	}

The rationale is to avoid assignment and known-to-be-false test later on. Also
split assignment that is going to be validated and moved it closer to the user
(this helps with maintenance in a long term). Unfortunately double test of comp_dev
against NULL just replaced with a double check of acpi_dev against NULL, no gain
here.

TL;DR: original and proposed pieces have their pros and cons.

-- 
With Best Regards,
Andy Shevchenko


