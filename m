Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074E343B492;
	Fri, 28 Aug 2026 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787923817; cv=none; b=Pq8/Vox8aFBdJrlmX6rLugQfPiXz631e3LukMPTe02OjodQtN0rbqgsdkukPGuL3VARobibIzdF4yOJunWjVtucC6IkZTNHdujokgPgFMSMOLNBR3v5GQZM2EXSu+jR6Qt+IdrURkIjz2VZSjBpzoY1WQMT2SbTwE3B/wPIZh6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787923817; c=relaxed/simple;
	bh=8llcm0RZ1yl8MU6DmPkS5GHcu5L7HXj98RCOWrCypjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SA7L4jKzwQwmR4dQ36Yv/RDbH2i2G8KKibZ3N0cA8jE9UheokngheNj74moY8i/4pRxKKrPFWDtx1UNG9RWCnxzNdpJC9SjuQkvatJ4tXx75bJZ7SQGJ7pmyGI4yLab3X5S6NctmlMLrFrruqri+HpOxvKw8lEdH7B38Be6FS7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jIsPI7UO; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jIsPI7UO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787923814; x=1819459814;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8llcm0RZ1yl8MU6DmPkS5GHcu5L7HXj98RCOWrCypjM=;
  b=jIsPI7UOXU5/2l5x3RpxG+A0jZBoMIXBlZnayJYZek+ufsyb1hp5K0PK
   sCtkkIMDDaTTDmcpe58A6LsCp2QxxzFQiGP4xBqee6chMU4uLNJB6Ap0C
   31WYukRQW/YyI/spXKbn5pJKq/UIiIGadhd6bU5lM+dhKakKVemmO0AZx
   oTOVC+YnO41zLXSzVJFOYwIPFutZ9SlI5Zfsf+V9/DzgDDNRhcqBNQIiH
   sJJgk0PYqSKqnhmlA3wGqk9M2GGQTtiDaowynt9j3xeO/1cISiB+56Djj
   RK3zym3LCoQko8MIhAxGREYz3hQLTY0jcbKE64T15c2vlvme/1Qc82CG0
   Q==;
X-CSE-ConnectionGUID: 1osFvu7wT3OEFVF+2fHNhQ==
X-CSE-MsgGUID: iyP+boygQoWxmy/AFfddFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88458496"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="88458496"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 06:30:12 -0700
X-CSE-ConnectionGUID: Y+E9BBtHRpOOammaPisijg==
X-CSE-MsgGUID: UCya3wgyT9iPjIG2fAWKlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="264909310"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 28 Aug 2026 06:30:11 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 3437199; Fri, 28 Aug 2026 15:30:10 +0200 (CEST)
Date: Fri, 28 Aug 2026 15:30:10 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-acpi@vger.kernel.org,
	rafael@kernel.org
Subject: Re: [PATCH 3/3] media: i2c: Use ACPI_PTR() for ACPI ID tables
Message-ID: <apGNYsroZTTOqe4c@black.igk.intel.com>
References: <20260828084328.257703-1-sakari.ailus@linux.intel.com>
 <20260828084328.257703-4-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828084328.257703-4-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Aug 28, 2026 at 11:43:28AM +0300, Sakari Ailus wrote:
> Add ACPI_PTR() to the ACPI ID tables where missing. The patch has been
> produced with the following command:
> 
> git grep -lP 'acpi_match_table.*=\s*(?!ACPI_PTR)' \
> 	drivers/media/|while read i; do
> 	perl -i -pe 's/\.acpi_match_table\s*=\s*\K(\w+),/ACPI_PTR($1),/' $i;
> done

NAK.

It doesn't explain why we need that. This also inconsistent with OF type of
IDs.

-- 
With Best Regards,
Andy Shevchenko


