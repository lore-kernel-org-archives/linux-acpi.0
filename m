Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36CD1D5160;
	Wed,  8 Jul 2026 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521126; cv=none; b=Esc8bCeP4hRrC0ByI0cUW4Gf50GP89kFLeXkygMVlKjDs9D+H/k/UV76CQaDWIK7OFOhQxK2tQEnNCooOY4V3K7rEjHhB0Hi6Nc0OLTeexJxPSZJzxaQ7HrKKnztkd3IFlr77mXH5yjxkbXUmkR/yg355r1K5+NF22AenvIBkGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521126; c=relaxed/simple;
	bh=rSppmTOAmtBkSLhZVuFPsgQN1Q0/f8PC59cpT0yi3M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ft/1OxJnQh+nKWPtRoiRr/ArApGq/NlONUeSvGIK40+aPNp7hduCuXlOZlw3706215c8pbalNaCT/PkqEU/HanqhH5My4hW2/n6qSzHQJYA3Vz1f5R41HqXPRXPncesZlQtiZynSIVW7Q/yTiIgjWNX1wsElTB0QPXX8gFctWEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BLaTcr5l; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BLaTcr5l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783521125; x=1815057125;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rSppmTOAmtBkSLhZVuFPsgQN1Q0/f8PC59cpT0yi3M4=;
  b=BLaTcr5lBChu5LGNdDN848KxX48+FzOK85IUbGbmNG+2SftgokS2pIsr
   YX8pv+cOcWJH0c2XHDVvdDjAu4oKJawnTK2T2Wf+kKnbNvdDA3NnJw+UC
   OfUDpq5HT+gAx/xhNn47wsz9Kq4zTx3NK2o9itXIVfJWYobiN2eeWTrj0
   /tN8/dy7KCniQZkM0wohWBL7Bw8f3uyFkZ4rZ64iH2zjuz69GTBN8xGL1
   ZCXmedNWtRDI0Y2IpxQQlFVI0dHZFY6neRHpuoN3PF/NOkv3llOHJX/tX
   iiFdVlI4jLb+QiyhgKOLpd/Q7UmaTbzzOsbNES9kxHdEsYQGEDl4nxr1+
   A==;
X-CSE-ConnectionGUID: WiacP/9mTKmKy5sAyBCEzg==
X-CSE-MsgGUID: C9lsGdwuQ/eJ6/u/g9qX1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84242362"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84242362"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 07:32:04 -0700
X-CSE-ConnectionGUID: HSpXZMxUS5C6BKWTi7/d/w==
X-CSE-MsgGUID: ZLHYUe7NSoCAd0ti1ZuKNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="247929343"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 07:32:02 -0700
Date: Wed, 8 Jul 2026 17:32:00 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Mattia Dongili <malattia@linux.it>, Arnd Bergmann <arnd@arndb.de>,
	platform-driver-x86@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v1] sonypi: Stop setting acpi_device_name/class()
Message-ID: <ak5fYKbOVT4D_xbI@ashevche-desk.local>
References: <3447860.aeNJFYEL58@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3447860.aeNJFYEL58@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 06, 2026 at 02:38:15PM +0200, Rafael J. Wysocki wrote:

> The driver sets acpi_device_name() and acpi_device_class() which are
> never read afterward, so make it stop doing that.
> 
> No intentional functional impact.
> 
> This will facilitate the removal of device_name and device_class from
> struct acpi_device_pnp in the future.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


