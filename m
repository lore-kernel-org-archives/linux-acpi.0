Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D988724DFF9;
	Mon, 18 May 2026 08:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779091665; cv=none; b=dn1MimuYXy9eKMMvYQ0AMqs6W9raqVu1NaRv0y8/RhnEzKVMCnu9lrqqGeamBH5iIsNl5GaABJayZXl5fLIB756bOq4htzch7W+FiE4zQWN4U6Lc3pTVz3j+k/nvFykA/VkOzglhYIdPkSYB+kz+vsEilH0ww5HPWnD6ZVJsgVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779091665; c=relaxed/simple;
	bh=hIE9hZ9VHJc5Om9Yytiyg8C3s9ElWKQYbnE1FqHjSeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coF3eJr9oWiBVIWVvIlRHAiR6RwyGqbQlACPABUtc6P6bLODuPKIp5QVR40xEMzpoBwm8MwsfxK9Dh7Yfew3SeziiCMdjuNq7uPeoRAiP4dr0PejUaN8XjMP+Z6OLYfkAHt9UHhLW57KE1a6jGAoo9PDvLAplq8H0ak7dw1zGrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kea1xQj9; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kea1xQj9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779091664; x=1810627664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hIE9hZ9VHJc5Om9Yytiyg8C3s9ElWKQYbnE1FqHjSeY=;
  b=kea1xQj9j6QetLFb5SQ7J6LH93kgBc7Nr6xGxNRE9zecEMnr1bF4UM4q
   8ayvHZtMxxA5fGS9REaRzJyUPC4mQzn2YuHcQ1e8LiUNPT+4B6P8krowG
   nbDbBCovW/OFB2gD6xqQNt+WMH8BP+2d9401NDFdRaQobofKo3JqGXKOn
   SLY7is1i6n7n/HPrzExG5twlpgX4/pv4+pHzmxI8UeW1tRlGhSp36MQTz
   jpZlpNPYZ0K0STzUrjN3/Su2RMC/HB2isobeeh8WSAnfxvnY+5lpRGRfV
   L0U+zz/QjG+tE1zS8YOeGfL3SN09GJ4BYf4MxGU1W2tSxc7Ea9YMpHum6
   A==;
X-CSE-ConnectionGUID: MXpcPKXrRyeYvqNcMX+uUQ==
X-CSE-MsgGUID: +QER8CEWS+mX54pCWFep+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="91329370"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="91329370"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 01:07:43 -0700
X-CSE-ConnectionGUID: P0+452UoTB2SVwQjI2IvmA==
X-CSE-MsgGUID: Ju1MHwxuTY+EvVH5OSvY9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="262875494"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.3])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 01:07:41 -0700
Date: Mon, 18 May 2026 11:07:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Mika Westerberg <westeri@kernel.org>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] gpiolib: acpi: Use snprintf() for ACPI event name
 formatting
Message-ID: <agrIy5i6k8IBVVBp@ashevche-desk.local>
References: <20260518075357.112584-1-mscardovi95@gmail.com>
 <20260518075357.112584-2-mscardovi95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518075357.112584-2-mscardovi95@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 18, 2026 at 09:53:46AM +0200, Marco Scardovi (scardracs) wrote:
> Replace sprintf() with snprintf() when formatting ACPI GPIO
> event names and fix minor formatting inconsistencies.

It has also unrelated stuff. Do one thing in one patch.

...

>  	if (pin <= 255) {
>  		char ev_name[8];
> -		sprintf(ev_name, "_%c%02X",
> -			agpio->triggering == ACPI_EDGE_SENSITIVE ? 'E' : 'L',
> -			pin);
> +
> +		snprintf(ev_name, sizeof(ev_name), "_%c%02X",
> +			 agpio->triggering == ACPI_EDGE_SENSITIVE ? 'E' : 'L',
> +			 pin);
>  		if (ACPI_SUCCESS(acpi_get_handle(handle, ev_name, &evt_handle)))
>  			handler = acpi_gpio_irq_handler;
>  	}

This doesn't seem to anyhow make code hardened or so. I'm not sure I see
the point. Also you may check the Git history around these lines.

>  }

-- 
With Best Regards,
Andy Shevchenko


