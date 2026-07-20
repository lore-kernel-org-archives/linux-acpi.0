Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12B438F255;
	Mon, 20 Jul 2026 19:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784575785; cv=none; b=lvw2kvN5wc4k8UARAPWAT/u0uO442oVHIoJcqA0WP+VHfB/wSQacxOJ+rXNSAKBj26RmCv0Tpr6e2dw64dSgdai62yB2kmGPBb8JbPmeW455w+UDYq76LiA9KMRaZgN5/8utEyOiCVJtn4jYa6VH3gWO7PLF+IaJ98f6R9AWWFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784575785; c=relaxed/simple;
	bh=75mjon7dmPKbIW2yMRYGkFCgw9C+ZdhWHy5Z9fWxJXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7ixQ3fc0bZvFpmzoQ/cRz1FXgBNgnsBsw7Aau0LSEKgRqRqevbLgPuAUs/JjZ8jDolrHs606wibqTPm0ulwuTDqEUyYsgRmW6PXBAGUXehOHBc8b+ysjxauoIMsR86Uwy1bVswgS93Sq4Tij5hqNGjx0MGvtXv8gk303wG3ooQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VtoXMF49; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VtoXMF49"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784575784; x=1816111784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=75mjon7dmPKbIW2yMRYGkFCgw9C+ZdhWHy5Z9fWxJXE=;
  b=VtoXMF49BBD2HejYajZf3d7dxQrfcUjvtrtJg7OPr0O/vT7LUK9fQPV+
   kq1rlajrQ1nNSx8Npnkk6soLFjoLhOCEo7w1ND5vfpXK/i0DcqfIm9g+k
   oq3fmkyA7Im09TTV3is48riNJxsCpm+yr01gHxKVlhXWJgULutdydLoJ4
   +dTBGjg/RLHJysuk4rmOWvQRCU/i5vnUUnVEREAEjl5guCAAk/+85dWg1
   MTHF/7vO9F/fWlPqtaWlSTNKeC5dXjPJ4csEaE+MsW2vy5b9P8HVCRgdn
   XQWxp7s5G73j65zM0/HTBDvUHqUQPTpX39IQ/fhXtbdQsXhGGcbWYPejC
   A==;
X-CSE-ConnectionGUID: Zxw3eHF7TkOup2pPZFUTOw==
X-CSE-MsgGUID: FQl9Yo0KT9KCBRojDoEP6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="107954618"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="107954618"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 12:29:43 -0700
X-CSE-ConnectionGUID: LMXVJUwoSXO+hRUPrxKatA==
X-CSE-MsgGUID: fsZct4E1Tia0J4HUpjjJjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="256357632"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.175])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 12:29:41 -0700
Date: Mon, 20 Jul 2026 22:29:38 +0300
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
Message-ID: <al53IqzXBOJrm-lc@ashevche-desk.local>
References: <20260719223640.2864890-1-rdunlap@infradead.org>
 <al4LwVQ8aLSlP-dk@ashevche-desk.local>
 <25e056d9-708b-4477-ac63-726e1a01fdd0@infradead.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25e056d9-708b-4477-ac63-726e1a01fdd0@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 20, 2026 at 08:30:59AM -0700, Randy Dunlap wrote:
> On 7/20/26 4:51 AM, Andy Shevchenko wrote:
> > On Sun, Jul 19, 2026 at 03:36:40PM -0700, Randy Dunlap wrote:
> >> Add kernel-doc for the missing fields in union value:
> >>
> >> Warning: include/linux/property.h:406 struct member 'u8_data' not
> >>  described in 'property_entry'
> >> Warning: include/linux/property.h:406 struct member 'u16_data' not
> >>  described in 'property_entry'
> >> Warning: include/linux/property.h:406 struct member 'u32_data' not
> >>  described in 'property_entry'
> >> Warning: include/linux/property.h:406 struct member 'u64_data' not
> >>  described in 'property_entry'
> >> Warning: include/linux/property.h:406 struct member 'str' not described
> >>  in 'property_entry'

...

> >>   * @pointer: Pointer to the property when it is not stored inline.
> >>   * @value: Value of the property when it is stored inline.
> > 
> >> + * @u8_data: @value as an array of u8 numbers
> >> + * @u16_data: @value as an array of u16 numbers
> >> + * @u32_data: @value as an array of u32 numbers
> >> + * @u64_data: @value as an array of u64 numbers
> >> + * @str: @value as an array of char pointers
> > 
> > I think the proper fix is to add
> > 
> > 	/* private: internal representation of @value */
> > 
> >>   */
> 
> OK :)

FWIW, while checking this, I found that kernel-doc seems missing the case as
above, so the proper handling via @value.u8_data: and so on doesn't work
because it's wrapped in anonymous union, and there is no such examples in the
documentation.

In any case, those fields are indeed private (or in C++ terms more like
"protected"). Hence my above suggestion is the way to go.

-- 
With Best Regards,
Andy Shevchenko


