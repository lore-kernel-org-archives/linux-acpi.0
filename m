Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AC83D090E;
	Fri,  3 Jul 2026 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081088; cv=none; b=oOmBvf3DmAZJ0R/AyvhgH571VjmTyKD5sFEXbmqV7+zCsNqMvIeBQbswMjA1+gZHhF+zYit0vNhyNm+BjSfCZ16duqIAzRpIQwQDNSKPrS4y2vSTSxGu67Y/RpueT2KYXqOxTjEeVjzr+FYCB2jYtzQEbU7we8y6hQbaBgfSsmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081088; c=relaxed/simple;
	bh=LwzD/6EokWbPSyLrFDefUh9dggweTVmw9HAHQLw9pls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GapxxM3DfFoDf9KwxOkAwVTwP1pSo4LFtmGd8u3IDwWrB8WN+sAeNpAxpjCchOQtJwLRM4sL96FxgxFgC8yBweRkaS04Sxkk+h9nPW/oUYT1Fjrb9A5IW+fvRlE/4p9Xo1VLXybSGlPJztJbExX+u7V5RqcdjQX0GUoQO1ffctE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QdTagyFE; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QdTagyFE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783081087; x=1814617087;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LwzD/6EokWbPSyLrFDefUh9dggweTVmw9HAHQLw9pls=;
  b=QdTagyFE21/xleUdyhAVn6BQ5LTlpVHUsgXkOAxBEUlqec9tYH9RR9d3
   3970BbQqW30x4FKRf0JM9NegMBEsSrvkJ81oxdOG+lYqcFMaxehp+2tUG
   w0QQml3666io4QUJw5pgHHTtdoxsOcrxsCNozrb898vsSOOavqciS7r7F
   mmF+8wv5kU1t4GyEAKvuTMYr7SAKkd6eJfFkjUGvBDQkfQ1We3nDB1q9N
   e9fMZNiTS3z5adpx0vu1uOETriXGTfieMlCREnz6QWAW7/vlMhrt8+C72
   etby2VvcOaydJEXdOf3ilYy+NxBc7F0bm4W5FbKiXpAw7eCu583ogiFVW
   Q==;
X-CSE-ConnectionGUID: 4Vie/kIdTNSWFQpJ8Gd9Cw==
X-CSE-MsgGUID: L/F5H5mHRz+fTHkrwtPrZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="87748072"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="87748072"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:18:07 -0700
X-CSE-ConnectionGUID: 2/l/i94QTCWZv9+ZMVbcKw==
X-CSE-MsgGUID: 27jc+NuJTOCTYVPRFxgVzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="253247087"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.80])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:18:04 -0700
Date: Fri, 3 Jul 2026 15:18:00 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J.  Wysocki" <rafael@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Denis Benato <denis.benato@linux.dev>,
	Jonathan Woithe <jwoithe@just42.net>, Robert Gerlach <khnz@gmx.de>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Kenneth Chan <kenneth.t.chan@gmail.com>,
	Mattia Dongili <malattia@linux.it>,
	Azael Avalos <coproscefalo@gmail.com>
Subject: Re: [PATCH v1 05/10] platform/x86: thinkpad_acpi: Stop setting
 acpi_device_class()
Message-ID: <akeoeAzCjTlGc_lz@ashevche-desk.local>
References: <5135166.31r3eYUQgx@rafael.j.wysocki>
 <23182921.EfDdHjke4D@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23182921.EfDdHjke4D@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 03, 2026 at 01:30:00PM +0200, Rafael J.  Wysocki wrote:

> To facilitate the removal of device_class from struct acpi_device_pnp
> in the future, make the driver store the device class string used for
> generating ACPI netlink events in a new device_class field in struct
> ibm_struct.
> 
> No intentional functional impact.

...

>  		acpi_bus_generate_netlink_event(
> -					ibm->acpi->device->pnp.device_class,
> +					ibm->device_class,
>  					dev_name(&ibm->acpi->device->dev),
>  					event, 0);

In other cases you condensed the code a bit, not sure if you want to do the
similar here

		acpi_bus_generate_netlink_event(ibm->device_class,
						dev_name(&ibm->acpi->device->dev),
						event, 0);

>  		return;

...

>  		if (send_acpi_ev) {
>  			acpi_bus_generate_netlink_event(
> -					ibm->acpi->device->pnp.device_class,
> +					ibm->device_class,
>  					dev_name(&ibm->acpi->device->dev),
>  					event, hkey);
>  		}

Ditto.

-- 
With Best Regards,
Andy Shevchenko


