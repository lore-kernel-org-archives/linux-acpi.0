Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EE044470A;
	Fri,  2 Oct 2026 10:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937458; cv=none; b=IqhMzZt07m2HgGCUxjZrq8nggk59IELQs/Tkzh5q2NMp07bmT6dhbFy6f81wwp44AlKXUOU3lKjKWxQvoyZTmAttS0pJAhoWy7Y675osBcqHmiCt02Jzk1WyzAAGDnEsQCc6Z3FI9kS95wHA21fdiJIeAIib60QPm0Ouo93lmmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937458; c=relaxed/simple;
	bh=MpQ8nLdNnR81vCVjCCsNhls8ahzgzhGE4VA7PIrgLQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YutonODdxGHYpJT6/sU1TGaZNea8MlrgZ5L4SB6kEKSBm2YbV9xPuMzIbO/XRDWKFbJuN0UXfs5JGf8MsGwMuAId+iLLPGc9DAbXFkUE6NAxW0m5/0xlaXdDONLUjmeiQZNPLHf5qLpi5qNXS80IQAfgeX4YyXQfo5zpc5nXK+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TLQ/bvNe; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TLQ/bvNe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790937457; x=1822473457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MpQ8nLdNnR81vCVjCCsNhls8ahzgzhGE4VA7PIrgLQA=;
  b=TLQ/bvNeilVj/aZjed4hVISyu4T+zyYrM0Czgxq+Fp6AnK7mOkygxiyg
   XQHNy2Xy89sMhm6djYJP9BNXzyUyEgK+Pj65RXfqctnuQtgYi1vGb6Ox5
   2Rq/a9djjcIvwF7oqAWSdvtLG8k0gsNoN1ZrhLDT8bprNdLna0LOkbpem
   fUz4d7rAQdyhLIVYg1hUEwehiBCy5dig1kxFdxhNP9kRZYdUbUow9AGvJ
   Y+G742gNE8m7YFcGp+VSH9lhOMmtHSio2wrJ48qp7PjnYgXw+Cf6ZTp7W
   Pw6pWSrrAV4wScj741GboMcLqLf4Xla9tnkiqGzyD9N48szZXzCKS0UeF
   A==;
X-CSE-ConnectionGUID: b3WynWKfT/ixjz072AXe0Q==
X-CSE-MsgGUID: 7Gbp9299QxqsKcDSmfLlSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="94414526"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="94414526"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 03:37:36 -0700
X-CSE-ConnectionGUID: WoWMfcBxTRWhFgAfLso6+A==
X-CSE-MsgGUID: S2m75JnTTWaYzJjpdnoIqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="314213711"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 03:37:34 -0700
Date: Fri, 2 Oct 2026 13:37:31 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Abduvaliy Abdulazizov <abduvaliy.hbai@gmail.com>
Cc: Mika Westerberg <westeri@kernel.org>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Ignore GPIO 11 interrupt on Acer Nitro V
 16S AI
Message-ID: <ar-Ja2AVJs1TzMpg@ashevche-desk.local>
References: <20261002101800.51506-1-abduvaliy.hbai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002101800.51506-1-abduvaliy.hbai@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 02, 2026 at 03:18:00PM +0500, Abduvaliy Abdulazizov wrote:
> On the Acer Nitro V 16S AI (ANV16S-41) the internal USB camera
> (0408:4035) works on Windows but never shows up on Linux.
> 
> The firmware drives GPIO 11 of AMDI0030 high to power the camera. The
> same pin is listed in \_SB.GPIO._AEI as an edge-triggered, active-low
> wake interrupt whose _EVT case only writes a debug code. gpiolib-acpi
> requests _AEI pins as inputs, which clears the output enable bit, so
> the camera loses power during boot.
> 
> After boot the pin register reads 0x00447a00 (output value 1, output
> enable 0, line low). With the xHCI controller kept away from Linux
> (pci-stub), the camera port shows CSC=1, CCS=0: the camera was
> connected during boot and then dropped off.
> 
> Booting with gpiolib_acpi.ignore_interrupt=AMDI0030:00@11 keeps the
> camera powered; it enumerates and works with uvcvideo. Add a DMI quirk
> so this works out of the box, like the existing one for the Acer
> Nitro V 14 on the same pin.

While this all sounds legit, I'm worrying that the pin can be used for
something more. For the record, can you share the DSDT table (or entire
`acpidump -o NitroV16S.dat` file) via some file exchanger so we may see
that?

-- 
With Best Regards,
Andy Shevchenko


