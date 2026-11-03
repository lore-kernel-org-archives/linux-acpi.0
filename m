Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728209;
	b=atmBmr1oDR1uXFr3u0Y/U5ubgQUHv7InuwDyXnmUBfRpQhnduTWTEtWev5yubRjFU/8Y
	 EkVUtyteaHnOXHk8E7V56MRvCavklPrMp6oW37VaCB5hyChVpNtMCy/e5F6mGT0kPyvUu
	 TAP58Cf1VijHwbUl20kQlWrXxqvLmH6zrvy3HsLv5wp8SVOzdRE/fCAunkAuhQ7yfsSSo
	 iQ9FlDCzHf4MyzO0buPx2wkqfV7ZDMqugIyqCXzX15sJ56JpJNEfBWVNWBfIQ+dD/7+4U
	 6rcrjPTN0kZAF07jC14TRSIW1N7kGyCrv0m7TrI/rdOvzU/pfn5QfgaeLdXamqcud2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728209;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=rK8Oyi1EVEyMMt2fZfOKvUCg++w38odpzGTd7OnPeuY=;
	b=SXyoTG+f1s4PCLyTWfzhlkOi/GVdLAp4Vo/a1ZmJ291qxzrHJXMH5UramVaUR4hB+cBD
	 2sR15tZ+rB20BO0uD4Qw8RgK2Q8dCRCAZZ2n3r1lcS3DgTIVD4i8XV9gZlWwFcnKERvEw
	 yERk2ZFCdEgoO5NqZltHRtPFagegOdY45138fDUUJW4ugosAQuPCbpBPN79pDOZaTQMXF
	 v2LwjyI2ZmAlIezeSnpIYGg5jArt4EbUcYWCpG8WtOn2pTq5CvbXQLHscN2t6GmSbdrMM
	 0uEIOX/eP4pov2MkY4Y1uoHBshcISUKrJnX6T3O2LTvFq5bsCs7+lO+cyG3AxdSK39g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EgCZqgSw;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87612606A31B;
	Tue,  3 Nov 2026 17:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87612606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EgCZqgSw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793728209; x=1825264209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vkMUZ8Mg4qCpdEUhz5E8ZLoH+xJDC3jv0x1a8OM3Wfo=;
  b=EgCZqgSwBiLhoz9mBgCyJjlKqSf6B/ddfjCx515MgmLiE6mj7yPJqdZ5
   jugw8TxvaF4OSU7YiZDm5zGl8m9YInT1xxQPPOTH4DB27ckRjhjgvOz0I
   5qFs/FSpvi15BISXxyJnHOFP6wiastKoP1NRT8SRUdt0GPsY9GeyLlYDZ
   Lrahl+ASodxa5XLDFh9E/oENTvUWtE/mjZbifREktxYTTd4J48c8XdpbE
   CVZqpW24sWaIJJc60xsmLv/KW5tEzKHwC9u7A9BsrBfxcA5BVWrDmhRI7
   ygFgEO8gvcbUV9wqfB2eTgfKH9yf/dfDJnu2udgHeQFSiYoI4yIBiDttS
   w==;
X-CSE-ConnectionGUID: SgwUSJDRTHuHfYVIz7swfw==
X-CSE-MsgGUID: i721Eu2VS8+n7EzYjMQSKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2354121"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2354121"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:50:08 -0800
X-CSE-ConnectionGUID: W8U5kkjERKmmqPh8cg97YQ==
X-CSE-MsgGUID: U12cYMDXTpeSN9n2zbd3/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="7014913"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:50:04 -0800
Date: Tue, 3 Nov 2026 19:50:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michael Walle <mwalle@kernel.org>
Cc: longzhao@ambarella.com, Bartosz Golaszewski <brgl@kernel.org>,
	linux-gpio@vger.kernel.org, Linus Walleij <linusw@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Mika Westerberg <westeri@kernel.org>, linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org, Long Zhao <zl020895@163.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 08/13] gpio: regmap: remove gpiochip before tearing
 down irqchip
Message-ID: <auoeysEHqGemmuhO@ashevche-desk.local>
References: <20261102-cv75-gpio-v13-0-4f93114ea204@ambarella.com>
 <20261102-cv75-gpio-v13-8-4f93114ea204@ambarella.com>
 <DMKL43ZCOSQ3.3TAJL8BRQ6ZTH@kernel.org>
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
In-Reply-To: <DMKL43ZCOSQ3.3TAJL8BRQ6ZTH@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 02, 2026 at 09:33:20AM +0100, Michael Walle wrote:
> On Mon Nov 2, 2026 at 7:46 AM CET, Long Zhao via B4 Relay wrote:
> >
> > gpio_regmap_unregister() currently calls regmap_del_irq_chip() before
> > gpiochip_remove(). That disposes the mapped virtual IRQs and frees the
> > irq_domain while ACPI GPIO-signaled events may still be requested and
> > while gpiod_free_irqs() still needs gc->irq.domain.
> 
> Maybe Andy have an opinion here. But that deviated from the usual
> cleanup in the reverse order and at least deserves a comment in the
> code.

Yeah, this is unfortunate. I think to make it work as proposed the IRQ domain
handling in GPIOLIB should be revisited. So, at least a good comment is a must,
indeed.

> > Remove the gpio_chip first so ACPI teardown and USED_AS_IRQ cleanup run
> > against a live domain, then delete the regmap irqchip. Use the same
> > order on the registration error path, which previously leaked the
> > irqchip when gpiochip_irqchip_add_domain() failed after
> > regmap_add_irq_chip_fwnode().
> 
> This should be split into a seperate patch with a Fixes: tag.

Not sure if we need a separate change here as two are coupled.
I leave it to Bart to decide.

-- 
With Best Regards,
Andy Shevchenko


