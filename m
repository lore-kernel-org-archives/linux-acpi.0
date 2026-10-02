Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D4423ABB9;
	Fri,  2 Oct 2026 13:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790947373; cv=none; b=l1PozWkiQz3nrA6ArBcTzSNz9f684v4StJMxj3otJxbFHwXvcoXkBvuOR0XshFlDymhMeGRGFdPM/tMjrp15VbMMvr61WB555QcPL9u/N6CUhHvtxeYjyBTSbforNv8owFycQqypp+y6npZL9r8JiME2d6fzY1BPoFjxQpzT1Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790947373; c=relaxed/simple;
	bh=tIsGgTqElrBgHl6NxW+B0lJjLpxb3oGWkZ0/YfGtlrc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gKLnscSXKkDJm0v1K6OLxdU+X9Z2uVv1hjwCmi3FJdWaUqa+MBtr3Xl4Xqtr/B6iBvILsReJUmkYrPI9hncktE4W9wBDdHEyUQPowUmYwpc5bIkxlu/M22Xvmt7Kb61BOhDoCfx9Wxs1t4vZJIFz6zX5lIrLjMXADYr6caAbc8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mh504W13; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mh504W13"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790947372; x=1822483372;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=tIsGgTqElrBgHl6NxW+B0lJjLpxb3oGWkZ0/YfGtlrc=;
  b=Mh504W13yw9gOzuX1N0CAGBbAE8jAeb6RiA102oTWi5xhKihtG6JLGc9
   9H/zQCH4Zdpjup6SyoBWM+GjwwliaPgLNIEfUxpDM1PrwmbE6QWAl/bBE
   /Wj6kCswHYDdSL1j5+oS6UOZoK7nzepknvTAIPnLuc3Sbr31pWTd1XMzL
   ABN34W4L+U1ueNbYl+0Nawh2KUKBQdAEhWgtzOUaUKVjJWdPT3opSmTtf
   wi4nXyPhzCDP/4cU6d3DxTzmWIhmRL9Yw5YEaQSKkz0l0NqJe4Q8eoDkh
   fR3gXbg64F6eFbmwYZfu5Pz0dU/Q07ObwHRGA6YGGOUZR9MWhL4e05RMP
   g==;
X-CSE-ConnectionGUID: 4CXUTmtcSl2anNsTOlCbOg==
X-CSE-MsgGUID: 2fDDy3/xSuKjFrLtZyDiqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="109197488"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="109197488"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 06:22:51 -0700
X-CSE-ConnectionGUID: MvkPQMhLSTOQ84LMFcQM+w==
X-CSE-MsgGUID: AaAP2TaGSkOALEihSjsy5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="276299396"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 02 Oct 2026 06:22:50 -0700
Received: from black.igk.intel.com (localhost [IPv6:::1])
	by black.igk.intel.com (Postfix) with ESMTP id 7F84677;
	Fri, 02 Oct 2026 15:22:48 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <westeri@kernel.org>, 
 Abduvaliy Abdulazizov <abduvaliy.hbai@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261002101800.51506-1-abduvaliy.hbai@gmail.com>
References: <20261002101800.51506-1-abduvaliy.hbai@gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Ignore GPIO 11 interrupt on Acer Nitro
 V 16S AI
Message-Id: <179094736850.937323.6382789346592990432.b4-ty@b4>
Date: Fri, 02 Oct 2026 15:22:48 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Fri, 02 Oct 2026 15:18:00 +0500, Abduvaliy Abdulazizov wrote:
> On the Acer Nitro V 16S AI (ANV16S-41) the internal USB camera
> (0408:4035) works on Windows but never shows up on Linux.
> 
> The firmware drives GPIO 11 of AMDI0030 high to power the camera. The
> same pin is listed in \_SB.GPIO._AEI as an edge-triggered, active-low
> wake interrupt whose _EVT case only writes a debug code. gpiolib-acpi
> requests _AEI pins as inputs, which clears the output enable bit, so
> the camera loses power during boot.
> 
> [...]

Applied, thanks!

[1/1] gpiolib: acpi: Ignore GPIO 11 interrupt on Acer Nitro V 16S AI
      commit: 6da1f3437435c82eaa15b121022474bb358ffe20

Best regards,
-- 
With Best Regards,
Andy Shevchenko




