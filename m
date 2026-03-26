Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3712DF12F;
	Thu, 26 Mar 2026 11:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774523963; cv=none; b=Qgn37nLHdF1tkySMLaBwdeZbe7JMDP7ZYN7EtaWBamqIAcppPR/2uUtmTgc+smLKEwWdmVwhGB5pvzilyP0gGDXcOOywftFrhjOsmjmhYslSWMsl59CVanUyPWVdAlVAsS2OBU3WKGE9FqRSVHcWGctaIMgIEzKaeTXGAGtnygE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774523963; c=relaxed/simple;
	bh=cpOOjpYPYESIU0ffyqKcNT2Upo1mwTuCSjSb/lpuIYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRXaV4nIdJvXEIwfEfZr6bzvBBS762wm1fC53enEc2Qk35fy/dArG8DDmLII6+O0i/BsPBbVPkn0lHAC2t5wPtsbh6TQV8j3VpUutn/SIQvjjFTxAj4gHSKmOzlqntLqNFeUNSt100lUfXpMif+RZ8VwkVM0GXZcNud5K9+LRds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kMuuBrZf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kMuuBrZf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774523962; x=1806059962;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cpOOjpYPYESIU0ffyqKcNT2Upo1mwTuCSjSb/lpuIYU=;
  b=kMuuBrZfkz71HsTuDslgB6UJCijr0V/ebm40j4B0mNAM1MDsfWDW+4gV
   pL/mU4yQ6hwU0QpVqY9bd75QG/ofEl9ZiDNmJ/Qg1yY5R+C7vCqnJs6DZ
   Zy3+w6J4uLJCQwYr2yk6Ppb5tHTJBVDl2nF4GiVHKH/C1n7vbERiDXWk/
   a2VLqj6yx4w6YphayrsL6ZnWc3OPYIZvjr35Oc+DGVw+jVwmgD1V8IBR+
   UDNTpyM6YhDTgtYqvGyvyuSuA1YIseZgNAhk19Oz3S+yD04QIZ2xH+uEY
   lF3We/Dl0wAO1PNUXSXfKIWqU4JIXLqSkG8CFrClKLciUF5ZiWr776rBv
   g==;
X-CSE-ConnectionGUID: 6tS0SBlARJGQuTb2iHhdRg==
X-CSE-MsgGUID: CgweGwNiREaLnOcQPZbaDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="79483794"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="79483794"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 04:19:22 -0700
X-CSE-ConnectionGUID: /rMWHD0hTR2iz57YiwguNQ==
X-CSE-MsgGUID: vdLnYSO0TXyn5k4EJnd6mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="220566936"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.216])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 04:19:18 -0700
Date: Thu, 26 Mar 2026 13:19:16 +0200
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
Subject: Re: [PATCH 3/4] software node: verify that property data is not on
 stack
Message-ID: <acUWNJLLsSJg07yJ@ashevche-desk.local>
References: <20260323-property-gpio-fix-v1-0-9cb46e5fe7df@gmail.com>
 <20260323-property-gpio-fix-v1-3-9cb46e5fe7df@gmail.com>
 <acKEm4EiZBqJ67nM@ashevche-desk.local>
 <acK34X9vBmvgHhLU@google.com>
 <acPMJiZHmxvVYYte@ashevche-desk.local>
 <acQJiEAtM3LKxDBS@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acQJiEAtM3LKxDBS@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 25, 2026 at 09:24:57AM -0700, Dmitry Torokhov wrote:
> On Wed, Mar 25, 2026 at 01:51:02PM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 24, 2026 at 09:17:18AM -0700, Dmitry Torokhov wrote:
> > > On Tue, Mar 24, 2026 at 02:33:31PM +0200, Andy Shevchenko wrote:
> > > > On Mon, Mar 23, 2026 at 05:39:39PM -0700, Dmitry Torokhov wrote:

...

> > > > > +#include <linux/sched/task_stack.h>
> > > > 
> > > > Looking at this name the use of it here doesn't sound right...
> > > 
> > > Because ... ? object_is_on_stack() is defined there.
> > 
> > Because it's defined there. The key word here I see is 'task' in the name of
> > the header, without Ack from sched folks, I am not convinced we can use that at
> > any point in the kernel.
> 
> It is fine to be used in drivers, and it is used in USB
> (drivers/usb/core/hcd.c), SPI (drivers/spi/spi-mem.c) and others.
> 
> "task" is not magical, it simply refers to a process or a thread (user
> or kernel). This particular macro just checks if the object is within
> limits of stack area of currently executing thread.

Still, it's C which can't really protect the public headers from misuse.

...

> > > > > +	for (prop = node->properties; prop && prop->name; prop++) {
> > > > > +		if (!prop->is_inline && object_is_on_stack(prop->pointer)) {
> > > > > +			pr_err("%s: property data can't be on stack\n", __func__);
> > > > > +			return -EINVAL;
> > > > > +		}
> > > > > +	}
> > > > 
> > > > And again same question, why we can't simply dup them as we do for (string)
> > > > arrays?
> > > 
> > > Because majority of users of software_node_register() deal with static
> > > const properties so duping them is waste of memory.
> > 
> > So, then why can't we do that for the references? Just then copy and free at
> > software unregistration if required.
> 
> We do not want to copy and free because that would be waste of memory in
> majority of cases where software_node_register() is used.
> 
> When dealing with other kinds of properties it is pretty obvious where
> the objectr itself lives, but when using PROPERTY_ENTRY_REF() and
> PROPERTY_ENTYR_GPIO() it is very easy to miss (I did! and I made them)
> that the reference args object is on stack as it is hidden behind a
> macro.
> 
> So it is just a safeguard warning us ahead of time instead of needing to
> figure out why a driver can't find GPIO even through the reference looks
> right.

Okay, but in the current form it lacks necessary information for understanding,
exempli gratia the property name.

-- 
With Best Regards,
Andy Shevchenko


