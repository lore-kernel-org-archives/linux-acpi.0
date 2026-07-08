Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2E73A784E;
	Wed,  8 Jul 2026 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520808; cv=none; b=OTPslE0ANDi9FcospXvwdRtf0Tmuxk2fGslePGat3soUkHRsVsnbD+7kFQPVIgwp/uJC9HvB87iiOayDOou4E8PWW3QPrLVqv/qvJhtQ1001WnMx/5Ru8unIA0Bu46B3iEHxyVdy0r+pNBM4rat5MgSl5f8I4709mJiFyUhBxGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520808; c=relaxed/simple;
	bh=NOEjyjHdrH50S6f26CNYRICDqPBReZdIZWNjCQdBXZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1LVQf05MXg/xS0QsshN5ViN55CDT/nKmUDmMQuI5u6k19lHNsAxPStnswo8AqrCdaR14jsPhWPk2BxRGZcGQGksOze1mEu3p6nwjhfWRB8uVZenX9KmC8ndfAERvcDCZEqs6s9HMIPtlTmEyjvM8m0lMrr3sRCJq6E3/VyOlEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mshN+HM4; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mshN+HM4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783520807; x=1815056807;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NOEjyjHdrH50S6f26CNYRICDqPBReZdIZWNjCQdBXZo=;
  b=mshN+HM47Ddd47ZkMhzw2u0Ywok/4+3ZGdM7BOufZj34gZ6XS+hK0GAd
   7x2azCHtFLZG6GmW2j9KNsZncWvZzT9L6d6dCwWpy8cMnzAS6tIGiN3P4
   L4dSJCw5M2stdT63cyPEIx0drs7mcpbTdBaIOzaTE77/9fPFaSbys0mdI
   xLr9kUQQ7Piauvuuvvl3z2kpjuIj5TnO21JzfCsf1zfcYOqr4QpZBDJdG
   r5/ItbLfmuVQhPBB9nYZK3rv90iv9J3mNhJ1OGQr55nfG5WOW6eDKuD6A
   Z47DO9OdGf9qSq/iZl/8/WHoczte3ku3aKA6aEw/WjP2A/9Jwux2TNkxR
   Q==;
X-CSE-ConnectionGUID: oDJxUyxLRYCUZnN7k0v+jw==
X-CSE-MsgGUID: lv+eqNNXTua2JOwxODTVRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83162715"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="83162715"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 07:26:46 -0700
X-CSE-ConnectionGUID: iuXcm7+pRtabG+p2OCZlzQ==
X-CSE-MsgGUID: iR2xfVNATpGtnK0rpp6hRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="249860871"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 07:26:45 -0700
Date: Wed, 8 Jul 2026 17:26:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Chen Yu <yu.c.chen@intel.com>,
	Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [PATCH v2] platform/surface: surfacepro3_button: Stop setting
 acpi_device_name()
Message-ID: <ak5eIhPrKL8nEjqw@ashevche-desk.local>
References: <12927239.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12927239.O9o76ZdvQC@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 07, 2026 at 01:12:35PM +0200, Rafael J. Wysocki wrote:

> The driver sets acpi_device_name() to initialize an input class device
> name initialization and print a message on probe success, but the input
> class device name can be set directly to the "Surface Pro 3/4 Buttons"
> string literal and used for printing the message.
> 
> Make the driver do so, stop setting acpi_device_name() in it and drop
> the symbol specifically defined for this purpose.
> 
> No intentional functional impact.
> 
> This will facilitate the removal of device_name from struct
> acpi_device_pnp in the future.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


