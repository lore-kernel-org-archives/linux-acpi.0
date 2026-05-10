Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7138C24E4AF;
	Sun, 10 May 2026 06:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778393955; cv=none; b=kCS8KqE6GVrz0eVZIzmrDruBJ/33ElOfODha/V4Dn3V6KVd1sXeIEPW5nLamoi2VzDPI14b/5q1O1DKaihJmew77teGFWKu1awSehQ2jrentk6vJoujCsQp2tnwz3CuZDooMCRiHRTmuYBvJkkgGb+TQ9t3gxHpUBRI+2qHO7Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778393955; c=relaxed/simple;
	bh=zgQD1poEEFdFBZRxRsQi2jZfPLh0jDmxyf4dQiXT9Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebX0CJMk4JQoXsoMv1RysB5QJbeeYKQCgzKdZJ1GNgbTmukC8OYY29pK7qg6PZHB53kaSRYMmh0LJ/FScPPbDdaa5v4F2lPy+Kt2K4/xpN4MR3M0JRdiMw/H//VAM84SCr5gIe1bG36u10UPSiacwhMfgEZ4Z08/9fkRDXmLdGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XVe+pZQE; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XVe+pZQE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778393953; x=1809929953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zgQD1poEEFdFBZRxRsQi2jZfPLh0jDmxyf4dQiXT9Vg=;
  b=XVe+pZQE1vri9ieVi0maKtnDR0daY9I8ugr7LR56w58axF5+VQmWsyZb
   HAppkoGtG3qedo7sxNt+Ydk+mzO1tERoRwintRs4r1dRX4zZWxrOWfWzY
   iXEoJoZWqlG+8b63BarL4Kgu8KAT1NcIup+jzeOjf89W9n+oTgE0MziKl
   a3Djqm9Mw1/UHhlYYZ7PG4fU/NakIIVqlRU3MhoCO/AfeXdffaVYDizkM
   CnirWqWbVa3OR7V3laYIGxDbMAkHcXLBal4NmZtRfysE4QDDhpScESHsI
   Zg9GIkXB7zzBd8RAuT5WF0Sz2h9J7dlfD5+E/s2EjoFqyvbGz6nYMeqrT
   w==;
X-CSE-ConnectionGUID: D1sblXn1ROO7XyOXdxvqtQ==
X-CSE-MsgGUID: egM6RkL9Sb+fLzRP0Sd+vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="101983548"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="101983548"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 23:19:13 -0700
X-CSE-ConnectionGUID: ylQy8OFmTki4ApQgozksXg==
X-CSE-MsgGUID: HVQJew80TCK/1M7jSNnrLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="267518246"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 23:19:12 -0700
Date: Sun, 10 May 2026 09:19:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v1] ACPI: driver: Check ACPI_COMPANION() against NULL
 during probe
Message-ID: <agAjXbnPamNFd0gA@ashevche-desk.local>
References: <4516068.ejJDZkT8p0@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4516068.ejJDZkT8p0@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 08, 2026 at 08:04:33PM +0200, Rafael J. Wysocki wrote:

> Since every platform driver can be forced to match a device that doesn't
> match its list of device IDs because of device_match_driver_override(),
> platform drivers that rely on the existence of a device's ACPI companion
> object should verify its presence.
> 
> Accordingly, add requisite ACPI_COMPANION() or ACPI_HANDLE() checks
> against NULL to 13 platform drivers handling core ACPI devices.
> 
> Also change the value returned by the ACPI thermal zone driver when
> the device's ACPI companion is not present to -ENODEV for consistency
> with the other drivers.

Yeah, or somehow to disable that matching.
As a (quick) fix this patch seems fine to me.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


