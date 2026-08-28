Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D114734E741;
	Fri, 28 Aug 2026 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787930570; cv=none; b=Nku7p4EoM9Q/p2RxwxygLQRw9MJbI6nxgG4aC/gmT8v3iwu7RWFXwxVIvLT0gK6PDPsgImbUGPNjMCo4JOpEyN1wdb7ZGLMwnPsupAcZrVLLsQTFRbK8zfDWJcq9uibdOBjTjqY7mahn4GLzIVxCRnYm27BybioUn/tzncz9X0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787930570; c=relaxed/simple;
	bh=n+tszpwZAQEa6yR5wA3n62XuCymeIttEuQ2oNfEC+xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQzimUEF4UhhCcB63TI/Uof29uclLd6fNY/qvXP0n15ubpI2SEu48aYRcQLLMQ26JBQr3ckyJnlsmd0N8lJrtge7h34nv/frlEQuHXe5GPnXr9ebyWCEizN7DlF7Xdxbw0GAuIhlVcomPhIpHv/z5IKBtyABKYWJ+3dBvZ55b/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oej+GHl1; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oej+GHl1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787930568; x=1819466568;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n+tszpwZAQEa6yR5wA3n62XuCymeIttEuQ2oNfEC+xs=;
  b=Oej+GHl1qA2RGocixDoXJrWCYCW8oxbvUm/1zPqWs3GjkL3mJ9SFQIDT
   XkLqDiNjnRgBBCWUoljjpxOR6yKHozVWAqw0NktAk4iMmaagZmQNR7Bdt
   Cph66fQq40AUO/bevShdumoPKR88zG8lVF1xTi/6rUiTKD5zGtMcpkucU
   J4N0CaI4Grv2qgFCV1/GZJTqe9SmzOwjx9uq6YYs+cVA8Ir1ooJrDOl9N
   EKyfJipZOaj92P8ktJ/UXfwjP7BnPPTuwBWlUHWIe2EzczCYsoOCAhoSm
   gG0pnEq6knPRYiMCBob63v+GHKw7LGVW6Ge5gYFj4YmshgAp83wP8p//5
   w==;
X-CSE-ConnectionGUID: 8Y4b+ESASkyj6WbFac94kw==
X-CSE-MsgGUID: vh1j31cvR3qk8UK34AXMJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="88296297"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="88296297"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 08:22:47 -0700
X-CSE-ConnectionGUID: irCKQAgUSKKRndKzvQh3GQ==
X-CSE-MsgGUID: 5t19cT/GRX+W0q5mTjdkzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="266381478"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.167])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 08:22:46 -0700
Date: Fri, 28 Aug 2026 18:22:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-acpi@vger.kernel.org,
	rafael@kernel.org
Subject: Re: [PATCH 3/3] media: i2c: Use ACPI_PTR() for ACPI ID tables
Message-ID: <apGnw9HlXSfVGy4z@ashevche-desk.local>
References: <20260828084328.257703-1-sakari.ailus@linux.intel.com>
 <20260828084328.257703-4-sakari.ailus@linux.intel.com>
 <apGNYsroZTTOqe4c@black.igk.intel.com>
 <apGk_7Uy_NcHG8V3@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apGk_7Uy_NcHG8V3@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 28, 2026 at 06:10:55PM +0300, Sakari Ailus wrote:
> On Fri, Aug 28, 2026 at 03:30:10PM +0200, Andy Shevchenko wrote:
> > On Fri, Aug 28, 2026 at 11:43:28AM +0300, Sakari Ailus wrote:
> > > Add ACPI_PTR() to the ACPI ID tables where missing. The patch has been
> > > produced with the following command:
> > > 
> > > git grep -lP 'acpi_match_table.*=\s*(?!ACPI_PTR)' \
> > > 	drivers/media/|while read i; do
> > > 	perl -i -pe 's/\.acpi_match_table\s*=\s*\K(\w+),/ACPI_PTR($1),/' $i;
> > > done
> > 
> > NAK.
> > 
> > It doesn't explain why we need that. This also inconsistent with OF type of
> > IDs.
> 
> ACPI IDs are used on ACPI only while compatible strings are used on both
> ACPI and OF. Thus the ACPI ID table is redundant if CONFIG_ACPI is
> disabled.

They may be informative for the cases when on the working say OF system I can
get the IDs for ACPI based platforms at run-time.

Also you just save a couple of dozens of bytes. This is peanuts and unneeded
churn. Again, here is my formal

NAKed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

In case you want to override that, please keep it in the commit message (among
other tags). And yes, we have such a tag in the Git history of Linux kernel.

-- 
With Best Regards,
Andy Shevchenko


