Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1060D427A1A;
	Tue, 14 Jul 2026 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018269; cv=none; b=ZdHpOtbf4anY6a40xim1ileu2rMg39qlwOzgD/59oxCa4KOCM5nnIPgtwUsLsBdiB5vKywnvqVlHmZRp8dnVwBu4LbcKctovLxC+H1Kl+qnH+PPCj+xF5kVk9qecYNLobX2fbh8zEK1cbWoIXME1YHdNurqDOXoz429GOpICb8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018269; c=relaxed/simple;
	bh=t02JFYvt2q6C6vocZJa0Gxw0ReMXr+FUBEDBNnbVEUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=banpvXs2OhdX6c26AA/mEvltKiq9k+mdw61duTq5QxQet9XQtE39K3Baj3WoSED+7bJQ/H3fVjlNaQJN2D0+RdWj8oA3UzfkUA3lkh4AZY/zPapYbMBASzePV5d4WgiM+1nFpnaJJPsxL6deVdLLCGjqCSvAIfB9E66EIyCvm1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sa4NfAhk; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sa4NfAhk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784018265; x=1815554265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=t02JFYvt2q6C6vocZJa0Gxw0ReMXr+FUBEDBNnbVEUE=;
  b=Sa4NfAhk6IQtPU1/RbfnBMeFqm42//cBIua1Hd3m0rg5kSwX0zqRqA9o
   57c7bN2kFdfXWAHyGE0HKxV86l//S7fWGoNuHDubpGLdaom27XH2w/Kxd
   6Otq7d+Axz2VY9DbGQpT4jAuWzfhabIO7lwlQjYd74ESgfD2B/Aj/i6Xk
   wwrldsOl4ZlQnVG5kmomdzu7AeA1e0rbv4hhzcOEhRifcZAGEUEK+iNpK
   lXU8YAH/M8y4n9EzyAPsOfUxbRQlXqruVlJZktzUmq/epjewOXIxupbuf
   KJhEaMkVLSW3XQRVTgBTVS6la3ut+RDJPTJtgZo9GKmghlPkcFM1B8VlN
   A==;
X-CSE-ConnectionGUID: eXaabVa3QPOHRx/5jS9uCA==
X-CSE-MsgGUID: vqR0YRE+RDmJ77cJSITgLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="102061369"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="102061369"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 01:37:37 -0700
X-CSE-ConnectionGUID: QRyz5A+HS3+Xxr+IZ8qxiw==
X-CSE-MsgGUID: 9kRuPCg6RHKOO/4ZDHER5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="251848007"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 01:37:34 -0700
Date: Tue, 14 Jul 2026 11:37:32 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Lixu Zhang <lixu.zhang@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Mika Westerberg <westeri@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 20/20] gpio: Unify style of various *_device_id arrays
Message-ID: <alX1TNKpn_eU3a7f@ashevche-desk.local>
References: <cover.1784013063.git.u.kleine-koenig@baylibre.com>
 <1f2d39342995533857417eb890628f7643b9a159.1784013063.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f2d39342995533857417eb890628f7643b9a159.1784013063.git.u.kleine-koenig@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 14, 2026 at 09:24:21AM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> Update the various *_device_id arrays to conform to the most used and
> generally recommended coding style. That is:
> 
>  - no comma after the list terminator;
>  - a comma after an initializer if (and only if) the closing } is not
>    directly following;
>  - no explicit zeros in the list terminator;
>  - a space after an opening { and before a closing }, a single space in
>    the list terminator;
> 
> Adapt the few offenders accordingly.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


