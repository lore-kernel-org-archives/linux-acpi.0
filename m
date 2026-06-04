Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44D43DB653;
	Thu,  4 Jun 2026 07:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559114; cv=none; b=K30dU/9i1LYCOSFPVcIDBps3PVQKmi7QBPw2pWKAY+94UgBLKkIdZZdN3nCiBsChkYzIUFEURhaSSbmX881sK83dgorSgl8aQRVYsN8OHE+B+br8AEp3yrhgaUQS6+QPThaetCfpwGn9XLbGj/SwqwW4CdMtMRLo16UqnprV0tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559114; c=relaxed/simple;
	bh=IB02n+b9cGfZCs5vd+68ON2afO8mXp7oZMfSbQ2gK2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h01AErmllg7XQMz13C6haVc3oajkDpxxNPyBaJQSn9wkBgp0M1ieP7ifw7Ocbf40asplwoqHNxTV4uByLJ6TRq/hp86yMOjyDAoAx4t800nFXWvWgQRSJ/jHVUUqJGQwoDO3yHML+N8oFNyk2rgB7o6wn6FTPjiTepvhslVkawc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c9z1nQQo; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c9z1nQQo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780559113; x=1812095113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IB02n+b9cGfZCs5vd+68ON2afO8mXp7oZMfSbQ2gK2I=;
  b=c9z1nQQon6AvOgPqhamJDuER2wU1u8PR5zDCpydFHMZ0C5hhtATsUBUF
   VE2QS6Fl3xMs/+CQ21K5vRCGd0Bjh6pCVs0bj07sDQwMceHT4qmEL1dMf
   75fnpAynAe4j63I+omosKfs9mzhoFgsv4qHP7xVlwcPyXu34eZ1l69JD5
   Tb7l4oaox2vFlHqkTiqDaZGHJR8uV940B/H1apsNB5WJU1MlicN1UxwO0
   gpZRKhvoKpqRpmyjMIg4w5Gz3fGPNcYn7/laXK19N+CdngrJ/46SpsVVX
   mTdi046rLcSHl2YoxomSV9lhx8WkzQKQC2cQIRfOOM9M4dovGHTuR3GaW
   A==;
X-CSE-ConnectionGUID: ihdEFAtNSxeGvwLl5CR64w==
X-CSE-MsgGUID: dwsJF2JwRP6OTGSwEVGh8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81122338"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="81122338"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 00:45:13 -0700
X-CSE-ConnectionGUID: wkuk7/PARLagQ5g0imlDIg==
X-CSE-MsgGUID: NLdKFuxFTA+v4IlAnpjpJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="241504781"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 00:45:11 -0700
Date: Thu, 4 Jun 2026 10:45:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] ACPI: bus: Clean up devm_acpi_install_notify_handler()
Message-ID: <aiEtBYBySInVqw20@ashevche-desk.local>
References: <2841496.mvXUDI8C0e@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2841496.mvXUDI8C0e@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 08:26:24PM +0200, Rafael J. Wysocki wrote:

> Add a pointer to the struct acpi_device used for installing the ACPI
> notify handler to struct acpi_notify_handler_devres so it need not
> be retrieved from the owner device via ACPI_COMPANION() in
> devm_acpi_notify_handler_release().
> 
> While at it, drop the function name from one of the messages printed
> by devm_acpi_install_notify_handler() for consistency and fix up white
> space in its kerneldoc comment.
> 
> No intentional functional impact.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


