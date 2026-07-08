Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EFE3CBE71;
	Wed,  8 Jul 2026 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520755; cv=none; b=dLqQWIISclPmx7cH1PAaJXflOmNXi+DR5B6NRwbDoTDr3TWw6oGdeE/RysbM9pCalH/6WcWH1vxKbI3KLgJ3zvugU0/nAUYcqINrOnP+eb2SpFGeEREOjPFvB7DGvTBqA2fwRntczL+uyDaL9462uf07AgtTHgthJWENVmRbDSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520755; c=relaxed/simple;
	bh=A3tFa8yk94m0+WioxNgJyCaPysW9Q3/hGYrbSgmoToc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2A+vWSo/9jNy+vvKZZqRRKwqucFOj53ha/geGukD/i/GiJ4WxdYaMQ+fZDjNvVBZYW5XacxIY9uLxSy5v8weeOsklsyvec9YLdhDhowF+p50y/0N8E8VE/Z/EWjpswuzO8Rn7pii3BvXM1RjHAJCwr/zc93vvGx2PGfVpwj+4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R1hXBB+I; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R1hXBB+I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783520754; x=1815056754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A3tFa8yk94m0+WioxNgJyCaPysW9Q3/hGYrbSgmoToc=;
  b=R1hXBB+Invhrx4jFWXPEms0CW61fdS4Bjo8YoOypGe2mCedd3K2dxoGZ
   zqBOAToG62NoYNDHEymQH/6iySvpTcJq0+y9D++0gFrRxfzw9MELNTk6d
   M4GuUJTieMryr6J2Y6+hawtUk9kyGpy9reS0BJ5AP89yZeaUngMYrgQUK
   FY74Ya/NgBDbvjWEHVXVfhNKPHOQ5pNw0C+k4hyCk8AcsXx3PO8fMtuJa
   qXk3PgN+oC/KExzEWWUsKBk6HcCcQp/MxKOkzfC7UJupke99cDYDw4pOL
   H+99WBrnPE6OBt9XxW3d29WghHouQApaFvyQm2zgqabM0EEY/are75pxj
   A==;
X-CSE-ConnectionGUID: 37RKPJcuQ3+rWYSKrk+hcg==
X-CSE-MsgGUID: +11irAIlRwqeMYCyHEmN/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84241883"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84241883"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 07:25:53 -0700
X-CSE-ConnectionGUID: MdbNR01zSYif48rJgiWwSg==
X-CSE-MsgGUID: fgi+BQlRQXWWQSQcEMD78w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="247928220"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 07:25:51 -0700
Date: Wed, 8 Jul 2026 17:25:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	x86 Maintainers <x86@kernel.org>
Subject: Re: [PATCH v1] x86/platform/olpc: xo15: Stop setting
 acpi_device_name/class()
Message-ID: <ak5d7Quwip7TiWsk@ashevche-desk.local>
References: <2866696.mvXUDI8C0e@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2866696.mvXUDI8C0e@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 06, 2026 at 02:26:23PM +0200, Rafael J. Wysocki wrote:

> The driver sets acpi_device_name() and acpi_device_class() which are
> never read afterward, so make it stop doing that and drop the symbols
> defined specifically for this purpose.
> 
> No intentional functional impact.
> 
> This will facilitate the removal of device_name and device_class from
> struct acpi_device_pnp in the future.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


