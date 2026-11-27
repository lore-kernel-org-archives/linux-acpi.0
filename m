Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795794176;
	b=nuYhcws/ZyDzrNgND9/y26I602Nf2zPeBwhGGipNxc3PM66Rg/CKSEV7iGNAXc/lEwrI
	 gDZaORqvccPzDpOaH/LB3WoY1DZAwjIDYNfg8H4g/2fC0L+S6DvTF3swMFGlhHIayVRBI
	 6I6H6xc373MoqRl4XKN9A93Y9HBUntvHSHHc2EajtJeTTyqWCWbdhg3QRfN7N3tql8R44
	 5TO4Q8j4b7MzpvgD6Y2lm0aMzcaKwQUlBH5/55STlQiutBpTAUl6zA4kzay4nrKas9Q5C
	 WDIqBGSoAwP5pdiMMuhm/M98Eb+iC/G6L6d9P+jGU+g5XQWTnS1KqdqcjDErS0evt4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794176;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=OV2n5pxa5jJDsl6ZNt1F2bG/AP7YeCoOJ/QFDfKpbKA=;
	b=MZDHog8ClKKK0G/+vQbw/nT/Bk8S0MqFLAxIGPGysfH9Qd4YIhV4iIGuKTO99n88rG6O
	 fszTRDRS77CP67GyEeMuznCxbyVI9E3UOygm/9veW0EY4AgP0mNYlCA2ukh0RtnE4LeiT
	 dqAS64qp4LImNv9RrfkoHHSYttPs4NFHNrON0F+ls4Qz5vlto49x3rXWgG+leMeCpaqhS
	 kBg96FFCyu8zP4JQAjBIVz5KM48Bg1o/e6trmPoL0d+1KYpOgJ52FQtDBK2NXu3N8HEVb
	 EQ9ysyelX9tXTlf4DKg+sdfI6ERyPmoR5pNWwInihG824I4Q9Cee/PPBZwwhCYZI2Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XFjdwkHp;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40FB606A31E;
	Fri, 27 Nov 2026 15:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C40FB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XFjdwkHp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795794176; x=1827330176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zianHThyPvkAVR9BQPrSJltJpqoR7uriQ3b2GnIuynw=;
  b=XFjdwkHpnLlTaxQnW//NMvBlShfd4b/HcZZP69kRq58VBMfDQdrDE8St
   bEq2h6pgUmyecUkKriVrZb7CmS357C7VfpoyyoD7E/3MSOFxgl4r4j2c9
   H7S4PK4/onyvWSIFPCbXfwoZBIaACpA5Q3HEbB1I+ccR6MO34g6/0T8dD
   SLv79j1IvUbzYnCZ7TsZL2B3s784w0ICD1i4NJeaphJWCX2bynrjNHsa+
   oGlEUbKY04R394wtxWkpcd8JaSeG+Z4ls2ifRHC9mERzRNwIgzbDzq1CZ
   tBqxu37YJYD5sCjROk2rnA1TwOe8sGQAu60RbwdtFXrv/OBzc5Oj3sIPK
   w==;
X-CSE-ConnectionGUID: sAEqj8rTQHOTksXRaKbPpw==
X-CSE-MsgGUID: AHXBT0KQRLqdDV8CeDTrag==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4620573"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4620573"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 07:42:55 -0800
X-CSE-ConnectionGUID: z+B7l+ODToiG4kg6U2qD3Q==
X-CSE-MsgGUID: h9sYtBs3SmyNxEnyvK5L4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="12287977"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.115])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 07:42:52 -0800
Date: Fri, 27 Nov 2026 17:42:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] gpiolib: release the chip's own lines before
 numbing it on removal
Message-ID: <awmk-lfmMw8GG21o@ashevche-desk.local>
References: <20261127-gpiolib-ownlines-v2-0-aambrozewicz@nvidia.com>
 <20261127-gpiolib-ownlines-v2-2-aambrozewicz@nvidia.com>
 <awltlfkwFWv8O4pG@ashevche-desk.local>
 <20261127124429.3423977-2-aambrozewicz@nvidia.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261127124429.3423977-2-aambrozewicz@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 27, 2026 at 02:44:30PM +0200, Adrian Ambrozewicz wrote:
> On Fri, Nov 27, 2026 at 01:46:29PM +0200, Andy Shevchenko wrote:
> > On Fri, Nov 27, 2026 at 09:49:26AM +0200, Adrian Ambrozewicz wrote:

...

> > >  	gpiochip_irqchip_remove(gc);
> > > -	acpi_gpiochip_remove(gc);
> > >  	of_gpiochip_remove(gc);
> >
> > I need to look closer for ACPI bits, but above doesn't sound right. Why
> > of_gpiochip_remove() is not associated with ACPI counterpart? Wouldn't it bring
> > a completely different experience on the same platform depending on the
> > firmware in use (DT or ACPI)?
> 
> Thanks for the review. acpi_gpiochip_remove() releases the OpRegion
> connections with gpiochip_free_own_desc(), which skips ->free() once
> the chip is numbed. of_gpiochip_remove() releases no lines; the DT hogs
> are freed by gpiochip_free_hogs(), which commit 5018ada69a04 ("gpio:
> Move freeing of GPIO hogs before numbing of the device") already moved
> ahead of the numbing. So both now free their lines before it.
> 
> To keep the two calls paired, for v3 I plan to split the OpRegion
> release out of acpi_gpiochip_remove() and move only that ahead of the
> numbing. Would that work for you?

At least it sounds like a better idea.

> > > - * This is called only from gpiochip_remove()
> > > + * acpi_gpiochip_free_interrupts() below finds nothing once
> > > + * gpiochip_free_own_lines() has run; it is for the error paths before that.
> >
> > This doesn't sound right either. Why the common method of freeing ACPI event
> > interrupts can't be shut down here and this one called when we need to remove
> > the IRQ chip altogether?
> 
> The event IRQs cannot wait for the irqchip removal: the numbing ends
> with gpiochip_free_remaining_irqs(), which frees them, and
> acpi_gpiochip_free_interrupts() then frees them again ("Trying to free
> already-free IRQ"). The irqchip cannot go before the numbing either:
> the character device frees its IRQs only after it.

This sounds like something is wrong in the cleanup flow. Why double free
appears in the first place? Is the acpi_gpiochip_free_interrupts() call
placed at incorrect function in the tear down flow?

> So for v3 I plan to drop acpi_gpiochip_free_interrupts() and this
> comment from gpiochip_irqchip_remove(), and call it from
> gpiochip_remove() and the error paths instead. Is that what you had in
> mind?

Perhaps. I can't see it clearly in my mind, maybe when v3 is out it will
be more obvious.

-- 
With Best Regards,
Andy Shevchenko


