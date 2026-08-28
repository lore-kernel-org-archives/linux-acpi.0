Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2552D3537EE;
	Fri, 28 Aug 2026 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931851; cv=none; b=tFRk77YsLNAu2sY8sziqxjeYCLfWThKqedzT5QD9SqUlAEBuhm0ApQxCWEnOzgboEJjW3yPLu+6Vt65MEdOcUE1nmoV2r4A/F8s45jBqDfK1auTq0gIJRDeOCoJO8CLacHpyrox8Ue1DjV++c/DMBkx6GIht9QghbqXgqnQ0uXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931851; c=relaxed/simple;
	bh=3kftKU6QSsPS12aGYnEzewRmMCKAjq7AHM3XHC9rZAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMLyvy1GBq9EU3KRumzstv4C6iVk7tvgdEqooQZM57CfuSbodcU8QAgM6IA9kOpikBm/4GzDRZa3H60ly8XFEhrE/LS2oNkJHDWbQqAdnnMvU+dMTfA9cy20taT6GUjp6EYS5H7G1SPy8K5RLkWnu7Em/2hAHPwZSqHZ35aStPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VRhd9MQx; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VRhd9MQx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787931850; x=1819467850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3kftKU6QSsPS12aGYnEzewRmMCKAjq7AHM3XHC9rZAA=;
  b=VRhd9MQx3Hzo91g37qGeubjV3ke42bayD5dOKKHV9SqIq0NS53uVGMVS
   Y84yG+w5DSMuIYLwUtF2SruF7IeGcoRqFK+82B6bZrXoaTIbdCLi0+xMC
   K8mAoeQYOZ6a47+dYWSlSZpuzcdCDozeBIGloTLeovWRaEP5We9vIFFp9
   Jr5xAkqMZkb9OzknhAzCu3gBwmHbxQz3gu8kOyActnPENdKu8NYgg6vAm
   ROo8TjHM8kuDb2Y4t/uJt8a/ZnrKVcriB5izlZ1X7V5Vwt7eOoKX5cXLt
   q0Gf8yMCOP+ADfr2GAELaxJKnQykYybU2hKHi9QoRZ5b5c7B3Utdhi2Ip
   A==;
X-CSE-ConnectionGUID: Gvt16lhxTvKdXn9AkngB0A==
X-CSE-MsgGUID: E1n9ZpD3RdCOP3ax11hn6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="99106286"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="99106286"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 08:44:09 -0700
X-CSE-ConnectionGUID: ctRrCIJNSxy4QXK1nITJ2A==
X-CSE-MsgGUID: m9fV/uLMSVS0MTQJStOzKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="291687312"
Received: from slindbla-desk.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.176])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 08:44:08 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id F1E1C121BDC;
	Fri, 28 Aug 2026 18:44:04 +0300 (EEST)
Date: Fri, 28 Aug 2026 18:44:04 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-media@vger.kernel.org, linux-acpi@vger.kernel.org,
	rafael@kernel.org
Subject: Re: [PATCH 3/3] media: i2c: Use ACPI_PTR() for ACPI ID tables
Message-ID: <apGsxDddKkRsP-Un@kekkonen.localdomain>
References: <20260828084328.257703-1-sakari.ailus@linux.intel.com>
 <20260828084328.257703-4-sakari.ailus@linux.intel.com>
 <apGNYsroZTTOqe4c@black.igk.intel.com>
 <apGk_7Uy_NcHG8V3@kekkonen.localdomain>
 <apGnw9HlXSfVGy4z@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apGnw9HlXSfVGy4z@ashevche-desk.local>

On Fri, Aug 28, 2026 at 06:22:43PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 28, 2026 at 06:10:55PM +0300, Sakari Ailus wrote:
> > On Fri, Aug 28, 2026 at 03:30:10PM +0200, Andy Shevchenko wrote:
> > > On Fri, Aug 28, 2026 at 11:43:28AM +0300, Sakari Ailus wrote:
> > > > Add ACPI_PTR() to the ACPI ID tables where missing. The patch has been
> > > > produced with the following command:
> > > > 
> > > > git grep -lP 'acpi_match_table.*=\s*(?!ACPI_PTR)' \
> > > > 	drivers/media/|while read i; do
> > > > 	perl -i -pe 's/\.acpi_match_table\s*=\s*\K(\w+),/ACPI_PTR($1),/' $i;
> > > > done
> > > 
> > > NAK.
> > > 
> > > It doesn't explain why we need that. This also inconsistent with OF type of
> > > IDs.
> > 
> > ACPI IDs are used on ACPI only while compatible strings are used on both
> > ACPI and OF. Thus the ACPI ID table is redundant if CONFIG_ACPI is
> > disabled.
> 
> They may be informative for the cases when on the working say OF system I can
> get the IDs for ACPI based platforms at run-time.

That's a bit far-fetched I think. Have you ever done that? :-)

Media drivers are probably one of the largest groups of drivers that are as
relevant for ACPI as they are for OF.

The of_match_ptr() that used to be present in nearly all media drivers has
been largely eliminated in the same context and the only reason for that is
that the table is also relevant for ACPI systems. The case is indeed the
opposite to the ACPI equivalent so I really don't see why we shouldn't just
drop it where it's, well, redundant.

> 
> Also you just save a couple of dozens of bytes. This is peanuts and unneeded
> churn. Again, here is my formal

I recall you often comment on struct field ordering to save, well,
typically less than dozens of bytes, too.

> 
> NAKed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> In case you want to override that, please keep it in the commit message (among
> other tags). And yes, we have such a tag in the Git history of Linux kernel.

-- 
Sakari Ailus
