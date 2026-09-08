Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A564E66B8;
	Tue,  8 Sep 2026 10:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862255; cv=none; b=Ml+o06ecmaYdHwFHGbCYOTrMyhOjlSxq1kKlmxrIyl9a7kGWaKeIFYGvVhP3DISvH6IT/kIJZ9gYjSnRR6GdF66ch10dZpq3kujWdIltaHHHDXIIPxrpmCPvDAI8NHaelvuRmZCEJn9ZIrEsGiRxV+Us8h7m8GQOsNsMksXa/OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862255; c=relaxed/simple;
	bh=AHxUGRiRnx/CLgRjxMWOyVMheita6x80DNzXfRCVnZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqusvQocmzRMoHWy+D4F5unIp1v1R1nYZ7Li6Ezx9P6cOoD/aCb5bRurH5E/wkQcVPLzsZhJhOPDtJuY/DYnDN73/0FOidRVM8MSM8i5h7F+XTWmYsbTyOz32XWeIwBbpizUkp4HL5ofvssQ9SbqhQPYzNbPTeDaY0U1f94ls9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eTZJA7OU; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eTZJA7OU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788862253; x=1820398253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AHxUGRiRnx/CLgRjxMWOyVMheita6x80DNzXfRCVnZg=;
  b=eTZJA7OUGSAOelG7YVdMh7Lr8jO49Y3l0adgHbUCkWiXDi2f3Lo+KAEN
   bDewciICkMtguX4Bn8HZiu/Sm1OSJnxCBDHFNm1meL6DjsL84pErwCI6U
   o7h7Pm5ELB9XimqT3kegs0Hcluu5rocaARDPUqwg9QDVxpeZ81TgPqyqW
   QBUUWaoOIARHtSCopL4CHTUmG/c/WizwNZuB/C6KS+bt3Yk5RXpfbT4dD
   1jb513xLsfelqbxQOiFP4llU3Q6UHHbGeosVooLtaAAgwLj4qjyDmQ2EA
   pGH7rkF65/SRQ0s9b2FxOQM4ZkWA1syZ2e7cd0zxxWbczp37wq1K8QcC1
   g==;
X-CSE-ConnectionGUID: TFQ96vdjR8ahhF+n3BgePQ==
X-CSE-MsgGUID: F5D6WTluSxypHgEl/FMyVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="99853766"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="99853766"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 03:10:53 -0700
X-CSE-ConnectionGUID: rZSfksbeRNun+rB95b/j7w==
X-CSE-MsgGUID: 2DBYMqv2T8ij4Juowe8KPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="274472913"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.92])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 03:10:52 -0700
Date: Tue, 8 Sep 2026 13:10:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] ACPI: utils: Adjust message printing macros for ACPI
 objects
Message-ID: <ap_fKdABWuOqbz5W@ashevche-desk.local>
References: <2300525.irdbgypaU6@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2300525.irdbgypaU6@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Sep 06, 2026 at 05:56:56PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> The majority of acpi_handle_<level>() macros use neither pr_fmt() nor
> dev_fmt() and acpi_handle_debug() uses pr_fmt() like dev_fmt(), but
> only if dynamic debug is compiled in.
> 
> For more consistency, redefine all of the macros in question to use
> dev_fmt() because they are more similar to the analogous dev_*()
> family of macros than to the pr_*() ones and make all of them use it
> in the same way.
> 
> While at it, rephrase the comment documenting those macros for more
> clarity.

Yes, makes a lot of sense!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


