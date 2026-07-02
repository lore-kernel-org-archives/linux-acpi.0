Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5854C3A6B7F;
	Thu,  2 Jul 2026 09:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983757; cv=none; b=a5fwPDu+S7FbgwbT9G8H8UHE68IFJVU3Q/ZYI9+gYBwFdbQXFICwgB64PXO7BYG+s9RJznwG3mIbhl5FMP9KlrVaHN2Ev40Y1HPlRGjXEI16YR+mH1eawrTzM7fPJGHTAPIaKICEP9N+YdmFGcvNn3f2CpNdakQgsxsqTRraDYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983757; c=relaxed/simple;
	bh=MnM5Is1Jb3E8Tt3TumhPu3e7wva41E/sp/tlrTvBIUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdECRRmqn0Rrg6WCcvYT00jo0xW0ffNziGjTwevJu3IvHI+gmWlPAeAVNAB5ceIfBezMpkfwQUCfFGelkyUAkzHZkLgCIkLXYiK47zXSSE8jN75QFLhM0Zvoy6wN6yUSTnNLMVKo2vnPso58/ZXjlc06U53VxzB5Jco7Q3hZ/5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eT0p3qPv; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eT0p3qPv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782983755; x=1814519755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MnM5Is1Jb3E8Tt3TumhPu3e7wva41E/sp/tlrTvBIUs=;
  b=eT0p3qPv4n4/hLZCYGARurq/mPHZWFSWt9xA73dUHRe+EbGXFMI5Jj3m
   QklwK1A5MA23H8TwowZ3GZNsafJpWNqVZ6ulbxfS3LLKZP4/p7Bp4VDw6
   djWAvXriU94aFGTpjKHsJ/m6NwUqmQF4VmsoFBS33TOOuQ84LDHY+QCyq
   bR632mkDln3N4/vEXPliBxRttd3FwlWh1aKoJd6wbskDRlgZ2v5/Q48OA
   NpHQdz//jIQX210IwIDuM0703IDmNXn0WdYa5oMxBX5aaOA43zgdYezR+
   DTGrXy2I4D6AyZm+Q2klLpaKXtsu2iy6gw1w/frlfi4NvqjYVszeSJFSc
   A==;
X-CSE-ConnectionGUID: dIDzq1BGQDiZKOcYxnsN4A==
X-CSE-MsgGUID: v1lC76I6Q2OR8Ic+OuRP8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83863157"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="83863157"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 02:15:54 -0700
X-CSE-ConnectionGUID: qsRMGnTPTImeK28S5z2IdA==
X-CSE-MsgGUID: RGgk0Xd2SMeV8wOFW+2zjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="257149632"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 02:15:52 -0700
Date: Thu, 2 Jul 2026 12:15:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	driver-core@lists.linux.dev
Subject: Re: [PATCH v1 0/2] ACPI: bus: Remove struct acpi_driver from the
 kernel
Message-ID: <akYsRl024Ll80oye@ashevche-desk.local>
References: <6027395.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6027395.DvuYhMxLoT@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 01, 2026 at 09:15:27PM +0200, Rafael J. Wysocki (Intel) wrote:
> Hi All,
> 
> After converting all of the drivers using the struct acpi_driver interface to
> proper platform drivers, that interface can be dropped now, which is done in
> this series (patch [1/2]).

What a nice result!

> Additionally, the no_pm flag is set for all struct acpi_device object since
> they are not going to be directly involved in any kind of power management
> now (that is, they will not have PM-aware drivers and they will not be
> included in PM domains).

I am in favour of this cleanup!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


-- 
With Best Regards,
Andy Shevchenko


