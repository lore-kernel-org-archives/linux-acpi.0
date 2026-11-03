Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707138;
	b=LYVpsuI+5cSg05tUaEuTIujp8kSGtY7S3Epmupftjgttuf0BfGAIghCFUruAIOWZtYFH
	 7dz0a6nePW6UkC1g+mzobUqm8FNWtdhgOhj5XPwFJKqdsZJ66OTf+SMt+wohrnE+fg0EZ
	 ZRLoU+K3oVR10kdv17nGia8/ZiCHNxrQvLcSkte8wU3+x4cj7Nwjj26jIF4WHZHCUe/XO
	 WBoOJPDRIAgOX6wm4bJJIo/3+mlH3KzW8zUUnyh69DLaS+Vb7Yhze62QUI5lnkxPjMyit
	 BaHstyuSyznZLK7OfLhLLC7mbwFRNfd9+Mx8OZk3gYbbilmsGQlYHHHAtWMvjV5svpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707138;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=qpvyviXlID8uNVyHZE6wnGhYmpIoIVVOIzz6sMnLrv8=;
	b=VlViKkqnPpygvY7ebozyPAqXqY55DN8Hriju1YPNOAoyZ/L7vLZrD1Nh8nWWQv+oYjTS
	 8lAlnhLdqMBYm8f+qbQchbNBIsgKLhH/nFaGw7d9UCN/NJ1dSLkw6V1vBAZUUkwhXLoUb
	 3cElvG8x8GJRNQ8XCmbFMUTBDdvcJoSuKRXZRDRp8SQv6VwbLECGBZfPjhHmYPHLcnbgI
	 GjZR3n4VDW3Caddh+agKPkLkvU1Uyt9FK1nI+FBKQmaVQim0Zu34t+gzyKcIH2Ovd2oa0
	 iqzLU74qzOjNl36BQTlUoqk1HtOVtWK7wPaMn8FR7sjCQPv9j8p57SvwYZTMUK8p31g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QyaiQLen;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E5E606A326;
	Tue,  3 Nov 2026 11:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89E5E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QyaiQLen
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793707138; x=1825243138;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LjepnItfHAR2JK8YVXjy9fiac3M0l5w1kC9Wmf6b8vM=;
  b=QyaiQLenJwpmF/4iCNFeXVh2YXFuKl+VoFntVAXG4nFEYBujdAOQXEcm
   uLRTx5sh52Etxu+AgqHncW7Ew1c0OBvzy36KLWSC2AAdyzLdjyw0wxbYK
   iIdQmOVsIBIyxYe29bnWa7jiG9WK/Ti0h+ekFIC5k68N/SRut2CKnssY9
   rkZkf0+8/BVEot6CX7HMzoQE5L4zKaFMRAzTTNvUYm+StdEKhLaPhCR9l
   B1cllJM8xQAxhRcW3kPwXTVIAOYeSsTz7WSCAUr0rODn6ZcnNPuO6e3Ok
   ATjwzZ433qTHB2132IX5KUD/gaQw9ct4lqgay3VFXFDkOHP4jCkfqwmfE
   w==;
X-CSE-ConnectionGUID: yT6mX2MVQjaShrriMtPjpw==
X-CSE-MsgGUID: J4sc4oFPQWajw1MpbRRGJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2437418"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2437418"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 03:58:56 -0800
X-CSE-ConnectionGUID: cE4qeZEiSLCzv7/JTLVHuA==
X-CSE-MsgGUID: FFpnA7LXSua669K6W4eriw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="8253668"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 03:58:52 -0800
Date: Tue, 3 Nov 2026 13:58:49 +0200
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
Subject: Re: [PATCH v13 09/13] gpiolib: request ACPI GPIO events for external
 IRQ domains
Message-ID: <aunMedCPibzJsfUi@ashevche-desk.local>
References: <20261102-cv75-gpio-v13-0-4f93114ea204@ambarella.com>
 <20261102-cv75-gpio-v13-9-4f93114ea204@ambarella.com>
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
In-Reply-To: <20261102-cv75-gpio-v13-9-4f93114ea204@ambarella.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 02, 2026 at 02:46:02PM +0800, Long Zhao via B4 Relay wrote:

> gpiochip_add_irqchip() requests GPIO-signaled ACPI events after
> installing the irqchip. A gpiochip that gets its IRQ domain through
> gpiochip_irqchip_add_domain() never goes through that path, so _AEI
> events, such as the power button on ARM64 ACPI platforms, are not
> requested.
> 
> Request them here as well. gpiochip_remove() already calls
> acpi_gpiochip_free_interrupts().

> Cc: Mika Westerberg <westeri@kernel.org>

First of all, Cc is a dup when other trailer for the same person is present.

> Cc: linux-acpi@vger.kernel.org

Second, move Cc: list to be after the '---' line, it will reduce the noise in
the commit message while sending to the same list of people.

> Acked-by: Mika Westerberg (Intel) <westeri@kernel.org>
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

...

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

In such a case where is the freeing these requested interrupts?

> +	return 0;
>  }

-- 
With Best Regards,
Andy Shevchenko


