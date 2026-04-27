Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0407337B413;
	Mon, 27 Apr 2026 07:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777274893; cv=none; b=LbyhqP4yIEjTrpc2tYFkM5/XCYWP4o5EDsO4P8mwvRlsZjDW5BWJpuohZeJk6BkrH7pO0KtE6+FEUxw6lXz9s5HLXjYPo5bwSWcBE+EhGf3RoPXg9ireWaafcwyV9aqL1pfGJYNHqv1c/s2EiH5mYDDB9xwcxESVbhK+wf21T/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777274893; c=relaxed/simple;
	bh=g9+2TjDYnFbVgRgYaLIVlkjTxyEg39WV/so2aGWoOpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXplTDwGBGPNhEvnI1OImZXZBAyfKAueRvQuVBjAVcxGQfOH4gaXCWCeA77TweR0yymKSJ2n69lgt5seQEMoJzE4PzhWHGVOTU6mlixK3m6BwskxgoFWHk+jSe6No9OxxlBHQH2txMkZuDMf9Y41ARObTM3taZGyYP9+3tzPgy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gIXu4uSw; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gIXu4uSw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777274892; x=1808810892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g9+2TjDYnFbVgRgYaLIVlkjTxyEg39WV/so2aGWoOpY=;
  b=gIXu4uSwTtNQ/yFjoApWRBA5gKwBy2Cp85g5L+szpADr+QvKxI0SiCw4
   HBXBd1pFl4ObQ+Kyp5x5qRij7Yra6D9btgzglGyXVUb9eB8pjeUt3ojoJ
   4O0C6ljtU79IWicrnpUaW3dIN5ZdrQidCyUjU61z7pzPnK8eSl+EsMdgP
   aDmn5d88pMnUCDDj5Kc61GmyrB+aPvOC8DYtv4Y8Q7E2uyj+bwOMu3bjr
   IA60p123PC2jjdrTVnBNSG8VXhX3R+etcHMRjMkmoVF8Tg6HsAkvFlw/q
   r5EkiSp9d5wAnGow1Bfb/3Y4AgPaZN1VagFJ8juH3x7K4Vbb1Oo8Nj5zs
   w==;
X-CSE-ConnectionGUID: +Nr6sEf2TqOtrhHQQEWRRg==
X-CSE-MsgGUID: x0qvIaoOQpScPpzBUoQjMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="78045434"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="78045434"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 00:28:11 -0700
X-CSE-ConnectionGUID: 7IS1jouKS6Gm3EW9eI9YDQ==
X-CSE-MsgGUID: DY2LqquxTGGHidGMIoh2/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="232678633"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 00:28:09 -0700
Date: Mon, 27 Apr 2026 10:28:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, andy@kernel.org, westeri@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: pmic: Replace mutex_lock/unlock() with
 guard()/scoped_guard()
Message-ID: <ae8QBnSs9fYvkv_i@ashevche-desk.local>
References: <20260424220110.25929-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424220110.25929-1-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 24, 2026 at 05:01:10PM -0500, Maxwell Doose wrote:
> Replace mutex_lock() and unlock() macros with the newer guard() and
> scoped_guard() macros. This will help modernize and clean the code.
> 
> Refactor control flow in affected functions by using direct returns,
> as we no longer need to manually unlock mutexes at the end of
> functions. This will simplify the return logic of affected functions.
> 
> In intel_soc_pmic_exec_mipi_pmic_seq_element(): While at it, remove
> now redundant "ret" variable.

Some remarks and one important comment (see scoped_guard()() error handling).

...

