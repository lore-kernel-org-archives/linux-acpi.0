Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7D23BD224;
	Mon, 30 Mar 2026 10:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774866837; cv=none; b=cL+f4hAnzjDnwJJ9aSQFFVpVOIPXkIXab6sOv6I3RCUGFpt6ArO+myvxJAstYmxOhhy1mNa/XblQMu3p6yyV4kZr7QIjiJ3mit9BlDzv/F6z+rRTJwbw7C+ZjrJGHwNC6/zy6Sk0E0fsIY39wQZsk7AhrHTHywRltZdsegWX1Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774866837; c=relaxed/simple;
	bh=smtoMUyBw2zlPEJe1p2Y3KgoOTvix2CcJIM4zEKIHsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiPyzcW/eiyGU8k4WqGgqBFbv7KFTJ+g3AquC+TJ4IOG6tJWg4cj5uV+dk1EK94X95guqChPPSiJiqiqYPJ+rCOHhe7zkcose+DGrNN3HJID+vOEwDiSKlqpxCCrkx1WMf0RAyRq2Gs4l78B9Hig442UC9h0MkJ2CxHyOGtR7hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZwCTe1aP; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZwCTe1aP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774866834; x=1806402834;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=smtoMUyBw2zlPEJe1p2Y3KgoOTvix2CcJIM4zEKIHsc=;
  b=ZwCTe1aPx7fK0SHwjSerLWZXXFlDJknW331hRuq0jxAxPkXDr4rRnsGY
   G3pWvehY/2UN/NrSThOmjHGHUGY8AG44RLocPE7r5du9UALeQe1Hu2c2D
   AjwDmTg2y7ZgN9Jl0n09xIrDPnPABxaulX5xU1WKrdMKzlbdXHhULMCcf
   dEzReypO2qvmjZi9Qfk1S5V/k23xNW+Fd+KjAIgwO8HNmE9NsKonDtT+W
   qt2J7mhx4t4xPskr9pUKM0mhuHCqdkvajS0+Yb751j7pFklU/c+EEHFn+
   Q+0X42SwnHgNxZwocsopB9YuO01Cy2fsykqdQPPrGNB4j0kxW3YQ0dpmb
   A==;
X-CSE-ConnectionGUID: XDCVrJINQZGqfyBVG5ZsXQ==
X-CSE-MsgGUID: wP8gqgj5SJqPi/zAo7u5jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="76046062"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="76046062"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 03:33:54 -0700
X-CSE-ConnectionGUID: 36Vv7GHeQJuXo0BHyud2JQ==
X-CSE-MsgGUID: T4J8RlLARIam4uWxHy7T/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="226270252"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 03:33:50 -0700
Date: Mon, 30 Mar 2026 13:33:47 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: Re: [PATCH v2 3/4] software node: verify that property data is not
 on stack
Message-ID: <acpRi0BOgT73pqpE@ashevche-desk.local>
References: <20260329-property-gpio-fix-v2-0-3cca5ba136d8@gmail.com>
 <20260329-property-gpio-fix-v2-3-3cca5ba136d8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329-property-gpio-fix-v2-3-3cca5ba136d8@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Mar 29, 2026 at 07:27:50PM -0700, Dmitry Torokhov wrote:
> When registering a software node, ensure that the property data is not
> located on the stack, as it is expected to persist for the lifetime of
> the node.

...

> +	for (prop = node->properties; prop && prop->name; prop++) {
> +		if (!prop->is_inline && object_is_on_stack(prop->pointer)) {

I read more about this... Any code that uses vmalloc() (or potentially may
switch to it from regular allocator with help of kvalloc() and similar) will
fail now. While it might be no issue right now, this may become a such. So
with this check in place you put a requirement that properties can only be
allocated from a kernel low memory heap and not vm.

> +			pr_err("%s: property data can't be on stack ('%s')\n",
> +			       __func__, prop->name);
> +			return -EINVAL;
> +		}
> +	}

-- 
With Best Regards,
Andy Shevchenko


