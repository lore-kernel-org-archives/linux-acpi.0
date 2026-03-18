Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C553BED29;
	Wed, 18 Mar 2026 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773833200; cv=none; b=XaC0suUObypgz6ft4JgZdZHwrPhgUe6S88B9/CqVx3MD25kNZwVVl3QiXRsQTgqd3AhZqfz5Xs05cQA70V3BcuLV5MwpyjEDlXCwthLYWI66DbRuAUPkF+APYdZUBtBKgpqBpYnKAMeaGtc8l4T5EMTVwgh1BTNVoiyZq0VgvPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773833200; c=relaxed/simple;
	bh=H+cIWJZ4Q1o7oz07cHAFjDrffGaOkfmaEx1mEYad3TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbFM3U6sWWSuYRWhZa/Tdg9V9wDov5c7223Bj5tEZDqfnGsjRGHXvhRrZwqglDHKZmIsuF+e7AA9yiiKXK+Gd2sTE1Xu56m7SLG2AojjZnUOBtm+DcGIFvuCnmEo9Z0WPlPR8HWzt7c9FPgVgp2VcQY3bo1O8KRexgzkNo0IxY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UuF55fp/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UuF55fp/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773833195; x=1805369195;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H+cIWJZ4Q1o7oz07cHAFjDrffGaOkfmaEx1mEYad3TM=;
  b=UuF55fp/cRAA8ogR+E2W380RYiFWaWG403PbYcXNAsQwk9FjmXwFAZxM
   KddujbZSP/QfXt40gLhirxTo7Hyvxqk0VlvgnR/3i02ZfDYJiUMjH0dB3
   chyoWzfCOVdUrTBZ6nkrY4eJqH/U8fmum+VHBXliWBAhIdcxaQTcF3xvS
   mq5nlzfjtdW6VCB2VTIOR7m4/jy1SY89w+mRxGRgG3FYRMYZLk4RdUNVq
   9gDnh6gOzZXnK5Jfe52hc6hCrmODQX1WwjFbHhCLfNzu5JRUKGlqelyBc
   OwFOo26NeWFkbOPCXG50fGE8RkcptEs/nx/j59VaWCkMgLarkeaT38xmO
   A==;
X-CSE-ConnectionGUID: wRF/GWFlR6SjecycxID0Vw==
X-CSE-MsgGUID: qut8y3ZcT+eEV6EfjkKkbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="92453307"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="92453307"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 04:26:34 -0700
X-CSE-ConnectionGUID: E0Yq5WTnRZKLW5njq9G0lg==
X-CSE-MsgGUID: 1Pkk9imrRmKh2IyWt3WYCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="222655371"
Received: from rvuia-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.243])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 04:26:32 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id E291B11FCDF;
	Wed, 18 Mar 2026 13:26:28 +0200 (EET)
Date: Wed, 18 Mar 2026 13:26:28 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Message-ID: <abqL5PnqGNQ-6Zhc@kekkonen.localdomain>
References: <20260317210828.2117631-1-andriy.shevchenko@linux.intel.com>
 <abnVTODs9fOqF9eV@kekkonen.localdomain>
 <abpcT5Yqfi5_SjKR@ashevche-desk.local>
 <abpsGfkitsXuWKb4@kekkonen.localdomain>
 <abpzZfYBPdM4AzLP@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abpzZfYBPdM4AzLP@ashevche-desk.local>

On Wed, Mar 18, 2026 at 11:41:57AM +0200, Andy Shevchenko wrote:
> On Wed, Mar 18, 2026 at 11:10:49AM +0200, Sakari Ailus wrote:
> > On Wed, Mar 18, 2026 at 10:03:27AM +0200, Andy Shevchenko wrote:
> > > On Wed, Mar 18, 2026 at 12:27:24AM +0200, Sakari Ailus wrote:
> > > > On Tue, Mar 17, 2026 at 10:08:28PM +0100, Andy Shevchenko wrote:
> 
> ...
> 
> > > > > + * In order to check for the property presence, use device_property_present().
> > > > 
> > > > Do you really think we should add this clause for each of these functions?
> > > 
> > > Yes, as Guenter pointed out that this has to be documented clearly.
> > > 
> > > > I don't think it belongs here.
> > > 
> > > And? What should we do then (taking into account my below comments)?
> > > 
> > > > The error code list doesn't document what is returned if a property doesn't
> > > > exist (-EINVAL) and it'd be helpful to add this.
> > > 
> > > No, this change is exactly against this. Because using an error code that may
> > > cover not only that case is at bare minimum fragile and layering violation.
> > > APIs that require to know the implementation details are not good APIs.
> > 
> > I have to say I disagree with that,
> 
> And I definitely disagree with tribal knowledge based (implementation details
> as it's not properly documented and can't, because -EINVAL is overloaded) and
> confusing approach that is in use and may be amended.

In general it's a good idea to document API functions' return values. It
certainly won't add to confusion, will it?

> 
> > there's nothing wrong with checking
> > error codes if you need to.
> 
> If that error code defines the case. Here we have not a such.
> 
> The wrong parameter to the function will lead to the same error code
> which is simply wrong.
> 
> > Either way, I checked the original patch. If you really think you need to
> > check for property presence and use default in the case the property isn't
> > found and error out on other errors, add helper functions for the purpose
> > instead of open-coding it all.
> 
> You mean adding 20+ helpers (at least 5 for arrays, 5 for single element,
> and doubled for device_/fwnode_) ?! This sounds like way over verbose
> approach.

It's still better than open coding this where differentiating behaviour is
desired. You'd probably need a few macros to generate the functions for
each type needed.

> 
> > > > It would have been best to have a separate error code for this albeit
> > > > changing this now might not be that troublesome either: very, very few
> > > > callers depend on receiving such an error code but there are still many
> > > > callers.
> > > 
> > > I'm against this because we have already a dedicated API to check for property
> > > presence, why do we need to have another (confusing!) way of doing the same?
> > > 
> > > Having a dedicated code may help to debug, but shouldn't be used as a main
> > > feature in my opinion.
> 
> I will send a next version of this patch touching only the present/bool functions.

Sounds good.

I'd also drop this from the patch

+ * This function is the correct way to check that given property is present    
+ * in the firmware node description.                                           

as redundant.

-- 
Regards,

Sakari Ailus
