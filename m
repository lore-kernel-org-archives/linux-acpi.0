Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5E7383C8F;
	Fri, 24 Apr 2026 09:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022021; cv=none; b=TQmeajnGQ8LzPEIfJfHCGEci0qfUE6p1W/oFDk11y4qxHIL+hIlWODUlnxbnUZylDiLzDB+dnyDWEAGwJ/ZpEwHY/0QT9Lff8JI5OBbTATANRx0qy+W101xfN7FI33R3Ea94pXgm+rk0tl6eMYhpUJ/anGhisEWp3EuUV9/tK9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022021; c=relaxed/simple;
	bh=JNmxuxsRo6UkNUwk4AqRyJ2KOxNhX+4DhFWzGybFzrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuZhG2jFpPDl/wVGHOvDOX4BmjyohEEc2YOYdopAikAZXERzFBQpjmAeB54Y2dT4ZVD4Obqj9jGo6lkrNPJ/s9PA0a/9h22Cow6KYQe1+OYOgu9GZWIlt+cOg/X6xUXJQ+Mb1DgvxSc5EnoDnZSR/DdcoK3Fg5oDMtmXD6G+DFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mm/2o755; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mm/2o755"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777022020; x=1808558020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JNmxuxsRo6UkNUwk4AqRyJ2KOxNhX+4DhFWzGybFzrk=;
  b=Mm/2o755OiAqgaApHB7PglcTJBc797mS93MAiK1J0kBen29s66OS+8H1
   SeiBzB4rKMaohjsPjXmDnkusqSnxs+Sd6zhmR6QSq1aYBW+oKTI5qCNjs
   V5klsMvXkW31ww5YgCzDwMb6NWIbzXfgH+cX4PjCTIUh+gSamwl4CAMru
   /Z0l3myp3eSq5nm0X3Ip0Ln4A5rRjz40y2k77p0zxLVGD/h7piWaSlzjc
   xR7s8XYBOpTic9/AgQpITJs55dS35bSjdXxHP0Ww13+QwmaN0bQwqm3Pj
   xsw5lKJshGWK1uEyj4WWlGNxV+xebVYgR7iptShEOvPpYdKqWmdrLVJKu
   g==;
X-CSE-ConnectionGUID: YGwrqN6NRHWk7eP/8oGYLg==
X-CSE-MsgGUID: bSqVJ0PoRwC64LQIX39V2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="81606838"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="81606838"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 02:13:40 -0700
X-CSE-ConnectionGUID: uM+kcCNaSpew9CueZKWN/A==
X-CSE-MsgGUID: fgocGVT9R4SB16v4dv9PDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="231900842"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 02:13:38 -0700
Date: Fri, 24 Apr 2026 12:13:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, andy@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] acpi: pmic: Replace mutex_lock/unlock() with
 guard()/scoped_guard()
Message-ID: <aes0QGXqZEpsZozV@ashevche-desk.local>
References: <20260424035501.219946-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424035501.219946-1-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 23, 2026 at 10:55:01PM -0500, Maxwell Doose wrote:
> Replace mutex_lock() and unlock() macros with the newer guard() and
> scoped_guard() macros. This will help modernize and clean the code.
> 
> In intel_soc_pmic_exec_mipi_pmic_seq_element(): While at it, remove
> now redundant "ret" variable.

...

> static acpi_status intel_pmic_thermal_handler(u32 function,

> -	mutex_lock(&opregion->lock);
> +	scoped_guard(&opregion->lock) {
>  
>  	if (pmic_thermal_is_temp(address))
>  		result = pmic_thermal_temp(opregion, reg, function, value64);

>  	else
>  		result = -EINVAL;
>  
> -	mutex_unlock(&opregion->lock);
> +	}


No. You need to either split a helper and use guard()() there, or indent the
body of scoped_guard() accordingly.

...

> int intel_soc_pmic_exec_mipi_pmic_seq_element(u16 i2c_address, u32 reg_address,

> -	mutex_lock(&intel_pmic_opregion->lock);
> +	guard(&intel_pmic_opregion->lock);
>  
>  	if (d->exec_mipi_pmic_seq_element) {
> -		ret = d->exec_mipi_pmic_seq_element(intel_pmic_opregion->regmap,
> +		return d->exec_mipi_pmic_seq_element(intel_pmic_opregion->regmap,
>  						    i2c_address, reg_address,
>  						    value, mask);
>  	} else if (d->pmic_i2c_address) {
>  		if (i2c_address == d->pmic_i2c_address) {
> -			ret = regmap_update_bits(intel_pmic_opregion->regmap,
> +			return regmap_update_bits(intel_pmic_opregion->regmap,
>  						 reg_address, mask, value);
>  		} else {
>  			pr_err("%s: Unexpected i2c-addr: 0x%02x (reg-addr 0x%x value 0x%x mask 0x%x)\n",
>  			       __func__, i2c_address, reg_address, value, mask);
> -			ret = -ENXIO;
> +			return -ENXIO;
>  		}
>  	} else {
>  		pr_warn("%s: Not implemented\n", __func__);
>  		pr_warn("%s: i2c-addr: 0x%x reg-addr 0x%x value 0x%x mask 0x%x\n",
>  			__func__, i2c_address, reg_address, value, mask);
> -		ret = -EOPNOTSUPP;
> +		return -EOPNOTSUPP;
>  	}
> -
> -	mutex_unlock(&intel_pmic_opregion->lock);
> -
> -	return ret;

This is not a switch-case and direct returns in if-else-if makes it harder to
follow. What you need is to drop now redundant 'else':s and leave the last one
unconditionally as the last code in the function.

>  }

-- 
With Best Regards,
Andy Shevchenko


