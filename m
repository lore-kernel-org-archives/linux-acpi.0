Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF01258EC1;
	Tue, 28 Apr 2026 08:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364043; cv=none; b=fjRn6KP6bwTpeAaHnPTUNSieip9n+USnf+lFOq9oAr4u8XMXkbCLmDEc8yy+YWWA/jDZKTJn8EqpczDhxlP1pwPfHELF/Gu4BrPNLCnKhzF2oduEI5JRij3g2dNzxe+6xIJb2cESaeXKWS+5YutkpWGk7R5ze7t2v/C4YrpOAYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364043; c=relaxed/simple;
	bh=FIOpf50egYGuxDu1gkkmZlFJz0kV5/vkpFDnm9Lo3Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDSWcW/NF7pKhNN+8eRi4V91EFQoicvVfcUiBT+BcO1PsAEB+9iDrjmpKv0iiosN3379M3KtSjq0ZsxRYzEP3BCn2icnunjHqiBowRgHO/niswvwwjvNstNBogOYpznxnAG7Kl655zvgggfH7Fg0eyUqrFFVFJSZvRYY9rgoGcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=drft+S7o; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="drft+S7o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777364042; x=1808900042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FIOpf50egYGuxDu1gkkmZlFJz0kV5/vkpFDnm9Lo3Ew=;
  b=drft+S7oeWYpNGfCKM7Cr4QtMkWTA11fnaL+Btn2gneRpiFGhp+3skFe
   6T6L8tCZmR4sTOl8m6Hs91uMKpne8qoIEqyFpLz94dMWSA7cC4Q3cHpXH
   7dKFEjAD/FTgPPiXILZZs5zLr6E5xgqF81X16UjTnUiGAJRu0OETKc8mW
   2g5F5pEzt6MXar+jmP3diVUInCCzEzjyfEEO4Gg48MUE0S/DvC6Oneqji
   pmt42NZFokIlyVnW+lq79UEub+vQAY0MI4NvCml1hViOoTy6dAFfrDHFY
   taU5/yO9LvW9qcETJ4Zt4gUY90ro4XtQHnJ1ZHbYfP75zHzn+rUhEPQru
   w==;
X-CSE-ConnectionGUID: jWb9wC36RPa4TkOFa8rvbw==
X-CSE-MsgGUID: QpVQZTcEQ9yY66IkpSydhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77295921"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="77295921"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:14:01 -0700
X-CSE-ConnectionGUID: 5pvbqdeZT3So/V/mOTfTIQ==
X-CSE-MsgGUID: k8bT68VJRuGrz8Im2m2Vow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="238913404"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:13:59 -0700
Date: Tue, 28 Apr 2026 11:13:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, Andy Shevchenko <andy@kernel.org>,
	Mika Westerberg <westeri@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ACPI: pmic: Replace mutex_lock/unlock() with
 guard()/scoped_guard()
Message-ID: <afBsRD8KqszA6Ava@ashevche-desk.local>
References: <20260427231119.55486-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427231119.55486-1-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 06:11:19PM -0500, Maxwell Doose wrote:
> Replace mutex_lock() and unlock() macros with the newer guard() and
> scoped_guard() macros. This will help modernize and clean the code.
> 
> In intel_soc_pmic_exec_mipi_pmic_seq_element(): While at it, remove
> now redundant "ret" variable.

...

> -	} else if (d->pmic_i2c_address) {
> -		if (i2c_address == d->pmic_i2c_address) {
> -			ret = regmap_update_bits(intel_pmic_opregion->regmap,
> -						 reg_address, mask, value);
> -		} else {

> +	if (d->pmic_i2c_address) {
> +		if (i2c_address != d->pmic_i2c_address) {

I slightly tend to make this change less invasive, id est leaving the if-else
as it was in the original code.

...

> -			       __func__, i2c_address, reg_address, value, mask);

> +				__func__, i2c_address, reg_address, value, mask);

Stray change.

-- 
With Best Regards,
Andy Shevchenko


