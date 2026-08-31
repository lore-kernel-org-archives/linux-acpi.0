Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD213C65E0;
	Mon, 31 Aug 2026 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788173736; cv=none; b=doiCNmHToShe97A293XVSCALsACP3QTkWA0Bf1oiQcYZH0hMD7leQVNEhI7wrZahxsTaD2vJMtH9jNuCVYU0J120ryUQ9KR1440pSVE1JZ0fLDvS8Xxxc6UAOX1n6RO/S1ScnMtr31t24FtWpN2+qP29L3kpzOFWiYNxrIZ/YEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788173736; c=relaxed/simple;
	bh=XuH+eb1MXLy0JmaspRiYm92S3Ssw/F5c26M6qzF2a9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZDQLmGT1+NQ5QRXeiGQG2tAr0H8DJMexWW43Xq8wtvX5FUr+I6AOTpQQP/bfrpJ3+nwA3aB6sLnaybURYmX3P+cCbArLrTGVdzY/hpQIg4D3oDE37A+82bMWWkhP4Ld4/f9/zCo09acJt5WAcbmw4l93fZ8ACtmIgh/k/rhi7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ot3NO7df; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ot3NO7df"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788173735; x=1819709735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XuH+eb1MXLy0JmaspRiYm92S3Ssw/F5c26M6qzF2a9E=;
  b=Ot3NO7dfq2XpiWSZ2V7UtaIMMWBtHVCdTn47CFOQFEwY4g/bwfFcHJdE
   FHATpoc1mYpSx/USBBF1FfTrJeDBv6Y46/zO3yh/XE5XXQMLR7wSntLeE
   jQ8p7qcnLPgw/MznF4H/b6am5P27T3c+ryfR/YhxnqtjZR7eEex6a7r+h
   HkSBp71pk2xEILbqk3v3PksblQdvCnlKyme3WQ6YBKrYfcKjWKXGaWp1i
   zCKt/qrY86AxED0PZhmauiSF1YwhktNS7dA2r4kXWMDvlsO2nuDkR0u5C
   qxaqU7KxPhjQxDgVk9sYIgI3CgmjlbAmF0WpogqudCGxA7s6zm3yECAKq
   w==;
X-CSE-ConnectionGUID: NpRnRzm1TMOWGi3GFT2nbA==
X-CSE-MsgGUID: Danx45CqTq6z0lR/bQjh9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88701387"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="88701387"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 03:55:34 -0700
X-CSE-ConnectionGUID: 6x2tAfSVSTaDJvB5rHn+1A==
X-CSE-MsgGUID: LInQW8rdRum8czUqXNdP6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="264474258"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.87])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 03:55:33 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 01E4211F894;
	Mon, 31 Aug 2026 13:55:29 +0300 (EEST)
Date: Mon, 31 Aug 2026 13:55:29 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-media@vger.kernel.org, linux-acpi@vger.kernel.org,
	rafael@kernel.org
Subject: Re: [PATCH 3/3] media: i2c: Use ACPI_PTR() for ACPI ID tables
Message-ID: <apVdoSlF9KNzRi36@kekkonen.localdomain>
References: <20260828084328.257703-1-sakari.ailus@linux.intel.com>
 <20260828084328.257703-4-sakari.ailus@linux.intel.com>
 <apGNYsroZTTOqe4c@black.igk.intel.com>
 <apGk_7Uy_NcHG8V3@kekkonen.localdomain>
 <apGnw9HlXSfVGy4z@ashevche-desk.local>
 <apGsxDddKkRsP-Un@kekkonen.localdomain>
 <apPWjluHkxwHCagh@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apPWjluHkxwHCagh@ashevche-desk.local>

On Sun, Aug 30, 2026 at 10:06:54AM +0300, Andy Shevchenko wrote:
> On Fri, Aug 28, 2026 at 06:44:04PM +0300, Sakari Ailus wrote:
> > On Fri, Aug 28, 2026 at 06:22:43PM +0300, Andy Shevchenko wrote:
> > > On Fri, Aug 28, 2026 at 06:10:55PM +0300, Sakari Ailus wrote:
> > > > On Fri, Aug 28, 2026 at 03:30:10PM +0200, Andy Shevchenko wrote:
> > > > > On Fri, Aug 28, 2026 at 11:43:28AM +0300, Sakari Ailus wrote:
> > > > > > Add ACPI_PTR() to the ACPI ID tables where missing. The patch has been
> > > > > > produced with the following command:
> > > > > > 
> > > > > > git grep -lP 'acpi_match_table.*=\s*(?!ACPI_PTR)' \
> > > > > > 	drivers/media/|while read i; do
> > > > > > 	perl -i -pe 's/\.acpi_match_table\s*=\s*\K(\w+),/ACPI_PTR($1),/' $i;
> > > > > > done
> > > > > 
> > > > > NAK.
> > > > > 
> > > > > It doesn't explain why we need that. This also inconsistent with OF type of
> > > > > IDs.
> > > > 
> > > > ACPI IDs are used on ACPI only while compatible strings are used on both
> > > > ACPI and OF. Thus the ACPI ID table is redundant if CONFIG_ACPI is
> > > > disabled.
> > > 
> > > They may be informative for the cases when on the working say OF system I can
> > > get the IDs for ACPI based platforms at run-time.
> > 
> > That's a bit far-fetched I think. Have you ever done that? :-)
> 
> I have not working with OF platforms, but I'm pretty much see value of this
> possibility.
> 
> > Media drivers are probably one of the largest groups of drivers that are as
> > relevant for ACPI as they are for OF.
> > 
> > The of_match_ptr() that used to be present in nearly all media drivers has
> > been largely eliminated in the same context and the only reason for that is
> > that the table is also relevant for ACPI systems.
> 
> So, if we ever will have a code to use ACPI IDs in OF enumeration, this will
> have the same argument.
> 
> > The case is indeed the
> > opposite to the ACPI equivalent so I really don't see why we shouldn't just
> > drop it where it's, well, redundant.
> 
> The use of the unneeded macro makes code harder to follow. Still ID tables
> are useful on their own.

About 20 drivers currently in Media tree use this "unneeded" macro in this
context. (These either have #ifdefs, __maybe_unused or depend on ACPI
directly, and the two first then can be removed after the two first patches
in the series.)

The rest of the reasoning you provided above is rather improbable IMHO.

> 
> > > Also you just save a couple of dozens of bytes. This is peanuts and unneeded
> > > churn. Again, here is my formal
> > 
> > I recall you often comment on struct field ordering to save, well,
> > typically less than dozens of bytes, too.
> 
> There is a difference, the ID tables are from RO sections, the structures
> are runtime and grow linearly as many objects of a type are created. Among
> two the priority of reducing runtime memory footprint has a priority over
> the RO sections.

These are often device specific and typically, albeit not always, there's
one device (especially camera sensors etc.) of a kind in a system.

> 
> > > NAKed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> The tag still stays. But nobody prevents media maintainers to do what they want
> :-)

Kernel documentation appears not to recognise such a tag. This can always
be found in lore though.

> 
> > > In case you want to override that, please keep it in the commit message (among
> > > other tags). And yes, we have such a tag in the Git history of Linux kernel.
> 

-- 
Regards,

Sakari Ailus
