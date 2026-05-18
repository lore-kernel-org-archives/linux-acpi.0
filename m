Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE09B3E00BF;
	Mon, 18 May 2026 08:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779091892; cv=none; b=RH/giLewNgkB7O7p3YsXuztHkYqgXqYxtivVrf353oYtxIHTv6MoTm3Ihs1PKHYzWRJop4bod+wYAz9NIefm7egvNgPseAS2TXZ8TQVaTzEtl+Lfsi8aMx+9uAz5E7ikk640+7xWkQoj84Jmbymx0ADG8+ENgVM6IQ2lS6i5eWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779091892; c=relaxed/simple;
	bh=LH3kToM5J/xEuI7C+Kv6Y99uRxYwDH0sAIWvZyy9ygM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l23o+7axRelR74v1zQFeXBtEktMTotHuymHwxDuLrzlXWyTrFN74jijc1cjNJF+l9Om80EfwEaEV5Ml8KFtNjCjRQ8fOHpOFnvikGCAF8Zr19IFzOxj5tPsPi+d3UBX9DAuuobuDHESShl7X8mB8hPM0fABpjJY4Zj2ddSRscGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cEmrveG4; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cEmrveG4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779091891; x=1810627891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LH3kToM5J/xEuI7C+Kv6Y99uRxYwDH0sAIWvZyy9ygM=;
  b=cEmrveG4LEFglArTpciAFnFHKFeOpubUECgDNVF1q5h+j1+wlzTa5idR
   IoPufWgt4M7hMjhpmkN2M9OmSMTGYHvjpSy5c6UBr+5DyOA0Xu63CcIum
   etctk2Qmv02LhnhdcRdVluOKEIZL43Y1Da0CSdP/fh2bHcy+ACsnVZNUa
   +wOTRFoeXFdn+hcdua1T+7TUEZ1MELA0tToLsPioICqxDJUFyIcwTgyDN
   PH6TcgPVcwMOxQS5hJ2SAi1KzG/LtIHCc0I+8ztCe8wERLk0abrnkkmdi
   6tu08gWIcgWtEUN8LexFtFYgI/3Cr/VR6CqJ9DxPjku3mCPcatZDu6hYp
   w==;
X-CSE-ConnectionGUID: 9JmvUVWPRX22UFiUWKySsg==
X-CSE-MsgGUID: Rf2BnDOpTNqUONMUFTsaAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="90635541"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="90635541"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 01:11:28 -0700
X-CSE-ConnectionGUID: gzBlYUoJTZ+igJYJwLbpsg==
X-CSE-MsgGUID: 1r3IiSIcQ6WbDDQGojy6hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="243648180"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.3])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 01:11:26 -0700
Date: Mon, 18 May 2026 11:11:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Mika Westerberg <westeri@kernel.org>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12] gpiolib: acpi: Modernize string parsing in quirks
 layer
Message-ID: <agrJq9n_bm8YXyqa@ashevche-desk.local>
References: <20260518075357.112584-1-mscardovi95@gmail.com>
 <20260518075357.112584-3-mscardovi95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518075357.112584-3-mscardovi95@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 18, 2026 at 09:53:47AM +0200, Marco Scardovi (scardracs) wrote:

We do not accept patches with empty commit messages (it's not 2007 out there).

> Assisted-by: Antigravity:gemini-3-flash
> Signed-off-by: Marco Scardovi <mscardovi95@gmail.com>
> ---
>  		if (len == strlen(controller_in) &&
>  		    strncmp(controller, controller_in, len) == 0) {
> -			pin = simple_strtoul(pin_str + 1, &endp, 10);
> -			if (*endp != 0 && *endp != ',')

> +			char pin_buf[16];
> +			size_t pin_len = 0;
> +			const char *p = pin_str + 1;

Keep it in reversed xmas tree order.

> +
> +			while (*p && *p != ',') {
> +				if (pin_len < sizeof(pin_buf) - 1)
> +					pin_buf[pin_len++] = *p;
> +				else
> +					goto err;
> +				p++;
> +			}
> +			pin_buf[pin_len] = '\0';
> +
> +			if (kstrtouint(pin_buf, 10, &pin))

This returns an error code, is it got shadowed on purpose?

>  				goto err;

...

The temporary buffer makes an unneeded churn. simple_strtoul() will work okay.
Even if it's an overflow, it's user's responsibility. And since we have this
already, it's now part of ABI (kernel command line comes from outside of the
kernel).

-- 
With Best Regards,
Andy Shevchenko


