Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9785836D500;
	Sat,  5 Sep 2026 06:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591419; cv=none; b=o/kv4/sJ3/trEbC57br13qc1CcOyMmPhyXUWoi9G3ZKZp44ELTfJx9USZaIPViKijSSjLuaYToZu/gKIcMvlDPUb5+8cLpHNt/8hH+zjNztVO3HCaaXB3QPrJ6Jy101ABQyOqvdH11FmsyZQDoOeRjGSHfJr3wGfIqserHnOpuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591419; c=relaxed/simple;
	bh=TR2O9ECcg6yQtpwzX9vsx4nZ+WrTN6YKf5+Cft5E6Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9geR1eoq1wIMf4EXkMheEMlJTHqh02wJrpZ2gaH7DxtGb0Gi0Vu66SN+tyXG8hlHNrDKuG4QJ1FfBBYWTpMUnPMAji81GPRS1uaytr4z8qjJVu74A+lHgsE3Ydju2VFH+0QDMibLSOSknJylUHFG5buOe1qx8bzDjkI4d0jnWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I4kfNSLl; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I4kfNSLl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788591417; x=1820127417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TR2O9ECcg6yQtpwzX9vsx4nZ+WrTN6YKf5+Cft5E6Z0=;
  b=I4kfNSLlRP6QV8o4iEGIrxoR4xwkTImC9czD2gMJKnIE/V8KyqojPBY/
   Xg9MgWLh7FeYzrRsJoR4UCLlXgWTxRNY+5cw+kxcNLL7ZXbFBrfCG09Uk
   1HFyfH5Dff73QWh6bxJ+TL2IXVlkH3Cg2xKlyUjvIe5ZqX/k1RxDL+N1i
   CJTZaenbLSBIJo6HcjevA15dxXgn0+oqacBDlsBtWetN5VoFou51hYAGd
   PyEsBtZXv+BryMf4kNb7suFdycbHIQvTHAzLiUQHZc7gOqPxLutFqs/db
   sSQRAy8uwRPVDf3UiMZVrUPd+Ai0rtMx8srfUVJYbX7pfmGtv3t8f3qXQ
   g==;
X-CSE-ConnectionGUID: /VQ/y8/JSRWb/xEAawhz3A==
X-CSE-MsgGUID: 42UEiH6jS3iPy953SYJguw==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="100245121"
X-IronPort-AV: E=Sophos;i="6.25,263,1779174000"; 
   d="scan'208";a="100245121"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 23:56:56 -0700
X-CSE-ConnectionGUID: jZlFHu74Sw2oy0YRMDcQuQ==
X-CSE-MsgGUID: 6EwboxHuSZmPCh7vgBvYng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,263,1779174000"; 
   d="scan'208";a="295108721"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.105])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 23:56:54 -0700
Date: Sat, 5 Sep 2026 09:56:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] ACPI: glue: Reduce debug noise from
 acpi_device_notify()
Message-ID: <apu9NIro83DpSu3z@ashevche-desk.local>
References: <2868233.mvXUDI8C0e@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2868233.mvXUDI8C0e@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 04, 2026 at 02:55:03PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> When debug is enabled in the ACPI glue code that handles binding
> devices to ACPI companions, acpi_device_notify() produces a lot of
> message noise related to devices that have no ACPI companions.
> 
> Reduce that noise by checking the most obvious cases, ACPI device
> objects and devices without a bus type, directly and returning from
> acpi_device_notify() in these cases without printing any debug
> messages.
> 
> Also make the debug messages that get printed more informative and
> change the format prefix to "ACPI/glue", so it is easier to filter
> these messages.

I would argue that the consistent formatting will be "ACPI: glue: "

$ git grep -n 'pr_fmt.*ACPI: [^"]'  -- drivers/acpi/ | wc -l
24

The / is used only in two cases: acpi/hmat and acpi/mrrm.

-- 
With Best Regards,
Andy Shevchenko


