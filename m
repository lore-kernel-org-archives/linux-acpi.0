Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7E0423141;
	Tue, 16 Jun 2026 09:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781602302; cv=none; b=DvYpLoYqUwmZtYs0u+aTKhW7yM1FZdK0PKQi1x7uYvtj28823YzlpPuWtDB0QkzTyyJnOfs1O+VKI/Hq0CxWy9FIPrWn250T9HbOhQTR0ujpP+ccLvKDDRgSK2jbJX/eYLErtVgaPpK+4ecPLPfz1FrbmSsHhBb25zfAqGwDltY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781602302; c=relaxed/simple;
	bh=py9/2Zt7xQMpoKBn11UstNzWxI/Y0GlDPMChdS5fpsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AT9yHU/1KPZxw4HyFOcSbZzX1mtOCk71CGFigIfg0D4zXGHMmFU2sUfJj+fRjVeLkv1EpswOVPa3kG/1FPy/qLahPK1hygrEudkNfZkuaRfQpfikiZ4scG2Z1pDka+nubxaD0PJzWtAvqG8kue/S0Y5VcYuUWcUeX1SOAIlI+T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DBEOQ9xD; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DBEOQ9xD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781602301; x=1813138301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=py9/2Zt7xQMpoKBn11UstNzWxI/Y0GlDPMChdS5fpsM=;
  b=DBEOQ9xD3hQVoAsENbAh4L8z+IBtavjph6f59S0h27MPVv+W0IBAzmur
   Qs4E7HhvqcmN6eU6EZ2Jal4tmzERdkNv+GJ5QD0OUrI7zSHjx3mzIvDVJ
   hVbNVXTx15RtTtJguc8bSrzkXsDEIUDHugpd+5OJQrV+SO4P7L6lmM5Gv
   n0g5ttDOpgxXM7vESILirovuVXu+OTAMRWMq6aziT12pe8WPod2n3qM8E
   uu9GbqIte3rkBwAKKrhFy02aK2znK+EdCupb6lGo5dJ8dT8iMxi2NPpuD
   iqRwctRvlMBPyhgyybP6uO+XT3dA52oUbXFEqE0QQp3atvLMYMzAMQana
   Q==;
X-CSE-ConnectionGUID: EyPOgSqAT3mkwYeDRTYr3w==
X-CSE-MsgGUID: h4t8i+q5QbO6gvQhhDPo7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="84926607"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="84926607"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 02:31:36 -0700
X-CSE-ConnectionGUID: oc00Q5OST/+TXJv3J8cyrg==
X-CSE-MsgGUID: berIJJJwRh+0Ez0I+zn04w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="246606999"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 02:31:31 -0700
Date: Tue, 16 Jun 2026 12:31:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marco Scardovi <scardracs@disroot.org>
Cc: Mika Westerberg <westeri@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add quirk for ASUS ROG Strix G614 series
Message-ID: <ajEX8L63vAhhndv7@ashevche-desk.local>
References: <20260616090824.5967-1-scardracs@disroot.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616090824.5967-1-scardracs@disroot.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 11:08:24AM +0200, Marco Scardovi wrote:
> The ASUS ROG Strix G16 G614 series laptops experience a long boot delay of
> approximately 36 seconds. This happens because the system firmware triggers
> a slow/hanging ActiveBoth GPIO interrupt handler at boot time.

'slow'? Did you mean 'low'?

> Even though commit 3bb62e3f99a5 ("gpiolib: acpi: Only trigger ActiveBoth
> interrupts on boot") restricted boot-time execution to ActiveBoth edge
> events, the problematic interrupt on these laptops is configured as
> ActiveBoth. Consequently, the handler is still executed at boot and
> the boot process stalls.
> 
> Fix the delay by adding a DMI quirk to disable edge event execution at
> boot for the ASUS ROG Strix G16 G614 family.

What is this interrupt for? Touchpad?

-- 
With Best Regards,
Andy Shevchenko


