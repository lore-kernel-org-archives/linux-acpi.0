Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724873;
	b=UQTcl6mhkFK/oLrpkR05vaibzW3BHqvbQAvVbXDiIR+JrkJ2rwBv+Uzp/lfV2jtF/Jq8
	 HEbpc7Z0U5l4zHfhH56bmQq/QMjBTaiXdo6y/FELTbLeJiC4G+TjRfhCKH3JEKGAkfuom
	 bjdDZMijcUC/kGHzT/hVS+CYP56b/OEz9FvwJPSqDoipHht92eW2rsSc2WP8Qm2KrohrA
	 GLYI6hpuujekeBRmi1fV05uFBdgrbIS9pYQKkZGI/nNFZ3cODYPRM8AE4xRgQpm/vsTKY
	 XegDEo5q0A/LuLVIv73UMcq2sxWjDNoJrLTSqK/YCJbDDLq04Rno/dxU1ufQOYglI2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724873;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=WD2GWrHxGNQECop37VP/Xf/Pf2MMXPl5ygD4L+CMi9g=;
	b=bdnJpvXheVJAxPyC2YTUd1wggYWDg+WWAEj+3h669kcTn1WjdqrUb8EAAIdQbSIJOxUf
	 6+Ykv3+zRR25UOMNucIRtSF02aCZyT7j5jfKQbmx0zWLxSETPcY6moJRcewRIMjp057gT
	 +jWP4kZfBMaM+AloWwVeWURbUe7h7m0Lcs5QE35uYpjOK5NXZy5bwlgLWZNt0QXYDVQg1
	 3U5HsbtOP6M4dNNRYFai9i0iA5wprud3kAI1SKxGJOG7K7buxqc1X0TN8B/qYDXhX3Pcp
	 6t0do5/Lqp4hMWQ6hTeKtyeMNlLHP7z4xzBECy4snX/JqcH1hTCVTaa5BRNG0HFc+rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J2F6WBWX;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559A6606EEAA;
	Tue,  3 Nov 2026 16:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 559A6606EEAA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J2F6WBWX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793724872; x=1825260872;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zGItpx+XsrdALmEsBycV8i25IwA6vjMLwIUqW81fqJE=;
  b=J2F6WBWXbLJBR3spy1VtPiKGfQHYqglx4SRwTyZcMCxoN5kTy13sXsNf
   OMpMErJgMqwUTCPC77csGYChFdhOBt5MlCxqAhmhuaQ1SUmaZzIKvSgsX
   kwKxual7/eiviTSTofES6H2mKWmixxVRT57Voh7DEphtF0dIAxkTG+e79
   tgCZPcRw8kwwShXX9+hokix2WKSX4sw5hVwWusVjMGYvGUHaThILIgxzQ
   eOQPOv19+ouRWGnLTI+mSp9GlLV3PvfTAgB6mw1K/cOYh+29V++a9mNVc
   g98yZR73h18ybHxKp1AhvFJL3fNtbphgRPxBtUWEtLmSvfXgzdD3YwX4p
   g==;
X-CSE-ConnectionGUID: p7I1yhG3SkOLtjgI5kdRWg==
X-CSE-MsgGUID: JLZ6G3ACT2mqTCy9K18QLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2351112"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2351112"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 08:54:32 -0800
X-CSE-ConnectionGUID: ElKpCDeGRoGMohprU6iHYA==
X-CSE-MsgGUID: 8ERzto85RWWYdWBfMOrcTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6820418"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 08:54:27 -0800
Date: Tue, 3 Nov 2026 18:54:24 +0200
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
Subject: Re: [PATCH v13 13/13] gpio: pl061: use string_choices helpers for
 IRQ trigger logging
Message-ID: <auoRwOBuoxz94haW@ashevche-desk.local>
References: <20261102-cv75-gpio-v13-0-4f93114ea204@ambarella.com>
 <20261102-cv75-gpio-v13-13-4f93114ea204@ambarella.com>
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
In-Reply-To: <20261102-cv75-gpio-v13-13-4f93114ea204@ambarella.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 02, 2026 at 02:46:06PM +0800, Long Zhao via B4 Relay wrote:

> Add str_rising_falling() next to the other str_* helpers and use
> str_high_low() / str_rising_falling() for the level and edge debug
> lines.

It should be two separate patches. Otherwise LGTM.

-- 
With Best Regards,
Andy Shevchenko


