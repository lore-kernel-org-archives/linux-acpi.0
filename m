Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ABA384CCE;
	Mon,  6 Jul 2026 15:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352821; cv=none; b=oqLIeBG94K46+8wXozzmvWgyp3idsWwbiCAkegnN6AIf6le8m8kRn57EyJ2dYLu411eyYBHerq3jLVUDBeShJ/nyfwqDb9SFbf7d7Z3U164owR0pMbudzCS/iZgm6ZQmELnpGYpZL61EpNKWR6J03kak61Dnqfu0IOtLc0Wi6iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352821; c=relaxed/simple;
	bh=8gYUW4D5wdjnaNNxOz8ev6lcg7g56HvaCKpukKDgbZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnhTSUkhA+Du5BZqBo+4fAwi6a8vz4pbAB01TN8EUdW4d5+dEr5vlvUVptJOSkBPvu6ESLqlBXGjKgILehiyckEhADCxlGXHMx60E+dXBfu2Vx4E3vr/KrAd3oqWd8T1w06EbF5X/3yOSA9Y90Y+IF7AVXMl0hQ+hwA5uOAZABc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oJFSLeBQ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oJFSLeBQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783352818; x=1814888818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8gYUW4D5wdjnaNNxOz8ev6lcg7g56HvaCKpukKDgbZk=;
  b=oJFSLeBQcVY3dUnqGjv16/1Ve4oOVEjoLhgl+go8eGT0k2k9A1tIHVed
   0HTJ5ABmLhFdAaIp5OwQ4zfx4XJW76w50RtmHY+cuKr4fwwfVY42A1Opp
   nbEfV8QXCYQ5fwenBIsup0htCszKHqWNeTz2uBshg/ZUNCP05+1kCsgfb
   SlD3+YGAF6+OfULiyUTYxaUPCI+DkGVXp1hSZKldqNGRbC/vPMnLmnckP
   AX/hOX4MJQveq0Q7KQXkpCALNJsGXiAaBSXD+pMvwNgbuK3rRci4mEeF6
   BZoWN8GMoBAy51umy/+kRFQSR3xwmfeyH7VV9YiHr4P1k74oX4hnqfFVy
   g==;
X-CSE-ConnectionGUID: oURiiWBiRKWvmH0+l4wlMg==
X-CSE-MsgGUID: NHAFWtsESTGVscz5xuJTBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83097974"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="83097974"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 08:46:56 -0700
X-CSE-ConnectionGUID: Zp59iAOJQ1OrewfxGjH2VQ==
X-CSE-MsgGUID: HuMDZ85fRNm+tLOkf8qc7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="252679141"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.48])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 08:46:53 -0700
Date: Mon, 6 Jul 2026 18:46:51 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Chen Yu <yu.c.chen@intel.com>,
	Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [PATCH v1] platform/surface: surfacepro3_button: Stop setting
 acpi_device_name()
Message-ID: <akvN6-V7TOuwG4c2@ashevche-desk.local>
References: <6036011.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6036011.DvuYhMxLoT@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 06, 2026 at 02:28:56PM +0200, Rafael J. Wysocki wrote:

> Since acpi_device_name() set by the driver is only used for input
> class device name initialization and printing a message on probe
> success, and SURFACE_BUTTON_DEVICE_NAME can be used instead of it
> directly in both cases, make the driver do so and stop setting
> acpi_device_name().
> 
> No intentional functional impact.
> 
> This will facilitate the removal of device_name from struct
> acpi_device_pnp in the future.

...

> -	input->name = acpi_device_name(device);
> +	input->name = SURFACE_BUTTON_DEVICE_NAME;
>  	input->phys = button->phys;
>  	input->id.bustype = BUS_HOST;
>  	input->dev.parent = &pdev->dev;

> -	dev_info(&pdev->dev, "%s [%s]\n", acpi_device_name(device),
> +	dev_info(&pdev->dev, SURFACE_BUTTON_DEVICE_NAME " [%s]\n",
>  		 acpi_device_bid(device));

I would keep one place of accessing the definition:

	dev_info(&pdev->dev, "%s [%s]\n", input->name, acpi_device_bid(device));

If we ever change that, we won't need to look at two (or more) places.


-- 
With Best Regards,
Andy Shevchenko


