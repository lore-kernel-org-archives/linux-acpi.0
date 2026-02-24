Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7AF39A805;
	Tue, 24 Feb 2026 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771941706; cv=none; b=vBa+N1sAO/Nh7zRTDcbWzLp3IUelfcEGjTvntRZ7NhR8Q3MipQt2aT1N521et8eMv7EbTXtD3T1clhJht/jl/loPAyLYArCl1o4ZD6QkmXnDTiSzUc/XEFWTmrjFdjhRVpOw2EOOGVL1B3HqepvjZdgkgvoJMmRfs3EVDyfOFZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771941706; c=relaxed/simple;
	bh=44rcZUI5SsiL58Ymfm0g62ctXV3MYG+L2Yy1vCRu1Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCagllsGj4DzJZdDqD/QJUIgzcB9BNX8liRzH9JbjgKZQB5Rpf/nkuq9WiSmtfjH8ouci1TwcyyVFxeImiLyWKThH94nKrSAt7/G1F6jw4BYdf30V8pAzupxyyS14kbk6e0w3tFUKNJ5J5EdnAYyN5/AjH1H4FVxVOYSKZKolm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fWLlkXjt; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fWLlkXjt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771941704; x=1803477704;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=44rcZUI5SsiL58Ymfm0g62ctXV3MYG+L2Yy1vCRu1Dg=;
  b=fWLlkXjthofLd6z2mXGulwUZShpMVekVpgAktNZDw0A31r9KLnkG7lUw
   5j30VEzNHrnhBkJo+x47ayhxdNDbN5nPTepjmNtNgnopDTdcQguCoc3Pe
   R4TO8+SpYxoxxECBCiLTC0vd8rS9jkW87YNUh+7IU+LPUbzqxAOhInydH
   +7LQ/X7PC8krVVkiP6PuNBejOkFweSrv52X/baUIwSmSdcQcYq0tuFd5g
   N0sD9Mdy4zQ0KjN0fJvy1YU/4ZMkhbQtVBCTtY2kwESVn9p4OyFnhzEhw
   9QGaKcmLGah1B6JNNBPpp4gp9f82uDPLPO0xQAJIT2MzvBPr0TJ4KdwJT
   A==;
X-CSE-ConnectionGUID: +H0RwFlRRxqZkQTDhiCYMQ==
X-CSE-MsgGUID: XJZ9TiDxR2uw2A165shV9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="90367895"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="90367895"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 06:01:43 -0800
X-CSE-ConnectionGUID: xVoiiQ1IRF66Mbu9Nxy3Og==
X-CSE-MsgGUID: 5BNDpJc7QjWybaO3y2mrjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="220017609"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 06:01:41 -0800
Date: Tue, 24 Feb 2026 16:01:38 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun.hu@oss.qualcomm.com>, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-acpi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1 1/3] driver core: Split device data types to
 device/types.h
Message-ID: <aZ2vQm3cQtBrmqMO@smile.fi.intel.com>
References: <20260223204412.3298508-1-andriy.shevchenko@linux.intel.com>
 <20260223204412.3298508-2-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gS6kyCOmwL-9JYiaxCDVubtBoK6Rb5NSgHD1GwkGoCRA@mail.gmail.com>
 <aZ1p4lgioFlxhFr_@smile.fi.intel.com>
 <CAJZ5v0hUwCFKH3f6pCW1idquyJ-93wtXzO70tq6D+ruU17+oGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hUwCFKH3f6pCW1idquyJ-93wtXzO70tq6D+ruU17+oGw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 24, 2026 at 01:21:10PM +0100, Rafael J. Wysocki wrote:
> On Tue, Feb 24, 2026 at 10:05 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Feb 23, 2026 at 09:53:17PM +0100, Rafael J. Wysocki wrote:
> > > On Mon, Feb 23, 2026 at 9:44 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > device.h is a huge header which is hard to follow and easy to miss
> > > > something. Improve that by splitting device data types to device/types.h.
> > > >
> > > > In particular this helps to speedup the build of the code that includes
> > > > device.h solely for a device data types.
> > > >
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >
> > > But why do you want to move the struct device definition out of device.h?
> >
> > Because it's a data type, and we have many drivers that may require it
> > (embed the struct device), but no device.h API is called directly —
> > only via a certain framework).
> >
> > device.h also includes many unrelated headers in such a case.
> 
> Why is this a problem?
> 
> Could those headers be moved to different header files instead?
> 
> device.h is mostly about the struct device definition and the other
> stuff in it is more or less additional.  Why do you want to make it
> the other way around?

It's a common trend in the kernel to split out _types.h and _api.h
(among possibly others). I follow this trend with a correction on
the folder versus prefix. That's why device/types.h.

$ git diff $A..$B --diff-filter=A --name-only -- include/ | grep _types.h

In v6.19:
include/linux/fs/super_types.h
include/linux/irq_work_types.h
include/linux/ns/ns_common_types.h
include/linux/ns/nstree_types.h
include/linux/rseq_types.h

In v6.17:
include/linux/unwind_deferred_types.h
include/linux/unwind_user_types.h

In v6.15
include/linux/resctrl_types.h

In v6.11
include/linux/cpumask_types.h

In v6.8
include/linux/hrtimer_types.h
include/linux/irqflags_types.h
include/linux/mutex_types.h
include/linux/nodemask_types.h
include/linux/pid_types.h
include/linux/plist_types.h
include/linux/posix-timers_types.h
include/linux/refcount_types.h
include/linux/seccomp_types.h
include/linux/sem_types.h
include/linux/seqlock_types.h
include/linux/syscall_user_dispatch_types.h
include/linux/timer_types.h
include/linux/timerqueue_types.h
include/linux/uidgid_types.h
include/linux/workqueue_types.h

In v6.4
include/linux/objtool_types.h

In v6.1
include/linux/cfi_types.h
include/linux/kmsan_types.h

In v6.0
include/linux/gfp_types.h
include/linux/io_uring_types.h

-- 
With Best Regards,
Andy Shevchenko


