Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2AB372EF5;
	Sat,  4 Jul 2026 19:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783191901; cv=none; b=Zw+WKEzKAHY20LOB1R7V7eSGe4oeOXb8ZdwSqgCJjE5iTjeQOXY7dvb0jgmzeqRh0ujnpOwgSeEPErZtHwbii0z8qY0/xyyffRE9SV1Z0iB67pyyb9q9LPoSGKjHIeCKyu2/KYpNi5vpomL1yj87SN8fpm63Kq5WaJFbciaoVgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783191901; c=relaxed/simple;
	bh=NxgWlRo1WekT/E7VOaafBTlkXH3NCkoFD5s+Dn450f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBfMX23C2CP3rrxnus3yjLd8W7IPrdWEA5xT6PllkpdEd9sstzbSEzLUs5pw+F1N/99DW+4WKqO9V/iUisoJ1lzXuPTwSxhP/B76joYwi6QPG7OOqkr1XgOzC4f/gSHt2zhD3bh3QdyWnMln+C66oPY2liMkjlumAx2nlx4YSMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MG2Wb5Ob; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MG2Wb5Ob"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783191899; x=1814727899;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NxgWlRo1WekT/E7VOaafBTlkXH3NCkoFD5s+Dn450f4=;
  b=MG2Wb5ObW6kogeo456/6MmkWr6DesJv7l9ZdNhexwxjrxkcXxZHP4aBh
   7WRiXrntvOpXVw4TrgyzcR2oYQ6YozbEwOL7ksYDi68UFbdGpbKH0nvMy
   iwF4TjX7FR01Xy7INIQjypP0lTUM5DKNEJrWqiAp34WNzqFIehOu5SkQg
   pNbp4dZutw6t9Rx//IP+NfMhnsOEKGe8uQUWDBZ7TzkzCtIHkYX7L+Lha
   745mYdkKtt4BT5s7Y9vju8a0TPa+oB/6VROQ0mYgj/3eZdryGOg8z11cl
   8+y9y6LiEK1GPYD3GUB9i4E+C80jGSDhu+XbDeIPqfC93/3Se/L6eTTt/
   A==;
X-CSE-ConnectionGUID: G6flq9FHQSiN1EIxzdChhg==
X-CSE-MsgGUID: i0c84W4YRnu4jnJ77S+xZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11837"; a="82995092"
X-IronPort-AV: E=Sophos;i="6.25,148,1779174000"; 
   d="scan'208";a="82995092"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 12:04:58 -0700
X-CSE-ConnectionGUID: YbbpujWFTXaPMsm8myaHnA==
X-CSE-MsgGUID: 8fNguPQPQ+29FmLrBHu6+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,148,1779174000"; 
   d="scan'208";a="257232737"
Received: from slindbla-desk.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.246])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 12:04:55 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id B146B120DF0;
	Sat, 04 Jul 2026 22:04:33 +0300 (EEST)
Date: Sat, 4 Jul 2026 22:04:33 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Arun T <arun.t@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Miguel Vadillo <miguel.vadillo@intel.com>,
	Len Brown <lenb@kernel.org>, Mehdi Djait <mehdi.djait@intel.com>,
	linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Add NVL CVS/IPU8 camera support
Message-ID: <aklZQdKb2NxkzrYe@kekkonen.localdomain>
References: <20260704171855.1462214-1-arun.t@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704171855.1462214-1-arun.t@intel.com>

Hi Arun,

On Sat, Jul 04, 2026 at 10:48:51PM +0530, Arun T wrote:
> This series adds NVL CVS support to the ACPI dependency handling,
> the IPU bridge, and the CVS driver. It also adds the IPU8 PCI device
> ID needed for the CVS driver to bind on NVL camera hardware.
> 
> Changes in v2:
> - Add a cover letter for the multi-patch series.
> - Add Reviewed-by from Sakari Ailus to patch 1.

There's no need to send further versions of these patches; patches 2--4 are
already in my tree.

-- 
Regards,

Sakari Ailus
