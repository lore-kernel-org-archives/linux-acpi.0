Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795450652;
	b=uUM+CoyQWWOn1LHfWrJjV7WcI5D2szmaaVKSrt+YlFO6pedHBh+/4QyVopGPQHzGOiae
	 s73HmR/jbM/bC3AMf22fbwKcUhMtnjooddb/hrV88hPMcmXP29YZTQERg1hea+mYILaji
	 /Yh1uHcVme3UzFXL9TLNiaVX6RBNOQs477GRHwZNY4G1auwxI6XirHxbZztxYUys+A2Sl
	 nNDTOm7KEsbeqiiN6CIQOvi6ssc7sxHSCRiR0dw8ESf3qM5xE6eGK/JvRJgpn4X/B/kFs
	 8QG+6sqahwQqXQMbI5OxBsElaJybcDVAzc++cosjTxyrrbrPv/ZEXCRO7fffykb4mdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450652;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=BctZxZhIdIRTeiVtsV2WTzSCZ0j/fyCHZmPwKEC+K5M=;
	b=cpEl7V41D7uea0hW1ulny6yrfJPf/9Jzzgpil3ht4zRdf407Ejxhyex2Vkz3qCd8T0EY
	 0U9Y+GXivdIXcqhKbIjsDKfJnxheeUow93SBPwSr+Ec4tRY3+SJ4+3AOS0nlLCO1KnzGj
	 AZnLbfsEc4hZNO9UfOjGcPEh3SfjuYvQ7+OaT1pgBJGcBzlrQNjHFA+MhQhxXR0ybJD1A
	 DAWj3FkcOI1aGU060s4y4VoqjGE+s5Eu8WgqTSNG3OFcaK+GNCD6dRMivgO90SpNbgQTi
	 WWRULEd1jM9txBTiVB1lXDrebotODF7DBEoAZ7ERJH6nXiN4TmHW/XPFyAbqHGotwnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kxMz9x8D;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA871606A31A;
	Mon, 23 Nov 2026 16:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA871606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kxMz9x8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795450651; x=1826986651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GOsvAtow4CHEx/fp/L9dAzHYy4b9WgH2aM55XWA3h1A=;
  b=kxMz9x8DS+4Skr8AGloG2oMrfbhR7wQF0qV4LpbHA2uQuKdzfnHfrBHP
   ljuPZW9N4ZqfDtJD9dWP1XYyzZitdmVwySnavI678mEDPzF54rHw24obx
   hHCuOQDJ4Rw4fuQsKCBqzkMLESw8XeyNfQtTMgaPwGyH2+jwwcq2SXfHc
   x11LQtaV2232jBoVoVklhzsuEqEF4OqW0B2TDbShBUcFhfhaZPRtrr+JE
   TivPOKC3v2fyYk96mNeC2zr6wR//CAWYmO5YmcFcSKhoV6ARQ48JE4aE6
   kyiNAnU+PNroHv3wTq5hkMsubxobkBikWHVL+ROCIDsg8MDeodOW55cfx
   Q==;
X-CSE-ConnectionGUID: gun2EC/vRgiZTNhDmxWYNQ==
X-CSE-MsgGUID: 7BvLn0PhRlOqFN4vBwU7iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4240243"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4240243"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 08:16:24 -0800
X-CSE-ConnectionGUID: ZOXQYvZCTa+z5mYAHslYCQ==
X-CSE-MsgGUID: +r6vlMnWSUueIc4LN0kq5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="13125051"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 08:16:23 -0800
Date: Mon, 23 Nov 2026 08:16:18 -0800
From: Andi Kleen <ak@linux.intel.com>
To: me@ahmedabdelfattah.dev
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: APEI: GHES: Poll error sources at their poll
 interval
Message-ID: <awRm0j8bBPrgMhw2@tassilo>
References: <20261119-acpi-ghes-poll-interval-v1-1-6f45cc65fd62@ahmedabdelfattah.dev>
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
In-Reply-To: <20261119-acpi-ghes-poll-interval-v1-1-6f45cc65fd62@ahmedabdelfattah.dev>

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 5d888c82efea..92d54c6b209a 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1276,7 +1276,7 @@ static void ghes_add_timer(struct ghes *ghes)
>  		return;
>  	}
>  	expire = jiffies + msecs_to_jiffies(g->notify.poll_interval);
> -	ghes->timer.expires = round_jiffies_relative(expire);
> +	ghes->timer.expires = expire;
>  	add_timer(&ghes->timer);

Makes sense. I guess at these long intervals rounding isn't very
useful anyways because the power impact is already low. It's more
for stuff that runs every few seconds.

Reviewed-by: Andi Kleen <ak@linux.intel.com>

-Andi
