Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D52376BCD;
	Fri,  8 May 2026 07:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778224986; cv=none; b=YM1xFaWcdWgRUNA8brJvU2x5c3k8UKD2R/VeTqyxPRG32hgsOH5WofBqIDDIM+C4Wis2ZsmSgxge1XSatuBVdXYPIloTFZg4Jt+ezawZn/lqBT12ZWt2udkQCiBLP1vRbVswAzg9XFDhqdDD6bBZmYJmuVpYzHCAvwc+uCvQip0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778224986; c=relaxed/simple;
	bh=H88G6CL5TWFd7eybjl9i88KQu59+VhkHbQ8Vy9juMf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPY3qg93Uo0/bZruIBXVwL5BXscYzak2zxiP6EwhSYaLfusIAqoh4WYR7GnuXmuvcff4fzWWJ8FzoMFsPHillg0BU8JmEsg6SjZi7mJ7WVosydSd+MV8c686LtJRpqM6+FPWtw5YqKEhVXH/OBA+7Jmb/g9kv/Nv5vrx5q2MbgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=baah6Vd0; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="baah6Vd0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778224981; x=1809760981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H88G6CL5TWFd7eybjl9i88KQu59+VhkHbQ8Vy9juMf4=;
  b=baah6Vd0lUtlWoIi6IPQLtHhUNu27t4H98KO2iMGhvVp7kwNAqmgImJk
   Gghdlj+1JWzzPBKb6oEgxnFULYIFHMP95wnL3aClcuK6ySqKhrS/rIv80
   Fi5bN2UYbKiYsc8/FCiOQrdLJ1oolmM3Gh1xuETqcpuAu/lF4VLOrs3Wj
   YlzG/BLYOZx73liCY8/JLKmY00UFMdLSSHrEWd5K4FaXHsYFTW0jIk3ME
   ZGuGJ6/0LFrbl2K1DeobLbK4ez/g+Jd2uRAHTXi4l1g7mLmDTrqqyjBIm
   3dKKnEqxTxycZ0Lqz8vnfwmm5cbu4wpJ70it7tlHgAD09dccymVk/5P0S
   w==;
X-CSE-ConnectionGUID: rqwT8BSCTNORMDNUOH1xig==
X-CSE-MsgGUID: gT8L2u2WRj6UT9ji0jkf5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="78913474"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="78913474"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 00:22:57 -0700
X-CSE-ConnectionGUID: sP8EyzS4Q2CEw4wpMF5N/w==
X-CSE-MsgGUID: GhWzL3kcT0K/Q5NLYveojw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="234034060"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.237])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 00:22:55 -0700
Date: Fri, 8 May 2026 10:22:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marco Scardovi <mscardovi95@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, mathias.nyman@intel.com,
	mika.westerberg@intel.com
Subject: Re: [PATCH v4 0/6] gpio: acpi: modernize resource management using
 cleanup.h
Message-ID: <af2PTWlxzIffkaU2@ashevche-desk.local>
References: <afzlsRkyKQzuUcgL@ashevche-desk.local>
 <20260508061729.9530-1-mscardovi95@gmail.com>
 <af2O4wKm01mSCaxr@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af2O4wKm01mSCaxr@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 08, 2026 at 10:21:11AM +0300, Andy Shevchenko wrote:
> On Fri, May 08, 2026 at 08:17:23AM +0200, Marco Scardovi wrote:
> > Hi Andy,
> > as requested I've added the missing Signed-off-by and related commits' messages.
> > Let me know if it's everything alright now.
> 
> Note, cover letter is not just for a simple comment like the above, it's mainly
> for the overview of the series as a whole, what it doing and why. No need to
> resend a series, just try to write down one in a reply to this message.

Also this is v4 of the series, you need to provide a changelog for each delta
between two sequential versions (here we expect to see a v1->v2, v2->v3, and
v3->v4).

-- 
With Best Regards,
Andy Shevchenko


