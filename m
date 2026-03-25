Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D883CFF5F;
	Wed, 25 Mar 2026 11:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774439470; cv=none; b=rUnrJjEiNLZaWJe9+uuF1104ZuLPDa26Ecs6xKFE03nngsvwsQB8KwhPXhiOU293tibG+PyNoO++6NcKBnhkaYGVtA5TUDJM71+mLDJZ7yzZDB9nZwAHCdVYMje1Ai0xPzcTQ42mPOzq9KdR+NG9IV/KIt7BrShp91KdGQ92T3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774439470; c=relaxed/simple;
	bh=H1TKSO1/ZhvI2JLcGb0a5zwCHr0NjdZkDRx2k8ZDX+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDDodgWFc3WHIlFJhNuwS4LD4AHJxEOafpVxz8f++n+QBZch1Qm/d8Jt+zs38GKsQoDxhzXTRH8xLfixsC0xM2P8Dv97WuZvvBpbTIiBtWfoc3U+zbLgwrjMENjWwdZAjmnFGfGbVL9Cd8E5ebmwlQy5EBnranRsreu1HR62+tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I1ugvKnY; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I1ugvKnY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774439469; x=1805975469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H1TKSO1/ZhvI2JLcGb0a5zwCHr0NjdZkDRx2k8ZDX+g=;
  b=I1ugvKnY+sD58HRZHiLbm6UYKO7RsQXtPA0aIMVFLEGmV6tdCBkMakT2
   LDJt+0EUlmZ6093UDbyLjwftsttG+5cmvV9/3jucN0Zq3i1G46DHBDNGJ
   QbEq4iaya8h7z2iOpGR6JuI1ucoPWerpCqIoGNH8vt91W4fsar0Vxuu1I
   a+UYNeNI+u/en4ci4Kx5i/KN+aLhLyOS4u9nj9VD3OHGR25UPumIiexlD
   rhjU1J6IXjcs3+BemNEzMeDL5qfvBTti/7gor1S1ig3RQt3ykCLAdTiCL
   B9e7Wenpapdhi4yjkOOXudkFAIIFa6YMtvMntQry0hdPICfSDQdj05eXd
   A==;
X-CSE-ConnectionGUID: bTkt1JA9Tpmy6L+9KahXFg==
X-CSE-MsgGUID: H+Bqkfd7Q3ScS/fiz24aqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="98093687"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="98093687"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 04:51:08 -0700
X-CSE-ConnectionGUID: deCQfuB9T/K/MOTQOLBsqA==
X-CSE-MsgGUID: Bj0LccEIQ/OboKfUEeC0bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="226299986"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.32])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 04:51:04 -0700
Date: Wed, 25 Mar 2026 13:51:02 +0200
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
Message-ID: <acPMJiZHmxvVYYte@ashevche-desk.local>
References: <20260323-property-gpio-fix-v1-0-9cb46e5fe7df@gmail.com>
 <20260323-property-gpio-fix-v1-3-9cb46e5fe7df@gmail.com>
 <acKEm4EiZBqJ67nM@ashevche-desk.local>
 <acK34X9vBmvgHhLU@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acK34X9vBmvgHhLU@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 24, 2026 at 09:17:18AM -0700, Dmitry Torokhov wrote:
> On Tue, Mar 24, 2026 at 02:33:31PM +0200, Andy Shevchenko wrote:
> > On Mon, Mar 23, 2026 at 05:39:39PM -0700, Dmitry Torokhov wrote:
> > > When registering a software node, ensure that the property data is not
> > > located on the stack, as it is expected to persist for the lifetime of
> > > the node.

...

> > > +#include <linux/sched/task_stack.h>
> > 
> > Looking at this name the use of it here doesn't sound right...
> 
> Because ... ? object_is_on_stack() is defined there.

Because it's defined there. The key word here I see is 'task' in the name of
the header, without Ack from sched folks, I am not convinced we can use that at
any point in the kernel.

...

> > > +	for (prop = node->properties; prop && prop->name; prop++) {
> > > +		if (!prop->is_inline && object_is_on_stack(prop->pointer)) {
> > > +			pr_err("%s: property data can't be on stack\n", __func__);
> > > +			return -EINVAL;
> > > +		}
> > > +	}
> > 
> > And again same question, why we can't simply dup them as we do for (string)
> > arrays?
> 
> Because majority of users of software_node_register() deal with static
> const properties so duping them is waste of memory.

So, then why can't we do that for the references? Just then copy and free at
software unregistration if required.

-- 
With Best Regards,
Andy Shevchenko


