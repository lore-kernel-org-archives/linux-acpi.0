Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9994537880E;
	Wed, 18 Mar 2026 08:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773821013; cv=none; b=I5hrMzwoV15rn4RWeujZqDq1wUfgNeyFUaIFZX6NSDuopQm+H4885bR6t71TXS89QB/aQl/owFzYJ8d0qOFNvR4/knoHnp0YFvDmMKqbNR3rpa9T7al8QXMlLqMxmS/T5xbqYyFVn6k8RVn214r9iZYhfVJ+YVquLuBh+D4JV7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773821013; c=relaxed/simple;
	bh=b1mj3ag2iPVepY081nzoCeH7Zw3Nrm9HNoFZg7rJV4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwPB1PdSLGthU+T6k+dAbxvm7Cdp87jn5UAZtczVQYHwYrqU4/qugbIHcxIyA/RyhGuVwIAhJErACTXs9V8npMu0hoFzBYMm2hHkfZZ8o+CwBZNdGEiXPNThW18tgFsqeQI6qMrWGaWACiHp/cRs1sA3AOCsJ6xt9l3zuzlP4vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O1iRHEef; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O1iRHEef"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773821013; x=1805357013;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b1mj3ag2iPVepY081nzoCeH7Zw3Nrm9HNoFZg7rJV4g=;
  b=O1iRHEefPXsscSMkQmGTP19dMmv3rywpN/11hiGURSH3PxnhyW2XyPbB
   TshK8lzzhZaQkVY5ggJq1llKCQn0VCaYJikC85guT8I9PmFA2sfhOQraP
   +PBiN0RyKMdtn2ESXDJ+0YNEBY9ByKnaJfZ+sx4zBuQwFixu0eZDsW+k6
   7PfsjNf3AEia2/Yo0DgnSMAoWdGgGnNfyWZVMMWD/q/NqQyLxdi2eRsSb
   p+XaxuZiRLXLe51UM+nxReDu8ldhJR4Dn51Cio+qiQo9XEUdiYQYQju+0
   vw1Ro0ibg5i9Ec48g5BbiL+VikI2g8/AxYXM1xiO9mRj/VB8i1VmtFjXY
   g==;
X-CSE-ConnectionGUID: MakOCTmaTw6eIMl7033zTQ==
X-CSE-MsgGUID: ZsDmlff/R+6vBI+zZrRMBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="86340302"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="86340302"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 01:03:32 -0700
X-CSE-ConnectionGUID: cgfUDgkQTvGpY3La3P2dHw==
X-CSE-MsgGUID: 12Lj4Ye9QYSh5rCI/7QrqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="218149009"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.240])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 01:03:29 -0700
Date: Wed, 18 Mar 2026 10:03:27 +0200
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
Message-ID: <abpcT5Yqfi5_SjKR@ashevche-desk.local>
References: <20260317210828.2117631-1-andriy.shevchenko@linux.intel.com>
 <abnVTODs9fOqF9eV@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abnVTODs9fOqF9eV@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 18, 2026 at 12:27:24AM +0200, Sakari Ailus wrote:
> On Tue, Mar 17, 2026 at 10:08:28PM +0100, Andy Shevchenko wrote:

...

> > + * In order to check for the property presence, use device_property_present().
> 
> Do you really think we should add this clause for each of these functions?

Yes, as Guenter pointed out that this has to be documented clearly.

> I don't think it belongs here.

And? What should we do then (taking into account my below comments)?

> The error code list doesn't document what is returned if a property doesn't
> exist (-EINVAL) and it'd be helpful to add this.

No, this change is exactly against this. Because using an error code that may
cover not only that case is at bare minimum fragile and layering violation.
APIs that require to know the implementation details are not good APIs.

> It would have been best to have a separate error code for this albeit
> changing this now might not be that troublesome either: very, very few
> callers depend on receiving such an error code but there are still many
> callers.

I'm against this because we have already a dedicated API to check for property
presence, why do we need to have another (confusing!) way of doing the same?

Having a dedicated code may help to debug, but shouldn't be used as a main
feature in my opinion.

-- 
With Best Regards,
Andy Shevchenko


