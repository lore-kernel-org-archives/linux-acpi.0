Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D457C3D954F;
	Fri,  2 Oct 2026 07:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790924997; cv=none; b=HmMpzU6BNNaVyY6zC2cWouV1GGPhH+8TbAy6sxGderiB3EoOnP4RNvC1Nwn1mD+g87yBPNN0Oq3xru0Tl66fPU6bCYk31+DIrgX38CxGxuVJ5KFu+/H+FZBUQbWj8FRfUyjiPt5T7nzBkGmyx6gxWrhBszEKAVwSz612a0wh53Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790924997; c=relaxed/simple;
	bh=4AW93WT6mJBFYDqC5zmEKm5Yf727JpdoYyAsFd5bPQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvfnFt9WnB/vZ8JZNV3/n5ruZxzfg6eSya9h4hxY2Aw1+wvO0gT77UYrPqc8aNWQDX8XxnQxjKDVZdqv+ANt9iRKoa+WkLYy66xf+P9eJdFNMEfPkbEt6h3bt/HOU1dPMr28p78cjvLMOIBXhPKA6fcohaipSGdfnlNszd6e0kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DBo+vor+; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DBo+vor+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790924996; x=1822460996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4AW93WT6mJBFYDqC5zmEKm5Yf727JpdoYyAsFd5bPQk=;
  b=DBo+vor+eA8M46nVC9bSSsHIALKOmdQ1mZHBFeUoVsl0KjT/AdAn2SvW
   sANJvrb/osP/WaDjh8s9ibQx6FmiJ19K9T/F55xMVrbrnKE2yJxZuv9Ig
   cHiyR0gpW+rgz+B7B/K9qMidT94tvvQiTUaYcn6mSf6EkgPcGt4TV2Sqi
   7NTgNvWe14mp3yRlv65qzmtJTFY7j4MNz7LmnOF1NVIjWK5Abb8EFNV+3
   eeYV1aQyZI7tpPiErgUL+uxaFnDOzPzcuuBbrGOPSuu7DZHbK0aqEqUrf
   1S+EoXPwxgINBNvalXz0BzBqVjFGbWBj6Dukl6SQ1SzXsbZWrK82x3FKN
   w==;
X-CSE-ConnectionGUID: z2BSeLymQw6S8lNB3uiFXg==
X-CSE-MsgGUID: GDN7WVacS9eONWm+YBEA6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90747065"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90747065"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 00:09:56 -0700
X-CSE-ConnectionGUID: oTfFj/KCQBWzpW6coXbAlg==
X-CSE-MsgGUID: GlWD86gpTkeVxKVmz4loAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="276299338"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 00:09:53 -0700
Date: Fri, 2 Oct 2026 10:09:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Alban Bedel <alban.bedel@lht.dlh.de>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Subject: Re: [PATCH] gpiolib: acpi: Fix GPIO lookup using relative path
Message-ID: <ar9Yvi6YRT9kjCO6@ashevche-desk.local>
References: <20261001152343.1995157-1-alban.bedel@lht.dlh.de>
 <20261002043608.GE176164@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002043608.GE176164@black.igk.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 02, 2026 at 06:36:08AM +0200, Mika Westerberg wrote:
> On Thu, Oct 01, 2026 at 05:23:43PM +0200, Alban Bedel wrote:
> > ACPI allow to use relative path in resources, pass the device handle
> > to acpi_get_gpiod() to allow resolving such path.
> > 
> > Signed-off-by: Alban Bedel <alban.bedel@lht.dlh.de>
> 
> Acked-by: Mika Westerberg <westeri@kernel.org>

Interestingly that I have no original patch in my mailbox.
Whatever, Alban, do you have IRL case, or is it for the to be
productised platform?

-- 
With Best Regards,
Andy Shevchenko


