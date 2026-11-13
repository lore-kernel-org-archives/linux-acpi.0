Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585673;
	b=IrPrTTaX3yXVTkO1B37XVM6uQNaZINq/arltRbRkSYH5SoN/VhVcAehMcKalJpdZ64zK
	 d0hGShJAe9yoqdkP1UeHv+DxPTGENuh11M6bDlNA3eOt2UJCeKpfw6uexZmcQqD2q8OHO
	 IQTK3qVIqXcfDBvj1baAheagJf4pSXjaO99/xs5VPSQc83OfUrZtVh9Es9GwREJnZ90EK
	 FvHULuwuqwEF11wZSt4cVxPFNukuJEp8AsW7B+Fl/nk/7Thh6g7T/qUbAC5C1JIz1Hd6c
	 7YM2IYXeS+IUMloB5Ttbv6mmKxFAxN/NmbfNSZlYOagGyMOZ0ikP3GwdaC7wmdilxjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585673;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=tDquF4Hyj3CEOl1BaUh2pG5lCjxkZA/JX9VcRxZibDM=;
	b=Il/KH4DqJ0me+ntbzur195A5Sgg6fBd9rpcephpHdDfFaRTMsiigMdUgL8pg3Qfw8I+b
	 Q6e0JfsSAyUSoAtsScOfU55/zNOtbP3BJ9ZvOebi881ISWD9Eg/P2955Nrq5p5aMiqdo+
	 4RMp6o7ns3Jh+3d+seu2bSnMvdvs0K5UYw8fTBTwf/gar5rssDE7jWxviubxt8GLbKdPe
	 +494W91WwuqiePm2QAFWuZ7ZO+6LbBB83jcakIlTALNLPNLBPmEtM+mGqU4Coa3siTWM4
	 bAvJg3JtVH051guplQoYGC5HOsZHXB2jJvAZry1UtEOOu2RPqOcI8byBOcsvWFWpZ9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="ary/ck7I";
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3741E60744CB;
	Fri, 13 Nov 2026 16:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3741E60744CB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ary/ck7I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794585673; x=1826121673;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=YG7WmtTH7eH/TRYWGKZhEqx8XmC5j5XvTISTGO02pwk=;
  b=ary/ck7IH4hV0TTsWMp+nYxh0QKKRsHioBkEvKaabif5TWPSm2RTyV6L
   PxhbETql6x6+3NqF9AGTV8ioRRWITOoME+qTQasybazFjfpXWGHiDzyO6
   C36PPkILbKTEVVO08DySSb1gvi13C51KlPuCr0H61PhIaMIck7/rMX6sE
   RiXLQ9PEbavPyaWaMMIGOnIhV58FwFkp8s1FUgsRQbrYhcnb6NUm0ceMh
   g65ULNiK4XOrVqRBUVEs7VkGFkTeTOl7R3/vBZ3OFvQHMrv83/lE4plup
   FpKuARNMrEGdVxl5Zln2Nalo5Ejs9vejxRCZHwAfXKKXIyQ2JyEY6CJai
   w==;
X-CSE-ConnectionGUID: u11ABXT7Tiq4pqHf3voMCw==
X-CSE-MsgGUID: 8Gci2kG5R0+BNpZaDpEJ3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3493316"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3493316"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 08:01:12 -0800
X-CSE-ConnectionGUID: bPhvzQduTSaESd0DpamkfA==
X-CSE-MsgGUID: iuvrwAL6S+iVWY/tM+JzbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="9040375"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.214])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 08:01:08 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Armin Wolf <W_Armin@gmx.de>, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
 Han Gao <gaohan@iscas.ac.cn>, Han Gao <rabenda.cn@gmail.com>, 
 Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, 
 platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-riscv@lists.infradead.org
In-Reply-To: <20261112134905.6100-1-johannes.goede@oss.qualcomm.com>
References: <20261112134905.6100-1-johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH v2] platform/wmi: Allow wmi module to load when
 acpi_disabled is set
Message-Id: <179458566259.7950.1578678353634598585.b4-ty@b4>
Date: Fri, 13 Nov 2026 18:01:02 +0200
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Thu, 12 Nov 2026 14:49:05 +0100, Hans de Goede wrote:

> The core wmi module provides symbols which may be used by other modules.
> These other modules may still function when acpi_disabled is set, but
> the current behavior of acpi_wmi_init() returning -ENODEV when it is set
> causes loading these modules to fail because the wmi module these depend
> on fails to load with -ENODEV.
> 
> One example of this is booting a kernel with both DT and ACPI/WMI support
> on an arm64 systems with devicetree which will lead to acpi_disabled being
> set. Trying to load the amdgpu module will fail in this case because it
> uses symbols from the drivers/acpi/video module which in turn uses symbols
> from the wmi module. Note the video module itself already contains handling
> to still load when acpi_disables is set for similar reasons.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/wmi: Allow wmi module to load when acpi_disabled is set
      commit: 8ab84b8e07ce3988c4fafbb9c622ec9e12e3b065

--
 i.

