Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F91B263F5D;
	Mon, 10 Aug 2026 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786376810; cv=none; b=L478SEi5jFpHGywRdkArXSS85B1k0LLthlXgJFz632VFknoAle96LqbOrj4tkt87fBQFAw9b9MJueWPJz3EK81sAYuBfHikPbcOBco/tXjCqd5W8RJd3NEYXiyiyDac80WoyCNiVMdmd8ArXF+V/QDZxghPiSN867C2pFybjXVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786376810; c=relaxed/simple;
	bh=4gIbwgwasZxeg2+1kdZunO96UDOuzVeBaoe4/ii5Euw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTBPShvS2pb/7f8MTlgjxhzyzR8eRKZdRV0FFlzWcgCDDkdCqzzvSc6dtO5EXflHkuC4wh5s5iyUA2QYhLiekdXTte3UqXBk6k+08CaislqIWc7TgY7uuSBCt1CE6watUo9/L9V2nAHhAqd+Rf5ZJLbD0PoJ2DhdK83sRfwF1JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P/btvMoz; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/btvMoz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786376809; x=1817912809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4gIbwgwasZxeg2+1kdZunO96UDOuzVeBaoe4/ii5Euw=;
  b=P/btvMoz3+D/MhfhKfhgmb0UvqjkjUIEFI3bStRZIX6dN38H1KGRT70J
   vTFc/9NjLtK35435616xFAUZCOnxkZEuTeRl3Ikdu3qlIWxFiJIx7icHC
   NK121o+WIH1c34PPjKqHzZvJ53elZDZFwpBW+RrrTq8ynAKXklgZAJlyj
   IIIXR8Wuict4phqchPUUv7a+w3J27S0oSgs45AhrTJRjYKxIS6f/830Sq
   SwtmR9RX/5fF/qHcYaFe490hMz0lk7KzLtjBrlgo0wcdhkdMyr7Th/npp
   62AvUpUiGUT45utu5z3X2qHaUKRT7aSlorurzgRFj7Ekv+Y0/DhMLjDjJ
   A==;
X-CSE-ConnectionGUID: x1cFQs2DRTuwBEgQzzCihA==
X-CSE-MsgGUID: XWTQvd3zRE6lvk4UqFDZfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="86015396"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="86015396"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 08:46:48 -0700
X-CSE-ConnectionGUID: /ofJ9f6TT/WAYaZ9NelnvQ==
X-CSE-MsgGUID: 7KeEez6BSHqgE2M3o3thXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="261323021"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 08:46:46 -0700
Date: Mon, 10 Aug 2026 18:46:43 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 0/3] ACPI: bus: Rework acquiring the primary physical
 for a given ACPI one
Message-ID: <annyY81d3NRYxCB9@ashevche-desk.local>
References: <4764923.LvFx2qVVIh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4764923.LvFx2qVVIh@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 10, 2026 at 01:28:44PM +0200, Rafael J. Wysocki wrote:
> Hi All,
> 
> This is somewhat late, but since there will be follow-up changes tree-wide,
> it would be good to get it into the mainline sooner than later.
> 
> It is based on the observation that the majority of
> acpi_get_first_physical_node() callers want to hold a reference on the returned
> device and the function is potentially racy because it doesn't get such a
> reference itself.  There were also some comments from Sashiko pointing
> out to this as a "preexisting issue".
> 
> The first patch adds a acpi_get_first_physical_node() replacement called
> acpi_bus_get_primary_device() and returning a reference-counted device (the
> former is retained for the time being, but made use the same code as the
> latter).
> 
> The next two patches change the core ACPI code to use the new function
> instead of the old one.
> 
> Later on, patches will be sent to switch all of the callers of
> acpi_get_first_physical_node() over to using acpi_bus_get_primary_device()
> and finally to drop the former.

I have one comment in patch 1 (see separate reply) but overall LGTM and I like
the end result.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


