Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3785B425CEE;
	Tue, 16 Jun 2026 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605572; cv=none; b=pblupT3X8AHhxjSoFOBAmfKFY9deG1uQZNr6jUcxp0upgR42A0K/wFFlFG1TRu9WVO5UhGSTEMCC98+8nAGNT8s2R5+gcBwZ4ylkt5gljSuoLPygJzQCca363IVoEQnUxW37fyR3urm93plbZL1bcuWVfinKyp0bvSl/frmwsic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605572; c=relaxed/simple;
	bh=T2tDQY5djmvfEiXrEfdiEmecOkUJXsXF/23nvDkAIcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAVzZbi62DV/P3R7PEDpV+IKcKXcyWTQNlJ7wlLE3IyuQTuUMNu86D+I/F6pBWo9LBnrPGuht0WSIq0DkpMQA8QbTGCdz+hFiBEWI9HuTr58HuQUJlvYQeEMZeyctiY5kX5MRpGspHA4cfVBEOJSUwlwdEMTTvkkW3GYDT0hHAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lZsmw7Fg; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lZsmw7Fg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781605571; x=1813141571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T2tDQY5djmvfEiXrEfdiEmecOkUJXsXF/23nvDkAIcQ=;
  b=lZsmw7Fgo+NF146kPb9T8BjomSBaq3JO7yNmMwC2VPglKGbkaPrVZ5Bz
   dxkVQZEXletCCsxje0W4sYMQ87+gJcQIweV8ZSj4dyfzNJo3fV/GogNqH
   ADuxVeRhmGEJWCLLtpprWBmUyEnIrAUP0J2kfQjv00gOK5pHuvAL9uesp
   Xje2t7RKmTg86ftiBf8VCqDX3MSeHldDRFzKND1G40Bf00AcM0f7MxgeF
   g63WD42SfIowLJolb/IfT397SKT95TXbr77QwEeIp6NXZ5T38Nbh/IWXF
   QIdD2+3z7oCud+TRzghVLtzajGg6cCjHOVfFIIlI5mEnkExMAjhCOn1Dx
   g==;
X-CSE-ConnectionGUID: 1HgxEU3CTLmtxNQZUL4Vog==
X-CSE-MsgGUID: +be7AvnnRlytS8cvkU7V2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82470564"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="82470564"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 03:26:10 -0700
X-CSE-ConnectionGUID: RqX3TuIlQPGKL1omTozagg==
X-CSE-MsgGUID: 96ToLmYySlG9hjUQQcXPDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="246615279"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 03:26:08 -0700
Date: Tue, 16 Jun 2026 13:26:06 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linusw@kernel.org>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marco Scardovi <scardracs@disroot.org>
Subject: Re: [PATCH v6 0/2] gpiolib: acpi: Add robust bounds-checking and
 safe address handling
Message-ID: <ajEkvstS6RgRTATK@ashevche-desk.local>
References: <20260610154204.110379-1-scardracs@disroot.org>
 <20260612085257.GY2990@black.igk.intel.com>
 <CAMRc=Mcv7SWVYA6rNZo+-tYx_ohOdedkewLZOa=X1Eei=1fTzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Mcv7SWVYA6rNZo+-tYx_ohOdedkewLZOa=X1Eei=1fTzA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 02:54:02AM -0700, Bartosz Golaszewski wrote:
> On Fri, 12 Jun 2026 10:52:57 +0200, Mika Westerberg
> <mika.westerberg@linux.intel.com> said:
> > On Wed, Jun 10, 2026 at 05:42:02PM +0200, Marco Scardovi wrote:
> >>
> >> The series adds explicit bounds checking for GPIO pin accesses and
> >> ensures safe handling of ACPI addresses in OperationRegion handlers,
> >> without referring to truncation or wrap-around behavior, which does
> >> not apply.
> >
> > I'm fine with these now.
> >
> > For both,
> >
> > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Andy, Mika: do you want me to queue these directly for v7.2?

I believe there is no hurry, but I have no objections if you pull it in.

-- 
With Best Regards,
Andy Shevchenko


