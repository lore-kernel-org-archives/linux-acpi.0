Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AE837F74C;
	Tue, 25 Aug 2026 19:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787686533; cv=none; b=XlkZLIhQEJjJ1CbfRbeP5zRi8fOSJhAXS39XFhT5R+RMy/2FIcrPqM6wBZ4TYnBMaPBHHl25Q6zo0inNrQOO+0p4zrRb6OS4N8NJpEZu/UhMteWz2qLASRuzDkT5Ckn3stxZa3CGPaYeZG4d9Zuu5sZvocooVPirMQyu+mljH8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787686533; c=relaxed/simple;
	bh=G2387h91OgjKMpA4bsCx87CZruyGQ+mdSovTf7kGdB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ax3Ah6PrYwaMfvVor6XaBM91RK+R+A+ds3Hyv0P7vTzLjLTcxiM7wmaDB+0S6ef9dryrVEh1JM8ry23/F9oSkJYda9pLln48L8fqtKEeqO/Ux50WyYksl3Y3NSZnoLluXjAIR4S0l66FcJ7VnVPWLPOb6sTeiOjdaBN3SWT5k2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YTTP9yfZ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YTTP9yfZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787686529; x=1819222529;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G2387h91OgjKMpA4bsCx87CZruyGQ+mdSovTf7kGdB4=;
  b=YTTP9yfZzd7559HfYQ61OsVN0uMVbfSFXv9GRMlOruBMrFGWWxefnqBa
   6ALoqd8XYPknaxLPXq5OadPRAkLlqFGba3a4g9zISzpWzlgle52vLfSUw
   C6PW7E/t2gS4bxSyY7Bk65S9GBVe9AhdplNdYtPaXqsi3lTo9ebFOPHey
   geJ35PILFxA99SfQ+pubbOrZHb95+u5XVqxLjQOX4JxWGfIFg27rCgYyS
   lz0oaQJpOHyeenu0/7E6Sqb5tEKAfrhMykl1qpiwFq4ZISKx+rGwmW0Is
   KQIyA65khV9RtS+7Vp7slY7dhr9fWFIsxkJ4UNj+K2Pe5ZRQNwvPYoY23
   g==;
X-CSE-ConnectionGUID: EFKjqINpQnCGpY6yuLc1Hg==
X-CSE-MsgGUID: HZtUkfuuQ0u1GSh9LNQR2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="99511187"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="99511187"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 12:35:25 -0700
X-CSE-ConnectionGUID: xT7nIAUbTT6XCKRxQH2B6Q==
X-CSE-MsgGUID: qtANlQHSTRaJqEHzYH+dLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="272613295"
Received: from carterle-desk.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.168])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 12:35:23 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id A4F97121C10;
	Tue, 25 Aug 2026 22:35:35 +0300 (EEST)
Date: Tue, 25 Aug 2026 22:35:35 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-media@vger.kernel.org, linux-acpi@vger.kernel.org,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 3/5] ACPI: Support __free() from cleanup.h for ACPI
 objects
Message-ID: <ao3uh2xos_1uwAgJ@kekkonen.localdomain>
References: <20260824211338.3583976-1-sakari.ailus@linux.intel.com>
 <20260824211338.3583976-4-sakari.ailus@linux.intel.com>
 <CAJZ5v0ieb2FcANOt0MRMsTrwtbLiUF48W_c=3z3OpNH92d=7vg@mail.gmail.com>
 <ao2FmNRFjSJVxhrL@kekkonen.localdomain>
 <CAJZ5v0gQVFxSkkjPbRf6bsKdgUBGduZV0M5SWrHoeB246ZLqew@mail.gmail.com>
 <134e9566-7913-86d7-1e8b-b2ca9ebec55c@linux.intel.com>
 <CAJZ5v0h4KD6Q1DeuwbFQ83U1=wKORMWUQNA2BwnFtsYAyzz_Ow@mail.gmail.com>
 <CAJZ5v0ggPGEu8YQTpeTC6=tVNr1zponkCbs+UQPieAH5k6ngUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ggPGEu8YQTpeTC6=tVNr1zponkCbs+UQPieAH5k6ngUg@mail.gmail.com>

Hi Rafael, Ilpo,

On Tue, Aug 25, 2026 at 03:08:07PM +0200, Rafael J. Wysocki (Intel) wrote:
> > If there is a cleanup.h "free" that can only be used with objects
> > returned by acpi_evaluate_dsm_typed(), I'll be fine with that.
> >
> > Or if everyone agrees that doing
> >
> >     union acpi_object *out_obj __free(ACPI_FREE) = NULL;
> >
> > is not confusing and fine, I may just say "Hey, I don't care that much".
> 
> And particularly there is this paragraph in a comment in cleanup.h:
> 
>  * Given that the "__free(...) = NULL" pattern for variables defined at
>  * the top of the function poses this potential interdependency problem
>  * the recommendation is to always define and assign variables in one
>  * statement and not group variable definitions at the top of the
>  * function when __free() is used.
> 
> regarding a broken code example, so I would think that this is not a
> made-up concern.

That's indeed a valid concern, still quite unlikely in practice but
probably hard to find when it happens, so avoiding that is definitely
preferred. That being said, the biggest trap in cleanup.h is probably in
scoped_guard(), and doing __free() = NULL somewhere doesn't matter much in
the end.

In this case I'll just call ACPI_FREE() sooner.

-- 
Regards,

Sakari Ailus
