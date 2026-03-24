Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D663FB7D8;
	Tue, 24 Mar 2026 12:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355621; cv=none; b=rlzSDxT4qV1tBSnWeYwK9g7CecT3aPQjWK111tgJMhv3BqiGvhUm2hELsPJjNf3ndoh1oUkeEho3zLx0KdULi0woFlCUkOgEAUkWxfp7ZWIKpe6Amc4BOEDi+npNmiHmN+4bHDRrvxl3tEEa9YXRGnSqwF+2DCGAYyFwDQ7sEyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355621; c=relaxed/simple;
	bh=L56j7PXLTT7wUGCOyfBaKiVleWDHS7aRZVwscznomDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwTeJkeDQ8x1f0D6mSIvO7nawWJ2QNa6ntulGrfASgCmy5bFrG8HKd5LSXMhokUPmETl5p0dJdKVTWidcZj+Fn6RdhFlspZI8aUUBFomeDz92pniEGU1qL5AtsQUWQdd24Qy8Lw3EWljfWGMi8tcpVyMh09Ftsbr0m4kaCI9iiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBlDP4KI; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBlDP4KI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774355619; x=1805891619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L56j7PXLTT7wUGCOyfBaKiVleWDHS7aRZVwscznomDA=;
  b=HBlDP4KI7HzhO2w9np8+dLxV2qdjhwynaZTlKxRO3gp+fYxneEMIoNOD
   mBmmH/Fvb3X8XWIMitmKQMp9vpgSF1r9Amz4LrHRtlbrGr2cJDONToRcY
   Rg6J0L5sJfxuY2Bv2biUsBfm+rRgGcesZUD95CvTxJ+uKOHyQsNyQoxWi
   0RjN5ZXWGUIuRSr1nhjNv0hTlG8NUyTV4eG5LEIhqIewt2GZ+qvN1ICzS
   p7lUNEWGgdMrx1hHzKKJaOgDV1PFP80ATJpAayakFMwFK+eJ6OmOH7X99
   lemEHt0QLK/1NVVv27Mo5CdWdJ7WN4q1FBgYXKcf5K05eK8uq9KjbkE5W
   A==;
X-CSE-ConnectionGUID: NhuioASURoa7lJ24uZ4+lw==
X-CSE-MsgGUID: PoobEMMISN++vIp+V69uYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75083029"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75083029"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 05:33:38 -0700
X-CSE-ConnectionGUID: JVpKOgWETn6acYytpQAF+w==
X-CSE-MsgGUID: 4PxSOVKTQvCCS794dvJFbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="229089411"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.214])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 05:33:34 -0700
Date: Tue, 24 Mar 2026 14:33:31 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: Re: [PATCH 3/4] software node: verify that property data is not on
 stack
Message-ID: <acKEm4EiZBqJ67nM@ashevche-desk.local>
References: <20260323-property-gpio-fix-v1-0-9cb46e5fe7df@gmail.com>
 <20260323-property-gpio-fix-v1-3-9cb46e5fe7df@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-property-gpio-fix-v1-3-9cb46e5fe7df@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 23, 2026 at 05:39:39PM -0700, Dmitry Torokhov wrote:
> When registering a software node, ensure that the property data is not
> located on the stack, as it is expected to persist for the lifetime of
> the node.

...

> +#include <linux/sched/task_stack.h>

Looking at this name the use of it here doesn't sound right...

...

> +	for (prop = node->properties; prop && prop->name; prop++) {
> +		if (!prop->is_inline && object_is_on_stack(prop->pointer)) {
> +			pr_err("%s: property data can't be on stack\n", __func__);
> +			return -EINVAL;
> +		}
> +	}

And again same question, why we can't simply dup them as we do for (string)
arrays?

-- 
With Best Regards,
Andy Shevchenko


