Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DF23EDE59;
	Tue, 12 May 2026 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608748; cv=none; b=o/qdGOShzoGyWX4pglRfSov+13J/dTFV1yaVNQitZbQdn1ElRQ1n/nXzPnwJ4gU+CuxX6w5958EIGVzmHmAfWH4lnbf25nni4QQnkHC5URoXKcz6VL+jh26Haf8ZsW261TOfXERk3ODWiTi3RGm7lYckI6Fd58HNO55loqv7oI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608748; c=relaxed/simple;
	bh=+zlxSB+87SmVSn+j69GTrz3x31i39zFkMe+RiKZscII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mn6fxoZuQcyK2NBgT+fQeSgR0L68RsguXP9suHRGeh0zDR5qj+FChaLngDVJGKCpGqNr87BXE2c2/Oo8pGOTTMYI+ilrtoSA32iZsF+em/GiYSe2A9xi933F5nJlQFCZGN1THyBP6KK64C/CwZThchKTfAFfwG6S+k0YjS277OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YQilqCka; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YQilqCka"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778608747; x=1810144747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+zlxSB+87SmVSn+j69GTrz3x31i39zFkMe+RiKZscII=;
  b=YQilqCkaLFJ+vNs/wNcU7DOzfD6Hg0WgA3JkaLXj2jBXzkNXufnMJ8EN
   LWtGk6YMsh68C+cw91tPUmi0iEX6rGz3rTvjEUqtM85pV6zgJLVeSyLb6
   XAiY1V4Wt3FeG4z9K6ZASFf3MLyjf1wzy3/jz2bvRmxssFPnz4VOMb1S/
   m5I3YQwwvxqk4I91EEpnv5BmIKMHtEg6Rj2pP5RNkX4qLSmFOcQSBdaed
   HD8ayrP8EywZSZo7epKc0JlK6yraF1KVM2Mkv+acex9NUVZib7ZPBiEMF
   Ylf1mckHlf2+G2hQjoc/BPUGN3knJp3zKknVWhRKlD6y6gSIdRUN57qKc
   w==;
X-CSE-ConnectionGUID: pF5n0DvXSYmsc9A0ARZytw==
X-CSE-MsgGUID: AZnJkaD9TqawbTqAcUbTFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79421887"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="79421887"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 10:59:07 -0700
X-CSE-ConnectionGUID: ipnBLGgHQc2J+5SfFtFwRQ==
X-CSE-MsgGUID: NkOqWvyiT/WihzgMMYmbwQ==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.244])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 10:59:03 -0700
Date: Tue, 12 May 2026 20:59:01 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	platform-driver-x86@vger.kernel.org,
	Andrea Ho <Andrea.Ho@advantech.com.tw>,
	Eric Piel <eric.piel@tremplin-utc.net>,
	Alex Hung <alexhung@gmail.com>,
	Shravan Sudhakar <s.shravan@intel.com>,
	AceLan Kao <acelan.kao@canonical.com>
Subject: Re: [PATCH v2 0/5] platform/x86: Check ACPI_COMPANION() or
 ACPI_HANDLE() against NULL
Message-ID: <agNqZTeZOKovY84H@ashevche-desk.local>
References: <6007701.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6007701.DvuYhMxLoT@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 05:10:35PM +0200, Rafael J. Wysocki wrote:
> Hi All,
> 
> This series replaces
> 
> https://lore.kernel.org/linux-acpi/4731840.LvFx2qVVIh@rafael.j.wysocki/
> 
> and as a whole it makes exactly the same code changes.
> 
> Every platform driver can be forced to match a device that doesn't match
> its list of device IDs because of device_match_driver_override(), so
> platform drivers that rely on the existence of a device's ACPI companion
> object need to verify its presence.
> 
> Accordingly, add requisite ACPI_COMPANION() or ACPI_HANDLE() checks
> against NULL to 5 platform/x86 drivers where they are missing.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

to the whole series.

-- 
With Best Regards,
Andy Shevchenko


