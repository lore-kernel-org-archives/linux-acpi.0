Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795087697;
	b=F+c1BsWTi0PHVmqt4F1gt32xOEIQJ7VMtWm94v0/iruV1W0NY+yCkw/UVF2wCdb9676E
	 IxjdJSvNirMps+4MrOvmjTpPvjHptwJIOxdDuzKrYKGzhruPV0CGtXnjUMW2WWWUqjTQJ
	 LCXqSckEvYSquehKIMUCb4A5SJA/34+60jyFpwwCcHV219MjM4dML+BV7Fvgj7PjJftiZ
	 qf+44CqanxiWP6vvzh23QxPOzzifAUqA6QZx2hWDGtTLVAT1YN6gHlWFkvJLpyI9vvD6s
	 kURb2SPHRxyC6LYsJZMgi0fO7ePICCl+ePV/HhMw41oQF7QNSjyxLFrvXErR/0pkmfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087697;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=I9IZpEuKdy30z/laMq6VgQ/ff8xsRDsSsvVHK8RAiUA=;
	b=n+ckY9hSB+jbFl728tCQVd6QfqFdiyZkAuXUS8kozvCtpZqiAGWsJsOhlQoH16BZF75p
	 Pkw45v5djvVLEze+AUeNCH1Ze1Jm7uYka14QjEftn/+IB8oDGs5Td4rGWRcnjrkjBOOg+
	 KqBg4/H+BLISwcOKSwmOcdcTFXw5dZlmXrk3fwofp/1h64hfq/JqqP03aO5LY0aoALvcM
	 iLMZND/8v4YQo9PKAOW0JtTWQ95UzVOwSUbSE7mpNZFZjcx33PFACgcj3VFDWiqlFC3/+
	 4syHsoy+snU2YMSTmBK2YDMPXxJSJ9tDWlh4+m+YjumQFyU1LuxuzbRIeebdJfaAs8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EASLygj0;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47360606A320;
	Thu, 19 Nov 2026 11:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47360606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EASLygj0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795087696; x=1826623696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x8JIk0shBz8EIyvL5Um8PdXJMheRiJqG7MuESXeeplg=;
  b=EASLygj0gz6no4QhTctieaUjJqW4zQfZ989/6N+5/WrkzTLgJA1ys+IL
   fCYZ2ifR6SOnI/0sys0epWYqUJc9eXWfqehDJ/lkxYDqmW4eVUCrX0FDC
   XW0VpQhrYFTrYGpNil5Fr7MObLxARpMdbz/kzTC5MxgggDDKur6eDh0sn
   U6WezThwNGS9JnlT+hb0pTpozHHBTi2YCpKZ7RYnjqFeAbVxCDaBlYkG6
   jN5MBGhutAl/aGMLik6xaqfZrFmEq0lzhrTN3NPQeOZl/lvThJ75c+xOh
   3xwSmQwUcoW/l1NVI3KKeUx6Jx5CQKYflMdQ3xdQPaC/Bdm0qhkXyvNXD
   Q==;
X-CSE-ConnectionGUID: +/lHNuP9RCWWbx7hL2vCgw==
X-CSE-MsgGUID: elQ/uqPAR0yU5pQMMq3ehg==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4012063"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="4012063"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 03:28:15 -0800
X-CSE-ConnectionGUID: YCIq1ZkKTWKxLbFf9JdF6w==
X-CSE-MsgGUID: +zircxRYQx6IBWFmrerOvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10542922"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 03:28:13 -0800
Date: Thu, 19 Nov 2026 13:28:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Yao Qi <xnorigc@gmail.com>, westeri@kernel.org, linusw@kernel.org,
	brgl@kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add ignore_wake quirk for ASUS TX Air
 FA401GM
Message-ID: <av7dS9vfX6Kyss3N@ashevche-desk.local>
References: <20260808155513.2221976-1-xnorigc@gmail.com>
 <aoqui1OfwEfsmQRu@ashevche-desk.local>
 <a89e95e2-abaa-4ea4-9be2-2a179f6f5257@amd.com>
 <aplgRRCxGEC-ahyw@ashevche-desk.local>
 <7f0826cb-13a8-469f-a098-c7212efa26eb@amd.com>
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
In-Reply-To: <7f0826cb-13a8-469f-a098-c7212efa26eb@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 03, 2026 at 08:44:03AM -0500, Mario Limonciello wrote:
> On 9/3/26 06:55, Andy Shevchenko wrote:
> > On Mon, Aug 24, 2026 at 10:12:18AM -0500, Mario Limonciello wrote:
> > > On 8/23/26 03:25, Andy Shevchenko wrote:
> > > > On Sat, Aug 08, 2026 at 03:55:13PM +0000, Yao Qi wrote:
> > > > > The ASUS TX Air FA401GM experiences immediate wakeups from s2idle
> > > > > (Modern Standby) when suspended with an external HDMI display connected.
> > > > > 
> > > > > This issue is caused by spurious ACPI event signaling routed through
> > > > > GPIO 24 on the AMD GPIO controller (AMDI0030:00), which triggers a
> > > > > system-wide IRQ 7 (pinctrl_amd) wake-up interrupt during sleep.
> > > > > 
> > > > > Add an ignore_wake quirk for GPIO 24 on this machine to prevent these
> > > > > unwanted wakeups. This has been runtime-tested and verified using the
> > > > > `gpiolib_acpi.ignore_wake=AMDI0030:00@24` kernel parameter.
> > > > 
> > > > Mario, can you ack this one?
> > > 
> > > It's likely very similar to
> > > 
> > > https://lore.kernel.org/linux-gpio/20260821070651.39763-1-vaknins33@gmail.com/
> > > 
> > > As you can see that's also GPIO pin 24.
> > 
> > Right, but this will need still its own DMI entry, will it?
> 
> Right.  We just need to look through the acpidump to confirm this.
> 
> > > Can we please see an acpidump to confirm though?

Yao Qi, do you have a reference to ACPI tables (acpidump) for us?

-- 
With Best Regards,
Andy Shevchenko


