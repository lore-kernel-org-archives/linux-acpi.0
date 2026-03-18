Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14ED3BAD9C;
	Wed, 18 Mar 2026 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773826929; cv=none; b=s8qpGTPo5E11iGMdOpoYuoJt7yztJv1zlTvbQTiVUcALmjNV7av1ik+t7dEar7eJZ1nCp2dH2KgmMWkeDvgqt1F44dT9aJr1+NZuRAqSwTPPBTpQWBwHnWANFEofYJi5LhWKgKvRJv/zfn65rHDbdi9ktG8rMViHXmQp0r0axwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773826929; c=relaxed/simple;
	bh=FD4yovjHYuXvS4IX2PQFhULxZUHfEZL3NFSUfI5/bVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8SUi4lb6eArq7+g7PXhaYyrw7MHR0jpl9BkWKDqJNUflMc3Zn3kP36/njC1ldJuACNbSPfoA5LjsAv4UzBsnZMr4HJ1nSHXrYBrmtuaT2rtwOFYzo0zh3xzqxMfvflusYC5bb9qZXHQMgd6ODIAPwc+nBq5uPA7lxrG++2VFec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JO5pBMIF; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JO5pBMIF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773826924; x=1805362924;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FD4yovjHYuXvS4IX2PQFhULxZUHfEZL3NFSUfI5/bVk=;
  b=JO5pBMIFSITgDBz484KTyeyi/oHAhcJ/bWPdB/+gk/XUX6a2cPMJsUl+
   dRnqYEe+BuTaAqwYZIufVjnEU34JLK5ejaJV3nprNDn243ZaJeNqfGPdq
   Ly8lf148orGRENIAIaXH0w7PD2db+QRWuTBcERh/Zk+p6LqCxlywPeCKZ
   D8MvUtrzY7UrbxHlWygyHQrN73XIw9sQP+akJHE1Y5aPJp1mPR17IfMEc
   kYZ2FAS/iXI19T3xhDihS10QI+a0BK3i4BT0pWxe+YsNdfxzdFV6T0Gkt
   iMiWN2Y7w4YxDJUiFOUtXF3IfP8HcflSVmBzV4WrOFtOUNMR3fv58H9f9
   w==;
X-CSE-ConnectionGUID: 9akSo8z5RnunGxcLRMygpQ==
X-CSE-MsgGUID: gVNM1rVHS4K4CM2cW/IjyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85955334"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85955334"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 02:42:03 -0700
X-CSE-ConnectionGUID: wW5TH9eURYuGRThRy/JTmQ==
X-CSE-MsgGUID: 1MaBj4RcS7mu4YkqItt0Sg==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.240])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 02:42:00 -0700
Date: Wed, 18 Mar 2026 11:41:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1 1/1] device property: Document how to check for the
 property presence
Message-ID: <abpzZfYBPdM4AzLP@ashevche-desk.local>
References: <20260317210828.2117631-1-andriy.shevchenko@linux.intel.com>
 <abnVTODs9fOqF9eV@kekkonen.localdomain>
 <abpcT5Yqfi5_SjKR@ashevche-desk.local>
 <abpsGfkitsXuWKb4@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abpsGfkitsXuWKb4@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 18, 2026 at 11:10:49AM +0200, Sakari Ailus wrote:
> On Wed, Mar 18, 2026 at 10:03:27AM +0200, Andy Shevchenko wrote:
> > On Wed, Mar 18, 2026 at 12:27:24AM +0200, Sakari Ailus wrote:
> > > On Tue, Mar 17, 2026 at 10:08:28PM +0100, Andy Shevchenko wrote:

...

> > > > + * In order to check for the property presence, use device_property_present().
> > > 
> > > Do you really think we should add this clause for each of these functions?
> > 
> > Yes, as Guenter pointed out that this has to be documented clearly.
> > 
> > > I don't think it belongs here.
> > 
> > And? What should we do then (taking into account my below comments)?
> > 
> > > The error code list doesn't document what is returned if a property doesn't
> > > exist (-EINVAL) and it'd be helpful to add this.
> > 
> > No, this change is exactly against this. Because using an error code that may
> > cover not only that case is at bare minimum fragile and layering violation.
> > APIs that require to know the implementation details are not good APIs.
> 
> I have to say I disagree with that,

And I definitely disagree with tribal knowledge based (implementation details
as it's not properly documented and can't, because -EINVAL is overloaded) and
confusing approach that is in use and may be amended.

> there's nothing wrong with checking
> error codes if you need to.

If that error code defines the case. Here we have not a such.

The wrong parameter to the function will lead to the same error code
which is simply wrong.

> Either way, I checked the original patch. If you really think you need to
> check for property presence and use default in the case the property isn't
> found and error out on other errors, add helper functions for the purpose
> instead of open-coding it all.

You mean adding 20+ helpers (at least 5 for arrays, 5 for single element,
and doubled for device_/fwnode_) ?! This sounds like way over verbose
approach.

> > > It would have been best to have a separate error code for this albeit
> > > changing this now might not be that troublesome either: very, very few
> > > callers depend on receiving such an error code but there are still many
> > > callers.
> > 
> > I'm against this because we have already a dedicated API to check for property
> > presence, why do we need to have another (confusing!) way of doing the same?
> > 
> > Having a dedicated code may help to debug, but shouldn't be used as a main
> > feature in my opinion.

I will send a next version of this patch touching only the present/bool functions.

-- 
With Best Regards,
Andy Shevchenko


