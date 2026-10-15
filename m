Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2273E8C77;
	Thu, 15 Oct 2026 18:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792089161; cv=none; b=fIRaO9vRiNoNr5nnB0rhPYtEPjtrX8sUPDmlCC/Jy5GdV7X/jqpUyvZWlrHxrmG5qGFRLIvwhlMviisW+wG6lkyD/TkFLEplgtWB9rq4u2nTIr86Xf5fa7zSzX7e8V8Fpg42vToUNaJmIwm7IAY1+U1jMC22ANmC8OMtCkB2NoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792089161; c=relaxed/simple;
	bh=ujF9Q6zrry5NePZqJr3akVR/yhaeDorGSQ5rXJWAedM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqDJWGSVyV3/g+nnN7/aoc6tXMwst8o4TymtKBNtJgP/Zu8s6vIn+DQRTvh6tdTC6M73ghOnQC624XvCUPevro60uC7KXISIY6vpHBny3fQMto8CjDbPgNWRes6kxgMErognOKnJQ4UhKe7E9lHQkOOBLpHZOqkGKM63fnM+MMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ECDRud1g; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ECDRud1g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792089159; x=1823625159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ujF9Q6zrry5NePZqJr3akVR/yhaeDorGSQ5rXJWAedM=;
  b=ECDRud1gWFlLd497ri8dPTJFAS7jgpK0lN84HDnNUZwSHmpWGCa0looN
   hpSLIXW29MrvGZ4cmVVjQIu43bxgPGWiYtFX/2bVK4hGtRxXgG4wBaBPn
   x7pkoQ15RYPptOCGucZ2Sr4gPAz2C7CB5I/SRSA/CYt51gWZxeWN/4/it
   TPscatgIRX+j18972MHxaMjExHtoc+IIYjiVfAokUB2dJUMzxA7IO3PiJ
   knlxtpeGJt09rutTw+E1chj4mWAyTsnXviBQUyfUt+J8JY7qbWu3lW6p1
   JLvtg+bwpFXpdHaKOzWkJ95MNQnfd+JzOlt4PF6yNe9ycNwW6dcmGIIAh
   g==;
X-CSE-ConnectionGUID: H2jrFuhYSEK/fQ9c+PHZEg==
X-CSE-MsgGUID: 1CnKM1DaQ6qGUiKXsodXhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="767555"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="767555"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:32:39 -0700
X-CSE-ConnectionGUID: qTYmpu1pSGeY6h+U+yHHOA==
X-CSE-MsgGUID: UHoqdt0mR1+ShZ/MC238vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1649557"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:32:37 -0700
Date: Thu, 15 Oct 2026 21:32:35 +0300
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
Message-ID: <atEcQ-qjIXt5eNJp@ashevche-desk.local>
References: <CAAUQFROUNCJo7EUn4eiDxSTd6pfPcQDP1_ma0G2k73DJtMnNVw@mail.gmail.com>
 <atEY_4U7Z-xZ6QpB@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atEY_4U7Z-xZ6QpB@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 15, 2026 at 09:18:42PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 15, 2026 at 03:21:11PM +0100, Nikodem Sanecki wrote:
> > Resending this report in plain text because my original email was
> > rejected by the linux-gpio and linux-kernel mailing lists for
> > containing HTML formatting. Apologies if you received the original
> > message twice.
> 
> And now the $Subject is well messed up! :(

Note, let's continue thread in your HTML start, I replied with text only there
and cited the whole message, so formally the content is public via my reply.
Let's not continue _this_ thread (with badly formed Subject).

-- 
With Best Regards,
Andy Shevchenko


