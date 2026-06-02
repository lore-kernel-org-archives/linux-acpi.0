Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE0813D891;
	Tue,  2 Jun 2026 07:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780386772; cv=none; b=TeJbrTQTE+9hsbEWMFfjWlNoD04Epj2mMC+HwKF9+ZpKNFB22hdvJocWJexNQ2lB7oMLdVR3jFIwGwZxR4HwUJ0YwLnQO3NjG92cUUqYuD8O5LzUiiJS279PZo86IcQNtzZo3w0yD61qqRWPWhfiAchWa2XjW+Lhgn0JFORREkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780386772; c=relaxed/simple;
	bh=o/5pQ87bezoy1L6yf8DtRcb6umHGoErqpcV63JMz0uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLqTtwIvaZhuTflevF/MrFrsOVpyZyR0xnmsk0erTyEPPhhXnh1YVNVyx26DBI5Som/8SvP7eMRpUAHasn7wWa+8VJMGXrhdTlNODXiGRpZIr4IzxsnvgII2vAY+oEv34hmR12ZjcQkL4CcHulIBuahqKEeFpv/HvOWjySmlAxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NN7477wt; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NN7477wt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780386772; x=1811922772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o/5pQ87bezoy1L6yf8DtRcb6umHGoErqpcV63JMz0uA=;
  b=NN7477wtyRCGZ+3lw9b2Ti0Liyo1Wa2MGPHb4VKMugviyj3EwjELwEx+
   y+kr6ved8pVNASNnOEocHESJvMl9kuHkjVbT9fjOExZGp2wiyaj/aHMsX
   aV3G82Py16XcaZw3FTbC2RynMmIpcAZg7Eji7hy8JUQ4h3OtyWPl0CV5b
   gNXkDmpzcoAtrstSMlpgOZCDTzLA1Z839dQ3tT2X1JyEmgsdxfxvg/DgK
   vEc9SiL288Tip2qLPHctwNbLOrf11KDiljB4BWxT9iqj2H9yEiHYKZGZX
   aicIVpvEdkuqu+RUQLpkn7QuX8b46SCkA5cyAZzg12Ntuv/UsjZsFrQD1
   w==;
X-CSE-ConnectionGUID: 8qiERIvMSgqnqnwfjs4vwg==
X-CSE-MsgGUID: D5UhlkuAQ2Sti274YOmSFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="83747726"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="83747726"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 00:52:51 -0700
X-CSE-ConnectionGUID: mebXPxO/QrKSc1SpVIM+gA==
X-CSE-MsgGUID: MGRvHfzARcm4ZAbGRYxlzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="243934104"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 00:52:49 -0700
Date: Tue, 2 Jun 2026 10:52:46 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marco Scardovi <scardracs@disroot.org>
Cc: Mika Westerberg <westeri@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] gpiolib: acpi: fix bounds-checking bugs in GPIO ACPI
 core
Message-ID: <ah6Lzn4NbilZQwvy@ashevche-desk.local>
References: <20260530094012.184276-1-scardracs@disroot.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530094012.184276-1-scardracs@disroot.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, May 30, 2026 at 11:40:10AM +0200, Marco Scardovi wrote:

> While reviewing drivers/gpio/gpiolib-acpi-core.c in linux-next,
> I noticed two bounds-checking issues in the ACPI GPIO handling paths.
> 
> The first issue is in acpi_gpio_adr_space_handler(), where the
> 64-bit ACPI OperationRegion address is truncated to u16 before
> validation against pin_table_length. This can cause out-of-range
> addresses to wrap around and access unintended GPIO entries.
> 
> Depending on platform firmware configuration, this could potentially
> affect GPIO lines associated with sensitive hardware controls.
> 
> The second issue is in acpi_gpio_package_count(), where malformed
> _DSD packages can cause pointer advancement past the package end
> during element parsing, potentially resulting in out-of-bounds reads.
> 
> This series fixes both issues by:
> 
> - Validating the full address range before truncation
> - Making the length calculation overflow-safe
> - Validating remaining package elements before pointer advancement
> 
> The fixes are intentionally minimal and preserve the existing
> behavior of capping ranges that extend past the end of the pin table.
> 
> Patch 1 also converts the related loop variables to unsigned types
> for consistency with the updated arithmetic.

You got me lost. There was v3 of something, what is this?!

-- 
With Best Regards,
Andy Shevchenko


