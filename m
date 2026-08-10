Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01B5412BFC;
	Mon, 10 Aug 2026 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786376601; cv=none; b=UcFImOKZgPEqIMIjcVZ8YQep3X9dAzvEtA17FofdiL+CoDgeCeDlAHAFovrc+iPjFdpUg6KYjgTZxCVtd5/C0svYFffRhAuoUfrcBmEXtTNwzneGDm7dpzMA++2MatO3kckULRD5uwUF+Hdt6xYqa+nExP70ikqqyAUbW8wJISI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786376601; c=relaxed/simple;
	bh=kSpYRxFesnNJJ1Ns1S+VbxA/rGQJaJ8W8iaBYFhenwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKwNrCBA3t+TXKT+4de0/9TLLhS8HXA5Z3dZsrAbqdjhX+YmpIG8pRQcFGwP7kD0Wk0xqK3lfFF8t2bnwKvFJ3NpT7bIYwAIyPGjdHyaIPURZn1BmQptN++NI5/vsqbpipOgFCxd0fRoxUZahX8zoit6RPx+MbaSqGOKt8UXr9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pv0qEcLF; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pv0qEcLF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786376599; x=1817912599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kSpYRxFesnNJJ1Ns1S+VbxA/rGQJaJ8W8iaBYFhenwI=;
  b=Pv0qEcLFAht2X/SJlSFV7B/uq/rky6aq19DQ3hWe5Fmljt2KErt+r2K6
   KC/QLoewgiYUw8hMcyYSRVhEtfFdKXCoDFsUjRz4IHvnIdkH52B4K3Dym
   hZJTisRxhM4tHT417/7N17OIG1p1tUfXrUXsnfWoSHF8hmndhMBlcFWST
   9ziF8Z9AisMB/ztSDw+uXSycY5w09iAIBhDZYe5aWA//buw+iL+820lJj
   iONYPFl1wL4fVygvb/fjXMShLjeUWNxZneCo9UdpXxQnCUjMZpJVQqnmM
   jM5rcE7QXBtISEXJLX09SKWSIp7m31yUiOiQdxJequmkJPLqBWAvu/CBI
   w==;
X-CSE-ConnectionGUID: waHvnBU2Q6qc/d1GRptsGg==
X-CSE-MsgGUID: 75m+ve05T2WOg/IiayYlhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="90573309"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="90573309"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 08:43:18 -0700
X-CSE-ConnectionGUID: MUKTrvwxTImvHAi29sLCDw==
X-CSE-MsgGUID: dReE5RHiTj65xZJNWXnaEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="261779686"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 08:43:16 -0700
Date: Mon, 10 Aug 2026 18:43:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 1/3] ACPI: bus: Introduce acpi_bus_get_primary_device()
Message-ID: <annxkiYsyfa4nh6z@ashevche-desk.local>
References: <4764923.LvFx2qVVIh@rafael.j.wysocki>
 <2283799.irdbgypaU6@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2283799.irdbgypaU6@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 10, 2026 at 01:33:41PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> The function used for obtaining the first "physical" device for which
> the given ACPI one is the ACPI companion, acpi_get_first_physical_node(),
> may return a stale device pointer (mostly in theory) because
> acpi_unbind_one() may run as a whole after dropping the ACPI device's
> physical_node_lock in acpi_get_first_physical_node() and before it
> returns.  The last reference to the "physical" device may be dropped
> then before the pointer to it is returned to the caller.
> 
> If that happens and the acpi_get_first_physical_node() caller invokes
> get_device() on the pointer obtained from it, which is done by the
> majority of its callers, a use-after-free will occur.
> 
> To prepare for addressing this problem, introduce a new function for
> getting the first "physical" device associated with the given ACPI one
> (the "primary physical device") that will also reference count the
> device in question before returning a pointer to it.
> 
> Make that new function and acpi_get_first_physical_node() share the
> physical node list lookup code.
> 
> No intentional functional impact.

...

> +static struct device *primary_physical_device(struct acpi_device *adev)
> +{
> +	if (list_empty(&adev->physical_node_list))
> +		return NULL;
> +
> +	return list_first_entry(&adev->physical_node_list,
> +				struct acpi_device_physical_node, node)->dev;

This is open-coded list_first_entry_or_null().

I see the ->dev, so having temporary variable will suit this

	struct ... *...;

	... = list_first_entry_or_null(...);
	if (...)
		return ...->dev;

	return NULL;

> +}

-- 
With Best Regards,
Andy Shevchenko


