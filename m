Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3F047044F;
	Fri, 28 Aug 2026 15:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787929865; cv=none; b=b9zeq/Xntxqis7IMw8LusltyQDhKhCoiIKYHrEZqsg7a7bYFmYQ+0o5uOKpwxEZIGuDMGyKBiAUxoh2cejv6YzwVYgN4scV7QFFQmj/Cs4tC64ddhFTeK8c3MYAGwXSuRHk2RhC1rBc0zFO6Syr1V/3wmbpTF8VfG3xqf2OQB/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787929865; c=relaxed/simple;
	bh=cJz/142xF3AUz+xCS4w5V4j4XauJdcpf/ekCKhOZ41g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHmxwCJTNXm5bYNHcUuHXprFtRBef5NeJmrdOUkZptLV/27EEoWMNteX7szZANXuGamDIIo7c1angm7D/UC5xNc+QB7n/Jo8msDhS3fo1YaHFuG+eUYeFYqy76BmTioQC58NCQZIAAoiRVigUlLCVMIMXu/2JeF6xy0OvshEYo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HqpXkSR2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HqpXkSR2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787929862; x=1819465862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cJz/142xF3AUz+xCS4w5V4j4XauJdcpf/ekCKhOZ41g=;
  b=HqpXkSR2it1OCI+ol6tpuZekyrnhLDohnYwa8/yL6BWUvYqfDbWbiUz3
   hJFy82dkWvHwumedyxQ+9W8mVuwbCKBrStaEgy5ZaG0Q+hAZ0Bns454eF
   LMuW/KsGDTZzydmiLx1whfrcLL2yK3scV+DInNw5aGETkhIpxqx8XJFSS
   1KqB0DVGatI1SRop2z68b5OYc/J1cZ1LPYluguJQQvQWSyB4Cufaa1Npl
   IMwkCAcIwtuVeslIdCzUIPqbBtQuzNr9ER6+F4GDUEZ0rMQyoe4hAd6Vg
   tDJZwN0RBx3gL98brVYgijzvadAu2eDxCvK5gkJNlzRKDTUXRawkTla0+
   w==;
X-CSE-ConnectionGUID: S4YJJI7jT6qusaKZuxd6ow==
X-CSE-MsgGUID: 3BdGWvfQRNKgAOgz8C+NNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="88646022"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="88646022"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 08:11:01 -0700
X-CSE-ConnectionGUID: hqhzIn8SRAy2jsugQWB6+w==
X-CSE-MsgGUID: GHSAya+oQyGDLx0q6zMfPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="264430519"
Received: from slindbla-desk.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.176])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 08:10:59 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id EFCEF121BDC;
	Fri, 28 Aug 2026 18:10:55 +0300 (EEST)
Date: Fri, 28 Aug 2026 18:10:55 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-media@vger.kernel.org, linux-acpi@vger.kernel.org,
	rafael@kernel.org
Subject: Re: [PATCH 3/3] media: i2c: Use ACPI_PTR() for ACPI ID tables
Message-ID: <apGk_7Uy_NcHG8V3@kekkonen.localdomain>
References: <20260828084328.257703-1-sakari.ailus@linux.intel.com>
 <20260828084328.257703-4-sakari.ailus@linux.intel.com>
 <apGNYsroZTTOqe4c@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apGNYsroZTTOqe4c@black.igk.intel.com>

Hi Andy,

On Fri, Aug 28, 2026 at 03:30:10PM +0200, Andy Shevchenko wrote:
> On Fri, Aug 28, 2026 at 11:43:28AM +0300, Sakari Ailus wrote:
> > Add ACPI_PTR() to the ACPI ID tables where missing. The patch has been
> > produced with the following command:
> > 
> > git grep -lP 'acpi_match_table.*=\s*(?!ACPI_PTR)' \
> > 	drivers/media/|while read i; do
> > 	perl -i -pe 's/\.acpi_match_table\s*=\s*\K(\w+),/ACPI_PTR($1),/' $i;
> > done
> 
> NAK.
> 
> It doesn't explain why we need that. This also inconsistent with OF type of
> IDs.

ACPI IDs are used on ACPI only while compatible strings are used on both
ACPI and OF. Thus the ACPI ID table is redundant if CONFIG_ACPI is
disabled.

-- 
Sakari Ailus
