Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABE240F758;
	Thu, 15 Oct 2026 19:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792093878; cv=none; b=qjkBAmvOMBsAINstvtBjI72eJRQb69irGzlRNuJuC6qAgXFIGQIPozyod17OAjDfcLh+KRFb+AdkcYZujOhVy9Wttx4j+gMVw9885veQQAmOAQZNC9IOflVSykyJf+Y6o+8Kgp2zX6+C4xNVjmwT7pqoR6zO6flmnPhr0H41bA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792093878; c=relaxed/simple;
	bh=T62Iwmpnt9lCfnmRUOQlkjAGaf3KxXe2KV6JnJ3wEHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyaKtYXffS3HNHmYl0c6KE3HhFhAnxbwGJoZBdFSnrZFAZh8P3uBy38tz6PIamYZ+fxhZ2r088c8C+yff5ytNh/vJLOfEQMR1EY+r/d8SEeRkJSjqyzehDm+FdFkMUHuPUS2exwiQja2QCESD1C5hthVyUPQYzz0rjLLyodTiTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kUw7n+GK; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kUw7n+GK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792093877; x=1823629877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T62Iwmpnt9lCfnmRUOQlkjAGaf3KxXe2KV6JnJ3wEHI=;
  b=kUw7n+GKgzO/WqimkIJVs0HPQXhV2D344+Wq0yw6IlWheDYO+zZtTizn
   hYrZ9oq0QHt0C2gtLzjr7IXaiDFH0QHzjOCY+4C+gj7aVQk8GV4rAZ+V/
   /qz6Dp9lrURoE/46GgVLIGU0l67uDfa5X7m1+fEIiApTVyUWtR1OQVuT1
   /IvaxRY96bCUOYvfuxNGUZvViuAb2Xw71JswIbkOqrbI9OfzHwYkpIsTs
   H2FDY7JvxLFYKA02J6sQ3fx/5Wt1lboLKM5+Bq1gZLW5ic4X+kfLJhDgw
   L4+FrBvEVNmGwV/4k2B7ZL8jPF/pCSY6hNSykH4HbOkps6/RIedYgwG0b
   Q==;
X-CSE-ConnectionGUID: mG3IP1XrR3yGldPr9zip8Q==
X-CSE-MsgGUID: QNR6wbuuQ4eYWA8tSJNZPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="878546"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="878546"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 12:51:17 -0700
X-CSE-ConnectionGUID: U6zhJEnsTG2bPWTlXVYUwg==
X-CSE-MsgGUID: TQw2FlzWTiqDSJFYv7V9zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2243263"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 12:51:15 -0700
Date: Thu, 15 Oct 2026 22:51:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: westeri@kernel.org, linusw@kernel.org, brgl@kernel.org,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Nikodem Sanecki <nikodemsanecki@gmail.com>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Ignore GPIO 11 interrupt on ThinkPad L13
 Gen 2a
Message-ID: <atEur_R_jFnlsZYU@ashevche-desk.local>
References: <20261015193924.4081906-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015193924.4081906-1-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 15, 2026 at 02:39:21PM -0500, Mario Limonciello wrote:
> The ThinkPad L13 Gen 2a firmware declares GPIO 11 as an edge-triggered
> interrupt in _AEI, but the EC uses the same GPIO as an output to drive the
> Caps Lock LED.
> 
> When gpiolib registers the ACPI event, the pin is configured as an input and
> firmware writes can no longer control the LED.
> 
> Add a DMI quirk to ignore the erroneous interrupt declaration automatically.

Bart, if you are still okay, you can add this to your fixes branch.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Otherwise I handle it after v7.4-rc1 in a normal way.

-- 
With Best Regards,
Andy Shevchenko