> -	mutex_lock(&opregion->lock);
> +	scoped_guard(&opregion->lock) {

>  

Now this blank line become redundant.

> -	if (pmic_thermal_is_temp(address))
> -		result = pmic_thermal_temp(opregion, reg, function, value64);
> -	else if (pmic_thermal_is_aux(address))
> -		result = pmic_thermal_aux(opregion, reg, function, value64);
> -	else if (pmic_thermal_is_pen(address))
> -		result = pmic_thermal_pen(opregion, reg, bit,
> +		if (pmic_thermal_is_temp(address))
> +			result = pmic_thermal_temp(opregion, reg, function, value64);
> +		else if (pmic_thermal_is_aux(address))
> +			result = pmic_thermal_aux(opregion, reg, function, value64);
> +		else if (pmic_thermal_is_pen(address))
> +			result = pmic_thermal_pen(opregion, reg, bit,
>  						function, value64);

Despite being long, I would still use a single line for the last one:

			result = pmic_thermal_pen(opregion, reg, bit, function, value64);

> -	else
> -		result = -EINVAL;
> -
> -	mutex_unlock(&opregion->lock);

> -	if (result < 0) {
> -		if (result == -EINVAL)
> -			return AE_BAD_PARAMETER;
>  		else
> -			return AE_ERROR;
> +			return AE_BAD_PARAMETER;
> +
>  	}

TBH, I would leave current logic, as it will keep the scope and the semantics
of the each branch consistent.

		else
			result = -EINVAL;


> +	if (result < 0)
> +		return AE_ERROR;

Also (some) compiler(s) might not see well the result being initialised all the
time when we are here.

>  	return AE_OK;
>  }

...

>  	if (d->exec_mipi_pmic_seq_element) {
> -		ret = d->exec_mipi_pmic_seq_element(intel_pmic_opregion->regmap,
> -						    i2c_address, reg_address,
> -						    value, mask);
> -	} else if (d->pmic_i2c_address) {
> +		return d->exec_mipi_pmic_seq_element(intel_pmic_opregion->regmap,
> +						     i2c_address, reg_address,
> +						     value, mask);
> +	}

{} are not needed for a single statement cases. But I see it occupies 3 LoC,
perhaps it's fine to have them still. Up to maintainers.

> +	if (d->pmic_i2c_address) {
>  		if (i2c_address == d->pmic_i2c_address) {
> -			ret = regmap_update_bits(intel_pmic_opregion->regmap,
> -						 reg_address, mask, value);
> -		} else {
> -			pr_err("%s: Unexpected i2c-addr: 0x%02x (reg-addr 0x%x value 0x%x mask 0x%x)\n",
> -			       __func__, i2c_address, reg_address, value, mask);
> -			ret = -ENXIO;
> +			return regmap_update_bits(intel_pmic_opregion->regmap,
> +						  reg_address, mask, value);
>  		}

Ditto.

> -	} else {
> -		pr_warn("%s: Not implemented\n", __func__);
> -		pr_warn("%s: i2c-addr: 0x%x reg-addr 0x%x value 0x%x mask 0x%x\n",
> -			__func__, i2c_address, reg_address, value, mask);
> -		ret = -EOPNOTSUPP;
> -	}
>  
> -	mutex_unlock(&intel_pmic_opregion->lock);
> +		pr_err("%s: Unexpected i2c-addr: 0x%02x (reg-addr 0x%x value 0x%x mask 0x%x)\n",
> +		       __func__, i2c_address, reg_address, value, mask);
> +		return -ENXIO;

In this case it's probably better to swap conditional to have error case first.
This is standard pattern elsewhere in the kernel.

		if (i2c_address != d->pmic_i2c_address) {
			pr_err("%s: Unexpected i2c-addr: 0x%02x (reg-addr 0x%x value 0x%x mask 0x%x)\n",
			       __func__, i2c_address, reg_address, value, mask);
			return -ENXIO;
		}

		return regmap_update_bits(intel_pmic_opregion->regmap,
					  reg_address, mask, value);

Or leave the inner part untouched as it's not the main part of the patch
anyway. This makes the patch cleaner (however it remains 'ret' to be defined).

Up to you and maintainers.

> +	}
>  
> -	return ret;
> +	pr_warn("%s: Not implemented\n", __func__);
> +	pr_warn("%s: i2c-addr: 0x%x reg-addr 0x%x value 0x%x mask 0x%x\n",
> +		__func__, i2c_address, reg_address, value, mask);
> +	return -EOPNOTSUPP;
>  }

-- 
With Best Regards,
Andy Shevchenko


