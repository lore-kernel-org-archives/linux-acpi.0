Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757611F09A5;
	Fri,  3 Jul 2026 12:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082946; cv=none; b=SKxIc+hF0F1wNqNdmQViGpkfXw8cOlsV+mLi36PLAjY7EP/mf6oB0JaiN/eIeguH/NXO5ZXHG8BxwEKu5OMDeRg9xHFiLyKj3BU6VkRiQ+q9ajIXLx9oWIUY/TzC5UIHTeShelU0n40vYc11WOMba79Gq0bO9ZeNCyK8tJI0uMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082946; c=relaxed/simple;
	bh=ZWeBm9fnFo7fd7SlqKSS/7ls4/c90Pe1K9fswByLNY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaDJpDnvfUcJP9Q/ngIHsY/Fvl1GC0dAr7Oklfb6qCxv+/ZKudxJBKjMCRKOyGSZSCx8Ni6NRS3mfJcn0WP6/A1EkHRzEVKY5Z9YKvHXDZnoIWu/K7TxCseSAKu5vHThdmzdn0ihflcYOvYu1a4jmrRpwoKdXVtCi8sXDkhW38M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gSzmUE/7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gSzmUE/7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783082945; x=1814618945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZWeBm9fnFo7fd7SlqKSS/7ls4/c90Pe1K9fswByLNY4=;
  b=gSzmUE/76EDmR5NdiN/UWKQPxyUMkx1UQCJlUZccENlAI9QKcOvubQDJ
   d/r8DuWUjZUILBv1aNYC8EgLx0nCPgcp/C1WZTD+PlUAgRGcdghLFVIJF
   Z17cg3shy0kEEWbqbz6W/vWKIbam5EPto1Immb2NFPNrZYqiSHfXJcfrV
   MAcEiyTI9JYDaylKJUTkleHECzeA18ncVYiQQAmCXn3eZbf5vSwkCkzKC
   8uS1fn/Z/TxLyKWJpcpl0Czxejn10EjeecmDbM1XMbgvQdq7XLiawcILZ
   GhKuSML3vaQWSA5okb+dA2aw/nX+x1BaSj/bULdgAHcIE7OHri1cGTHFQ
   g==;
X-CSE-ConnectionGUID: 0h8NY8r9QUuptq8b7cBMCg==
X-CSE-MsgGUID: HC/c1IKmT42wwgXJK+rdWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83705414"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="83705414"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:49:04 -0700
X-CSE-ConnectionGUID: dL/+Rz6aRgaS9fwK9EJE+Q==
X-CSE-MsgGUID: ZnVLkZ9DRCSFhwtAtKZnKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="252646263"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.80])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:49:03 -0700
Date: Fri, 3 Jul 2026 15:49:00 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Herton Ronaldo Krzesinski <herton@canonical.com>
Subject: Re: [PATCH v1] platform/x86: topstar-laptop: Stop setting
 acpi_device_name/class()
Message-ID: <akevvLJNxwcJfaML@ashevche-desk.local>
References: <12951216.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12951216.O9o76ZdvQC@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 03, 2026 at 02:41:51PM +0200, Rafael J. Wysocki wrote:

> The driver sets acpi_device_name() and acpi_device_class() which are
> never read afterward, so make it stop doing that.
> 
> No intentional functional impact.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


