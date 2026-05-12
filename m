Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0B2379C27;
	Tue, 12 May 2026 07:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778570736; cv=none; b=ECemgb2JaAXdLlKCNQYfqPWjWTinSD/BM+kBraeEhmUj8GAdiewC1ciyNxjHjg6subqRgEvliBLPFp7V7DKnPO56CfyUVRVc/i0CehKBOzXfpobY22o+uOXQ1vycthvJx+8blngszcZftmLZftk/Ew9ElGEl838i6oWmzVZZPx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778570736; c=relaxed/simple;
	bh=PeVOJjCFZ8afC7E8cxhQ0xbeqCctf6NNU/R60vKAtBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PiElhCowz91tqpNi2KI7zDDOXK8IFv3dpFB4F2CYM1lVOxWfQLKaldAOdQq3YCCOdMREpaeRRq35zysNVJX8Fv69sVV6QEJpq6c6Oy+fEfiF9UMRhuQJjtOd63U9QpisSN8LFTRoduj6/5JtAWrBnfKcZJbzYz3GFcW3y/zBbLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YB9GisrY; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YB9GisrY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778570733; x=1810106733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PeVOJjCFZ8afC7E8cxhQ0xbeqCctf6NNU/R60vKAtBA=;
  b=YB9GisrYrntCCvu5i1+TJDia95+vIeObs8WzLHuQrBxB8IfiCTUtNYAV
   tXNPfqoDREY8nbQ9xSb4zlMU+fzRMh9E+N/hXcnbWjkaD6eQLgLP0IvAK
   h/58npQcd9MO8HwaF/vE9IxfDadBNjCh/8yRKD2Cxa8MdVYZn1/errH8y
   1sTytFS+bbJTnMI+//N6NQSyGYGFNIv5/rPUzYAn9jQJkPWU3WMDUwdLA
   gculBORt8fLvzN0t/VnsmfxXOwMBFMRZFxqtWqUnPWXWPsPizbb3LrWtc
   YiSJVQM7+RhkcJM+h/5HwzbpElTtZkys+LyzmGebMm/PAOF4nMbrKpBHx
   w==;
X-CSE-ConnectionGUID: DAYVxT5QQs6oebnjvAIzPg==
X-CSE-MsgGUID: BoOWENa+SMWt98QJfZwzeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83088526"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="83088526"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 00:25:32 -0700
X-CSE-ConnectionGUID: Qub24myqQcO5Lh1e6PFbVg==
X-CSE-MsgGUID: 04MBYrdYRgSGIUiGj3R/ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="237930127"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 00:25:27 -0700
Date: Tue, 12 May 2026 10:25:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Denis Benato <denis.benato@linux.dev>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Jonathan Woithe <jwoithe@just42.net>, Robert Gerlach <khnz@gmx.de>,
	Matan Ziv-Av <matan@svgalib.org>,
	Kenneth Chan <kenneth.t.chan@gmail.com>,
	Mattia Dongili <malattia@linux.it>,
	Jeremy Soller <jeremy@system76.com>,
	Azael Avalos <coproscefalo@gmail.com>,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v1] platform/x86: Check ACPI_COMPANION() against NULL
 during probe
Message-ID: <agLV5STILBnNNfWH@ashevche-desk.local>
References: <5990022.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5990022.DvuYhMxLoT@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 11, 2026 at 09:48:26PM +0200, Rafael J. Wysocki wrote:

> Every platform driver can be forced to match a device that doesn't match
> its list of device IDs because of device_match_driver_override(), so
> platform drivers that rely on the existence of a device's ACPI companion
> object need to verify its presence.
> 
> Accordingly, add requisite ACPI_COMPANION() or ACPI_HANDLE() checks
> against NULL to multiple platform/x86 drivers that have been converted
> to platform drivers from ACPI drivers recently.

> Fixes: 578bc2a53ae2 ("platform/wmi: Convert drivers to use wmidev_invoke_procedure()")
> Fixes: f7e648027d7e ("platform/x86: asus-wireless: Convert ACPI driver to a platform one")
> Fixes: ba19eb10170b ("platform/x86: asus-laptop: Convert ACPI driver to a platform one")
> Fixes: 3a96c7915d93 ("platform/x86: toshiba_haps: Convert ACPI driver to a platform one")
> Fixes: 553b2ac59fbb ("platform/x86: toshiba_bluetooth: Convert ACPI driver to a platform one")
> Fixes: 246d6cefe525 ("platform/x86: toshiba_acpi: Convert ACPI driver to a platform one")
> Fixes: 19ebacfb442b ("platform/x86: dell/dell-rbtn: Convert ACPI driver to a platform one")
> Fixes: 80b8f68b94ab ("platform/x86: system76: Convert ACPI driver to a platform one")
> Fixes: de6837243af0 ("platform/x86: panasonic-laptop: Convert ACPI driver to a platform one")
> Fixes: 6da22b031a3c ("platform/x86: fujitsu: Convert laptop driver to a platform one")
> Fixes: d5c9212ccfaa ("platform/x86: fujitsu: Convert backlight driver to a platform one")
> Fixes: bd13b265d386 ("platform/x86: fujitsu-tablet: Convert ACPI driver to a platform one")
> Fixes: 8507277ef132 ("platform/x86: wireless-hotkey: Convert ACPI driver to a platform one")
> Fixes: 3471415c8186 ("platform/x86: topstar-laptop: Convert ACPI driver to a platform one")
> Fixes: 138db7ee58c0 ("platform/x86: sony-laptop: Convert PIC driver to a platform one")
> Fixes: 14004dd31caa ("platform/x86: sony-laptop: Convert NC driver to a platform one")
> Fixes: 2d9cb20610f7 ("platform/x86: lg-laptop: Convert ACPI driver to a platform one")
> Fixes: 8a44bd3ffdb2 ("platform/x86: intel/smartconnect: Convert ACPI driver to a platform one")
> Fixes: 163a68a31f74 ("platform/x86: intel/rst: Convert ACPI driver to a platform one")
> Fixes: 079b59fd2d79 ("platform/x86: eeepc-laptop: Convert ACPI driver to a platform one")
> Fixes: b30a462720ad ("platform/x86: acer-wireless: Convert ACPI driver to a platform one")

Looking at this I would rather see the series, but am not a maintainer here and
I'm fine with the result. As a single patch or as a series

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

>  static int acpi_fujitsu_probe(struct platform_device *pdev)
>  {
> -	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
> +	struct acpi_device *adev;
>  	acpi_status status;
>  	int error;
>  
> +	adev = ACPI_COMPANION(&pdev->dev);
> +	if (!adev)
> +		return -ENODEV;
> +
>  	status = acpi_walk_resources(adev->handle, METHOD_NAME__CRS,

Don't you want ACPI_HANDLE() actually? (Note it's not directly related
to this change, but perhaps a material for further improvements.)

>  			fujitsu_walk_resources, NULL);

...

> +	device = ACPI_COMPANION(&pdev->dev);
> +	if (!device)
> +		return -ENODEV;
> +
> +	pdev_info.fwnode = acpi_fwnode_handle(device),
> +
>  	status = acpi_install_address_space_handler(device->handle, LG_ADDRESS_SPACE_ID,

Similar Q here. And some more drivers seem use handle in the given context.

>  						    &lg_laptop_address_space_handler,
>  						    NULL, &pdev->dev);

-- 
With Best Regards,
Andy Shevchenko


