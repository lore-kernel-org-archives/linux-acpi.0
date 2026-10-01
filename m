Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5135F4AD4B5;
	Thu,  1 Oct 2026 18:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790878530; cv=none; b=t595WYTmiTsSd/ZTz+6FFDQMur6W+z9HiF90LVQOtBLlSFdcTvHjRJmqJHNwlnO+bN5oWijrXfZRVBb3nJ6Uop+Tg+s9n9tkFbIBdh6SoBcTF9xtjBaq5cfTGtxmxhy8W0V/cf8/z9Ejv3xCLLAv2Wn2C66A0/vm33kqtqZacFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790878530; c=relaxed/simple;
	bh=50s2Qv0GNgNGN/PAeJ//wTD0DLgmTftx13CRNmJZOX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUj6srAILCB9MPnZrr1fVrMpfJsauOr102QRYyUlbE2/w/jUBmG7CDqm7kFPITMjPZCcGpCpEg7yKy0tXyOyUjPEH7RKQJxgv3xPXN7jcfS5rZVgrPe4/coRHD0EeKOleahOzxp9QSLZidWzBdh7RpWwldf2/IWBqCoRHrfnx64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CrA51B+f; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CrA51B+f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790878528; x=1822414528;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=50s2Qv0GNgNGN/PAeJ//wTD0DLgmTftx13CRNmJZOX0=;
  b=CrA51B+fMGkzk3k0V2363W0f9ksXSeMYwCuXDWk4LVS4LhDdPmelq+Jd
   9Ah69ZOEkOCzXdKuUB7O2gbdOxEI8rJv0rF1QmIcW1lVIs+QKNeMHPEiw
   vGEdQHAvy/iAMW53yJp66vHn4l/SByI5LjcFA6nx0dYL3HvOZXluGcTU4
   0bSv9jgrMq/l1UzjC8jQU/OtvPJ0l39YYtbKcyG1J7krLd5bGPv48JhsK
   I6U57eugNAXhH4UfTj5LEpaT2OaOVjmLNmcTqlnPemHEGjN5pTJoKUeH7
   HRSOz8+PutSP0KaBE1m50lHeyeERE+DXdjbIRO26Op2GjmrtTLmcCH9pA
   A==;
X-CSE-ConnectionGUID: 8/3nI9daQGOV7xZDW3uMCg==
X-CSE-MsgGUID: JGoqlRvcR6ibIT5yOIjiGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90506354"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="90506354"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 11:15:24 -0700
X-CSE-ConnectionGUID: F2CkvQq/Sr+ntoWJunaitw==
X-CSE-MsgGUID: zpbmy6ppT+uC9lG0ERv/KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="279360229"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.27])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 11:15:22 -0700
Date: Thu, 1 Oct 2026 21:15:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rahul Pon <theflyingrahul@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mika Westerberg <westeri@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
	linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: GED: Support GpioInt event resources
Message-ID: <ar6jNo7-Wgx2ZLty@ashevche-desk.local>
References: <20260930111505.1108-1-theflyingrahul@gmail.com>
 <CAD++jL=45ZdTbHsLDTAmTt3f+=VBVK014TLJyd5Drdba3V=dSQ@mail.gmail.com>
 <20261001041856.1984-1-theflyingrahul@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001041856.1984-1-theflyingrahul@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 01, 2026 at 09:48:56AM +0530, Rahul Pon wrote:
> On Thu, Oct 1, 2026 at 1:52 AM Linus Walleij <linusw@kernel.org> wrote:
> > I don't understand the patch at all, but I understand that Andy or Mika must
> > review it otherwise it's not going anywhere, so looping them in.
> 
> Thanks, Linus.
> 
> Andy, Mika: some context that should have been in the commit message.
> 
> ACPI 6.6 section 5.6.9.2 says a GED _CRS contains only Interrupt
> resource descriptors, so this firmware is outside the spec. It is still
> the only source of lid events here: LIGE's _CRS is a single GpioInt on
> the GPIO controller (pin 960), and the controller's _AEI lists one
> other, unrelated pin. ECGE is the same, with pin 768. On Windows, the
> in-box ACPI device driver (acpidev.inf) binds both GED devices, and the
> lid works there.
> 
> For _EVT, section 5.6.9.3 passes the GSI number, which a GpioInt does
> not have. The patch passes the pin number from the GpioInt descriptor,
> as section 5.6.5.3 does for _EVT under _AEI. Both _EVT methods on this
> laptop ignore Arg0.
> 
> If the approach is acceptable, v2 will state the spec deviation in the
> commit message.

Is vendor of the firmware / platform being informed? Do they accept their
mistake? Are they going to fix their crap?

-- 
With Best Regards,
Andy Shevchenko


