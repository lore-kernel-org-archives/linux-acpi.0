Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D67C41D63F;
	Fri,  2 Oct 2026 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945909; cv=none; b=NzVGJ9vNXY1nuGQONSRPVsLKfWdp5SyRbQCyxvZ7iik4YzFzHdGxED7L8c5f3TBqP/AxY1oa44+C3sZB04YBwi/OL5U73y4IWCMbTTU1j42AEi8UHqViphrT42dauaOxIpw10k6Wfk5IIxTHW31cSStFgALG8/hqB4zZkQUzFeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945909; c=relaxed/simple;
	bh=DpUR6uOIndM4PlTAVW6OCY4m4wz4r9tXf0VQ3uJ6zOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDL5FIiubaQJMT6y6jQ/ZM9mCoJfXTBNoLEZKzk6pCF5/Zh58Sf0ErZkxH2M87urpVRE2mjnOK7D9gcYW63JZCMs5BQlemGXEQZ0o79fOFSPNKY3QThOKQOyb0MKvSz5KMW4TXMn3EyhOhFWHSBjqsmdPR6U2FcDLPJEhHe4p3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kNI4b4Ky; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kNI4b4Ky"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790945907; x=1822481907;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DpUR6uOIndM4PlTAVW6OCY4m4wz4r9tXf0VQ3uJ6zOU=;
  b=kNI4b4KyfeVh6YyigBYl835zhOCZF8mydXBryA0K7M+rOz88NIXJzxR3
   y8UO6V8iRH9YRLsuWg2wNvi6xwy9nNRsuK3U8TxN7CZslPyLcsqJpLCuW
   MJ4ZEHbUd0kVLZLG/ztX2Sf31Hbb5N2FuwL6+WTPTpEuqtAwd6V9i8B6d
   /WrH5ZQ5CW630HcVs0739y4hvSXuQsdUrfWt7YccHKOzFtoe+S+aGo7xh
   ljw885RXsPDAfsuOHhFWTQiZTI71qWwdntpMnJzJYNKUvR7/goYy35wqR
   b0l5h4WbgavEJPCuxFY1aBkmVotB+HpC9DIQ4bWaNJyS5j6Xwtg7+gmil
   g==;
X-CSE-ConnectionGUID: Hv6izO03R9O4vaKQt7DSxg==
X-CSE-MsgGUID: tn/5YLYWRT6s+qa/Z2al6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="91573052"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="91573052"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 05:58:26 -0700
X-CSE-ConnectionGUID: 3hQVQT88Tf6eNujsmXxNHA==
X-CSE-MsgGUID: phuvjuzzTOqKScn2c1siFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="304205366"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 05:58:24 -0700
Date: Fri, 2 Oct 2026 15:58:22 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Abduvaliy Abdulazizov <abduvaliy.hbai@gmail.com>
Cc: Mika Westerberg <westeri@kernel.org>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Ignore GPIO 11 interrupt on Acer Nitro V
 16S AI
Message-ID: <ar-qbsmktRJbFoF-@ashevche-desk.local>
References: <20261002101800.51506-1-abduvaliy.hbai@gmail.com>
 <ar-Ja2AVJs1TzMpg@ashevche-desk.local>
 <CAPGafd=-SfJoVMXtjwpahEkZ8nB9gTjGm+C5WvP+F-AdjsGPjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPGafd=-SfJoVMXtjwpahEkZ8nB9gTjGm+C5WvP+F-AdjsGPjg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 02, 2026 at 05:17:02PM +0500, Abduvaliy Abdulazizov wrote:
> On Fri, Oct 02, 2026, Andy Shevchenko wrote:
> > On Fri, Oct 02, 2026 at 03:18:00PM +0500, Abduvaliy Abdulazizov wrote:
> > > On the Acer Nitro V 16S AI (ANV16S-41) the internal USB camera
> > > (0408:4035) works on Windows but never shows up on Linux.
> >
> > While this all sounds legit, I'm worrying that the pin can be used for
> > something more. For the record, can you share the DSDT table (or entire
> > `acpidump -o NitroV16S.dat` file) via some file exchanger so we may see
> > that?
> 
> Sure, here is the full acpidump (BIOS V1.14):
> https://github.com/abduvaliy-engineer/acer-nitro-anv16s-camera-fix/releases/download/acpidump-v1.14/NitroV16S.dat
> 
> What I found when going through it:
> 
> - Pin 0x0B shows up only once, in \_SB.GPIO._AEI, as
>   GpioInt (Edge, ActiveLow, ExclusiveAndWake, PullNone). Its _EVT case
>   only does M000 (0x390B), with no Notify.
> 
> - There is no GpioIo for it, and none of the M009/M010/M011 GPIO helpers
>   are called with 0x0B. The only static mapping of the GPIO bank in the
>   DSDT (OperationRegion GSMG at 0xFED81500) has fields for pins 23 and
>   40 only.
> 
> - The PCIe reset pins in the NVMe SSDTs (RSTM) are computed at runtime
>   from a platform table. Pin 11 is not one of them on this machine: it
>   reads low after Linux takes it, and both NVMe drives keep working.
> 
> So as far as I can see, the firmware drives the pin as an output for the
> camera and lists it in _AEI without a real handler.

Thanks for sharing. I will wait for Mika's tag and apply if he has no
objections.

-- 
With Best Regards,
Andy Shevchenko


