Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D234F799F;
	Mon, 19 Oct 2026 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416653; cv=none; b=guXJBm2kkI5hsBHlPo9G2Jnf2lYD+VMxMhmit8azhNRo9LHWs07yqz6YPB64NvjoOaFc6BDbaYK2CjDGJJgfX3IYoT1kqg2lirDmEka47WI+iGo40ixq7696iseMUdlELVMCTr7nhQIh1JRF0Vmsk2MATw/Xvtv058LAGuSc3wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416653; c=relaxed/simple;
	bh=NICBlbvM48ZtCIEZlB+lOpD2bf1G/B+sFnO1Us3u1vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCFWJt2o7Tcp3pPVfHDKcs0091ZlVz8W9M5yRW82bNDDvrJzjxfOsVAnUL3oeSv2ApTrL2as1THz2rcHI17rczSZ4gpoC2qBPbP6X9SNB3DdUTdYrs56n1tMWCjA174sl3WCu5pnhLEOBBTT0TpWIOWXpS1gjjj21V+BbwIbGws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZDbTzUV2; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZDbTzUV2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792416652; x=1823952652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NICBlbvM48ZtCIEZlB+lOpD2bf1G/B+sFnO1Us3u1vg=;
  b=ZDbTzUV2NvWx0oHOIKzPm22Cfqepk6SyIFHcyBcetJQwTwShkmu+INyx
   GxgJDvXAMoOt+XurYkEozD+zfWBzro6vPiDqqShYrjvTlledJToPbsECV
   SZrWKi4Uc8Rpqd3nGfoxHM/hHtdic7wjpGiXDPNKBaNXo7MppeMVTYlqY
   o2+k8rMpMSKfh0UzQfsirE+6Hn3Id+mtWZ2hPp+PKyFsKLAG7P4q5H2LG
   gsRdQwtVJdW0RFLX/QTRIEodLIzlVKQyeGzYXmxSfNyb0Tfb/n0a3JsRN
   7bYs9NFisXfeuqGnkNpNuzJ0NwPJEVgLgx0Q02mDuRWbQLgU+DJJbGjqv
   A==;
X-CSE-ConnectionGUID: xAs1Sx7BQzanoxcyRuW10A==
X-CSE-MsgGUID: /g2wJqD8TcOKF8sO8BXAWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="992379"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="992379"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 06:29:16 -0700
X-CSE-ConnectionGUID: KFJG4IO2QwKHVrAoUn1LNQ==
X-CSE-MsgGUID: SdPv2i5VQ/aJUVz6/JJSig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2637797"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 06:29:14 -0700
Date: Mon, 19 Oct 2026 16:29:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Mika Westerberg <westeri@kernel.org>,
	Abduvaliy Abdulazizov <abduvaliy.hbai@gmail.com>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-kernel@vger.kernel.org,
	Trijan Koju <trijankoju11@gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Ignore GPIO 11 interrupt on Acer Nitro
 16S AI
Message-ID: <atYbJ4ByzDb1mlOQ@ashevche-desk.local>
References: <20261007120944.1705014-1-abduvaliy.hbai@gmail.com>
 <179239686600.5748.7808377662325552771.b4-ty@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179239686600.5748.7808377662325552771.b4-ty@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 10:01:08AM +0200, Bartosz Golaszewski wrote:
> On Wed, 07 Oct 2026 17:09:44 +0500, Abduvaliy Abdulazizov wrote:
> > The Acer Nitro 16S AI (AN16S-61) has the same problem as the Acer Nitro
> > V 16S AI: the firmware powers the internal USB camera (0408:4059)
> > through GPIO 11 of AMDI0030, but also lists that pin in _AEI. Requesting
> > it as an input cuts the power, so the camera never enumerates. On this
> > model the same rail also powers the internal microphones, so they do
> > not work either.

[...]

> Applied, thanks!
> 
> [1/1] gpiolib: acpi: Ignore GPIO 11 interrupt on Acer Nitro 16S AI
>       https://git.kernel.org/brgl/c/5a088d1b7266249e7701a94fc90fc829d1ad5ba1

You actually applied my PT to for-next instead of for-current...

-- 
With Best Regards,
Andy Shevchenko


