Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F833DA5A2;
	Wed, 18 Mar 2026 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773843371; cv=none; b=lLA6iQfOk1NcYvCdQUEhQqS2bShBAguSfIQbYi4UdYS7MJwEE0cR25SC+Q0Ph86EV4zIUJ+qIgB5yd7yAQm2vMbiHvkLu9S1erCP2wVFAp4GTYQ9J/3IZ9BHeuiw1LF+JswZV2c8B39dLZBWSWbNAfigKVLtsgdO3StmKIOHWb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773843371; c=relaxed/simple;
	bh=c5Uce+pPSJFdL8hXtYdk2wMgWKHB2CNrPLxAl3FMHik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7ImG3nV6PC9herUOZb3T0wCgn8yNgT+eT+EJSQVj0jQriUkThiwUtRY9iInHGFSCCPWARi4sClvlzvBrWsnQrM3Mqlle315AMdlfB/+km6kW9F5+eeFTZ3Yfm5hT8HJnq17sNyKvqz1Hj417RDc4WitgVYA0Jx7Zn8uXX/Wo6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fE0sDGvf; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fE0sDGvf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773843371; x=1805379371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c5Uce+pPSJFdL8hXtYdk2wMgWKHB2CNrPLxAl3FMHik=;
  b=fE0sDGvfos7Rnx+fj8XvPEWh/ERzihbIr3Numj92bTGD7AsFRfVRen9C
   +7vXVAHTRaqPZuhLntQkzNGMLN750Y3sE1DbcDf8+dI6cob3kxv7FBBS1
   QXMhv9cD+gBhgv65S3hnAW31+nqp7O5aUri6rrh4wNsYKJaDgZ4DK262A
   BcdtbgFZu1VVzHyw/oow8cOoFpyALD3dMF8yExyOGObw2HkBXvOS13wz4
   7je5zE4T5ilAWgvCRXF+7TsSn+aNQk4+GMFX510MNPEY118KBnTDHl+81
   It5RtECSMd0zux7j5ZmxOQeLycbQboWFGk4Sn2K4F/nXSNS1XD1hD7PJo
   A==;
X-CSE-ConnectionGUID: ThZwkcC6SNiC5+69OW01SQ==
X-CSE-MsgGUID: lJ5qeVfnSjyemP1oWsnqIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74928906"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="74928906"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 07:16:10 -0700
X-CSE-ConnectionGUID: frawAoCnRYq9MjJwCT2OvQ==
X-CSE-MsgGUID: LrnsiYcATOOle57CLAZDKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="222699304"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.240])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 07:16:07 -0700
Date: Wed, 18 Mar 2026 16:16:04 +0200
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
Message-ID: <abqzpC4hAhdWUa0b@ashevche-desk.local>
References: <20260317210828.2117631-1-andriy.shevchenko@linux.intel.com>
 <abnVTODs9fOqF9eV@kekkonen.localdomain>
 <abpcT5Yqfi5_SjKR@ashevche-desk.local>
 <abpsGfkitsXuWKb4@kekkonen.localdomain>
 <abpzZfYBPdM4AzLP@ashevche-desk.local>
 <abqL5PnqGNQ-6Zhc@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abqL5PnqGNQ-6Zhc@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 18, 2026 at 01:26:28PM +0200, Sakari Ailus wrote:
> On Wed, Mar 18, 2026 at 11:41:57AM +0200, Andy Shevchenko wrote:
> > On Wed, Mar 18, 2026 at 11:10:49AM +0200, Sakari Ailus wrote:
> > > On Wed, Mar 18, 2026 at 10:03:27AM +0200, Andy Shevchenko wrote:
> > > > On Wed, Mar 18, 2026 at 12:27:24AM +0200, Sakari Ailus wrote:
> > > > > On Tue, Mar 17, 2026 at 10:08:28PM +0100, Andy Shevchenko wrote:

...

> > > > > > + * In order to check for the property presence, use device_property_present().
> > > > > 
> > > > > Do you really think we should add this clause for each of these functions?
> > > > 
> > > > Yes, as Guenter pointed out that this has to be documented clearly.
> > > > 
> > > > > I don't think it belongs here.
> > > > 
> > > > And? What should we do then (taking into account my below comments)?
> > > > 
> > > > > The error code list doesn't document what is returned if a property doesn't
> > > > > exist (-EINVAL) and it'd be helpful to add this.
> > > > 
> > > > No, this change is exactly against this. Because using an error code that may
> > > > cover not only that case is at bare minimum fragile and layering violation.
> > > > APIs that require to know the implementation details are not good APIs.
> > > 
> > > I have to say I disagree with that,
> > 
> > And I definitely disagree with tribal knowledge based (implementation details
> > as it's not properly documented and can't, because -EINVAL is overloaded) and
> > confusing approach that is in use and may be amended.
> 
> In general it's a good idea to document API functions' return values. It
> certainly won't add to confusion, will it?

No, but it's already documented. -EINVAL is for "invalid parameters". Of course
one may describe that it's not only that, but also property not present and
possibly other cases hidden deeper in the stack of the backend functions. This
will just show my point, that -EINVAL is not guaranteed to be unique for the
purpose.

> > > there's nothing wrong with checking
> > > error codes if you need to.
> > 
> > If that error code defines the case. Here we have not a such.
> > 
> > The wrong parameter to the function will lead to the same error code
> > which is simply wrong.
> > 
> > > Either way, I checked the original patch. If you really think you need to
> > > check for property presence and use default in the case the property isn't
> > > found and error out on other errors, add helper functions for the purpose
> > > instead of open-coding it all.
> > 
> > You mean adding 20+ helpers (at least 5 for arrays, 5 for single element,
> > and doubled for device_/fwnode_) ?! This sounds like way over verbose
> > approach.
> 
> It's still better than open coding this where differentiating behaviour is
> desired. You'd probably need a few macros to generate the functions for
> each type needed.

There are not so many cases, and actually in some of them open coded variant
suits very well. I do not see enough justification in adding those helpers.

> > > > > It would have been best to have a separate error code for this albeit
> > > > > changing this now might not be that troublesome either: very, very few
> > > > > callers depend on receiving such an error code but there are still many
> > > > > callers.
> > > > 
> > > > I'm against this because we have already a dedicated API to check for property
> > > > presence, why do we need to have another (confusing!) way of doing the same?
> > > > 
> > > > Having a dedicated code may help to debug, but shouldn't be used as a main
> > > > feature in my opinion.
> > 
> > I will send a next version of this patch touching only the present/bool functions.
> 
> Sounds good.
> 
> I'd also drop this from the patch
> 
> + * This function is the correct way to check that given property is present
> + * in the firmware node description.
> 
> as redundant.

Then it will be no sense in the patch, will it be? The whole point is to clarify
how one should use API when the desire is to detect if property is present or not.

So, I send my v2 as I see it useful. Then you can NAK it at your wish.

-- 
With Best Regards,
Andy Shevchenko


