Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFFE15FA81;
	Wed,  8 Jul 2026 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521570; cv=none; b=CN9nmH4e4w1cqB6Q8SFgEiZWWX67MvbDa0md+lKkbNUrctQQeZgZ41/PtFVZRofPpMvTuSWEVGraacJ5U32dvhP24HtuQe9DPXxjk4uEOOocrNN3ioF/HhgkGVrtz6yVMk5Lr3gEaBt4LYFKnTZQYXMl/Hrqrpn++JDPOIhtKmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521570; c=relaxed/simple;
	bh=Brc88gt06M3A3ZZnh0TyP1FN4NWFmV5F1JYreY0byKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KG/o2inJsavhJDhvq4xtnkJLGCsdT1g1CDUYXS10ujFRoaYOGulXEwnnyxfcp5jXP/zlQ43fUFL94+2nivGXI8F5VXUbYSoWP9cfP57T167/vYh1ykdtou+7ymi+P3AUQuJs7nUXYj+w7WnhXZXynQUig8BZrRM03/eSw4+RVOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GygFFSLn; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GygFFSLn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783521569; x=1815057569;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Brc88gt06M3A3ZZnh0TyP1FN4NWFmV5F1JYreY0byKo=;
  b=GygFFSLnLc8318UF88skYyv28uSLYfxxTEc0no4nUC5W0GoCodUSWczk
   W8xoewHhBsBm1RuqRamDkZ6MBOAcBFVANGL84xwxQzZ+gYICBtKD0DNDp
   lgY7ehNNbzzpxLxb87oe//tiMjwe3y3D/Tn/Yam4kgGsJEvJxylN6+MK8
   Oz3y1NLIBF8kYz63GRM6dcybXJhBTccQgNM09VZeh7TaGeAbgGHwO0B8W
   ftzKGEHAsoBaz6ghiyq6PvvkLN0ytSdLZwYCAZ73B8hXrfOmTF6KAyvJN
   aRjBL6gtbMki3nJWZALr8xqpHDDIM1FnEGK4a7u48jghDB4jMQIfgUsGk
   g==;
X-CSE-ConnectionGUID: ntX0PqQoQ7eCSeleAVQ6KA==
X-CSE-MsgGUID: S4EVFR8STZea8fdumqJaYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88098073"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="88098073"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 07:39:29 -0700
X-CSE-ConnectionGUID: nZyuZqF2R2yP0ulT8twUVw==
X-CSE-MsgGUID: 16dC0Uz3QHqiH4BnmEMOhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="258605698"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 07:39:28 -0700
Date: Wed, 8 Jul 2026 17:39:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] PNP: ACPI: Stop using acpi_device_name()
Message-ID: <ak5hHUpQsFyn04N9@ashevche-desk.local>
References: <23191780.EfDdHjke4D@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23191780.EfDdHjke4D@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 06, 2026 at 02:43:32PM +0200, Rafael J. Wysocki wrote:

> Since acpi_device_name() checked by pnpacpi_add_device() is never
> populated, its length is always zero and the codition checking it
> is always false.
> 
> Accordingly, drop that condition and use acpi_device_bid(device) for
> setting dev->name in pnpacpi_add_device() unconditionally.
> 
> No intentional functional impact.
> 
> This will facilitate the removal of device_name from struct
> acpi_device_pnp in the future.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> -	if (strlen(acpi_device_name(device)))
> -		strscpy(dev->name, acpi_device_name(device), sizeof(dev->name));
> -	else
> -		strscpy(dev->name, acpi_device_bid(device), sizeof(dev->name));
> +	strscpy(dev->name, acpi_device_bid(device), sizeof(dev->name));

'dev' here is of struct pnp_dev, so this is the way to fill it.
(I was first confused, but after looking into the full context
 everything becomes clear.)

-- 
With Best Regards,
Andy Shevchenko


