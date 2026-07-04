Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7431AC45D;
	Sat,  4 Jul 2026 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783172217; cv=none; b=tYjd5NFyIOm82NgIjFuQdRCuWnCsLdl1WhtuUvddKC7h+70OOmJpIx9DuOLJqDGL8UywRP+26Zu//QGe2sj/v2FtWHebstB3EsaQpJatAlbLX4ihIBO6DQIUEYtFflXsBlUbU6JqLi5asLv8jL6i8srAn7t5cUrv3lXHuiDpei4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783172217; c=relaxed/simple;
	bh=rd29hEW7/mZEN6nZZOylxIVm7Oed4Lfu7eg/D0iII0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWtye0dz8nGNvYnlEQa6u7+zsgnfNsgClGtljBrq96SssJPUQJdFsH3IEPJKSjCjzr/EXVe7mSuPwrOoOZR/hDxAhJOedVcvmPQsuDnffMIQiDMJR68d28/4TH6pdO0NTa3zgm8UeNWBEei5k820F6tI7EYvFsfoFyX6WEs+kQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IsiSJAEi; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IsiSJAEi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783172214; x=1814708214;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rd29hEW7/mZEN6nZZOylxIVm7Oed4Lfu7eg/D0iII0o=;
  b=IsiSJAEiL9Torj9hY51r7EdcMy2Pf3418kFyY7CopggMyXp/ABPY4EyN
   TUnz8bl2WB1g+Q5fgOqo5l9LW82YeTQ/X8QrPdUlaZgb6MHF1qMlFqKYr
   ZBQAZllZbYh7QKa6Mi/z8kMhqANZwDrCKApdPzSzabNbP9kSXFvydwnSJ
   C0yx1bv/vjDDyegcH5TJ3I75DZUZ3TOKnRFa/DbeGJ43e7YmR+YhG7uUA
   3alxX6PMyZV0C6h0phF3iB5mZR+Tpctdl8GP1anYwlmn4D60Z0+T9W09L
   5oggAkO23PWtHPSMQzc1mZUIqLzJJ8H25KxPGLxsvfVWv3Nv4PFp7kNQA
   A==;
X-CSE-ConnectionGUID: OIDUTSrRTZ6k/BIASywslw==
X-CSE-MsgGUID: COaM1uMaT4OiygS7hIzMMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11837"; a="83751855"
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="83751855"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 06:36:54 -0700
X-CSE-ConnectionGUID: EGyFSN2bTNqauH/OqNo6ag==
X-CSE-MsgGUID: Ieix8opTRCePRyU+d9n8ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="250651072"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.237])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 06:36:53 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id DE247120221;
	Sat, 04 Jul 2026 16:36:51 +0300 (EEST)
Date: Sat, 4 Jul 2026 16:36:51 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@intel.com>
To: Arun T <arun.t@intel.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, mehdi.djait@intel.com
Subject: Re: [PATCH 1/4] ACPI: scan: Honor ACPI _DEP dependency for NVL CVS
Message-ID: <akkMc_1FoygAriBH@kekkonen.localdomain>
References: <20260702131809.1224895-1-arun.t@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702131809.1224895-1-arun.t@intel.com>

Hi Arun,

Please use git send-email to send the set and preferrably add a cover page
when you have multiple patches in the set.

On Thu, Jul 02, 2026 at 06:48:09PM +0530, Arun T wrote:
> Add INTC10FA to the ACPI dependency honor list so the CVS driver is
> loaded before dependent camera devices are probed on NVL platforms.
> 
> This matches the camera dependency handling already used for IVSC-based
> platforms and ensures the camera streaming path is initialized before
> sensor access or pipeline setup depends on it.
> 
> Signed-off-by: Arun T <arun.t@intel.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
