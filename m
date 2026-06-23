Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A01F371CEC;
	Tue, 23 Jun 2026 10:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209374; cv=none; b=M7xbCxOVUCVaUyQAS+qzJ1D+8NG/XyjKfi0tb2vCo8VULbg5SzMIhC+Kljdcgj11WD4WrQeAYQes8Ok1qUkP8d5SQfWqFAB64mYhc0Hufa7oVFjwfcUiacvi4DI+sczaA/gX3+4xAhr3ROt/OALuhsntsq6SL8ztPp3w8jSJ8hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209374; c=relaxed/simple;
	bh=xv4r6u0rAfI0XXJ7Y3S0NT2YfyY0CONMP/ImwPkH8bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVqfOd6/BqPfN9O+bx1ZpsQ0Mo1K69jcGLSz0ya7B01171CFoVpk5yJ52VrMNjhSddHOoDiNtpVzMgQk7+aS3DjNyfGGNKS8UFn7bHcszI9WG5eWpbJzksNQw3qhXl1xjXFDCjGJn7POSW9ixEDzHFFJSoKYoGXPtj2GMg2eY38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ACQ/9jaw; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ACQ/9jaw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782209373; x=1813745373;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xv4r6u0rAfI0XXJ7Y3S0NT2YfyY0CONMP/ImwPkH8bw=;
  b=ACQ/9jawOjWURs13CVArhCaf+fZsjgKauc+ECalDJ6CEphx1ejVIisJZ
   ZSoclYjWd1GKrO7gMH4vpNeMIloNUvxNpJR/t5f2vCEK8vUQdk39f8W2P
   B3I0lu47qXw0PHnjE9AsaJveUhT6IU9hpwXQcQaP3NMzwZ3zbmsug649A
   wtcCdLXfxbuspAN5XjxWd0jrDnmknF/5F89PES4+1RTz+YN/kcO+HFz1D
   AZNvfoAlli1U4MK7MzLCquDurQPPTiHd+tLWLyaNxXuvKErh8E/fNUvcE
   F+g2UmBupDH3XNIoepmdBht4bT59CY8pwzQcuk7d0BmtYGC1rHFZrwIjz
   g==;
X-CSE-ConnectionGUID: 6ORWjDxJTnW4etMAox8YDg==
X-CSE-MsgGUID: e2w2hMaUSVW4/nJxWaRurg==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="100376401"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="100376401"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:09:33 -0700
X-CSE-ConnectionGUID: fO295pNvSEiHBZM9FO5beA==
X-CSE-MsgGUID: +viiu0Y0Q+aDKjP2Rb+XuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="251411103"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:09:26 -0700
Date: Tue, 23 Jun 2026 13:09:24 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Frank.Li@oss.nxp.com
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
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
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 1/4] device property: Introduce
 fwnode_graph_for_each_endpoint_scoped()
Message-ID: <ajpbVCGGKchNa2rd@ashevche-desk.local>
References: <20260622-fw_scoped-v1-0-a37d0aac0a68@nxp.com>
 <20260622-fw_scoped-v1-1-a37d0aac0a68@nxp.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622-fw_scoped-v1-1-a37d0aac0a68@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 22, 2026 at 10:30:11AM -0400, Frank.Li@oss.nxp.com wrote:
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
> fwnode_handle_put() on early loop exits.  If there is a need to retain the

Just be consistent with 1-space versus 2-spaces gaps in the same text.

> reference, then return_ptr(child) or no_free_ptr(child) may be used to
> safely disable the auto cleanup.

No objections from me.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
See one nit-pick below.

But you will need driver core maintainers to Ack this.

...

> +#define fwnode_graph_for_each_endpoint_scoped(fwnode, child)			\
> +	for (struct fwnode_handle *child __free(fwnode_handle) =		\
> +			fwnode_graph_get_next_endpoint(fwnode, NULL);		\

You should follow the existing style, the 'f' in fwnode should be under 'u' in
struct.

> +	     child; child = fwnode_graph_get_next_endpoint(fwnode, child))

-- 
With Best Regards,
Andy Shevchenko


