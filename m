Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779996;
	b=xeNChHr5Zw/+POB7oPMVh+x/U1sJwZRJw1B07n4njrtozahUClomGd4eg7SagpXZexli
	 UmhiJnqQ5EyOeeOUgJZsX2twoXtMrsMhozfV9+XcApxM7+oF4p60V6U6P+dG3PKDx2C9A
	 jE0BepfJcRGIhsUR4Kk9Jc+P+gwOFqfuJm+3PE5LfrzTEJPHBWb64ofymWfASfw9Vr67u
	 ieefIi+YE+IYVwGtyXp7jwgTXGvR0UcQPxim7nedpUzKF48N3PVVQJ4u8kNp9Xz2KWVYg
	 d3mr1N0tla64mcXptC0sT9j00t1jmum6bF+RlhrL9ZpuD4EoU9xnouKDX4khTeRUx+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779996;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=VSJSZYFCIg5xzcQK5N1FpOOz2dqwieADpLYnMs+55W0=;
	b=Cvsu8CS8Dld8aGxVBgr5kgZdjvtZE8+8rY+2YAXdbbo4on5Z0woEFBM+35w432584SKE
	 4n/2WIgGyVtZDZW9d9i04LQLebIHTW+beymnIEcKg0kEmyMgIpyUOIq8t5wEIr6tCX+bL
	 CIaCMNt2zZQFzjOLri8GoGwsJz+P/hmH1lyAvakVOIw/t8TTJyCKSm6LTABWrYi3/+0jo
	 81e7dq8vd3r0Ehh8Hzhu3s9bHPM/w/RHVOhlWRMn2XTU3NQkZiuS0YoRxoA3a/2L3FsYc
	 nG6QuUDeWIcBaYqgjS4CLfZUA8259gpv+KXvwSY0fKPL7t7hATJU7DrYNCrWbhMR6Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Uh440XR3;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A78606A33F;
	Fri, 27 Nov 2026 11:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20A78606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Uh440XR3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795779995; x=1827315995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LVYcptX2xDr9+GNz7qsLrHcJURHUKzzQUseuFFgmkmk=;
  b=Uh440XR3xnig1nn8lCz/6oXRqYvIXVDLwRSkDDlAKAhizQvWyoAI5CvA
   c+Me2+A7Q4GQYk/use+0RpwYXmmLd/BYgAaNvt0T9ivpw67XQ8aN5duC2
   VFf0UVkMvcHYFahRL1Bn8t+2aRFKdcjEioPtY2U3hyby8mKqH1kc1wsIx
   pi8nKJJTtItvXxgRnmGq37DejCWRrVNAimSREWeFYykxvcPkE9a9VR2Gw
   MwGD4A7dySyNRrEpaFjqgz0d0/I8/1xYKr1bMqZd+85IJ2QhzkdbbIoqr
   hGZVXSgYtkqGYo2wSFf5TiRnHsxipW6v9SPsfLwr7KZB89EcIkF4+IFvy
   Q==;
X-CSE-ConnectionGUID: aZEIMlPaT72aRBfw1U+PJg==
X-CSE-MsgGUID: e+zsrgEMSd6t5IWSTJHZPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4708986"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4708986"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 03:46:34 -0800
X-CSE-ConnectionGUID: io3XVtZqRMGNyPi/7TGBXQ==
X-CSE-MsgGUID: qqaE1NGWRqmRrkocRjk/DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="12639678"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.115])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 03:46:32 -0800
Date: Fri, 27 Nov 2026 13:46:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] gpiolib: release the chip's own lines before
 numbing it on removal
Message-ID: <awltlfkwFWv8O4pG@ashevche-desk.local>
References: <20261127-gpiolib-ownlines-v2-0-aambrozewicz@nvidia.com>
 <20261127-gpiolib-ownlines-v2-2-aambrozewicz@nvidia.com>
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
In-Reply-To: <20261127-gpiolib-ownlines-v2-2-aambrozewicz@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 27, 2026 at 09:49:26AM +0200, Adrian Ambrozewicz wrote:
> Commit 5018ada69a04 ("gpio: Move freeing of GPIO hogs before numbing of
> the device") made gpiochip_remove() free the hogs before it clears
> gdev->chip, so that gpiod_free_commit() still calls ->free() for them.
> ACPI event lines, ACPI OpRegion connections and shared lines are still
> released after that: ->free() is skipped for them, and the ACPI event
> IRQs, already freed by gpiochip_free_remaining_irqs(), are freed again.
> 
> Release all lines the chip requested for itself, the hogs included,
> after the chip has left the device list, so no new lookup finds the
> chip, and before the numbing. Move the numbing into a helper for the
> next patch.
> 
> Reproduced with a test-only ACPI-style event on gpio-sim ("Trying to
> free already-free IRQ" on removal) and a shared gpio-sim line on arm64
> (->free() skipped); with this change, neither.
> 
> This depends on "gpiolib: shared: remove the proxies before releasing
> the shared line".

...

>  	gpiochip_irqchip_remove(gc);
> -	acpi_gpiochip_remove(gc);
>  	of_gpiochip_remove(gc);

I need to look closer for ACPI bits, but above doesn't sound right. Why
of_gpiochip_remove() is not associated with ACPI counterpart? Wouldn't it bring
a completely different experience on the same platform depending on the
firmware in use (DT or ACPI)?

...

>   * gpiochip_irqchip_remove() - removes an irqchip added to a gpiochip
>   * @gc: the gpiochip to remove the irqchip from
>   *
> - * This is called only from gpiochip_remove()
> + * acpi_gpiochip_free_interrupts() below finds nothing once
> + * gpiochip_free_own_lines() has run; it is for the error paths before that.

This doesn't sound right either. Why the common method of freeing ACPI event
interrupts can't be shut down here and this one called when we need to remove
the IRQ chip altogether?

-- 
With Best Regards,
Andy Shevchenko


