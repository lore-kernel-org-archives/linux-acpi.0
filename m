Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6E53F661F;
	Thu,  7 May 2026 19:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181561; cv=none; b=KSr1Itx/0RnBJk/IpePyggQquAb4gVjeG9ieVJvUzFDc+EXORit4o1NqkRLJLUNJUT5ZOPkyKTDEYiXciniOulVj0CACqITmaBcukCmk4ib3mU5Xc8Mw6fld6kHkKOFcdgQ2tXy9qe8GLl4YRJ3vu3JnyM7H043WTnG0/6b1g9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181561; c=relaxed/simple;
	bh=dRVjvmUN2oA7j2K7VQHzPc2lYSC2ly8h4q679VpC0n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fpotegp0pttEHZHjGxDLV0f6iGEWD2hO5LG+nEcgyaw7fTDY0e6vVKZyH2nb5ApFgAvveh+dxlWLQy9NUszKmqugzOMipT/ATqi3hmBwqV2po/KYynHX9M8SvAGibxbZkDlS1lHV6l+DQFztsz7wg5VUySJgNGPlJNuIc1P/3AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rq+i2KF0; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rq+i2KF0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778181558; x=1809717558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dRVjvmUN2oA7j2K7VQHzPc2lYSC2ly8h4q679VpC0n0=;
  b=Rq+i2KF0fcaI92hiwwZSRkKW82cvcdk8/R/YIdMRGxA/o2BS3qWKYA7k
   FYdmzESqPzaml2W8rgtbqlO7kzEx+12qh524WEy1OFSqgzq1nhnSack3d
   VkTOASGj4gr6Rhy+Hx8/22tEXngYoFsd4qSJ4CsN79NgLyqTbDgTa5rqj
   8Rj9x9qSLwOP8nyrUw4gCioZNXtKqWXLbV6bTht2XgVVQuGpwpdVh9r+3
   KInyU0YwaOi9K1wU8C+dbalz0OWb/zCzCNB+jEhJ2ukI+56elwb6UBsDr
   mHRBii3/rGrSxAcKlBIKWCyNCra46tX9G8YDFcm0NosWojY/oaZqZi1Mv
   Q==;
X-CSE-ConnectionGUID: gX1MG5zJQom1WbVLJmLf6w==
X-CSE-MsgGUID: Q7Y4DA9uSrizv+MtWoatvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="66671405"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="66671405"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 12:19:17 -0700
X-CSE-ConnectionGUID: Bv256kdXRYa+uCRGw308xA==
X-CSE-MsgGUID: fwSA2GkzSTu0WFaOZKsWRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="260262352"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.149])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 12:19:15 -0700
Date: Thu, 7 May 2026 22:19:13 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marco Scardovi <mscardovi95@gmail.com>
Cc: mika.westerberg@intel.com, mathias.nyman@intel.com,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] gpio: acpi: modernize resource management using
 cleanup.h
Message-ID: <afzlsRkyKQzuUcgL@ashevche-desk.local>
References: <20260506123421.1077421-1-mscardovi95@gmail.com>
 <20260507155647.403964-1-mscardovi95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507155647.403964-1-mscardovi95@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 07, 2026 at 05:56:41PM +0200, Marco Scardovi wrote:
> Hi Andy, Mika,
> thanks for the patience: I was way too excited about my first patch on
> the linux kernel and let it takes over the reasoning and I'm sorry for that.
> I've moved the defines on the right places as requested and refactored the
> patches to be smaller and tested the build with KASAN and kmemleak as requested
> by @Mika without any visible regression as for now.

You MUST provide:
- DCO (Developer certificate of origin)
- commit messages

Without that, it's no go *at all*.

-- 
With Best Regards,
Andy Shevchenko


