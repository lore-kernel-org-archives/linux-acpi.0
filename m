Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229AC1A5B8C;
	Sun, 23 Aug 2026 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787473448; cv=none; b=XiLrI+N7SBNLdgocqcvoMcHpNVofG/3PRT4DkDYlCxA/90l/LS8NWfPx+XppF31gOHsAwomFJPtoqEB24YingwpNf6GaDVQYhFQgH0FqimD3RE7/pKXRih5RovcTZTdxOWCupNDo3Ef3T0KvxQ0YU8rKY9EtxjXjGIOMsaUYw3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787473448; c=relaxed/simple;
	bh=qoZ/oVoXZxZ2CMIIrtYMI17kY7edDBot3TR60JiYTkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlNAdQcF3arigXsJeP++CikJhsgpj/OgqD8lkwOReKWJDpPcSRd9gWoRJoijomcLkXYt9KqfqMn2fmCTPw9VMataR8unO/cgYll20pr8z3440lNVqg5ayL52ZN53vrEq40vo3bwvRY1CNoNAefeaVDx1DDWirf/yvKl+zRrKiS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZohd0tF; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZohd0tF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787473446; x=1819009446;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qoZ/oVoXZxZ2CMIIrtYMI17kY7edDBot3TR60JiYTkI=;
  b=ZZohd0tFVxCa0HoUoMVV3t/jWQyEUK/nz2Lw8UMp27AeAuEoMhWHSrpX
   aTZvtH585y2vPorTffdf+dgdadIp6n5HpDDmpu7K/E5SRSjTfMCSzHa/z
   S5ygbTPM90fKK8ltskN3rUGGeZzbH8oB1r7jpc9DUq6R25bMscSVsebak
   iONkOtrZZnhse3RxSzkuPRBh0peqCTYNxkMNx+nSD2CdQabR8uxE3K4YU
   AMBMFPrdL9oMeID3hJ+dDy/aO+Yxs4mTMrNow742xOzIb14FmRP0lE7US
   w+eR2PEz0RKK/6HPLMuDQ8kV0zVFQzrBICh0SAoGp56GwUmqcFQLL6Mx3
   Q==;
X-CSE-ConnectionGUID: GUI+n4QZS1WQBq1PC7V14g==
X-CSE-MsgGUID: 5Pa69+/VRLi1Vmgb5YG4Jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="88012581"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="88012581"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 01:24:04 -0700
X-CSE-ConnectionGUID: lBdKFbEYQ1ihkzhYQveaQw==
X-CSE-MsgGUID: 0yf3M9S3Toq1fJ9amZ4T+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="267301149"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 01:24:02 -0700
Date: Sun, 23 Aug 2026 11:23:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Yao Qi <xnorigc@gmail.com>, westeri@kernel.org,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH] gpiolib: acpi: Add ignore_wake quirk for ASUS TX Air
 FA401GM
Message-ID: <aoquH9Z2lfer_KrH@ashevche-desk.local>
References: <20260808155513.2221976-1-xnorigc@gmail.com>
 <aneGptJn8J7eF9tj@ashevche-desk.local>
 <CAD++jLkCYwTyK6C8LvZiYJ9fSc8bp3RPpb4d6EgQTRraJtJDzA@mail.gmail.com>
 <anmNf3rJGxso6nuc@ashevche-desk.local>
 <ans3pcNFEDVBYXXT@ashevche-desk.local>
 <CAMRc=MeDLc-LPwoCEA8yMw3+L9UcN-NgXpYpFPxtUNffAAffyw@mail.gmail.com>
 <anwxWXfqSt2bM8iy@ashevche-desk.local>
 <CAMRc=McGR_2V2mPJZwU6kBk8TzCV6iKu3-C9yF1bbWE0R73-cw@mail.gmail.com>
 <anxyNPJfvkVaa8L-@ashevche-desk.local>
 <CAMRc=Md=5gnKO9TzQR6bgSzNqj_qvRF=j9uVSTnA75A_ZPqT_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Md=5gnKO9TzQR6bgSzNqj_qvRF=j9uVSTnA75A_ZPqT_g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 12, 2026 at 06:39:20AM -0700, Bartosz Golaszewski wrote:
> On Wed, 12 Aug 2026 15:16:36 +0200, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> said:
> > On Wed, Aug 12, 2026 at 06:54:30AM -0500, Bartosz Golaszewski wrote:
> >> On Wed, 12 Aug 2026 10:39:53 +0200, Andy Shevchenko
> >> <andriy.shevchenko@linux.intel.com> said:
> >> > On Wed, Aug 12, 2026 at 01:23:53AM -0700, Bartosz Golaszewski wrote:
> >> >> On Tue, 11 Aug 2026 16:54:29 +0200, Andy Shevchenko
> >> >> <andriy.shevchenko@linux.intel.com> said:
> >> >> > On Mon, Aug 10, 2026 at 11:36:19AM +0300, Andy Shevchenko wrote:
> >> >> >> On Mon, Aug 10, 2026 at 12:17:06AM +0200, Linus Walleij wrote:
> >> >> >> > On Sat, Aug 8, 2026 at 9:42 PM Andy Shevchenko
> >> >> >> > <andriy.shevchenko@linux.intel.com> wrote:
> >> >> >> > > On Sat, Aug 08, 2026 at 03:55:13PM +0000, Yao Qi wrote:

...

> >> >> >> > > If AMD people will be quick enough to tag this, I will include in my PR to
> >> >> >> > > Linus W. on next week.
> >> >> >> >
> >> >> >> > To Bartosz?
> >> >> >> > It's gpiolib...
> >> >> >>
> >> >> >> Oh, true, I have also pin control stuff to send!
> >> >> >
> >> >> > Okay, I have checked if I have anything to Bart and it seems I mixed that with
> >> >> > pin control stuff. So, Bart, if you feel confident about this patch, you can
> >> >> > take it directly. Here is my formal tag for that
> >> >> >
> >> >> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> >>
> >> >> Is this a bugfix? I'll be OoO until the end of August starting on Friday with
> >> >> the exception of a single day to catch up on email. I'll be sending my PRs for
> >> >> v7.3 tomorrow. Not sure if I should take it for v7.3 or v7.2?
> >> >
> >> > On one hand there is no rocket science behind this patch (that's why I gave my tag),
> >> > but if you strictly want AMD to confirm, then postpone, so it's up to you to decide.
> >>
> >> If this is not an important bugfix, then let me postpone it until next cycle.
> >
> > I believe a user may survive with this bug to be present for a bit longer.
> > But not my call, at Intel I have no such hardware :-)
> >
> 
> No worries, it can go upstream right after I'm back from vacations.

Since there is another similar patch pending, I will take them all into my
branch and issue a fix PR after -rc1.

-- 
With Best Regards,
Andy Shevchenko


