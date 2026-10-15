Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318375616A2;
	Thu, 15 Oct 2026 18:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792088330; cv=none; b=txe2AlwnsB+KQTPjhJPp6/8pgCMMwrOLz6eloSbVYhd/EyN11dzZFsvXEH/jtQa4yZipV+Tfe6pRp8kwdKkeeJg0g+NvT7WWMaJugJeRuFi4T2e8XucoF+jufjzwVHNInvtSqMdWZ+t+bAHMNExSGeN9JfD2XicoufcclZu9wjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792088330; c=relaxed/simple;
	bh=gTGg9BOjVWVo1boRvIyDXtUe1sirzLFltHwaR86a2f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJRrB4wlHyCebQNQkLwR3TSMSQThY+4nXcylVXTi5TFrfuKLNAZAb6AOPnBRUnRzDsdmLHfk9+JUWIorezSk9PINPvQCACVv5i/iZfM4V541GOrjm3Hpd/2uh6MQYP1xk82USAC5bPYJDLUd7Ksudu4e6RBxoH8IvwXvZhXXCnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fv6ZSICX; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fv6ZSICX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792088323; x=1823624323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gTGg9BOjVWVo1boRvIyDXtUe1sirzLFltHwaR86a2f0=;
  b=Fv6ZSICXL/dVsa9G3n6wxl4M6pLVHK9VIvZCqZLrnYwVwYrx3P0HFVeO
   dxDc408FSH1QODRbaWgucI7Li4y9s70HCv9h0x9tdCIQhif/kmrOH0LTb
   o7N2+ffpiINbedAP3ZohLW5YRz1KNsBCXJtSjk97izDY6P36LjdhDuU8y
   fDRSEYsighXdwK2Z+eGWC2yzsNMbZn3GWtkPWLXT4wCxBq55pvJDVjA3e
   yJ1Eh+2s7oLE5rKCfgR1n+NoH0lDXFOXjLOkICoK3EpWUrCqGquhA1M8V
   CJfgE5SqzR65X/+YX16iFRxBoDlqXQFGs5Sgybpp7qbb/j9D5BE8hi15+
   A==;
X-CSE-ConnectionGUID: yf1gS5tdTUqMDkfoOJOmdw==
X-CSE-MsgGUID: Ce75QTX9R8CYrhBWtSO1kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="868745"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="868745"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:18:43 -0700
X-CSE-ConnectionGUID: uRi+Fb8VSDai4w2TleP2Ew==
X-CSE-MsgGUID: xvBmOdDiTuui4ELzD7tOjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2070359"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:18:41 -0700
Date: Thu, 15 Oct 2026 21:18:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nikodem Sanecki <nikodemsanecki@gmail.com>
Cc: westeri@kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Hello, I'm reporting a Caps Lock LED issue on my Lenovo ThinkPad
 L13 Gen 2 AMD running Arch Linux. I found a workaround that completely fixes
 it, and I hope the findings might help implement a permanent kernel fix. **A
 quick note:** This is my first time using Linux, and I'm a complete beginner
 when it comes to kernel development. I used ChatGPT (GPT-6) to guide the
 troubleshooting process, analyse my laptop's ACPI firmware, and interpret
 the results. I personally ran the diagnostic commands and verified the
 observed behaviour, but the technical explanation below is AI-assisted.
 Please correct me if any of the analysis is inaccurate. ## Problem Under
 Linux, the physical Caps Lock indicator LED never illuminates, even though
 the Caps Lock key itself works normally. The LED works correctly under
 Windows and during certain stages of boot, so the hardware itself is
 functional. After investigating, GPT-6 identified what appears to be a
 conflict involving GPIO 11 on the AMD AMDI0...
Message-ID: <atEY_4U7Z-xZ6QpB@ashevche-desk.local>
References: <CAAUQFROUNCJo7EUn4eiDxSTd6pfPcQDP1_ma0G2k73DJtMnNVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAUQFROUNCJo7EUn4eiDxSTd6pfPcQDP1_ma0G2k73DJtMnNVw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 15, 2026 at 03:21:11PM +0100, Nikodem Sanecki wrote:
> Resending this report in plain text because my original email was
> rejected by the linux-gpio and linux-kernel mailing lists for
> containing HTML formatting. Apologies if you received the original
> message twice.

And now the $Subject is well messed up! :(

-- 
With Best Regards,
Andy Shevchenko


