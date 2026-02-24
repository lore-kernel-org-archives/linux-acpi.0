Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8202A3815F0;
	Tue, 24 Feb 2026 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771941759; cv=none; b=JBnPBeqeW1o//MqH5x1rCDP98ExSo+0lfJlZ5MWvy2XUr/NFqFrBTAKoWFajqDZsZ9RwyYP7UlY//ZRl5fc7xY5/NjIRr/8MxmBwBldA7cH2eMev9HeBYuomQ1bnIlUZEMNNjf92CQhSbpgHAaG5WvM0DhrbFN6dRGpV4mF6SW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771941759; c=relaxed/simple;
	bh=wzMlk3qgQ9c6m/L+mEV6uN6iJFu15e/DVXjuK1beh7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhUndelqok+n0kOlzjMdB8RsJy1QzWKp6mDMh70EmSIUCfKJPHOpZLNFKqUcyi+Sbj4LljTZ9UEAAuVx9Ikd75j+oC80T/g5yJAHDMmJIpF78aaVi5bH2vvPcY7jf4UzoGA6JSuURFa39wCR8arpAlDfPzo+2k//Rg/tViM8jYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQ6/Amqh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQ6/Amqh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771941758; x=1803477758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wzMlk3qgQ9c6m/L+mEV6uN6iJFu15e/DVXjuK1beh7I=;
  b=cQ6/AmqhBXQdy5ALjkRmkF47Y5RXuh6zcfHiC65kkrOqBW81U4YPF4yn
   5K8XaEyqvG7nq6uTrlFuAZeugz3Qz/TjwaJeUabqUOIJ9c1y/G1yiJ/dB
   I54e8MljrAvCYdZM+4fZpxefGf+qtVsIFFPunG37wnNl0pXko27a+dOU+
   J1jqDUE35en/qSXGwMNKL9c+icPao2NoEkIzfx+KTR2zv8fr28fgwXCAE
   hpmmPGlk8FK7a0jpIrN5I60Tbf7F6C7tBXB1DkMg2Qois73mN20fly9Uo
   qq4GcLxVOY5h30lN0w/HaEJeMjsG0iFLXkcLWya1B36XEWwGpk9gw5iQT
   w==;
X-CSE-ConnectionGUID: AvnzEWhcSuK1zGjoYkYtYw==
X-CSE-MsgGUID: WO1mgZ5NQdmpam6XzmZxOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="95571370"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="95571370"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 06:02:38 -0800
X-CSE-ConnectionGUID: pRNKfFsCS6WJagilvbslBA==
X-CSE-MsgGUID: MZwKWNyUT9+vCxQT2JUXLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="216076881"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 06:02:35 -0800
Date: Tue, 24 Feb 2026 16:02:33 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zijun Hu <zijun.hu@oss.qualcomm.com>, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-acpi@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1 1/3] driver core: Split device data types to
 device/types.h
Message-ID: <aZ2veVh1tXkFf7Nh@smile.fi.intel.com>
References: <20260223204412.3298508-1-andriy.shevchenko@linux.intel.com>
 <20260223204412.3298508-2-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gS6kyCOmwL-9JYiaxCDVubtBoK6Rb5NSgHD1GwkGoCRA@mail.gmail.com>
 <aZ1p4lgioFlxhFr_@smile.fi.intel.com>
 <CAJZ5v0hUwCFKH3f6pCW1idquyJ-93wtXzO70tq6D+ruU17+oGw@mail.gmail.com>
 <2026022436-scrambled-mumbling-59a3@gregkh>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2026022436-scrambled-mumbling-59a3@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 24, 2026 at 05:17:43AM -0800, Greg Kroah-Hartman wrote:
> On Tue, Feb 24, 2026 at 01:21:10PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Feb 24, 2026 at 10:05 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Feb 23, 2026 at 09:53:17PM +0100, Rafael J. Wysocki wrote:
> > > > On Mon, Feb 23, 2026 at 9:44 PM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > >
> > > > > device.h is a huge header which is hard to follow and easy to miss
> > > > > something. Improve that by splitting device data types to device/types.h.
> > > > >
> > > > > In particular this helps to speedup the build of the code that includes
> > > > > device.h solely for a device data types.
> > > > >
> > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > >
> > > > But why do you want to move the struct device definition out of device.h?
> > >
> > > Because it's a data type, and we have many drivers that may require it
> > > (embed the struct device), but no device.h API is called directly —
> > > only via a certain framework).
> > >
> > > device.h also includes many unrelated headers in such a case.
> > 
> > Why is this a problem?
> > 
> > Could those headers be moved to different header files instead?
> > 
> > device.h is mostly about the struct device definition and the other
> > stuff in it is more or less additional.  Why do you want to make it
> > the other way around?
> 
> I agree, this feels wrong.

Nobody is going to remove device.h :-)
It's a split based on the trend in the kernel.

-- 
With Best Regards,
Andy Shevchenko


