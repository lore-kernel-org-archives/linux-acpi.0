Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DF4221FB4;
	Wed, 11 Feb 2026 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770798797; cv=none; b=d3WeUQOWA5qozzDW37LUubwq7OAzVIjsVTSHq6B1tcn7EHooEAmSSRO3xc5I7wQ3pPx2BKVYB3A6VCj/yp9kLKQ0fMeONkKG294f138JwCFYQKaUMApL2ALWpYZJM8dQIfEJpbHtBLUGsxIehVDJw3yged0XCk73l0PpIVjwo18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770798797; c=relaxed/simple;
	bh=nY1zDwIFtizozkOQvdT3Io4yyQot8DXqdXtNdIM+wcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNq6nXm4WmMU32a2R83aPTAZiGnIvL62DrlPDC71h1/MUei5Xtd6aoqpYBevrDELB4SARvpmMpDuBb7jHJP3aQ5/MN5wmktOQmvIaU6if20eR6VzJcz+010zywt3XsuHNqlZgtuqrOybL8mtzFjJfuOUaAA2Heqjb5C8O2NIjVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ArZ5enyO; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ArZ5enyO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770798796; x=1802334796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nY1zDwIFtizozkOQvdT3Io4yyQot8DXqdXtNdIM+wcw=;
  b=ArZ5enyOkKr9l7v1Gr5BwfisDZXjFKML6+2KvdioIqHepbEu4X6pz602
   Dpk/QRCy8LIofAY6BxwR2+d6IM3k5veJE7pNVWxVrTSsR5+HSMHplRf6g
   zKyc6HLEWiPEoIue6JotgVIs0ZaK17DYRUI/cXXcUpeg1XG9n0pARWZnY
   6K+HCc9L+ei2/QC8FSuTmNCWYgvYwC+v1712mRhdbeXmq8mBnejCO29BX
   EitKA7a/yBBePrbTPETVVp3ui83naeVxurrfxRNH1iBpEJu6u9KsYGxdy
   UQr3t+wys8m6T+UPuHalxg8ODr3PuoH/8yeIQETeZ7b9PKVAIDzXxXVmd
   w==;
X-CSE-ConnectionGUID: W5Bsa4IDSpKUyHfkxgrcBw==
X-CSE-MsgGUID: WF5BUzVqSmm15TD35oputw==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71982550"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="71982550"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 00:33:15 -0800
X-CSE-ConnectionGUID: QgcgqTc6QhW3mbQqCcrPew==
X-CSE-MsgGUID: jVLfTpHaQkaFzZtyRy63Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211240512"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.220])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 00:33:13 -0800
Date: Wed, 11 Feb 2026 10:33:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/1] device property: Allow secondary lookup in
 fwnode_get_next_child_node()
Message-ID: <aYw-x0fKcjRz3RdC@smile.fi.intel.com>
References: <20260210135822.47335-1-andriy.shevchenko@linux.intel.com>
 <aYurEV6kKQfI3cs8@kekkonen.localdomain>
 <aYw6g-R5hXd2jnwQ@smile.fi.intel.com>
 <aYw9cHENHUhxtzZP@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYw9cHENHUhxtzZP@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 11, 2026 at 10:27:28AM +0200, Sakari Ailus wrote:
> On Wed, Feb 11, 2026 at 10:14:59AM +0200, Andy Shevchenko wrote:
> > On Wed, Feb 11, 2026 at 12:02:57AM +0200, Sakari Ailus wrote:
> > > On Tue, Feb 10, 2026 at 02:58:22PM +0100, Andy Shevchenko wrote:

...

> > > As the function becomes trivial, I'd move it to property.h.
> > 
> > Yes, but the same applies to many functions in the property.c. I don't want to
> > treat this specially:
> > - exceptionally for this function (what about the rest?)
> > - for the matters of backporting
> 
> There are other similar functions in property.h already. Moving the other
> trivial ones there, too, wouldn't hurt.

There is actually a potential issue that I would like to avoid. Id est
the device.h is a mess and first of all I want to split it to a few other
headers (one of which for the fwnode stuff), and only after that reshuffle
this, because blindly moving everything to the header is not a good
strategy in long term.

...

> > TL;DR: I would like to move this patch forward as is. After that I will
> > consider cleaning up as suggested taking into account other places.
> 
> Sounds good to me.
> 
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Thanks!

-- 
With Best Regards,
Andy Shevchenko


