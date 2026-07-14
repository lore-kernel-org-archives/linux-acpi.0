Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB1A3D9DD6;
	Tue, 14 Jul 2026 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018188; cv=none; b=TYwBpZBwasYD1UkLJf13Nho9t1rsBcfyeiDlYbHpJ5D5FHHM/0VjovgWPGROWDDZ9NFnlj0Z/opkPFbVh+McWbKNBSSIq1xpn8So6LiuTbcjbcvalmPJxTcuqn10xsdUZXbzE9CCwXPO9xU3xOr1opG9YAFOl6e6DJumGJaDWNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018188; c=relaxed/simple;
	bh=qo28EFWZxrsMXY4+G3XAbNJfDxU2gJLVu2KlDJ/n3Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lbs0hAUCG2ltwTwAF5swIherhf4o8QoX5qtPh4Ad82PydZ7lcKlPvsGrZiZcgtCegZyiPHNk8XRr2+yGbC/310kt3SCvOqha9qRZIaJSMDMNN4EFgxUM8wLg0gpTdlXFSN6YzWk2OeT3m/ioGaglvToRd1XiH5Rt6/BUgnW3NhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hG5qDB4R; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hG5qDB4R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784018181; x=1815554181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qo28EFWZxrsMXY4+G3XAbNJfDxU2gJLVu2KlDJ/n3Wg=;
  b=hG5qDB4RvuZrixVIPygZKXM3lW/4GaS0DmR7mF9jeMSOMWYjfshL8p9O
   5jbrfRmisQj4IQwZinpgws0UpMyNIMtfJzyF1uu7DJkcUDRTg3IybGYmz
   tmtYFEueJhnOI2KsS4xbFEDh5i1zEPRGDXhfh+FYZiftxIJWWOa7J7xOY
   h/obR8GJFbnm/sgMekrS+z/huzkdBcuOsocCh8GoVDBHuSsPRk20CdHi9
   cCPwf4xg6Wrrn7/3guS3OzHEXzEHeTFVGhWSViujhdBpduqPE5dd652MQ
   WY1tFFSH6cIyuBkqYBi02xOH16NtLPAichT0PKUHazU4EGlx1Ojnwscjd
   w==;
X-CSE-ConnectionGUID: gVHh/HxlT0+pBekF2f9gUQ==
X-CSE-MsgGUID: WeRe4+JcQF2qeT8XlJmXOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="102061324"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="102061324"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 01:36:11 -0700
X-CSE-ConnectionGUID: itx4fwgVR4uM93ncyrEO9A==
X-CSE-MsgGUID: LLDD+2CUScqpzW7EtThIXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="251847743"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 01:36:08 -0700
Date: Tue, 14 Jul 2026 11:36:06 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Mika Westerberg <westeri@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 09/20] gpio: Add missing dmi module annotations
Message-ID: <alX09v_juWEZs7TC@ashevche-desk.local>
References: <cover.1784013063.git.u.kleine-koenig@baylibre.com>
 <eb1fdcce0f07e274e5590b8821d9dd7835f1ce0a.1784013063.git.u.kleine-koenig@baylibre.com>
 <alXyEPWUS5cJg6Jb@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alXyEPWUS5cJg6Jb@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 14, 2026 at 11:23:48AM +0300, Andy Shevchenko wrote:
> On Tue, Jul 14, 2026 at 09:24:10AM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> > A driver module matching devices using an dmi device id table is
> > supposed to declare that in the module's metadata. Add this information
> > for two drivers that failed to declare these.
> 
> No, it is not supposed. Why?

...

> These are quirks and enumerating by quirks sounds weird.

Saying that I recall that we have also PCI ID tables and ACPI for the other
purposes than enumeration. Please, revisit all your patches with the same idea
and remove those MODULE_DEVICE_TABLE():s which are not required or actually
must not be there. Some drivers have comments regarding to the absence of the
macro, but some may not. Feel free to add a comment there.

-- 
With Best Regards,
Andy Shevchenko


