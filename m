Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27583BED11;
	Thu, 25 Jun 2026 06:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782367717; cv=none; b=LyKXjwtSVgd+m2ujMvZ/dD2DJVT09oMYygBNl+tiegPWbor0WtH1aSUg09nejuka7FrRQP+v1ZGqUlz3z486zNB7zW7czv9ASLOfRUL2RPZCcTDLSKgFBD91Q8C/J54WBQ/tc0N1ENhIjsVZiElY3xW9OaAHwpXz79M9ZIoGi7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782367717; c=relaxed/simple;
	bh=pQPGTJ0oLnaYxiWoK2IhGUUclA9Sw43MnypFha8fAVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OC0/b9SeryXpqJ9NdD1NH8MG81iRL3nMCjbDjJyOfwlspECmHo9DLssMJrpvwOGVkavflwwzNPBxMGXsjKKPuPHd2H4lVXW4CY10saz2MY3PcXArjt54vaYXOq6xWkNJpwbF5wX2OdtEVCnBIcsTBtLpiMYZvR5qwzWspq0bzzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IMX8dVIj; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IMX8dVIj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782367715; x=1813903715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pQPGTJ0oLnaYxiWoK2IhGUUclA9Sw43MnypFha8fAVo=;
  b=IMX8dVIjbBvLJJz8oxycT4y+wQdQ3kLCb9nuGtixaPO9ni14Qk90LT0w
   oiiUBBixh5G0vnk6s8DpLUvGSb24R0442zYnAP7L0uxqqUvAyR6FQcFXb
   kGss+sy3DYtN2b2kpDeyHHbj2HTelIleY27AhZW0w7f1Hw8yqt7nzGB5u
   NmuKGJZq7RvZ/skpypfU3yV9kLTkK41LB+WHeoxEL0XUpjRRm/4boM5Pf
   OwWgF6oZGRWVDwqKg6fmzNFjezOAqP4rhvgjpg5Pd9r1Ujbf0jEz3ecwJ
   tOhH73Q4jqf4483h0byuLlTe4WQeRpNxJYE70ViNF8Hq3aF6JK75utHYL
   Q==;
X-CSE-ConnectionGUID: 0UI5cChFTvSxRIHsGF9Yxw==
X-CSE-MsgGUID: Z0Dve25UT16LRluaeZgMbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="100565329"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="100565329"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:08:35 -0700
X-CSE-ConnectionGUID: KwtRsW4VRHyqR+M6fmWCWg==
X-CSE-MsgGUID: ZZ3K49gsQvOHbhb2XfhTHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="249381443"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:08:31 -0700
Date: Thu, 25 Jun 2026 09:08:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marco Scardovi <scardracs@disroot.org>
Cc: w_armin@gmx.de, bnatikar@amd.com, brgl@kernel.org,
	johannes.goede@oss.qualcomm.com, linusw@kernel.org,
	linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
	westeri@kernel.org
Subject: Re: [PATCH v2 0/1] gpiolib: acpi: Add quirk for ASUS ROG Strix G16
 G614 series
Message-ID: <ajzF3aHqFZOH8n6P@ashevche-desk.local>
References: <f51df47c-0523-41ee-9e7d-0aa0177065e7@gmx.de>
 <fDMIXYjSRMSLJNqjRmWA7Q@disroot.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fDMIXYjSRMSLJNqjRmWA7Q@disroot.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 24, 2026 at 07:49:21PM +0200, Marco Scardovi wrote:
> Hi guys,
> 
> I'm feeling like a complete idiot right now and have to make a
> mea culpa for it.
> 
> I didn't notice that [1] wasn't still merged into the 7.1 stable. I took it
> for granted as it was on linux-next since april and newer patches made by me
> were already merged on stable. It sounded strange that a patch made that
> was working 2 months ago to stop working suddenly and now I know why.
> 
> I'm truly sorry for all the noise: you can skip on it.

Okay, so this thread clarified that Mario's patch fixed your issue and any
other model that is affected.

Hence, no patch from _this_ thread is going to be applied.
If it's not the case, speak that up!

> [1] https://lore.kernel.org/linux-gpio/20260429025247.1372984-1-mario.limonciello@amd.com/

-- 
With Best Regards,
Andy Shevchenko


