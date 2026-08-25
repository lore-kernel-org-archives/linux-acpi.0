Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F13D3DE44B;
	Tue, 25 Aug 2026 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787655277; cv=none; b=h4tpbADfwyJOnewVsNChCqURxDmmflPqTwdd0d1/xvCSta/Fzc0PhYGCpLai50lSdXZWrpf+aIQF+dGw4LBvyQSo7HmfxeEEi0fr9ME6IIVPy/AXCq0/621GCuftpAfmjUSnHtWBidN2AUcom4XmoJeoYD2IWJ3dQC+ZrteYmCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787655277; c=relaxed/simple;
	bh=qI+SEJZOcXYX4b4gFl+qQ4tUtOkx04k5KdOWYthme/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YM+u5hfb07e8DEbTsy/JLlA0SpD7IbkChboLJfFGQkoWR/X4idKqYXQg2tPfiNVLhgoyOIdIMceaDQ5jVNBQVkjhJ59DUHRqu2q6JapZzn13Nt0FFyzGTRIXz7zgnJTVRumQrMRimknBI1Wbh30ftNcNNp+t6LJDDRfxBuDkYl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lb9r424r; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lb9r424r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787655275; x=1819191275;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qI+SEJZOcXYX4b4gFl+qQ4tUtOkx04k5KdOWYthme/0=;
  b=lb9r424rphHxucQMjHqt5lgACc/tArShzQARFXnog9gBTBSLQGta/ikX
   OR5ymZSDUS352l2Yg3+FFCCF/oDysMA5nOLbXOMcDGGgFGlZtd0+DEBV7
   eZHTL+EIKJtRD5/UVedoHsOp+2FVjd0IWEQUY0MwK8nViGiQC4/Z53YHg
   V0+Utz8a01fXBKmpkIXJh4mlP53fds4SVxcMo43oGY8C7+Ra6EJ4sQUdV
   d+ODTG02cf5IJYPNphlC9g1pFRTdNNVJPr4/wgZsvagM/FLZA0NKrMsKW
   pmnNLF046lX7Kq+OJT8B9wNAaPqOy+GO1GcAV3qqDeB4ltyHeE+x2Cs8c
   Q==;
X-CSE-ConnectionGUID: eBdX9u0PT0qoDivnLpMbJg==
X-CSE-MsgGUID: ic3/QE33RWCUxzkhym4nsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88320678"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="88320678"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 03:54:34 -0700
X-CSE-ConnectionGUID: tuFkrwj+QeqsCMJqFxNyMg==
X-CSE-MsgGUID: /kN3aDjoTkmnRx2sGaAhCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="270718182"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.50])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 03:54:31 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id A39E2121BE0;
	Tue, 25 Aug 2026 13:54:42 +0300 (EEST)
Date: Tue, 25 Aug 2026 13:54:42 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-media@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 5/5] platform/x86: int3472: Clean up GPIO parsing
Message-ID: <ao10ctlOyvH5eMlf@kekkonen.localdomain>
References: <20260824211338.3583976-1-sakari.ailus@linux.intel.com>
 <20260824211338.3583976-6-sakari.ailus@linux.intel.com>
 <dbf333db-28ca-78ab-db76-f1773db844c7@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbf333db-28ca-78ab-db76-f1773db844c7@linux.intel.com>

Moi,

On Tue, Aug 25, 2026 at 01:40:25PM +0300, Ilpo Järvinen wrote:
> On Tue, 25 Aug 2026, Sakari Ailus wrote:
> 
> > In skl_int3472_handle_gpio_resources(), return an error where it happens,
> > except when we're holding a reference to a GPIO. This involves
> > incrementing ngpios earlier on but that does not introduce a functional
> > change.
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/platform/x86/intel/int3472/discrete.c | 42 +++++++++----------
> >  1 file changed, 21 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
> > index 2024eaa09033..400bee9e4cb8 100644
> > --- a/drivers/platform/x86/intel/int3472/discrete.c
> > +++ b/drivers/platform/x86/intel/int3472/discrete.c
> > @@ -369,15 +369,23 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
> >  		agpio->resource_source.string_ptr, agpio->pin_table[0],
> >  		str_high_low(gpio_flags == GPIO_ACTIVE_HIGH));
> >  
> > +	/*
> > +	 * int3472->ngpios can be incremented here as it is an argument to the
> > +	 * _DSM, not e.g. an index to an array in C. Additionally, in case of an
> > +	 * error the value won't be used.
> > +	 */
> 
> I wasn't expecting comment for this. You might have added it because of 
> my questions but IMO it's not needed.
> 
> I think just the old way/place was confusing, especially given how 
> some/part of the error cases did increment it. But after moving it here, 
> it makes much more sense even without that comment.
> 
> And one can determine it's not being used for C arrays by using grep so 
> that too seems just unnecessary detail.

Ok, I'll drop it.

> 
> > +	int3472->ngpios++;
> > +
> >  	switch (type) {
> >  	case INT3472_GPIO_TYPE_RESET:
> >  	case INT3472_GPIO_TYPE_POWERDOWN:
> >  	case INT3472_GPIO_TYPE_HOTPLUG_DETECT:
> >  		ret = skl_int3472_map_gpio_to_sensor(int3472, agpio, con_id, gpio_flags);
> >  		if (ret)
> > -			dev_err_probe(int3472->dev, ret, "Failed to map GPIO pin to sensor\n");
> > +			return dev_err_probe(int3472->dev, ret,
> > +					     "Failed to map GPIO pin to sensor\n");
> >  
> > -		break;
> > +		return 0;
> >  	case INT3472_GPIO_TYPE_CLK_ENABLE:
> >  	case INT3472_GPIO_TYPE_PRIVACY_LED:
> >  	case INT3472_GPIO_TYPE_STROBE:
> > @@ -385,24 +393,24 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
> >  	case INT3472_GPIO_TYPE_DOVDD:
> >  	case INT3472_GPIO_TYPE_HANDSHAKE:
> >  		gpio = skl_int3472_gpiod_get_from_temp_lookup(int3472, agpio, con_id, gpio_flags);
> > -		if (IS_ERR(gpio)) {
> > -			ret = PTR_ERR(gpio);
> > -			dev_err_probe(int3472->dev, ret, "Failed to get GPIO\n");
> > -			break;
> > -		}
> > +		if (IS_ERR(gpio))
> > +			return dev_err_probe(int3472->dev, PTR_ERR(gpio),
> > +					     "Failed to get GPIO\n");
> >  
> >  		switch (type) {
> >  		case INT3472_GPIO_TYPE_CLK_ENABLE:
> >  			ret = skl_int3472_register_gpio_clock(int3472, gpio);
> >  			if (ret)
> > -				dev_err_probe(int3472->dev, ret, "Failed to register clock\n");
> > +				dev_err_probe(int3472->dev, ret,
> > +					      "Failed to register clock\n");
> 
> Don't know why changed linesplits in this instead doing them directly in 
> the 2nd patch.

Oops, that's where I intended to make them. I'll fix that for v3.

-- 
Sakari Ailus
