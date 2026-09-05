Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62939360EF2;
	Sat,  5 Sep 2026 07:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788594271; cv=none; b=S0EE3Olef+tfSbQjc27r0SKHbKvPJN1yuA1HIxI1ICt8AiFprRZoAxHs6P/GnVUr0qzWlDK4VUvzx0LHpXng3fcqNaJSTcVEsZIQ/CSiEd7aBgOlaOS7QkJ8Hkmjfxtuqmwk2bsovW3de95O+RuPQurCqngBo/o7l4rm4kz9Gn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788594271; c=relaxed/simple;
	bh=j3wvVFfckmgjrFD3yF7a6wyniicOFkDp+N7/iU6mACE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmltW7uhmPm+v6EmLtG03DBvIhBZ4hd7GND7qMEsLN+NRfxyARugCSsYaN8b8ZG+sjCB28PvLG+TxzmVkdDkYerCdGt9Onh36/3dEnr7Ls1QEZfALi3KqXb9WCy/aYhVDz3yXDw3rpoYjgDQx92Qn884Egt9PSwar71rB5QqDx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RoWRky+l; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RoWRky+l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788594269; x=1820130269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j3wvVFfckmgjrFD3yF7a6wyniicOFkDp+N7/iU6mACE=;
  b=RoWRky+lJkhhBizeS13+AiZv54WRfL7V3thW76iehwChpK1ZArqV5xhy
   x1NqtquM3Ky+wIaR8JvHX7YKFq5bA0G0+Tvw4tVntAtAwO4tYyTzyXx+m
   93zFlzoA7aQuGPI+rQObR9uKSuwZ9cfrQXkFji3XLM97/67g210XbvcYx
   lPTvexkjFnHoq1o5T+bRPHDtMeYA6LQAOOJLv/zGlXZN3uwqM+ODU/ud1
   UwoaRmDJPm8SgomdiUdQiZ1KUXue9cyqfTyVT4S0q03Xxp2ypwH+hM695
   e2Y5U/jdFTPBd5n2xttg3qJOopIvZYqgZqNPfPa+pSnkmXggB3PXHjzRc
   w==;
X-CSE-ConnectionGUID: 9IeRF07BQieXfL4R3uHpLA==
X-CSE-MsgGUID: gEVsRvLvTkeimrs+uGLp1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="92955856"
X-IronPort-AV: E=Sophos;i="6.25,263,1779174000"; 
   d="scan'208";a="92955856"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2026 00:44:29 -0700
X-CSE-ConnectionGUID: MtiZCHO/QVqlSY3MbRboSQ==
X-CSE-MsgGUID: +U3QRXWBQW+TuSc3diu8aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,263,1779174000"; 
   d="scan'208";a="308487217"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.105])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2026 00:44:26 -0700
Date: Sat, 5 Sep 2026 10:44:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: Re: [PATCH] driver core: fix typos in comments
Message-ID: <apvIV6uIkqFI5dlF@ashevche-desk.local>
References: <20260904111816.31254-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904111816.31254-1-hemanth.selam@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 04, 2026 at 04:48:14PM +0530, Hemanth Selam wrote:
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.

Not sure if it's okay to combine three different areas in one patch. OTOH
this is quite minor fix and I wouldn't expect any conflicts with anything.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


