Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05643321F2D;
	Wed, 24 Jun 2026 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782328577; cv=none; b=BjMhhFMVT6WYIQUZ+1O5M6SVnZyYfotuA5jUfSuy1UnmaHmeizcOnjqPRUJnWCKzxBf3ZsnBxwLbbGwG5wvSPvOJsClnfuzE+V8mkfx9sjyWjbkEH2mp44ONPNtCsTpc6aCgchXzKwm0LZwcd5BqCtxg45n7BtOnPfzKBIUQyc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782328577; c=relaxed/simple;
	bh=QiPILnKlLuOHtaJpr6jjLy6flwPX2L0FxIacScwZD7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2OP8Quh22HYP7oW7KBY+Kfrh/VzPLN7XoW7lYeVoicUApeK1n9dPSH27xwj+5/Up9yGyh9+quOhUF2EmT9HtGX1bdtumlsfAp6G8Le/aWiaosadfCwWDY50cIVIhL+H1jInxjuPleCF+jSNXcTFyvzr72WOrMgiT5FAOsYPCNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=T5vfv449; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="T5vfv449"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 11BA6E9C;
	Wed, 24 Jun 2026 21:15:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1782328535;
	bh=QiPILnKlLuOHtaJpr6jjLy6flwPX2L0FxIacScwZD7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T5vfv449pdBSSpldMnnTgRtmlKEuGS7xR/QqdoAmSDsipINNJfQM0aDOJmupDXynL
	 M1S1ZTMK4NSbJrwB7EcA5PGPwIV6rfyYmW3jWieV4wOCQKyZmUsf/aZUAVuEMyriDg
	 RlLsCTwdXzjMK9kwP/uDjrrb4QgNUF25wIXIdvoM=
Date: Wed, 24 Jun 2026 22:16:13 +0300
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
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 3/4] media: rkisp1: use
 fwnode_graph_for_each_endpoint_scoped() to simplify code
Message-ID: <20260624191613.GE851255@killaraus.ideasonboard.com>
References: <20260624-fw_scoped-v2-0-0a8db472af4a@nxp.com>
 <20260624-fw_scoped-v2-3-0a8db472af4a@nxp.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260624-fw_scoped-v2-3-0a8db472af4a@nxp.com>

On Wed, Jun 24, 2026 at 01:00:11PM -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Use fwnode_graph_for_each_endpoint_scoped() to simplify code.
> 
> No functional changes.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
> Andy: Keep original code because too much break. and I am working on more
> generally solution, so the whole function can be replaced.
> ---
>  drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> index 1791c02a40ae1..f90e01301943c 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> @@ -187,7 +187,6 @@ static int rkisp1_subdev_notifier_register(struct rkisp1_device *rkisp1)
>  {
>  	struct v4l2_async_notifier *ntf = &rkisp1->notifier;
>  	struct fwnode_handle *fwnode = dev_fwnode(rkisp1->dev);
> -	struct fwnode_handle *ep;
>  	unsigned int index = 0;
>  	int ret = 0;
>  
> @@ -195,7 +194,7 @@ static int rkisp1_subdev_notifier_register(struct rkisp1_device *rkisp1)
>  
>  	ntf->ops = &rkisp1_subdev_notifier_ops;
>  
> -	fwnode_graph_for_each_endpoint(fwnode, ep) {
> +	fwnode_graph_for_each_endpoint_scoped(fwnode, ep) {
>  		struct fwnode_handle *port;
>  		struct v4l2_fwnode_endpoint vep = { };
>  		struct rkisp1_sensor_async *rk_asd;
> @@ -286,7 +285,6 @@ static int rkisp1_subdev_notifier_register(struct rkisp1_device *rkisp1)
>  	}
>  
>  	if (ret) {
> -		fwnode_handle_put(ep);
>  		v4l2_async_nf_cleanup(ntf);
>  		return ret;
>  	}

-- 
Regards,

Laurent Pinchart
