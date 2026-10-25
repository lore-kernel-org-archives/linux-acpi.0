Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792958228;
	b=1pHJeCIXSSyIlJVZajwVZR+Jrk+02SvdjkQaNqMN9nuT7lMzvLqEP94vOS8CKulxsZh+
	 c3y5D4zFmQB0viqUw4a+pflco26BbEr3iAxHl6rhND5xnCUhIJfjisadIu0mccyB63uZH
	 opPFvMwPNvnU27atoD56otgbH6C/FTYvP1CkPoP4D0rjvcFmu0kivMH8vzno/V8Gr6uAm
	 fgyGoxyri+SnTQPA94jI7h60LScPuBgQt1BKyT8Sw5Q3sduqZiT0+LgSLkX8VAlsO2Koi
	 7wdZWYHnneh4+MOk2i/y3U72B2M3wq2PT2AgiKw5e6v8K8kArVqsrzU7FVXs6ost0gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792958228;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=kahT6UbLfLxUV0ZyM6jJTb1DQHG/g3qj7Da815pW49M=;
	b=ZP/3Ui4JObtXOe6Kp4d6DDRkzLnmV5aFPyLaTx67+3WGVLOzlktYDzuPQNGUEPDFuqZM
	 b0OZiEJSIZFdiYk17kk3T7TY8QGGLwpAfVXnqAnFYcy8pLAtFFE7nhPt0e36U+e9mflTK
	 kJza5vakrawTKsIyOm/o2bt0nAMUHdbZA7ADIc/V+vihQhQndBkG4+Q383iBl2RvbJKa6
	 BJiI06TPaUZbE1esZqxy5Jc8QXBCFukLAakE06s7lhu+XRZJNso+mvKZfYTOmonIFp5NX
	 xgfVB2lyepyNz3hWQQ9PJoxuR2grFXEuhvbSZjTfl6BeLElJ8WfY24vWIpUZUQmLt/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kVo58MIY;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D37D606A31B
	for <linux-acpi@vger.kernel.org>; Sun, 25 Oct 2026 19:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D37D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kVo58MIY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792958226; x=1824494226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Itg3E6wxul5ZzBAEIwOP4hFrI8qZ07e3ooOi1BLe/vc=;
  b=kVo58MIY41Hf5bOiFZA1Nr4kQkW37pDysymUOiyd8+sGXdf/uBJwi50a
   zRz5bmJZufU9sM3jE8qbDKG4YkSUHv+Pie5dB3AQ0jh1thBQlmADhiQoo
   Cc9wWNaLz301dQj5fKNB8u5nZSGHfxSWQ/7ZlPi9ipbhWnSTI73NOPjBh
   EHO31nd5VfIHWuDVE11B77e85n9krIkUrp93hdyTCwtOA9/pZUUASHmNL
   blmvT3gf4kyin2P+TGsq9kD6flf9uX8ROn2s1h1mm5dC4RRDeUeg+GVGE
   0izn6mV5LtTU2i9Dj07na/jjmA/f2d9FXKhJQQa6aDbmY3kewryg6zhsW
   Q==;
X-CSE-ConnectionGUID: 15KqJxf+RzyksYlGP+F0Vg==
X-CSE-MsgGUID: jSwctnlmRVWr5dj4vcfV+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1716834"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1716834"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 12:57:06 -0700
X-CSE-ConnectionGUID: pfCSJCymT4mGYkHlAYbtYw==
X-CSE-MsgGUID: J4vlRyMmRAqgBr2Rwc3Y/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4191644"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 12:57:01 -0700
Date: Sun, 25 Oct 2026 21:56:59 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?iso-8859-1?Q?Sebasti=E1n?= Luna <sl140998@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, tony.luck@intel.com, bp@alien8.de,
	guohanjun@huawei.com, mchehab@kernel.org,
	xueshuai@linux.alibaba.com, maciej.wieczor-retman@intel.com,
	pawel.chmielewski@intel.com, lpieralisi@kernel.org,
	sudeep.holla@kernel.org, catalin.marinas@arm.com, will@kernel.org,
	sunilvl@ventanamicro.com, andy@kernel.org, westeri@kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI: resource: Add AIR SRL CX307XX to
 irq1_edge_low_force_override[]
Message-ID: <at5fCxGcAiIwFfnm@ashevche-desk.local>
References: <CABB517KGWdM2xb+h6y41sWXu_NsRTjcmZuaVWALTw-NKbSS20A@mail.gmail.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABB517KGWdM2xb+h6y41sWXu_NsRTjcmZuaVWALTw-NKbSS20A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 24, 2026 at 05:25:54PM -0300, Sebastián Luna wrote:
> The AIR SRL CX307XX (board name CX30000, BIOS 1.09, Ryzen 3 3200U)
> describes the PS/2 keyboard IRQ in its DSDT as:
> 
>     IRQ (Edge, ActiveLow, Shared, ) {1}
> 
> and the MADT has no Interrupt Source Override for IRQ 1. Since the
> kernel ignores the DSDT IRQ description for IRQ 1 on AMD Zen systems,
> the keyboard ends up with the default ISA settings (edge, active high)
> and receives no interrupts: the i8042 counter in /proc/interrupts stays
> at 0 and atkbd logs "Failed to deactivate keyboard on isa0060/serio0".
> 
> Booting with acpi=noirq works around it, but then the internal touchpad
> (I2C-HID behind pinctrl_amd) stops working.
> 
> Add the machine to the irq1_edge_low_force_override[] DMI table. With
> this entry the keyboard and touchpad both work without any kernel
> parameters and the i8042 interrupt counter increments normally.
> 
> Tested on the CachyOS 7.3.0-4 kernel (drivers/acpi/resource.c is the
> same table as in mainline).

This is similar to what you send a few hours before. There is no version, no
changelog, no nothing to understand what's the heck is going on. Also it is
mangled.

...

Slow down, and do not send anything for a while, please. Make sure first
everything is set up correctly on your side. When you will be ready, but
not sooner than a few days from now, send a v2 of the patch with changelog,
that has to be located in the comments/changelog space (after '---' line).

-- 
With Best Regards,
Andy Shevchenko


