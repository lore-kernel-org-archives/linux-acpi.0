Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C293793D2;
	Wed, 13 May 2026 20:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778704964; cv=none; b=B6nOifDLr0XXEe3JD/yZ63y50MNILJyCCsQnbeXGVgLoZg/EiWsS1QXCHPKsHx9zrLzvo1ldBGjk6tuu1qoxfxePvgNdMsF1zioDhyIqXMqeKt9IQk1E5x/ICdmxZbRA57OAFzFWlCLI4osqMXUkMq6NmIQEhTjK3sFnomQyLVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778704964; c=relaxed/simple;
	bh=b4tiv6EnRYdOIOYOWIdyTPnp4PG2IQAXzJLtKunbDJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1HpbNA/cxg240orHuKOc9Hqps/VudF5jrm2FgkUKLGM6vxpA2Lp1/1wPxPjKkzmJMC9BpjVLOELLbK4q220dUTjLWzFzi+bcufz+ffFH4QlgrRNYMOB0f2HOlXeEY74aBWQqqYZZ41Q/AahATnJvoFlBq3eHvHxIUZ+fpd+4KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YFPQ9lq3; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YFPQ9lq3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778704963; x=1810240963;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b4tiv6EnRYdOIOYOWIdyTPnp4PG2IQAXzJLtKunbDJY=;
  b=YFPQ9lq3wUEFgNpQHqL6tBJM/wI1UuVF/gWOsCAOB9Lz0mIgyJKZQOxx
   O4Na6exJ4oFCk1CpGaXJ8NZ+pc4k+MtkWipOlgCXvQCww/YH8t2AUuC4E
   gwb5Oxm3+sYfdfOpyh/NQh/AHL/IVYa50Rwt7V1OFX0eru9G8HgmEi9Tq
   qqvMHxroIsXXgflSPGHK5uUBUBdqfXn8guBvFRGSyXF/Nsc/QFn2H2o7b
   /OCO1q2hgTt4sJxdeWqlT/cL3USYJxVPHTeN/zBmtzpxpKRkQ8u6zkL9O
   qrSv5bgjOFOphJCe84iFWSlgP9IJwGgPERH/yr08LuaFfEI8pB4QVAMbC
   A==;
X-CSE-ConnectionGUID: WBAuOPUyQv+EnsjKxWgC0Q==
X-CSE-MsgGUID: zH8HjKgBRPexxrUXEj1aHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79595464"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="79595464"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 13:42:42 -0700
X-CSE-ConnectionGUID: AOQFnQSrQ/W+ULwGqcCaUA==
X-CSE-MsgGUID: r5gm8HS5TUm8Lasynt9MSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="243154783"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 13:42:41 -0700
Date: Wed, 13 May 2026 23:42:38 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v1] platform/x86: xo15-ebook: Use devres-based resource
 management
Message-ID: <agTiPgeCEEbUEWEY@ashevche-desk.local>
References: <12913455.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12913455.O9o76ZdvQC@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 13, 2026 at 08:53:44PM +0200, Rafael J. Wysocki wrote:

> Use devm_kzalloc() and devm_input_allocate_device() in
> ebook_switch_probe() for allocating the button object and the
> input device, respectively, to simplify the rollback path in
> that function and ebook_switch_remove().

...

>  	id = acpi_match_acpi_device(ebook_device_ids, device);
>  	if (!id) {
> -		dev_err(&pdev->dev, "Unsupported hid\n");
> -		error = -ENODEV;
> -		goto err_free_input;
> +		dev_err(dev, "Unsupported hid\n");
> +		return -ENODEV;

Now we can use

		return dev_err_probe(dev, -ENODEV, "Unsupported hid\n");

>  	}

-- 
With Best Regards,
Andy Shevchenko


