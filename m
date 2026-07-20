Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80897405C3E;
	Mon, 20 Jul 2026 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784548295; cv=none; b=a8XZQgdb7Kv/vR32o3sjpYRgxqDrWYWa2pGMVmsw/kPUgJnqqdrgFv2tygT0J7AmDQOTHbBtJs41SfMSNakLX6JDLQLDz9UOcoLdueaJJsC9MZqeckKPUdz6dnM9eVwwYLHc+Ca8jzYqipoFPCc96AHhuRqIx+ciX1GhofNveZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784548295; c=relaxed/simple;
	bh=Fp+tjSkmn/gRsigNwXnvYIho9dEMKry/pWvnQvyTz8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGvh3uSwr3tHYOFfIjKAS04cZyRxsEgkshExXR8dLzYudolFI1UfZ298pZw3xrvKqvgpk33qIAlRljtkVOImJqWKrLldaW6SKXNWn6ZDFC0xbpNgq5DYqkirOUGF15/05Eu1ixOukA9wqhP4wffPicUOCMNqHYqEcjEzPK5LRY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l5yAXH3e; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l5yAXH3e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784548295; x=1816084295;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fp+tjSkmn/gRsigNwXnvYIho9dEMKry/pWvnQvyTz8c=;
  b=l5yAXH3ehfL4ozWTXnIyF2OcC5e5ZvsATPRd5Uup30N1i/skRWk9PpTH
   vWaz9lIyjbR+VKsZUiHnu46NRAYByK5B/Kb0N5yYbObJGC6onzVd06gkN
   z3NTFcgMkA/3BdLeaiktJVyONWiYaFeelEIzm1HLlSbGfRAaUSantp9Qb
   Nfzu788/XjMiKQeV8rXAiZOhJDfa3EyhcFpIJdJUBDDw2fen/lvLzkvkM
   b+K1XhQheeVoQLNfevzBKqZ9OEcyGfkHq/NuuyQUJXjkxUUDpPiu5fisA
   OdsmZsI6OwsnvTwd2dKngnGd2Qkk8N8VAdzlHpUfcB+J1HDuRHTtAc9Sz
   w==;
X-CSE-ConnectionGUID: xzWn0ZZpTZi1P6vhPSvdAA==
X-CSE-MsgGUID: 9WQx0rSkQgiiSYc7KmHEGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="102676288"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="102676288"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 04:51:34 -0700
X-CSE-ConnectionGUID: /eOSUtt/RL6YXwgBQqc9bQ==
X-CSE-MsgGUID: z7tHEYdnTZeiCUGdFZaliw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="251093296"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.175])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 04:51:31 -0700
Date: Mon, 20 Jul 2026 14:51:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev
Subject: Re: [PATCH] device property: add missing kernel-doc for
 property_entry
Message-ID: <al4LwVQ8aLSlP-dk@ashevche-desk.local>
References: <20260719223640.2864890-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719223640.2864890-1-rdunlap@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jul 19, 2026 at 03:36:40PM -0700, Randy Dunlap wrote:
> Add kernel-doc for the missing fields in union value:
> 
> Warning: include/linux/property.h:406 struct member 'u8_data' not
>  described in 'property_entry'
> Warning: include/linux/property.h:406 struct member 'u16_data' not
>  described in 'property_entry'
> Warning: include/linux/property.h:406 struct member 'u32_data' not
>  described in 'property_entry'
> Warning: include/linux/property.h:406 struct member 'u64_data' not
>  described in 'property_entry'
> Warning: include/linux/property.h:406 struct member 'str' not described
>  in 'property_entry'

...

>   * @pointer: Pointer to the property when it is not stored inline.
>   * @value: Value of the property when it is stored inline.

> + * @u8_data: @value as an array of u8 numbers
> + * @u16_data: @value as an array of u16 numbers
> + * @u32_data: @value as an array of u32 numbers
> + * @u64_data: @value as an array of u64 numbers
> + * @str: @value as an array of char pointers

I think the proper fix is to add

	/* private: internal representation of @value */

>   */

-- 
With Best Regards,
Andy Shevchenko


