Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51BD380FEB;
	Wed, 24 Jun 2026 19:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782328780; cv=none; b=nw5hA0hoOnjOf1WRQY0K97/VZP3UJahIx3ifDY/VnJJTyGDkowQFGguXF115INYDkDkk5/H4DWSXK2Z2vrBxw3xwuf9gWeBaYy3W90URA87Ng9Z/7Dt3JYyVJ7fRVoLn7Ipn7UOhKfMDUaN5Bc7rypmj8/3q/C/B6d8NVoOr1pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782328780; c=relaxed/simple;
	bh=SygbhfMsHBXymcem7e6Zd0nKKWVHq2pp7wmjCrhnj44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E66B57+NYz90RdHwVImqWcr9bnXCLiJ1D+plc6kpJIH6bd2Hg1MLK6Y/emdS99JG12ZOnsl44+DuGuAZcS3GBNuTSxywPWKYcIu1iJEFul4QjWRE+GdHo61InifWW+dHEIrZiC3B2Ud+kAF2NHiIt3GJunKZAfrtZ9UxWDSRp5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=R9iPS6IL; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="R9iPS6IL"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 56D7E1049;
	Wed, 24 Jun 2026 21:18:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1782328737;
	bh=SygbhfMsHBXymcem7e6Zd0nKKWVHq2pp7wmjCrhnj44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R9iPS6IL6p0/dDAwuFkL5icB0WAA7/VF1Z2f8Muhz3zenEk89jfcpVogCPF9xqqsm
	 QPxnlkhw7Ug6s2tpdrYSAD+ZWecr8sCsX3hYxbY51skwWfYFAI00vNswoaiCKIZj+k
	 0HxXfhmL6kVxPTzsYM4hCVIu8p8C42YQ/DqNXn+k=
Date: Wed, 24 Jun 2026 22:19:35 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Frank.Li@oss.nxp.com
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
Message-ID: <20260624191935.GG851255@killaraus.ideasonboard.com>
References: <20260624-fw_scoped-v2-0-0a8db472af4a@nxp.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260624-fw_scoped-v2-0-0a8db472af4a@nxp.com>

Hi Frank,

On Wed, Jun 24, 2026 at 01:00:08PM -0400, Frank.Li@oss.nxp.com wrote:
> Add new helper macro fwnode_graph_for_each_endpoint_scoped() and use it
> simplify media code.
> 
> Typical example should qualcomm's driver (camss.c), the v4l2_mc.c and
> rkisp1-dev.c only silience improvement.
> 
> Anyways, *_for_each_*_scoped() already use widely and make code clean.
> 
> Build test only.
> 
> Sakari Ailus:
> 	when I try to improve the patch
> "Add common helper library for 1-to-1 subdev registration", I found need
> camss.c pattern, so I create this small improvement firstly.

Those are nice cleanups, thank you.

After applying this series, the only left users of the
fwnode_graph_for_each_endpoint() macro are in drivers/base/property.c.
They can all be trivially replaced with the scoped variant. Should we
add a patch to use fwnode_graph_for_each_endpoint_scoped() everywhere,
and drop fwnode_graph_for_each_endpoint() ?

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v2:
> - colllect review by tags
> - fix typo and indent.
> - see each patch's change log.
> - Link to v1: https://patch.msgid.link/20260622-fw_scoped-v1-0-a37d0aac0a68@nxp.com
> 
> ---
> Frank Li (4):
>       device property: Introduce fwnode_graph_for_each_endpoint_scoped()
>       media: mc: use fwnode_graph_for_each_endpoint_scoped() to simpilfy code
>       media: rkisp1: use fwnode_graph_for_each_endpoint_scoped() to simplify code
>       media: qcom: camss: use fwnode_graph_for_each_endpoint_scoped() to simplify code
> 
>  drivers/media/platform/qcom/camss/camss.c           | 17 +++++------------
>  drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c |  4 +---
>  drivers/media/v4l2-core/v4l2-mc.c                   |  5 +----
>  include/linux/property.h                            |  5 +++++
>  4 files changed, 12 insertions(+), 19 deletions(-)
> ---
> base-commit: 3ce97bd3c4f18608335e709c24d6a40e7036cab8
> change-id: 20260620-fw_scoped-5dab644510a1

-- 
Regards,

Laurent Pinchart
