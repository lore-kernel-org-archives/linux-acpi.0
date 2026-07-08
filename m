Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE893D170C;
	Wed,  8 Jul 2026 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507274; cv=none; b=GNGwYiw1eNcO8AOD8Dp+Mn+EDdEGQPQai8ShH7HpZ0qUKTBQ5DsrM9Y6XTqnYU9p3CHyUO3lIl8p+hJtwl8CI0jUyULHyr+stGk+b8xwSvKMioNsmRcoVVu42ZNdlSh+Hrq482xB3A47fbpXOeD45F3+cZTv9Q0KGTQncj7jMaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507274; c=relaxed/simple;
	bh=V3byV+Jr38OfJj4SzwQYrO4Dd/7QC9RVjCvimfBGsQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YePgcA1v3hK1Bf+YELrB9eOGYAgz3y5/OebxEyrxeZ3OSUjQ/5eFeo79Y0YwfXm/Qs78fISjitZd7bF+768ylul1CjAES5NDHs52eROOVQYIs5+BIPvtW/mqXKlO8OKpJE8HImLL2qcuAVJiRsoIEPrNZ3RQRRuQVBVqU/i8a/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HMNKQ0d4; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HMNKQ0d4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783507267; x=1815043267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=V3byV+Jr38OfJj4SzwQYrO4Dd/7QC9RVjCvimfBGsQw=;
  b=HMNKQ0d4bPZYkcYD7bFC1k4AgcnrRy2Af/cwtJIFoKfHd6ueTs50zPpt
   2OdUiDJGq5MedxwbRsbA+G66rJ28QhNv+FA4zs+VY3TvMCzegqJOikaMr
   4Yco/1pK8jJK/iexCFEGtcjzTK9zYY3hFyworCI+DjGw0fwk9EM+4wFb4
   lTtobCjWPNJFfNedPV7DIMP8bEoOxQbpTSxE683O7HD8pGrOfnFlvH+0R
   EOHk7MIhq6v8K2KgGKGr/5B7j7e7r89vQr2xhB12GRl6qEXIVQR9H2j5r
   ohK0sikDh2UAUz+V4LuHY9UhN/8kUGiS08WVTr5IRWBuTBayo4VmwlZ0k
   w==;
X-CSE-ConnectionGUID: F32uqRIoQMCWtIGOjgHKfw==
X-CSE-MsgGUID: A4/Nb3Z0QdCsV7CmFqE0iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="95543379"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="95543379"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 03:41:03 -0700
X-CSE-ConnectionGUID: 6dKVa7VfSoCEnzDPCGVAGA==
X-CSE-MsgGUID: 7SpT6Cf9Q3KicpJfk5YIOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="256161900"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.120])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 03:41:01 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id D061111FB4A;
	Wed, 08 Jul 2026 13:41:00 +0300 (EEST)
Date: Wed, 8 Jul 2026 13:41:00 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Arun T <arun.t@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Miguel Vadillo <miguel.vadillo@intel.com>,
	Len Brown <lenb@kernel.org>, Mehdi Djait <mehdi.djait@intel.com>,
	linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ACPI: scan: Honor ACPI _DEP dependency for NVL CVS
Message-ID: <ak4pPIH5SHFO_oJu@kekkonen.localdomain>
References: <20260704171855.1462214-1-arun.t@intel.com>
 <20260704171855.1462214-2-arun.t@intel.com>
 <CAJZ5v0iBs98Rkyardw-XjKEpi=2s8cWqb0_RqUL0B-KKoNGu1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iBs98Rkyardw-XjKEpi=2s8cWqb0_RqUL0B-KKoNGu1A@mail.gmail.com>

Hi Rafael,

On Mon, Jul 06, 2026 at 07:53:59PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Sat, Jul 4, 2026 at 7:24 PM Arun T <arun.t@intel.com> wrote:
> >
> > Add INTC10FA to the ACPI dependency honor list so the CVS driver is
> > loaded before dependent camera devices are probed on NVL platforms.
> >
> > This matches the camera dependency handling already used for IVSC-based
> > platforms and ensures the camera streaming path is initialized before
> > sensor access or pipeline setup depends on it.
> >
> > Signed-off-by: Arun T <arun.t@intel.com>
> > Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> 
> unless you want me to apply this patch, in which case please let me
> know.  Otherwise, I'll assume it to go in via the media tree.

I'll take this via the media tree.

Thanks!

-- 
Kind regards,

Sakari Ailus
