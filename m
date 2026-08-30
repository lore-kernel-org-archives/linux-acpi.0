Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10FB231A3B;
	Sun, 30 Aug 2026 07:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788073621; cv=none; b=HACigMAvaIPT20fclf0f622ti25hvjx2B/ijyCsLrClkR7FUw4YaV+U4qQSieXdGQholR76LdIzIuEa0r/omkxfKttoHovQFSFqniHg0VfjZ+WfHdSp9pI7/LA7gGOIzlk6sHKdAfzuoIQOlUtkfVmeVFzaN7h8UU6dkNIjK+lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788073621; c=relaxed/simple;
	bh=MGmsVi7TZDCdgsOZMrhHPi1ZoVvRIQBoiKiFOOZ7K1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEXQafOEoO/MdzZPlUgBmunpEzFpS1teynYP65GdVdHXmQkgGQ3Nht6T2CtxhkFSGv9sb65eRsV96DdWiyuuBrtvBaUH7m74VIfdvwTzCyq0pQkWgk0D2mYGA5rajU8r060SLKjdjkeFBwXwzZq/PWDswpAOUJb3AlKH/Zr6qdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H3xxVfEV; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3xxVfEV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788073620; x=1819609620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MGmsVi7TZDCdgsOZMrhHPi1ZoVvRIQBoiKiFOOZ7K1k=;
  b=H3xxVfEV98CRt3B3w77U8DKKbU/Ds5o201DU4vI8EUFijnAzFimvShxS
   kyrnT91os2fN5nYQQzBQWeeEH3dIP7p3MXGGnOs5VSDHFvUMueMCAGlA8
   xWeztiJjHn/jV7rddF7NQcUdkcXObePQZvezPylXdpDJiHovgSlRh5sul
   g0ysEE3Xhn6WG1d8pFQY0xOOh8EMSL6Q3RKASPcTg29oHNWFPKM6obhxU
   ZnvnFvfpdBLUK57aPDvjRZT2paPWyu5f74WuMjkwaPsUqsu9BR3pPrVx1
   WY6TikbqHxLCg2cyHIUkQs3/x4tGB30Cfskx3LWPrbmhlLpzZrn7PuZOR
   w==;
X-CSE-ConnectionGUID: BeCbI0MQTfejJ7RdeONeJw==
X-CSE-MsgGUID: APJZyxouSAWqNW7ZqyDGNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11890"; a="88530617"
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; 
   d="scan'208";a="88530617"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 00:06:59 -0700
X-CSE-ConnectionGUID: Sm2dx8fsQoWi6QSgJf/ucA==
X-CSE-MsgGUID: 0fe+B8/zTw26sFDF2vbuTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; 
   d="scan'208";a="269088947"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.243])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 00:06:57 -0700
Date: Sun, 30 Aug 2026 10:06:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-acpi@vger.kernel.org,
	rafael@kernel.org
Subject: Re: [PATCH 3/3] media: i2c: Use ACPI_PTR() for ACPI ID tables
Message-ID: <apPWjluHkxwHCagh@ashevche-desk.local>
References: <20260828084328.257703-1-sakari.ailus@linux.intel.com>
 <20260828084328.257703-4-sakari.ailus@linux.intel.com>
 <apGNYsroZTTOqe4c@black.igk.intel.com>
 <apGk_7Uy_NcHG8V3@kekkonen.localdomain>
 <apGnw9HlXSfVGy4z@ashevche-desk.local>
 <apGsxDddKkRsP-Un@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apGsxDddKkRsP-Un@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 28, 2026 at 06:44:04PM +0300, Sakari Ailus wrote:
> On Fri, Aug 28, 2026 at 06:22:43PM +0300, Andy Shevchenko wrote:
> > On Fri, Aug 28, 2026 at 06:10:55PM +0300, Sakari Ailus wrote:
> > > On Fri, Aug 28, 2026 at 03:30:10PM +0200, Andy Shevchenko wrote:
> > > > On Fri, Aug 28, 2026 at 11:43:28AM +0300, Sakari Ailus wrote:
> > > > > Add ACPI_PTR() to the ACPI ID tables where missing. The patch has been
> > > > > produced with the following command:
> > > > > 
> > > > > git grep -lP 'acpi_match_table.*=\s*(?!ACPI_PTR)' \
> > > > > 	drivers/media/|while read i; do
> > > > > 	perl -i -pe 's/\.acpi_match_table\s*=\s*\K(\w+),/ACPI_PTR($1),/' $i;
> > > > > done
> > > > 
> > > > NAK.
> > > > 
> > > > It doesn't explain why we need that. This also inconsistent with OF type of
> > > > IDs.
> > > 
> > > ACPI IDs are used on ACPI only while compatible strings are used on both
> > > ACPI and OF. Thus the ACPI ID table is redundant if CONFIG_ACPI is
> > > disabled.
> > 
> > They may be informative for the cases when on the working say OF system I can
> > get the IDs for ACPI based platforms at run-time.
> 
> That's a bit far-fetched I think. Have you ever done that? :-)

I have not working with OF platforms, but I'm pretty much see value of this
possibility.

> Media drivers are probably one of the largest groups of drivers that are as
> relevant for ACPI as they are for OF.
> 
> The of_match_ptr() that used to be present in nearly all media drivers has
> been largely eliminated in the same context and the only reason for that is
> that the table is also relevant for ACPI systems.

So, if we ever will have a code to use ACPI IDs in OF enumeration, this will
have the same argument.

> The case is indeed the
> opposite to the ACPI equivalent so I really don't see why we shouldn't just
> drop it where it's, well, redundant.

The use of the unneeded macro makes code harder to follow. Still ID tables
are useful on their own.

> > Also you just save a couple of dozens of bytes. This is peanuts and unneeded
> > churn. Again, here is my formal
> 
> I recall you often comment on struct field ordering to save, well,
> typically less than dozens of bytes, too.

There is a difference, the ID tables are from RO sections, the structures
are runtime and grow linearly as many objects of a type are created. Among
two the priority of reducing runtime memory footprint has a priority over
the RO sections.

> > NAKed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

The tag still stays. But nobody prevents media maintainers to do what they want
:-)

> > In case you want to override that, please keep it in the commit message (among
> > other tags). And yes, we have such a tag in the Git history of Linux kernel.

-- 
With Best Regards,
Andy Shevchenko


