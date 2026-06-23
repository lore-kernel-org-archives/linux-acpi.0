Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E83370AE6;
	Tue, 23 Jun 2026 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209872; cv=none; b=FwFjJYRoeGsPei/03nk3HXdrwguBvSilpr/mvszQeilm48/euCqanR8CadubxzWsaEt7fdc0TDyJQW7jSF2m9O7uYKi14nqLnf8vRY3k9/tNkjtKVEL0nY33t2FUfsEEyWGRYk19fq7vZ4wbCguudYHKyYuCGWgzC1by4TOciuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209872; c=relaxed/simple;
	bh=yKxWuSxIg6MtigXJlkd4YV7IcsGj0BsCefuviCtPryY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLtbUYMDipCPlxSYog5b9H3UcYQM2pyfK0b7kZcIhBQ48VX+vgVfvyRRHcBhG/yeWKM/b9m+57Pnvhybc+RUnbs5U3RiTmG+NHzHJ00qahE/8iMUbCEnoSDY97gL5serNYckUCsMKF9nMpZ7dlBYUCmm7UsUxZ87XQ2IdMY4zPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lxzl24QX; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lxzl24QX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782209871; x=1813745871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yKxWuSxIg6MtigXJlkd4YV7IcsGj0BsCefuviCtPryY=;
  b=Lxzl24QXfsyQ6eVEgxwHFye3D3nWWz1jhcW45ygFHdSs17Mce/YTlLx1
   6GuDpsNWd0s7TR9yh4Mz7P/wc1Jq/RMcqwPDQL3hgrFdwA9A2m6hJlXsw
   zbiTBvosTGRbR3syTgmGMeFDZAmCd25zk8JfvTrJkwONRHPHEA1HN9oK4
   m0xSVDG/OXrL/Lgm4to3KkpRNLLXTjJ+BaUyOURq+5zGdcGMa+vacO7uE
   LYcJnX8Ke4oR2BBSokQWKDRdgay3r1OXZBpGS+B/gHkBk9nOxDXNQT3SD
   d5S/VJQ+7R9Pbh36yrgtKdCKnEw5Z0LBIbPpgViGdYi1lgRWX4byocenJ
   g==;
X-CSE-ConnectionGUID: ZTz3ywX4T46JCTOTQL5mnA==
X-CSE-MsgGUID: jh2CW4bxSN6SUwhiJe6yxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="105741655"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="105741655"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:17:49 -0700
X-CSE-ConnectionGUID: G7sg3GILRvyFR4uiszCSKg==
X-CSE-MsgGUID: QsrhBqDFTai4ya99CyYq3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="249341451"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:17:44 -0700
Date: Tue, 23 Jun 2026 13:17:41 +0300
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
Subject: Re: [PATCH 0/4] media: add and use
 fwnode_graph_for_each_endpoint_scoped()
Message-ID: <ajpdRUZhmn1fDXDx@ashevche-desk.local>
References: <20260622-fw_scoped-v1-0-a37d0aac0a68@nxp.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622-fw_scoped-v1-0-a37d0aac0a68@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 22, 2026 at 10:30:10AM -0400, Frank.Li@oss.nxp.com wrote:
> Add new helper macro fwnode_graph_for_each_endpoint_scoped() and use it
> simplify media code.
> 
> Typical example should qualcomm's driver (camss.c), the v4l2_mc.c and
> rkisp1-dev.c only silience improvement.
> 
> Anyways, *_for_each_*_scoped() already use widely and make code clean.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
for patches 2, 3, and 4.
Patch 1 has individual comments.

-- 
With Best Regards,
Andy Shevchenko


