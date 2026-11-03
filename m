Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728003;
	b=Gn7M0dZ4Tg/72ZD2YDNLPK5TaK0Obxy3Y3SiSNsJmcP52PTu/M6SKqK1EdAu/nMidzzy
	 j0I1aTzozeNULZEhFAjR1de3p2AX9RrMdKHJxzZvoLkh7MrViomSbDVkef8rZLdDe2Scg
	 uwSt/uyLkbINRa9xZPjU4J9fCkRO2JBTHgbRAdnMVfjRZBNBLnJ4cQBrvrswDvcFxzh/O
	 zMIBpqiaQPgNmkUurjGC1OJsK/F1QiUI8zmCzK0wuDQ1KyvwuJ5BFaCmd3/PuLh1Ht1Wq
	 KXh4tAFafQHo1SnOQNHFUvz1gaYXHxGBS1TtOSM30jsl5qRSza6LQj9xsMtZM2Axguw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728003;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=/dxNHrW6G0LpkFGwuqqn+AZVOo/NlA+DkY90dwAI/rQ=;
	b=n74NPx/822VB4Gxvs6gnSsOZ4AV40rjGxdIJl1Dl/6is27fk57oE/zyeO4co8ITwBErO
	 SpGMDOpzSdNgI//FefaBFUyEBZi8GzBbQ+40+Na1W5CVzChehUw0lP2OIjTMoFdCP9qu3
	 iOJJ9fX8mAv7VN8X22f5XMR+337WXN8P4ZvdgY9y9WOm4bFkRGYtW6pN5SVLGhxnPKgFn
	 s4+Ww00pvkT4jXtS4PHNHi5sUmQlNtdJVmQdSOE2ZpIRxVRC4U8HsO5mndOVJr0fV1J+i
	 PyRaGuLhNFP/mkgE5lR9eacWc/jZXidruiGRWsoenSFhGZdqmngSLOoYhuZznXPsVRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=itGMsRvV;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9453606A328;
	Tue,  3 Nov 2026 17:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9453606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=itGMsRvV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793728003; x=1825264003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8tWwkUcDgUwAlNlsNw/nuUJoQ+QTjblPWrHjviPkR8Q=;
  b=itGMsRvVxr1Q3nNbuhocA9ZNiFvVmAxZ3yXdlnssesRQUTYFAbSQ22cz
   +kfR368ncHU0iu4tZBMo+uDZFa/n8/3TWOX3RPqHhGN2CugVY+NNoL/3x
   rOsJOW+PdzjLOGha4NB2VEdWDqQ94bbuUfjuJSpi5oQ9bbFw5mBTfnbM8
   uEWdzD0U/dFse3eygo3mWj/Bup8n6IPiJCR4Y1OiSnh2KGpESsL+xf96V
   JhruHcuPZHqKZwFWHwBQKs2vjHQC6FmAA84NZ+qefNmQQ0KMeSPyc2qMI
   8O1os0qsunrUREI80zELzS3wITeCLGKDgNvmNOO/vWiwCFrXAA8w6mtg8
   w==;
X-CSE-ConnectionGUID: +I+Pow6ASIGXWPkBwurNYg==
X-CSE-MsgGUID: WSb8YOMTRS+FaBvDTPxiSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2341647"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2341647"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:46:43 -0800
X-CSE-ConnectionGUID: 2qmoe+4zTeqQJV9qvwrzQQ==
X-CSE-MsgGUID: Vd3mWcaoQmyREjgKNrE6Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6840336"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:46:40 -0800
Date: Tue, 3 Nov 2026 19:46:36 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: longzhao@ambarella.com
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Mika Westerberg <westeri@kernel.org>, linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org, Long Zhao <zl020895@163.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 08/13] gpio: regmap: remove gpiochip before tearing
 down irqchip
Message-ID: <auod_B2Aie6Tk7Za@ashevche-desk.local>
References: <20261102-cv75-gpio-v13-0-4f93114ea204@ambarella.com>
 <20261102-cv75-gpio-v13-8-4f93114ea204@ambarella.com>
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
In-Reply-To: <20261102-cv75-gpio-v13-8-4f93114ea204@ambarella.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 02, 2026 at 02:46:01PM +0800, Long Zhao via B4 Relay wrote:

> gpio_regmap_unregister() currently calls regmap_del_irq_chip() before
> gpiochip_remove(). That disposes the mapped virtual IRQs and frees the
> irq_domain while ACPI GPIO-signaled events may still be requested and
> while gpiod_free_irqs() still needs gc->irq.domain.
> 
> Remove the gpio_chip first so ACPI teardown and USED_AS_IRQ cleanup run
> against a live domain, then delete the regmap irqchip. Use the same
> order on the registration error path, which previously leaked the
> irqchip when gpiochip_irqchip_add_domain() failed after
> regmap_add_irq_chip_fwnode().

...

> Cc: Michael Walle <mwalle@kernel.org>

Use --cc in the command line for `git format-patch` or at least move Cc list to
be after the --- line. This will reduce a noise in the commit message.

...

> +#ifdef CONFIG_REGMAP_IRQ
> +	if (gpio->irq_chip_data)
> +		regmap_del_irq_chip(gpio->regmap_irq_line, gpio->irq_chip_data);
> +#endif

>  #ifdef CONFIG_REGMAP_IRQ
>  	if (gpio->irq_chip_data)
>  		regmap_del_irq_chip(gpio->regmap_irq_line, gpio->irq_chip_data);
>  #endif

Now it seems a dup, make it a helper, like

static void gpio_regmap_del_irq_chip(... *gpio)
{
#ifdef CONFIG_REGMAP_IRQ
	if (gpio->irq_chip_data)
		regmap_del_irq_chip(gpio->regmap_irq_line, gpio->irq_chip_data);
#endif
}

-- 
With Best Regards,
Andy Shevchenko


