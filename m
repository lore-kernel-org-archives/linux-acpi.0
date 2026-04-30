Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA0C40DFB4;
	Thu, 30 Apr 2026 06:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777530214; cv=none; b=P2U9vgYRE7N/i8a07nUZFbs4Uis5CSpE7OdSbKqyRRXP38wDgDE+AynqeKxi20h4HoJWqTx8OaR2OlzXqxxEiEmsBMseJCVRr3d/mxPcECx97xc0pzJZHQuiYAZtrYQlW+M+BEA3P/8sSIwfv0DpLHPYJn/0UNIPn89ySci8pnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777530214; c=relaxed/simple;
	bh=6L61oZr/77k8SEoKbWVbmQqUG3Y58FL1/cqxvgoHbDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBVv3Dhcr5uQZjurCqKXzmfCoCMyEkBfRw60KkNNA16OrpiOvr8kxYsQwZeYnSMdjB18zelXUtzDgYyzUfK/sjXr1k7TYEsoPrrgm9b2GO4Botn5hWuSbGbmM8xD3slzwh3wE/xWB8gmrQ1lGT21kzLsZ4U9sFpoPdCfnzMUSwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Guhv5UDY; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Guhv5UDY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777530212; x=1809066212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6L61oZr/77k8SEoKbWVbmQqUG3Y58FL1/cqxvgoHbDw=;
  b=Guhv5UDYb/zDg7+LCI1CCMGtHKSi4w28cT70SR2XMSMeZJSLu/mEedUQ
   8iJa1XiblC65eiF2h+VlMCGxEMir3jbo5+ngS9XlQlWEHIO9J+xsKNK2F
   oSjT+7NwDGGjK7h3VTWu3fRko1DyHdpOskkDaWwhtVoBnve7JIsmva4qv
   aNkZ0Km3YnaLgx7qmnS+AHEoEqDiCZ8/wYRBUXre68o4ypcDtQ/kc3C6/
   g3ASumrZt9qauvR80z3/hkgjofGx7pCHZ/3dIblmO6jNeQZ7XonhvqoPW
   H6ag3SN6Bl+cLXD1MFT/yBWeT+L/KhXQY1f8pYLTXnt/S2VrwrEmrgdy6
   Q==;
X-CSE-ConnectionGUID: b6z+0azjQmmFuVNkEaRzDQ==
X-CSE-MsgGUID: uZv9vaesTdyWpCnKemecLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78392023"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="78392023"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 23:23:32 -0700
X-CSE-ConnectionGUID: T9nKqYqBRaifRppe4BqNKw==
X-CSE-MsgGUID: jFbm2h45TJK/bPWfKDc+Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="258073179"
Received: from zzombora-mobl1 (HELO localhost) ([10.245.244.42])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 23:23:29 -0700
Date: Thu, 30 Apr 2026 09:23:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, Andy Shevchenko <andy@kernel.org>,
	Mika Westerberg <westeri@kernel.org>,
	"open list:ACPI PMIC DRIVERS" <linux-acpi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] ACPI: pmic: Replace mutex_lock/unlock() with
 guard()/scoped_guard()
Message-ID: <afL1X3ywCwJRIz1Z@ashevche-desk.local>
References: <20260430013507.46259-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430013507.46259-1-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 08:35:06PM -0500, Maxwell Doose wrote:
> Replace mutex_lock() and unlock() macros with the newer guard() and
> scoped_guard() macros. This will help modernize and clean the code.

...

> -	mutex_lock(&opregion->lock);
> -
> -	if (pmic_thermal_is_temp(address))
> -		result = pmic_thermal_temp(opregion, reg, function, value64);
> -	else if (pmic_thermal_is_aux(address))
> -		result = pmic_thermal_aux(opregion, reg, function, value64);
> -	else if (pmic_thermal_is_pen(address))
> -		result = pmic_thermal_pen(opregion, reg, bit,
> -						function, value64);
> -	else
> -		result = -EINVAL;
> -
> -	mutex_unlock(&opregion->lock);
> +	scoped_guard(mutex, &opregion->lock) {
> +		if (pmic_thermal_is_temp(address))
> +			result = pmic_thermal_temp(opregion, reg, function, value64);
> +		else if (pmic_thermal_is_aux(address))
> +			result = pmic_thermal_aux(opregion, reg, function, value64);
> +		else if (pmic_thermal_is_pen(address))
> +			result = pmic_thermal_pen(opregion, reg, bit, function, value64);
> +		else
> +			result = -EINVAL;
> +	}

>  

This blank line is not needed as previous is coupled with this check.
This is a minor thing, but what takes my attention is the result assignment for
last else. While this is correct code it might provoke false positive warnings
from the compiler(s) that can not properly parse scoped_guard() and proof that
result is always assigned (the warning is something like "uninitialised variable
in use"). Let's wait for CIs to be sure we do not enter a such. Otherwise, this
will need a refactoring like

	result = -EINVAL;
	scoped_guard(...) {
		...
	}

>  	if (result < 0) {
>  		if (result == -EINVAL)

...

>  	if (d->exec_mipi_pmic_seq_element) {
> -		ret = d->exec_mipi_pmic_seq_element(intel_pmic_opregion->regmap,
> +		return d->exec_mipi_pmic_seq_element(intel_pmic_opregion->regmap,
>  						    i2c_address, reg_address,
>  						    value, mask);
> -	} else if (d->pmic_i2c_address) {
> +	}
> +
> +	if (d->pmic_i2c_address) {
>  		if (i2c_address == d->pmic_i2c_address) {

Maybe we should not touch this either and actually have clean guard()() patch +
refactoring returns, dunno... My whole concern here is that this code is not as
simple as IIO switch-cases when we replace break:s with return:s mostly
automatically without breaking readability of anything. Here is different case
and mixing guard()() with return:s refactoring makes it harder to review and
understand. Also if any regression happens, will be harder to maintain.

...

I don't want you to waste more time on experimenting, I think we better
wait for CIs and Rafael, if they all are okay with the change, that will
work for me.

-- 
With Best Regards,
Andy Shevchenko


