Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE2A3A16B8;
	Sat,  8 Aug 2026 19:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786218158; cv=none; b=LzMzvCaKKnpffJGGHEevQlAFo2ctwzIKpWLUWejJlcLfrliCfkIyIl0/HKRMb3/s3ZUqKzXrk9sMiG6xx/tM4CQIEaQf4sCnEnhbVg9MxF269haZ6gKHn595uFc+3x8JtGE12EGKx+hSGVwC23WF85vw9Yj3j4tn/wVImEaMgNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786218158; c=relaxed/simple;
	bh=a4OcAdqrCX6y0kPXZFtZr84ZjqS+lZJOOiA7oR5U0bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgRcT3lJYX0gtS2NqUABBjwaeKgeUCdQhCjQTEqTnNiCV/+NZb6TepHPkcrZ/yAvGm6rpxS5TQFEFpWhhYHjr7PVS43GiEjnQqdSA+oTXVr4es9yiliKUCR6y6aIZv1eWn4t6mOPOrMIS17+NXrkPal4cNu1SjeFpw/GWYSZ7dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GNKEVdAi; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GNKEVdAi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786218156; x=1817754156;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a4OcAdqrCX6y0kPXZFtZr84ZjqS+lZJOOiA7oR5U0bM=;
  b=GNKEVdAiiCD071qdIi47g4Ly7UI0ZL55RqS2Lf55MOeUod9Z2WisEBbt
   M9bf3IAmOfip1maC71BltfX05K6ne33cr40R2fvBEtJamdat9HQtyQVHL
   kCz6MkF/V4RB0ZRGdM7yguv6SktAjuJiytQNivw79f/PfJXmhhJzNliNA
   P0eVkCwBTvflCmKsYyiZQ/NQcgyCpg7Jba8luYHSkEmc1GGcE29J3gUUZ
   doGjPAOxRJxd+kMsCiBNmK9dkbrkrHZ+nehU/5TgrYpbpeMokvbjbdtbx
   Yp/Q61pqIf/8aHS+dBk6IeB0JADafbLA41hkoMriuyvpPqvUBnWyXfbWS
   Q==;
X-CSE-ConnectionGUID: JIxFP/tFQ4WOU45Uy8Kegw==
X-CSE-MsgGUID: 8Zcvn/5PRb+E3jYUaCTJBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11869"; a="97141785"
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="97141785"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 12:42:35 -0700
X-CSE-ConnectionGUID: YDkSpz6FSUKmrUsfPSkgww==
X-CSE-MsgGUID: Bh6wZ5dQQxCQiJA3ZHAVWg==
X-ExtLoop1: 1
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 12:42:33 -0700
Date: Sat, 8 Aug 2026 22:42:30 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yao Qi <xnorigc@gmail.com>
Cc: westeri@kernel.org, linusw@kernel.org, brgl@kernel.org,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add ignore_wake quirk for ASUS TX Air
 FA401GM
Message-ID: <aneGptJn8J7eF9tj@ashevche-desk.local>
References: <20260808155513.2221976-1-xnorigc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260808155513.2221976-1-xnorigc@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Aug 08, 2026 at 03:55:13PM +0000, Yao Qi wrote:
> The ASUS TX Air FA401GM experiences immediate wakeups from s2idle
> (Modern Standby) when suspended with an external HDMI display connected.
> 
> This issue is caused by spurious ACPI event signaling routed through
> GPIO 24 on the AMD GPIO controller (AMDI0030:00), which triggers a
> system-wide IRQ 7 (pinctrl_amd) wake-up interrupt during sleep.
> 
> Add an ignore_wake quirk for GPIO 24 on this machine to prevent these
> unwanted wakeups. This has been runtime-tested and verified using the
> `gpiolib_acpi.ignore_wake=AMDI0030:00@24` kernel parameter.

If AMD people will be quick enough to tag this, I will include in my PR to
Linus W. on next week.

-- 
With Best Regards,
Andy Shevchenko


