Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63863B47C9;
	Tue,  2 Jun 2026 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385692; cv=none; b=gPu4Ji7BdSPjqq/i8YavF4/LTnOt+nmPC0DbsOdGLFb637S6nCJ255VpHUhqAEcF1bK7Q2aZzL1Xnz3B4vqFmMcbhtG6qCEe6It1SSMP6gcNSispMBYq1DhZGn6ZkkgijwnwK88O5lI6i+TOqax1AJOEeTsuYPbqqMk+CxFJwPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385692; c=relaxed/simple;
	bh=LT1YlLr0VvfYyb8ZbGeU7+/ZsyveE0n6JR8cQhPmat8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTEWaJa4HvJbMKW7o7Vt855S6B/7JKgBANpL9nCBayIxrQrsxTlTJatDuECNuRTgJqyaOZ3L42uNXgImR3DBJk9jtcZctUqzLYeRIvYHTn53w5X3QGSpex4vx1y9aBiDGF1UezhMfQ8mTE/B5GVKB+uanjxvn8p42rqKwXrg2V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lGDoms/4; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lGDoms/4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780385689; x=1811921689;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LT1YlLr0VvfYyb8ZbGeU7+/ZsyveE0n6JR8cQhPmat8=;
  b=lGDoms/4XMJJW0QBEnR3Ij/C2OGpI/JasIikoo+ExaP4owVjQvbIVJUf
   6FaMzPlCBloPY1aSxeN0LLOvy//7ZNft6theNRD4PLJ/L0DOnj/QYxuTU
   oxAhNcVVCgaOOZVctT57BnNtsWdIltq4y0gA/Gg7BqApoBTCOm2t2ozuz
   4V+yT6GP5el1NDC1Nw07eOlbX/c/dceiN3THSf46eRzQbQxY7TMr+QdaM
   b6zQF8l0KDgkiemgE55OI7Y2WQIoG4C40AoVb6snCDAwxvswWYUzvxD5y
   A9Fzsq9uJCqqyzH1pyxFTUCmJrjak/8lwLebcqbehHMKE0/ELhd/ozOXj
   g==;
X-CSE-ConnectionGUID: bq6lgfPKTkGauqzvHvNAKA==
X-CSE-MsgGUID: AuHLbPKCQqu0PBtK7rajaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="91739904"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="91739904"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 00:34:48 -0700
X-CSE-ConnectionGUID: Pk2OOrJJR4amkuVCWjHCnA==
X-CSE-MsgGUID: GsXs1WveTHiDhuxqEJKZXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="243931150"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 00:34:46 -0700
Date: Tue, 2 Jun 2026 10:34:43 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
Cc: brgl@kernel.org, linusw@kernel.org, linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	mika.westerberg@linux.intel.com, westeri@kernel.org
Subject: Re: [PATCH v3 1/2] gpiolib: acpi: Add robust bounds-checking for
 GPIO pin resources
Message-ID: <ah6Hk5f7jn1QiqKp@ashevche-desk.local>
References: <agwfEMtEctXYC1oc@ashevche-desk.local>
 <20260520074955.55443-1-mscardovi95@gmail.com>
 <20260520074955.55443-2-mscardovi95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520074955.55443-2-mscardovi95@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 20, 2026 at 09:45:46AM +0200, Marco Scardovi (scardracs) wrote:
> Ensure that the GPIO pin resource arrays are safely bounded before
> accessing indices. Add bounds checking in acpi_request_own_gpiod(),
> acpi_gpio_irq_is_wake(), and acpi_gpiochip_alloc_event() to prevent
> out-of-bounds array reads if the ACPI namespace provides malformed or
> empty pin tables.

...

> -	int polarity = GPIO_ACTIVE_HIGH;
> -	enum gpiod_flags flags = acpi_gpio_to_gpiod_flags(agpio, polarity);

> +	enum gpiod_flags flags;

> +	int polarity;

What's the point?

...

> +	polarity = GPIO_ACTIVE_HIGH;
> +	flags = acpi_gpio_to_gpiod_flags(agpio, polarity);
> +
> +	if (index >= agpio->pin_table_length)
> +		return ERR_PTR(-EINVAL);

Now, what's the point of assigning flags and polarity before check? If you move
them after pin assignment below it will justify the changes in the definition
block above.

> +	pin = agpio->pin_table[index];

-- 
With Best Regards,
Andy Shevchenko


