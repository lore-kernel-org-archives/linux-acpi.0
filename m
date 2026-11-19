Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795074123;
	b=VjbsifJfp2xuysEGAh4/1E0GUMaNWZ//pq27uNl/lfeah6dkWmm9rlOrBiO1UT5w+gEy
	 YjBTLysi8vdXTVLSkk0ZYV3oC69vxcSszoyn5rKYRooZ7EamUjN91bfMoy29zmqI5X3Le
	 lrbBYue9m+vGBmKY7gheGETWh4NUtMk/5lRyV3cZ3c21bw5T17kXx8QFOWe886/x8h8GO
	 10jG88huWXysdkYL0DMy2+JxFFWtxVz/15gzm2TrHwxwkNxv8pGzi8eDwp0bM4EzWlN+s
	 orXJuUDuuA58HoNuLH1go/rbMqUZ9reoRut88kunbvtzBal034Zf0bqkOX3pPFc8Plg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795074123;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=DPA4QPvvKXXRJR1BnFpBBw8xRGoRxKY425nAdlRlCtg=;
	b=QjocRo+RROFtqox7ZDvhzIoGmbqgXLAf3VZNSa3PD8W81mJjQPDJmAm/SxtqIgIcGZBl
	 UGK1ass+l6N1U3+6I75GJQsw03op5pZzS9E/GOH+ChixHYeiGIPBjx7ArFqXpYgmf8mbH
	 fsjy3SJrPSiZQ9Zs7gFtAHgkTV+12M7ub804avFHTSzXeMuKTFbxedz6rskD17kQp0bQH
	 DZMexPugdH86zEbTb1f2UzjOfxr5ujP2xbwMtp3DEN9BafpBh55ZhF+5qb2aAKXuIOqks
	 gXqP7WjqmPBVWAo3lzGB0yMrhzaDkYZoOwdJeAZ3XeX7bWeFExxLtN87YnAUoG3Lp7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="BGqy/KbK";
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93739606A320;
	Thu, 19 Nov 2026 07:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93739606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BGqy/KbK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795074123; x=1826610123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mJFDbRth82D7LvE3TJIt9B4iX0hay27kcRbGseFOyOY=;
  b=BGqy/KbKP5y+P+JiSom1FC19x96UFLd+Xu2C0sumMC/j5VL+UJrj70Xj
   TCJuccB7q2wHNGlmmnVzAQBvnrtgAEXogVQfHbZidUKMu63+qqfY2xWUU
   1YVgX0pQzUad17z5pICIKiArTaJj+hY4s5ZR5GjZVYG+ZlA3jVuvbLt7J
   6WdvqsFwK8o2adtsfxKgyg5MYTMAr5VC1gswZTfGn3bDwvi6l9+7hzlm3
   FNrE4cg3kNgDDegqkWalbViihq6VVM+lv0r0+ylKRSMgwWx5SO/TdxxCZ
   PAKia1szUUngWU5vhh+bcgfU6557ifHRcivFc2OTV9yyhG5EawHCdzCH6
   A==;
X-CSE-ConnectionGUID: jjgNVvrHS1ymPzX1tjquhQ==
X-CSE-MsgGUID: aH+m0Jd8T9KLJSg3Hy2ekQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3962677"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3962677"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 23:41:53 -0800
X-CSE-ConnectionGUID: Ao5xCaAORjqsg8/XJcEAEQ==
X-CSE-MsgGUID: Pry+TRldS6yibQZ56xXMcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10358501"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 23:41:49 -0800
Date: Thu, 19 Nov 2026 09:41:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: longzhao@ambarella.com
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Mika Westerberg <westeri@kernel.org>, devicetree@vger.kernel.org,
	Long Zhao <zl020895@163.com>, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v15 09/14] gpiolib: request ACPI GPIO events for external
 IRQ domains
Message-ID: <av6oOow5yYodizSc@ashevche-desk.local>
References: <20261118-cv75-gpio-v15-0-e3c563673fe1@ambarella.com>
 <20261118-cv75-gpio-v15-9-e3c563673fe1@ambarella.com>
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
In-Reply-To: <20261118-cv75-gpio-v15-9-e3c563673fe1@ambarella.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 18, 2026 at 03:42:26PM +0800, Long Zhao via B4 Relay wrote:
> 
> gpiochip_add_irqchip() requests GPIO-signaled ACPI events after
> installing the irqchip. A gpiochip that gets its IRQ domain through
> gpiochip_irqchip_add_domain() never goes through that path, so _AEI
> events, such as the power button on ARM64 ACPI platforms, are not
> requested.
> 
> Request them here as well. gpiochip_remove() already calls
> acpi_gpiochip_free_interrupts().

This is part of the bigger issue with IRQ domain registration AFAIU.
(See patch 3/14).

-- 
With Best Regards,
Andy Shevchenko


