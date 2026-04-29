Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BB93191D6;
	Wed, 29 Apr 2026 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777458265; cv=none; b=UHc8CK6IHIEEq76WufI8kFcpmv8K/JAOZbVDnwvswDOqsyqvaqeHM+Zp6We3Lhda2H4+hTwdJeGybEdAmW+8A9/QQqH0j8wEroGTiUWMPOPsRKZBXyLJG+EFgQ1vC8+P540Bu5QvK8TOxE28GfrE44EapUYRycEFzOmQlSCrwYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777458265; c=relaxed/simple;
	bh=GKz3n4s8VFuROmva3+L75e+p2YEJ1U526UcrD9zV3Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJpLVCC5Jg3kgSt8nuw6T/HpOkH/e9QPBVHD6fIsrzug4D3ogW4XzuJiD32B1CJZ5b6OWl5LzWmb67MlI2JLdhAUMJhZcbDkWYiQbZjJCoOownena9WeCbbIhWlNLWuKeLLPnjR5FTh7ZPUdFop4qy+CfyI2TBwF9kjvb27M/jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fWkLSdF3; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fWkLSdF3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777458263; x=1808994263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GKz3n4s8VFuROmva3+L75e+p2YEJ1U526UcrD9zV3Zo=;
  b=fWkLSdF3r80ZISSATou5dXHVphJ8cMaxIIRzya0q2pZn+KZShrKIgcXU
   37hDRK62uzqIBSAj20oguy1fkS2eRnCo3cecbtKynaTGHIzhmuxpa/vM4
   yaKnFwsXrj0ZedbGnCGF6QHiE861gpWaWYNlv3Kdgq/uejCSdmOe2kn68
   ip3b5v+ON4rIJlhtfBV3mAAiqh6vaXcFsI8290Y9+n7ZD6Y6l8DpM8AWX
   sshRD5fnKsGvKuyKrh6h7MEu0GqZD9S6WlMmd5lIgz19E+Z/nV69b5g0Y
   O0Twn0yEulYvZ4rWp1TgqrCW257RgIar3qQJ0ZQa0FkIPiZcLJQrouTiN
   A==;
X-CSE-ConnectionGUID: AKPMj5L2QwGpGpdHvXOQEw==
X-CSE-MsgGUID: 00KKREfJSIOOFtBnjElWCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78277791"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="78277791"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 03:24:23 -0700
X-CSE-ConnectionGUID: tDG63m3wTAKVLU3f0aKzHQ==
X-CSE-MsgGUID: On1erOD2QoWLll+V0LQRWw==
X-ExtLoop1: 1
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 03:24:19 -0700
Date: Wed, 29 Apr 2026 13:24:17 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>, westeri@kernel.org,
	linusw@kernel.org, brgl@kernel.org, bentiss@kernel.org,
	Francesco Lauritano <francesco.lauritano1@protonmail.com>,
	Marco Scardovi <mscardovi95@gmail.com>, Armin Wolf <W_Armin@gmx.de>,
	mika.westerberg@linux.intel.com, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Only trigger ActiveBoth interrupts on boot
Message-ID: <afHcUTi5QNq8LlIb@ashevche-desk.local>
References: <20260429025247.1372984-1-mario.limonciello@amd.com>
 <6f359bec-2525-40e9-9994-15b16fb82f12@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f359bec-2525-40e9-9994-15b16fb82f12@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 11:48:13AM +0200, Hans de Goede wrote:
> On 29-Apr-26 04:52, Mario Limonciello wrote:

...

> > +	/*
> > +	 * Make sure we trigger the initial state of ActiveBoth IRQs.
> > +	 *
> > +	 * According to the Microsoft GPIO documentation, triggering GPIO
> > +	 * interrupts marked as ActiveBoth during initialization is correct
> > +	 * as long as the associated GPIO line is already "asserted"
> > +	 * (logic level low). We should not trigger edge-based GPIO
> > +	 * interrupts not marked as ActiveBoth.
> > +	 *
> > +	 * See: https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/general-purpose-i-o--gpio-
> > +	 * Section: "GPIO controllers and ActiveBoth interrupts"
> > +	 */
> >  	if (acpi_gpio_need_run_edge_events_on_boot() &&
> > -	    (event->irqflags & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING))) {
> > +	    ((event->irqflags & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING)) ==
> > +	     (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING))) {
> >  		value = gpiod_get_raw_value_cansleep(event->desc);
> > -		if (((event->irqflags & IRQF_TRIGGER_RISING) && value == 1) ||
> > -		    ((event->irqflags & IRQF_TRIGGER_FALLING) && value == 0))
> > +		if (value == 0)
> >  			event->handler(event->irq, event);
> >  	}
> >  }
> 
> One nitpick, which can be a follow-up patch since Andy has already picked this
> one up.
> 
> I think that now that the second if condition has been simplified to just
> value == 0, it can be added to the first if as " && value == 0" dropping
> the nested if.

But we need to get that value first (unconditionally!). I think it wouldn't
be desirable change.


-- 
With Best Regards,
Andy Shevchenko


