Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079045;
	b=J6DTmRJIub9QTGSDggXvjo45CbratGv/A8t9jD2a7Ts7sWQfDpsC5HuypoICnNsIyCKt
	 DizFuRDjGUuh0uG9V32ir7DW35HC5lON1H0C4QeKbUed1XJTHJk54BB9MsdMgFsa8Q5QI
	 L8yfo2x3XN4qyxlHn0erdDYDH2QnrQUJoOb90+DBmVSxRBLmwIRE9+nK/cgaPofJEPVNL
	 AJHVOzyN7ONrMQ0LihD2VJKXOhyMhKkK3CrsYqFIetjZizZAKfTJgA3CQWB133YDPhPfN
	 pyRo+9uRkn+D0gu7x8yHMBUtap74owoA2sUjtVN38SkS6EcN6Rw7dhhWK+EkpUyIWVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079045;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=bI0ZDEugVfoInLkWTnkv29Sk5KHKc3K9ILUm+SD/dc8=;
	b=CtVPUKlAK+xUjWOkiOZxb2ZZTKAwHPHrduA9tVF+iliUvBw5P62K36jwjF9mRDCMw8Jg
	 FY7YH1uz4H6/h2gIzh4fGYEhjxS1NPZqe75hg5ljlKlNfQsVEDHHChXp192D8XIBcPgI9
	 EewvhOqhyj/0Qyu00FPG8AE7hHXhhg2G2TwNeCrmLPFIkZ6rXSVF5/6g6bsSkNzFr7h3V
	 L51RvLuYT56bi9VLnCoAV6OQfucOyAbRLgjLKjLQRBtFhGfd0Q6CFhSm/vZuhNp7nToKA
	 ahU3OiBxm96WK1z71AwZLhe9wzR23WiTM04ubTPEEAGvJLw5d8/7Ibk4ky9fCHTXcQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="kK1oCF/w";
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB62A606A31B;
	Tue, 27 Oct 2026 05:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB62A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kK1oCF/w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793079044; x=1824615044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2WpjaTFHROeNXncH1sB7DMvCxdj1XpNG8d7YiGokm/8=;
  b=kK1oCF/wY9JGdW1etPEL0kpVGrkOrJ0GUHOU9yzvC+V0h0Mb1T8/V7J5
   Sj/S38c57eUn4IE4ILDClCGZfSAKhaA83M3EtS5/2p/x2v2uWV3b/JUIV
   l0KZ8AawTfhGTJO/VZShTBOvuJqViY5ngAFqUoQY08T75v00VZABvoe1v
   lROlo8uEqCYgMvd/VxrJbEyieH8wD5difJBHLYB7rwL9EtXyMjKMnjVfR
   sskPseG9NnIRmPwt5qD/3+Ug431HUEY5o+mq6BIKzhF6BLMqN9H8DixTm
   sAOs3yfa1gQYn0sWLDpM4gdOQoKExGqVUCrfIj76QFeC7V4jZbC3X90CD
   Q==;
X-CSE-ConnectionGUID: ZFM7za1GTZ64o9wqqAXXfA==
X-CSE-MsgGUID: QKTLVurTSgGJlXQXuSZWZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1780757"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1780757"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 22:29:58 -0700
X-CSE-ConnectionGUID: XidpNHlySEySvMSHywRj4g==
X-CSE-MsgGUID: kzsLSwvqSuGockY+XdVgYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4326428"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 26 Oct 2026 22:29:55 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id B7BB399; Tue, 27 Oct 2026 06:29:53 +0100 (CET)
Date: Tue, 27 Oct 2026 06:29:53 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: longzhao@ambarella.com
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Long Zhao <zl020895@163.com>, linux-kernel@vger.kernel.org,
	Mika Westerberg <westeri@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v12 08/11] gpiolib: request ACPI GPIO events for external
 IRQ domains
Message-ID: <20261027052953.GH158991@black.igk.intel.com>
References: <20261027-cv75-gpio-v12-0-c22555400e18@ambarella.com>
 <20261027-cv75-gpio-v12-8-c22555400e18@ambarella.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261027-cv75-gpio-v12-8-c22555400e18@ambarella.com>

On Tue, Oct 27, 2026 at 12:18:55PM +0800, Long Zhao via B4 Relay wrote:
> From: Long Zhao <longzhao@ambarella.com>
> 
> gpiochip_add_irqchip() requests GPIO-signaled ACPI events after
> installing the irqchip. A gpiochip that gets its IRQ domain through
> gpiochip_irqchip_add_domain() never goes through that path, so _AEI
> events, such as the power button on ARM64 ACPI platforms, are not
> requested.
> 
> Request them here as well. gpiochip_remove() already calls
> acpi_gpiochip_free_interrupts().
> 
> Cc: Mika Westerberg <westeri@kernel.org>

One tiny comment below, other than that looks good to me,

Acked-by: Mika Westerberg (Intel) <westeri@kernel.org>

> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Long Zhao <longzhao@ambarella.com>
> ---
>  drivers/gpio/gpiolib.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index e5fb60111151..63c51d9ee0bf 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2353,7 +2353,15 @@ static void gpiochip_irqchip_remove(struct gpio_chip *gc)
>  int gpiochip_irqchip_add_domain(struct gpio_chip *gc,
>  				struct irq_domain *domain)
>  {
> -	return gpiochip_irqchip_add_allocated_domain(gc, domain, true);
> +	int ret;
> +
> +	ret = gpiochip_irqchip_add_allocated_domain(gc, domain, true);
> +	if (ret)
> +		return ret;
> +
> +	acpi_gpiochip_request_interrupts(gc);
> +

Looks better if you drop this empty line.

> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(gpiochip_irqchip_add_domain);
>  
> 
> -- 
> 2.34.1
> 
