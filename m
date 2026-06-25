Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FCC2874E6;
	Thu, 25 Jun 2026 06:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782369083; cv=none; b=mnmskOjizAk3ficUSFmvXgVhfbO3huNXny3Y16q4QRLOVxprBM+QzRPKTqrnd7UClOvW7EDxv8KTq6XthGH8Z89Xj1PV8HEiIub1SCE+RBcRbUfy/vYewX7COKtWiiAt8I9qNY/75MVeDaj+tsgsDMfy3gngJjWayhkXogLfvAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782369083; c=relaxed/simple;
	bh=fwGnL97xmgeZIlcEfXqmDIbjqKBgP8CglQlDHEXM+X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EW2C/O2KBlzxe48a0fFUgZSUU0dnoR7xCWVEIRa9NfdKLddsTquBXVca4QpWwbSCPeBSfZiIRqjHkBPEQqQ8Joe/VW48ewkbIQLgbFR+/ZNqmnjZuYA8V4sk5A1BEGn2W6/VIltNP1x28F4HnnEqliPbtkQPStkTwjO4xyrxVPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jCBw0qeI; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jCBw0qeI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782369082; x=1813905082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fwGnL97xmgeZIlcEfXqmDIbjqKBgP8CglQlDHEXM+X8=;
  b=jCBw0qeIx4c4gKAy0zAG5bICAQ+IxZvowUtKXtJuwQDT48D9zsiL4fPr
   CDXBeueOyIJUTulDU70w1IYU5uYBNdzmVAYiv/H58ucNwLa/UZ1k1QlXY
   ouBkY/yUmc58XMmfy6Fdpb9Q0949sJq7tudbVNpWk1T2xsUs+vmFZrETq
   g+cXoeYnDV8r/7knwATN6gNasvieea5QR6omJKNoHpbaMO9E6rWqIDcyh
   fQNvDQotgfMzq9uVUQn4NqwElfE5c5AaZg4V8vvGPq2sy2l045Ue4DXFi
   a4uRKsmFTMdoHiIhMDNQQpypg8EU9VpFTEE2TTySEzh0w2f0+O+Iu3NLU
   g==;
X-CSE-ConnectionGUID: BSfNjMHVSjWriRn49YrGxQ==
X-CSE-MsgGUID: hUGvNEDsRP+GxpX2UMfi6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="87046024"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="87046024"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:31:21 -0700
X-CSE-ConnectionGUID: slld4H3rR16nX4qt4wrK0A==
X-CSE-MsgGUID: LScKLZpATE+psYxu0HB+Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="252343530"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:31:16 -0700
Date: Thu, 25 Jun 2026 09:31:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Dafna Hirschfeld <dafna@fastmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	driver-core@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	imx@lists.linux.dev, Guoniu Zhou <guoniu.zhou@nxp.com>,
	Frank Li <Frank.Li@nxp.com>, Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Subject: Re: [PATCH v2 0/4] media: add and use
 fwnode_graph_for_each_endpoint_scoped()
Message-ID: <ajzLMiKrlXf2hFRd@ashevche-desk.local>
References: <20260624-fw_scoped-v2-0-0a8db472af4a@nxp.com>
 <20260624191935.GG851255@killaraus.ideasonboard.com>
 <ajwxcn2LXS8InAjZ@SMW015318>
 <20260624200237.GJ851255@killaraus.ideasonboard.com>
 <ajxCOE3avXXLlrfT@SMW015318>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajxCOE3avXXLlrfT@SMW015318>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 24, 2026 at 03:46:48PM -0500, Frank Li wrote:
> On Wed, Jun 24, 2026 at 11:02:37PM +0300, Laurent Pinchart wrote:
> > On Wed, Jun 24, 2026 at 02:35:14PM -0500, Frank Li wrote:
> > > On Wed, Jun 24, 2026 at 10:19:35PM +0300, Laurent Pinchart wrote:
> > > > On Wed, Jun 24, 2026 at 01:00:08PM -0400, Frank.Li@oss.nxp.com wrote:
> > > > > Add new helper macro fwnode_graph_for_each_endpoint_scoped() and use it
> > > > > simplify media code.
> > > > >
> > > > > Typical example should qualcomm's driver (camss.c), the v4l2_mc.c and
> > > > > rkisp1-dev.c only silience improvement.
> > > > >
> > > > > Anyways, *_for_each_*_scoped() already use widely and make code clean.
> > > > >
> > > > > Build test only.
> > > > >
> > > > > Sakari Ailus:
> > > > > 	when I try to improve the patch
> > > > > "Add common helper library for 1-to-1 subdev registration", I found need
> > > > > camss.c pattern, so I create this small improvement firstly.
> > > >
> > > > Those are nice cleanups, thank you.
> > > >
> > > > After applying this series, the only left users of the
> > > > fwnode_graph_for_each_endpoint() macro are in drivers/base/property.c.
> > >
> > > I already checked previously, two place use it.
> > >
> > > fwnode_graph_get_endpoint_count(), it will go though all endpoints, last
> > > ep is NULL, which totally equial to scoped() version.
> > >
> > > another one fwnode_graph_get_endpoint_by_id(), which return ep, expect
> > > caller to call put().
> > >
> > > if use scoped() version, need use no_free_ptr() at return, which make think
> > > a little bit complex.
> >
> > It would introduce a tiny bit of extra complexity there, but the
> > advantage (in my opinion) is that we'll be able to remove the less safe
> > fwnode_graph_for_each_endpoint() macro.
> >
> > Now one may argue that the risk of
> > fwnode_graph_for_each_endpoint_scoped() is returning the iterator
> > without using no_free_ptr(). I wonder if that would be easier to catch
> > in static analysis tools than the current pattern that leaks a reference
> > when exiting the loop early.
> 
> It's not big deal, if everyone prefer drop fwnode_graph_for_each_endpoint(),
> I can do it.

I slightly tend to the safest option (see below), but as a compromise I can
suggest to inline the fwnode_graph_for_each_endpoint() into that single user
that doesn't need a put. However, this may uglify the code and rise a question
of the consistency. So, consider that suggestion with grain of salt and apply
only if we have wider agreement with it.

> > > It'd better leave these as it.

TL;DR:
This is the safest option, of course. And as mentioned above I slightly
prefer this way. Another argument is that in some cases we might want to
have it in the future and since we have an existing user, let it live.

-- 
With Best Regards,
Andy Shevchenko


