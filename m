Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FCF425CC0;
	Tue, 16 Jun 2026 09:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781603890; cv=none; b=HOHaLT0OYTRMGSKbfpFfyEGWBkGh3213U6NM0GvrejLi7XzsKuFSc31sAXHSNPiTOlM5n5TRpe1XQ+6h7pCBC5yIxIkJp9/uVR7ywFL32G9SMwkcwrpAD3JA1pSeY3dHSHnfp8hBx0J9hDqmFLM5lD5Dg951FSjYWtkA1cnrd2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781603890; c=relaxed/simple;
	bh=stz8lhbZ05qN0z/1+fythJuDB4lrzB7n8AsoLvVhn5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvRXsKdmZbZjPo9/hpBcUoknYLNwcvljSS5EbmuBQrMHJROkNQqPEy/+CWjdlwSln5KSrlcQlYDfSq0NEhK7ZgOZpfxqbb9NTl/pol/t1MPdssvR8RD/9cuUgd2ZRcOKlk3oGBcHZQYlIHoy7yZ17UvONH/CquiELDO0H3fd1wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SAX0HQfP; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SAX0HQfP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781603890; x=1813139890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=stz8lhbZ05qN0z/1+fythJuDB4lrzB7n8AsoLvVhn5A=;
  b=SAX0HQfPZsOZgwssLDTRSSZfx1+KnuvG9c4zWgADH+gsr2AJudAiDjTe
   1oYMskS06FfG81YMCNTIGrh/cv+XG8DUVzZHlgthZSI0RKnSbir+hIsUo
   aTo8MJAjxDpACejbSNrrF2HVS0eVWhRxnu9x9cwbvVyQOfD/xKANxmx2u
   /2Yws2OSkjet5zCYZ8i3Gj3BYLkgXC39Me1+LonIPwGaWUUOzjKElIEEk
   ItpmIspYcRMKV3U8GEIoc0/BWiyk0VTFEvap2XGf4kvuiBdV7HlXUZMST
   WDLo0TC2wZigAQG3Gh7IOwMYmwoD/dD/i2d1oDfTTPmMBIkYATSBSThAY
   w==;
X-CSE-ConnectionGUID: 7Iksu+/OQyGc5e8qd6Dv4Q==
X-CSE-MsgGUID: seSEZMwGQv6wGNyNBO+9aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="93482105"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="93482105"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 02:58:09 -0700
X-CSE-ConnectionGUID: 7k5q62m7TAuQYbcA5xiKRw==
X-CSE-MsgGUID: PkvbfS/1Q6q/XHyMPhyZUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="247597055"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 02:58:07 -0700
Date: Tue, 16 Jun 2026 12:58:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marco Scardovi <scardracs@disroot.org>
Cc: Mika Westerberg <westeri@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add quirk for ASUS ROG Strix G614 series
Message-ID: <ajEeLL5u3hf7lvWD@ashevche-desk.local>
References: <20260616090824.5967-1-scardracs@disroot.org>
 <ajEX8L63vAhhndv7@ashevche-desk.local>
 <RqcbSmnzQWas394Kq-TG7w@disroot.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <RqcbSmnzQWas394Kq-TG7w@disroot.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 11:43:56AM +0200, Marco Scardovi wrote:

...

> > What is this interrupt for? Touchpad?
> 
> It is an ACPI event interrupt on the AMD GPIO controller (AMDI0030).
> Specifically, it triggers on pin 21, appearing in /proc/interrupts as
> "amd_gpio 21 ACPI:Event" and as you guessed it is the touchpad.
> 
> Previously, using "gpiolib_acpi.ignore_interrupt=AMDI0030:00@21" or
> "gpiolib_acpi.run_edge_events_on_boot=0" as a boot parameter successfully
> bypassed the 36-second delay, which confirms this specific pin/handler is the
> culprit stalling the boot process.

Mika, do you see any problems with disabled (deferred?) interrupt for this type
of event? I think it might break the suspend-resume (on touchpad event). Also
do you remember if we ever had touchpad event to be ActiveBoth?

What I'm trying to understand if this is pure BIOS issue (typo) or HW really
wants to
- be able to generate events to the OS (at boot time?)
- have the reaction on any edge

Mario, do you know anything more? It's AMD platform at the end, what the TP
model and if it requires both edges...

-- 
With Best Regards,
Andy Shevchenko


