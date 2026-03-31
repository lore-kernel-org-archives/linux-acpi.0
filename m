Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3B53DA7D6;
	Tue, 31 Mar 2026 08:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774944136; cv=none; b=gtZ2dOHGkBqIkrbkBP04txpt6pZitIT9wnAjepIkfOj0HHK0eYa35lcT6gabLDJBg9CwJ0+RAqmN1l1R3AZpY+SWtVGBf7b6ad5StuR3b7MIh1+68+VRLwgHERK5hu0+Sij8iDYpGwhmAlMKzmmrW7ZpLTtii9rxT9CFSmscCXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774944136; c=relaxed/simple;
	bh=XtNYc2qP1eiUp5JnrJI9cDtMe9sjxEtm602IJHUnYLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuwCdLkinCQoQRJg6p5Bx3YEg6hBdM3mLz6a1rssXxjyNG9H3OhY8U1g3b8V0siqGGwDjRZfvlgBg9stjcKJxoo31Q5wWn76vl2BCInNafR+iTAR6Vg96HBK7i6RYnpL9xzl7qMG0VEfV/fZhXYy++9Hevt7X/hT5dC41pTnu/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CxKg890n; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CxKg890n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774944135; x=1806480135;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XtNYc2qP1eiUp5JnrJI9cDtMe9sjxEtm602IJHUnYLY=;
  b=CxKg890nmlQu+6TGrrluZvYbFQX1tB73F2bpLJD7Zkede6MIAplneBaS
   I8RgD4ybJWReRGH1opW1avCgLXQ7kJXjDl9hg7GwTHuTPz6ZuDpQI4Vcq
   OcG/rirb2JzSW/se+igbEbIeW8YUgv/6lxFKtzphaw7FAqqQk97sNHzrh
   TucQmrRm02GvMBg4ozowC868trq1++qmXMpbX8j95lbIlN29upaWXTXuq
   jeWq+8dcwD2yZCeBmDkNIdkdb8GM0QCtvGC6ZMhSmJIc7/ZebjLpbfvsG
   yckqazvhE1om9GqAtHRvXLX2KQ4ehTz2PZALbZPRlFk8zjrBnJUoE9JUl
   w==;
X-CSE-ConnectionGUID: lHwa5Xd+SueRZxLHrQ2P/w==
X-CSE-MsgGUID: Bms5Z94nSEKTyTV72libyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="75120810"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="75120810"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 01:02:14 -0700
X-CSE-ConnectionGUID: slSNnCSxRti51WU6Zahqxw==
X-CSE-MsgGUID: Dq1cBZR9RYaqYG+Ny/53zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="226263143"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 01:02:09 -0700
Date: Tue, 31 Mar 2026 11:02:07 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: Re: [PATCH v2 3/4] software node: verify that property data is not
 on stack
Message-ID: <act_f13eyaBPrJ-w@ashevche-desk.local>
References: <20260329-property-gpio-fix-v2-0-3cca5ba136d8@gmail.com>
 <20260329-property-gpio-fix-v2-3-3cca5ba136d8@gmail.com>
 <acpRi0BOgT73pqpE@ashevche-desk.local>
 <acrvakIBxO76OAlU@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acrvakIBxO76OAlU@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 30, 2026 at 02:49:52PM -0700, Dmitry Torokhov wrote:
> On Mon, Mar 30, 2026 at 01:33:47PM +0300, Andy Shevchenko wrote:
> > On Sun, Mar 29, 2026 at 07:27:50PM -0700, Dmitry Torokhov wrote:

...

> > > +	for (prop = node->properties; prop && prop->name; prop++) {
> > > +		if (!prop->is_inline && object_is_on_stack(prop->pointer)) {
> > 
> > I read more about this... Any code that uses vmalloc() (or potentially may
> > switch to it from regular allocator with help of kvalloc() and similar) will
> > fail now. While it might be no issue right now, this may become a such. So
> > with this check in place you put a requirement that properties can only be
> > allocated from a kernel low memory heap and not vm.
> 
> Can you tell me more about this? As far as I can see it will actually
> have false negatives with CONFIG_VMAP_STACK, but should be OK not
> trigger with vmalloced memory... But I am genuinely interested to know
> more.

I dug into the history of this macro. It was added for the block and ide
subsystems to make sure that there is no buffer supplied that may not be DMAed.
As we know vmalloc():ed buffers may not be DMAed. In some commit messages
it was explicitly mentioned that this macro fails on vmalloc():ed memory.

Note, I haven't checked the actual behaviour by trying that on the HW.

-- 
With Best Regards,
Andy Shevchenko


