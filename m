Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D91719539F;
	Wed,  8 Jul 2026 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521054; cv=none; b=oGBU+imIyfA+9Yy4OmQNeW3ChMVYAaJRnGIRU6tDvL9ir/hztSJNcGXkiaqT/fPE3ODlzH+Sj7z/pLtQqEzS0VNq9f7PIQUboien8QIQiZ5Ci3WmfzN3jt1jG7Ykc4B1DQN7qCytMp5aiLaGpc6RSDs2HAZPLuSTQ0KtpFu5pJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521054; c=relaxed/simple;
	bh=rSppmTOAmtBkSLhZVuFPsgQN1Q0/f8PC59cpT0yi3M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAUcnpwRJNoGlTVxVXVyGsd4EMfsD+4SRztcOXZlrC68DFzrXm8F44Da27UZf9sp++vZ+pM5ZxI8qv5Eesbj5MrnzV61d00b6FwMPERingMlgUb7kg7h9e4583KfXuhFYg96iPThUFPhCh0aLV4ayEpGLyd293cxI8zBXO1naCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZYk6EMVI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZYk6EMVI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783521053; x=1815057053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rSppmTOAmtBkSLhZVuFPsgQN1Q0/f8PC59cpT0yi3M4=;
  b=ZYk6EMVIoux0Rfdo7ygWnkVXnu4ZPXl8+GewcDtneYe3/PYJ2tBe/PXY
   3h+CA1TAXVqFINFOb/Sfqank9EG22d3oXpmNUk7/xb7mA18zy6iVLtyMc
   m6wWn4ARGUI0abc+vWxDTsS9PB7EpSoFCB1TJCnOIovX2JguEFl99gNRz
   HSF5iq9IA94jAPcMDPDq7qVzlqtdpCJwcZ07r4uY/4kXV8GNauzUzK247
   sdq/bt/lMqFLYQe8sfVlo5mGRysJvsUjseUC3A2MqLEk6wY7csrVopBb6
   32frHB02chIN0UZPv7QOEgG4yOZdUZp1abhCcoL2eJ89oIMeFw4O2UepJ
   A==;
X-CSE-ConnectionGUID: 81PPXjmHQAmdp9xvydducg==
X-CSE-MsgGUID: dLTHI/PPRG6rupONmKyYNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95700622"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="95700622"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 07:30:52 -0700
X-CSE-ConnectionGUID: iWeLSigYR3GjCnC1fl3+rw==
X-CSE-MsgGUID: LKc0HbjpTUi9LYGALh9YXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="259208384"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 07:30:50 -0700
Date: Wed, 8 Jul 2026 17:30:47 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Mattia Dongili <malattia@linux.it>, Arnd Bergmann <arnd@arndb.de>,
	platform-driver-x86@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v1] sonypi: Stop setting acpi_device_name/class()
Message-ID: <ak5fFzeakcFSjIqM@ashevche-desk.local>
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


