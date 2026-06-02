Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C9C3126C2;
	Tue,  2 Jun 2026 22:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780438223; cv=none; b=nbOkPEGbdryxIJ82pTQwqT9PIa/PJ+aZsTR3if7P2pAZ9OiAaJH7DkvdwhZ+Mg5KvpWtJY2bZMOQlzWRtD2LrcqJ+EX2RmQVYhza4qYs+1SM6NBqF7Ntz2Q285M591sWfbKZBwrwVtQFryvYjHEyhpi+jgZRkg7vf6XPT/8W8UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780438223; c=relaxed/simple;
	bh=GAJ9AxVYHxLr8aEdjTbMyrbJiMM5A2SAwdnY5FQWiEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nx1pcnSwGFI1/1ZBXCsHr6SrDUqWBtcvkfcTpNzKDslpawsWeDbBTmGX6HUiApg3iNWzKonVIBWlKpPZptaCfsCFcTkz5W0xoztVW+f8ELZ8zCpviOwP4j+yvnjSzKxoWhXTfNkYq8wExUftqmhjC5QbBcBtkrBKoR0p136hRq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mleeQ5L0; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mleeQ5L0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780438221; x=1811974221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GAJ9AxVYHxLr8aEdjTbMyrbJiMM5A2SAwdnY5FQWiEY=;
  b=mleeQ5L0CGVhakLLX5uAHdGE+XwBXaD0eNvgQ0Yi9GcYk28jaxwLJLRE
   RFyz5+WRKDQy+QtmXK5J58rwYMMPYAKC0c7Q9vKzibI5UCF9Q+Cospi6P
   Lf0OsYB848GSBVOVkiMzJupWsk0DKvxcQtC6piwEjjrsf2TzTzC84aOM9
   G3RBv+fYa/WJDIcabOs5aHu/Q+ADlcIcl3CXVCViq1upHWKR7NaEwhVq1
   B4O+pAFh5jFdN40d/LpTdHygch8+78u6e2w8KzE+pcLt6FkHXoDlqs72b
   0oBuQgxDAAaFcGyEscKkGOiK2zByseW0KaC9k1Yi96YbUSP4m/JJE+Ko/
   Q==;
X-CSE-ConnectionGUID: cRevsgkqSMi51z1yjW4bew==
X-CSE-MsgGUID: 8jYdAiRmRWa7Eiyob8jE8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="68778630"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="68778630"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 15:10:21 -0700
X-CSE-ConnectionGUID: usGoQYf+SUqoxIXAk7fgjw==
X-CSE-MsgGUID: /3owYF0uR4iwAPE06Z3/YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="241547026"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 15:10:19 -0700
Date: Wed, 3 Jun 2026 01:10:17 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Hans de Goede <hansg@kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject: Re: [PATCH v1 06/17] ACPI: HED: Switch over to devres-based resource
 management
Message-ID: <ah9UyXwsLAjIJEff@ashevche-desk.local>
References: <4739447.LvFx2qVVIh@rafael.j.wysocki>
 <7950702.EvYhyI6sBW@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7950702.EvYhyI6sBW@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 21, 2026 at 04:04:03PM +0200, Rafael J. Wysocki wrote:

> Use the newly introduced devm_acpi_install_notify_handler() for
> installing an ACPI notify handler and since that function checks the
> ACPI companion of the owner device against NULL internally, remove the
> the explicit ACPI companion check from acpi_hed_probe().
> 
> No intentional functional impact.

...

>  static void acpi_hed_remove(struct platform_device *pdev)
>  {
> -	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
> -
>  	hed_present = false;
> -	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
> -				       acpi_hed_notify);
>  }

devm will be cleaned after this, right? So, here is a window that if one tries
to unbind device from the driver in one thread and do the opposite in another
they will see the flag false while resources are still allocated for the old
one. It seems that hed_present should be also devm:ed?

-- 
With Best Regards,
Andy Shevchenko


