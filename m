Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957B83AFAE7;
	Tue, 28 Jul 2026 06:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785220061; cv=none; b=ACI4yiKadESRo5pArNUg4uCYjhfOh8LRIDs4rvPz9q/eknG2yi2ClsN8rmyAZ9IqWR5kieUCObDsEoX1RnLrKpQ1HigGpQsbL/LHaLWR4vHfuAU6dPGbfRogRE2HeJMRGJMfWeo9cbLUrcedwxB6UXHEiXdn4Bc575zf/JRKNho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785220061; c=relaxed/simple;
	bh=n61/Ko2KpmPXrNRArmSqenWM8pHBLVFT+MXAHy832ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usHuoTpVNUtKSh8Hsyr8xyoXeM0DAG1JtWcdjO8dyMJ8adn5COvh5kDT2/E4DJ1DPdsT2Ue0qL0jSWfJ2NNZaDX1FMcyJKl8RC0Yrs99hAJdvWKtexVfQnrBeBYttkEHCAm3drI0EwQBwq407zNyy7BzI9e2yZJ0XdWKV93WlAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jyUt7N2l; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jyUt7N2l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785220058; x=1816756058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n61/Ko2KpmPXrNRArmSqenWM8pHBLVFT+MXAHy832ds=;
  b=jyUt7N2lHjKIGTV88R8aZZEViN1aFKYy/S6/MsxcuTYj4xVl97Kz/cNc
   qGbcU7U5JtsW+YKlJ4auTHbnRhWHYY/Ms1LK52mZhNCKdMFGdS7C7b2jF
   B7XByVAGfiKUHMQ6yJqn2Z1++8DdRP2nWLcBbLouBgbbyuOaQBjoKc9mW
   /ref+0C2gkZddd2guAcrairRjoEE42nWsNxIbVJiFks9vLiKGbZban4RB
   +rK7N8dMsZOCbWtkSGK+IqG5BxhESh6N4oIQYSS1AnY8iodOtrwFlO0dl
   DJBFb9F8dOMRxNmlQR7wv8QlR9ljpvHVj0xGZEM+po7BYPmaEka01V92s
   Q==;
X-CSE-ConnectionGUID: CkqHKO02TcGWMNtwO/OG1w==
X-CSE-MsgGUID: kJQGI2vuTmSCZXrqcJLjng==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85916861"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="85916861"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 23:27:37 -0700
X-CSE-ConnectionGUID: 7lUQRfEHQpKN9hWm0txrsQ==
X-CSE-MsgGUID: YAB21esTSxytgpm7w8nVtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="284154898"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.69])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 23:27:32 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 1FDE0121C02;
	Tue, 28 Jul 2026 09:27:32 +0300 (EEST)
Date: Tue, 28 Jul 2026 09:27:32 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Frank.Li@oss.nxp.com, "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Dafna Hirschfeld <dafna@fastmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	driver-core@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	imx@lists.linux.dev, Guoniu Zhou <guoniu.zhou@nxp.com>,
	Frank Li <Frank.Li@nxp.com>, Guoniu Zhou <guoniu.zhou@oss.nxp.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH v3 1/4] device property: Introduce
 fwnode_graph_for_each_endpoint_scoped()
Message-ID: <amhL1BkIG0uTPceL@kekkonen.localdomain>
References: <20260625-fw_scoped-v3-0-ffd0868e498d@nxp.com>
 <20260625-fw_scoped-v3-1-ffd0868e498d@nxp.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625-fw_scoped-v3-1-ffd0868e498d@nxp.com>

Hi Rafael, Danilo,

Can we merge this via the media tree (assuming you're fine with the
change)?

On Thu, Jun 25, 2026 at 10:17:21AM -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Similar to recently propose for_each_child_of_node_scoped() this new
> version of the loop macro instantiates a new local struct fwnode_handle *
> that uses the __free(fwnode_handle) auto cleanup handling so that if a
> reference to a node is held on early exit from the loop the reference will
> be released. If the loop runs to completion, the child pointer will be NULL
> and no action will be taken.
> 
> The reason this is useful is that it removes the need for
> fwnode_handle_put() on early loop exits. If there is a need to retain the
> reference, then return_ptr(child) or no_free_ptr(child) may be used to
> safely disable the auto cleanup.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v3
> - fix missed a tab before \
> 
> change in v2
> - collect Andy and Guoniu's reviewed-by tags
> - fix indention
> - remove extra space in commit message
> ---
>  include/linux/property.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 14c304db46648..c71177ca16a95 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -545,6 +545,11 @@ unsigned int fwnode_graph_get_endpoint_count(const struct fwnode_handle *fwnode,
>  	for (child = fwnode_graph_get_next_endpoint(fwnode, NULL); child;	\
>  	     child = fwnode_graph_get_next_endpoint(fwnode, child))
>  
> +#define fwnode_graph_for_each_endpoint_scoped(fwnode, child)			\
> +	for (struct fwnode_handle *child __free(fwnode_handle) =		\
> +		fwnode_graph_get_next_endpoint(fwnode, NULL);			\
> +	     child; child = fwnode_graph_get_next_endpoint(fwnode, child))
> +
>  int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
>  				struct fwnode_endpoint *endpoint);
>  
> 

-- 
Kind regards,

Sakari Ailus
