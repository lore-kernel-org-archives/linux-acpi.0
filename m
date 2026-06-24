Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BE53002C8;
	Wed, 24 Jun 2026 20:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782331361; cv=none; b=AIq5XzTa56s/V463jN+M1e0/SoTcb21zd/4OiF1oF3YFmFkhz3vABwlnG6KPGpdVoCuGFLGWD41RMjMbSBE+O+DnPMeuiVzEBfOxVe84ntsMSDwDN2bLIxKJtsAo3EMyYbbAAb9QpwOHwyhA1iqfa5PuXhIwwN27y2vgdUXiN0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782331361; c=relaxed/simple;
	bh=DUKIEE7/NbZR/k8cWAM68518/PZODDzrS+U/d4ruhG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmgBOLwNQMkygty1gEJwwVaBAGSlAFzVnOAax52ezMSTc5viqVkvKI9Q/jh27QRi0TCnLAzuWsc49gMT9oykSp2g4/dBH9kSiM/HJWxtr5VDGFVgn/OOPIuh5nMvzZZrqPeIpoo2ssm8WzvL/XSqnWw4KiDYeNAT47yg3kGqVqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=q5Qwb1kn; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="q5Qwb1kn"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 696961E6;
	Wed, 24 Jun 2026 22:01:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1782331319;
	bh=DUKIEE7/NbZR/k8cWAM68518/PZODDzrS+U/d4ruhG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q5Qwb1knc4r2eTb764ud9nediE0cB7p1Mt9q0e69aRTQSHkAd7UZJqXVVelzGEarK
	 QlFfXvaJ7RXtTwURcika1vW9uzUE6YjD0fnpv6+B4ZFnfzZhMu6TyA31EiE6TaILkY
	 p3IlZ42+5Jz1Hyxio+3i1dERD8ml8lN9MkmcLqGw=
Date: Wed, 24 Jun 2026 23:02:37 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <20260624200237.GJ851255@killaraus.ideasonboard.com>
References: <20260624-fw_scoped-v2-0-0a8db472af4a@nxp.com>
 <20260624191935.GG851255@killaraus.ideasonboard.com>
 <ajwxcn2LXS8InAjZ@SMW015318>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ajwxcn2LXS8InAjZ@SMW015318>

On Wed, Jun 24, 2026 at 02:35:14PM -0500, Frank Li wrote:
> On Wed, Jun 24, 2026 at 10:19:35PM +0300, Laurent Pinchart wrote:
> > On Wed, Jun 24, 2026 at 01:00:08PM -0400, Frank.Li@oss.nxp.com wrote:
> > > Add new helper macro fwnode_graph_for_each_endpoint_scoped() and use it
> > > simplify media code.
> > >
> > > Typical example should qualcomm's driver (camss.c), the v4l2_mc.c and
> > > rkisp1-dev.c only silience improvement.
> > >
> > > Anyways, *_for_each_*_scoped() already use widely and make code clean.
> > >
> > > Build test only.
> > >
> > > Sakari Ailus:
> > > 	when I try to improve the patch
> > > "Add common helper library for 1-to-1 subdev registration", I found need
> > > camss.c pattern, so I create this small improvement firstly.
> >
> > Those are nice cleanups, thank you.
> >
> > After applying this series, the only left users of the
> > fwnode_graph_for_each_endpoint() macro are in drivers/base/property.c.
> 
> I already checked previously, two place use it.
> 
> fwnode_graph_get_endpoint_count(), it will go though all endpoints, last
> ep is NULL, which totally equial to scoped() version.
> 
> another one fwnode_graph_get_endpoint_by_id(), which return ep, expect
> caller to call put().
> 
> if use scoped() version, need use no_free_ptr() at return, which make think
> a little bit complex.

It would introduce a tiny bit of extra complexity there, but the
advantage (in my opinion) is that we'll be able to remove the less safe
fwnode_graph_for_each_endpoint() macro.

Now one may argue that the risk of
fwnode_graph_for_each_endpoint_scoped() is returning the iterator
without using no_free_ptr(). I wonder if that would be easier to catch
in static analysis tools than the current pattern that leaks a reference
when exiting the loop early.

> It'd better leave these as it.

-- 
Regards,

Laurent Pinchart
