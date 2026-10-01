Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED46B431A4A;
	Thu,  1 Oct 2026 04:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790827467; cv=none; b=D2pEkVDCfD9sHcROUSXN0D7PWsa7HD6JQ43YpsD3u7WtvExHf6Z9TEkmNk8sC4lBpyUihZKbrUj1uMDSo84djYyK4TQzrwusJ9w07HicwRHJB6cBgYP0vFDWPCrLtHVRqstLtDPs7vmfRgdpvaBGZ//MmGL7hc2TCYzC1X76MeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790827467; c=relaxed/simple;
	bh=FObhEVNrHO2VKVsKpHwvIPfW2vuPInhiqvtBgfbU9Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2lEmRgTrJUPi/MFPDA54jsL0wUyrzvAJrxp6euu2/J+dRRzGGVed+FywK4pkzM+ffxhm4qk9CJCHJtLOtUjnPiUc95dh6CIPNvaeRMArIGdyNI7A7RYUYENQpcHh0wHGsM+VTWjaQBGgEX8bLkIGy+z3PAmkI0LsXoixSF+q4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=myvAIiJj; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="myvAIiJj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790827464; x=1822363464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FObhEVNrHO2VKVsKpHwvIPfW2vuPInhiqvtBgfbU9Y4=;
  b=myvAIiJjRjPdb3zz+AkDz9oURmy+tkDHjK/wo6xmZ5/3qi3xTL5LPidr
   5aRJJfmJo7t9SMsN3PFGhBu/lTzsUr5gg4dZl4gS0aShbcyq5oVXvPAdT
   46pTqFg+2wYFR9+kY2p3Qa/OeUYwGtnBTX8JWMoCNItSv0mSslEPs44wE
   4XZl6Gv211XFp6DPLQY24F+xnWGC07rsR30p9PI7lQ/kp/4ONJslBk+Ky
   2Rj5yPzGGUPTMQc5pYAjPKLVMJ5XXP7yNgShkeAQe6GkZLLq85156qYc1
   n/bjELH2/pfab4jSrby/jX4DMq39btSioHYcWd/6GjHNF1Skq7xanA7Xa
   w==;
X-CSE-ConnectionGUID: GJFn1BwdQmCpI3oThngYUg==
X-CSE-MsgGUID: bFQzNUqWQvqw+8Y5BZyh2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90343374"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="90343374"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 21:04:23 -0700
X-CSE-ConnectionGUID: KWI7QV0RS0ahnguAXRPcIw==
X-CSE-MsgGUID: E923JTlTTP6nUpt5pgNuWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="275424517"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 30 Sep 2026 21:04:21 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 23B0499; Thu, 01 Oct 2026 06:04:20 +0200 (CEST)
Date: Thu, 1 Oct 2026 06:04:20 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Rahul Pon <theflyingrahul@gmail.com>, Andy Shevchenko <andy@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
	linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: GED: Support GpioInt event resources
Message-ID: <20261001040420.GB176164@black.igk.intel.com>
References: <20260930111505.1108-1-theflyingrahul@gmail.com>
 <CAD++jL=45ZdTbHsLDTAmTt3f+=VBVK014TLJyd5Drdba3V=dSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jL=45ZdTbHsLDTAmTt3f+=VBVK014TLJyd5Drdba3V=dSQ@mail.gmail.com>

Hi,

On Wed, Sep 30, 2026 at 10:22:22PM +0200, Linus Walleij wrote:
> On Wed, Sep 30, 2026 at 1:16 PM Rahul Pon <theflyingrahul@gmail.com> wrote:
> 
> > The Generic Event Device accepts only Interrupt and ExtendedInterrupt
> > resources in _CRS. Some ACPI firmware signals GED events through GPIO
> > controllers instead: the HP OmniBook 5 16-bf1xxx (Snapdragon X2) describes
> > its lid (LIGE) and embedded-controller event device (ECGE) as ACPI0013 with
> > GpioInt resources, and both currently fail to probe with "unable to parse
> > IRQ resource".
> >
> > Handle GpioInt resources: get the Linux IRQ with acpi_dev_gpio_irq_get(),
> > which applies the trigger and polarity and returns -EPROBE_DEFER until the
> > GPIO controller is registered, and evaluate _EVT with the GPIO pin number,
> > as done for GSIs above 255. GpioIo resources are skipped. On a failed walk,
> > free the events already requested and propagate the GPIO error (including
> > -EPROBE_DEFER) instead of -EINVAL.
> >
> > Tested on the HP OmniBook 5 16-bf1xxx: lid close/open run _EVT and reach
> > the ACPI button driver and logind.
> >
> > Assisted-by: LLM
> > Signed-off-by: Rahul Pon <theflyingrahul@gmail.com>
> 
> I don't understand the patch at all, but I understand that Andy or Mika must
> review it otherwise it's not going anywhere, so looping them in.

ACPI GED specifically is supposed to use interrupts only (hence the name,
Interrupt -signaled ACPI events). I think this one should really use the
GPIO signaled ACPI events instead and probably just has the ACPI0013 there
by accident. Can you share the ASL around this device?
