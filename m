Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80953393DD0;
	Wed, 25 Feb 2026 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772016926; cv=none; b=IsrpB5Gq13yUexDDhw2750uW7Nfr99xjZzWzd/EQ88ZH6ycZnYUVmPHcaNJwuWEJIRrnyoT86JnV9RXXI0yepJWEejAKwoEdPyPyMtBpHLJZESrugsBztfKvvaSGXfPdi8cOlHovacHAJYkg4Mmi96DU7a0ohf+twFdtQvRATYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772016926; c=relaxed/simple;
	bh=xpJps7rUYHe5PIxLR3DK6yboXdMXgA4cd+zI75+lphM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r841FXoONQlcLEFRCOz0tepDpItSvsMp0owfF+e8Rouw4BE4P8Q+kGTEtZwi0mFyXbfByIiPd949sKYuvBEOMFJguRGKFYEQQ706MAvkmivRyJsCnep1MQGBHZPUS5WNFHDF8dz31Uf8nHL0EEjvY57Coc9jhCSV96qzVLSiJ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JXuf2ijD; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXuf2ijD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772016926; x=1803552926;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xpJps7rUYHe5PIxLR3DK6yboXdMXgA4cd+zI75+lphM=;
  b=JXuf2ijDgs0odNloL6nLMJxEO315t/R9KlxqM4G+ncsu18BZj2T9JJnp
   RCXgFUp7SV3mC3gL+Afm+kR9JxwRzn9yVk0dXvF9ZcCKaGRF8yxoxeDJ/
   iynM9cRWDrhLVnMFA2dXrPcYGDJe++czVdCpOiDmXL3U9FfXCIVkpfs4N
   t8+ay0rVq9isxW4sAHwEqZ3AS5m/xea0le2JtKY6LbHNuPGOO48ChRjdz
   nvYX2FzT6Bah6RMssBfez4p35g/gJY+fIBgoju3u0njXKheGnb1e7v1ug
   jzUq7DgEF25+X/PrdfQoOBBi7xu4DKJ5bxW79Y0rnrOijfnr3F3VcASJR
   w==;
X-CSE-ConnectionGUID: yOJekg+2QsWACORXQg/qNw==
X-CSE-MsgGUID: ddcXarfYR969tIAa/uUpQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="84142463"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="84142463"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 02:55:25 -0800
X-CSE-ConnectionGUID: nFfJOe/7Tjug2RMhQXW42A==
X-CSE-MsgGUID: H0uDcXigR4e2Q3269k6srw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="220697361"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.71])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 02:55:22 -0800
Date: Wed, 25 Feb 2026 12:55:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Len Brown <lenb@kernel.org>, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3] gpiolib: match secondary fwnode too in
 gpio_device_find_by_fwnode()
Message-ID: <aZ7VF9N2LbdA-QhA@smile.fi.intel.com>
References: <20260225-device-match-secondary-fwnode-v3-1-a7152054135a@oss.qualcomm.com>
 <aZ7UbXkmiM6NGkyI@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ7UbXkmiM6NGkyI@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 25, 2026 at 12:52:35PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 25, 2026 at 11:12:25AM +0100, Bartosz Golaszewski wrote:

...

> > +	if (IS_ERR(fwnode))
> > +		return 0;
> > +
> > +	if (device_match_fwnode(dev, fwnode))
> > +		return 1;
> > +
> > +	return node && !IS_ERR(node->secondary) && node->secondary == fwnode;
> 
> I believe Rafael is right in suggesting just
> 
> 	return node && node->secondary == fwnode;
> 
> At this point fwnode either NULL or valid. 'node' comes from device,
> so it may be all three. Assuming it's actually can't be error pointer
> the above check is sufficient. But maybe you wanted full check, then
> 
> 	return !IS_ERR_OR_NULL(node) && node->secondary == fwnode;

And probably NULL should be excluded from fwnode:

	return fwnode && !IS_ERR_OR_NULL(node) && node->secondary == fwnode;

-- 
With Best Regards,
Andy Shevchenko


