Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753C93191BA;
	Sun, 23 Aug 2026 08:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787473555; cv=none; b=UDu8L/N33fRwepc1zH0L2RDxY2PAMfcwj+/s/RSIlYh0t5BpAwbRur/XnMV5sefmsR9A5MQMCL/24ybZzN52gWp80zd4h5Z2IsYP1garl83OHoE4ZT/tyW6zo4S0daW8Umel2buAnoZsOf+okya/FhEDnwqdAVFZj0jp9gSIxaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787473555; c=relaxed/simple;
	bh=Lj9CikgnquCWU0U4LdnqEiXb1E3uwIvVLfQ8UwZ41g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ds0gH71Oaf5vLJp4Xs918vHTlNz1QPon0Ndw4AI0q5S6PJbQHwEFrIATDvjU6a0uqGfZ8wpJs2nWiSYl03ZRZhvdHfVqA5Z1xGMJ/HeS2hGNDVXXNhwkDeITvmXAlGLlUIwm7YwJRXeHiQzQHoi5KCv6FFrLfAcvqElX/NGB3ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XYjqBeHI; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XYjqBeHI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787473555; x=1819009555;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lj9CikgnquCWU0U4LdnqEiXb1E3uwIvVLfQ8UwZ41g0=;
  b=XYjqBeHIqpCd5jZ5LUJimtx+zi6TJlRWn4TYuiDrWplwcwevbgic2w4s
   t8gXrpe+Rmb7ehOjtv+R8VC122khO7NxmGnP08E6/0IEBKu18/EPaH8+2
   jaRBm/aLNaffjRaBjhGdo1mj5asZ5ml8OJaDZVWPtZYgwUGTLzWymJ0dP
   7Noq3FFkGFcoZ+gCiwb57a1kSoHWWP0MCMfg0vds2fWD8CtjXuTttOHff
   YgWgqRqG4RmEsMwfWK02sjnrpf4/2NejpSbSH9oJAHAfMn+OXW0khZABJ
   Al4JaWENmJ0/xE61m2QpHX1kgYzN9TgdBJ2x8dp8D2HsvxpepdoC1ccYa
   A==;
X-CSE-ConnectionGUID: XrEUTFo8S9CxtBuZpybIeA==
X-CSE-MsgGUID: 6Q/NqpptSDWPRaybP1WcVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="88012635"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="88012635"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 01:25:53 -0700
X-CSE-ConnectionGUID: 1gqSY8vGROSPu8QHxyAiKg==
X-CSE-MsgGUID: PQp5c7E4Spm1jtnUIU1gwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="267301260"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 01:25:50 -0700
Date: Sun, 23 Aug 2026 11:25:47 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yao Qi <xnorigc@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Cc: westeri@kernel.org, linusw@kernel.org, brgl@kernel.org,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add ignore_wake quirk for ASUS TX Air
 FA401GM
Message-ID: <aoqui1OfwEfsmQRu@ashevche-desk.local>
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

Mario, can you ack this one?

-- 
With Best Regards,
Andy Shevchenko


