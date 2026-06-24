Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CC93624BC;
	Wed, 24 Jun 2026 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782328500; cv=none; b=CqeoY4FRLO3yH0jR2dYg3HPYfPSHmZ5kmVSPZ5j4d2Q6sGRBnWMAuJXgvHKYAVu0ytRd6xGqqFKTL8wx9svpzw49y50VMx2wu+dq1yTTh+sby8fLgh93WbMHp/YV9MeaXLGAl0AsdgLJq1EelycoafBV3ngqcdifCT7JpBX7+1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782328500; c=relaxed/simple;
	bh=4l3LwfXynM0MsWP2kcvzPf7S3XQAOuf0AlSVOoYKWIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbrJLWh1UZlY4LFAimM45dbhEMRwLWN729HSyQT/y4LSVyhyRCmcyyMdnLnJRgAr4wwYFcvLeapIIrzIxs8oORI4wka7uN53T5upzLLuO4Pps7sdB1NZgbrrbiCisWex5xmkAFXDIRp53vddPsefIOTWsbrP1bJx7nYDz42U+mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=GaqAF6Y8; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="GaqAF6Y8"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 45848236;
	Wed, 24 Jun 2026 21:14:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1782328457;
	bh=4l3LwfXynM0MsWP2kcvzPf7S3XQAOuf0AlSVOoYKWIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GaqAF6Y8/h3JELG3xUHoxAj0t/lD1G8Yuz7xkdZoqjtld0QtIDHM5nhx+A5vDQmV7
	 ovby1WLWvV7w1axQLbuA+3u3efsU0JcAHedtGdbOdmgidHRiNaqhuK/pBzB30v6axE
	 YikzPxT71bFWSPP4vGlqpk0U3yjqe+Jgu9MgZUnk=
Date: Wed, 24 Jun 2026 22:14:55 +0300
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
Subject: Re: [PATCH v2 2/4] media: mc: use
 fwnode_graph_for_each_endpoint_scoped() to simpilfy code
Message-ID: <20260624191455.GD851255@killaraus.ideasonboard.com>
References: <20260624-fw_scoped-v2-0-0a8db472af4a@nxp.com>
 <20260624-fw_scoped-v2-2-0a8db472af4a@nxp.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260624-fw_scoped-v2-2-0a8db472af4a@nxp.com>

On Wed, Jun 24, 2026 at 01:00:10PM -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Use cleanup helper fwnode_graph_for_each_endpoint_scoped() to simpilfy
> code.
> 
> Reviewed-by: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/media/v4l2-core/v4l2-mc.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-mc.c b/drivers/media/v4l2-core/v4l2-mc.c
> index 937d358697e19..5d7fcd67dc42e 100644
> --- a/drivers/media/v4l2-core/v4l2-mc.c
> +++ b/drivers/media/v4l2-core/v4l2-mc.c
> @@ -324,12 +324,10 @@ EXPORT_SYMBOL_GPL(v4l_vb2q_enable_media_source);
>  int v4l2_create_fwnode_links_to_pad(struct v4l2_subdev *src_sd,
>  				    struct media_pad *sink, u32 flags)
>  {
> -	struct fwnode_handle *endpoint;
> -
>  	if (!(sink->flags & MEDIA_PAD_FL_SINK))
>  		return -EINVAL;
>  
> -	fwnode_graph_for_each_endpoint(src_sd->fwnode, endpoint) {
> +	fwnode_graph_for_each_endpoint_scoped(src_sd->fwnode, endpoint) {
>  		struct fwnode_handle *remote_ep;
>  		int src_idx, sink_idx, ret;
>  		struct media_pad *src;
> @@ -397,7 +395,6 @@ int v4l2_create_fwnode_links_to_pad(struct v4l2_subdev *src_sd,
>  				src_sd->entity.name, src_idx,
>  				sink->entity->name, sink_idx, ret);
>  
> -			fwnode_handle_put(endpoint);
>  			return ret;
>  		}
>  	}

-- 
Regards,

Laurent Pinchart
