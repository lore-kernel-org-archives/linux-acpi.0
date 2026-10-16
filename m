Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C6C2DA749;
	Fri, 16 Oct 2026 05:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792128367; cv=none; b=SJqTr/VRJkhQynba5uxqt+aNVDhj3/Ih3wW+FtDA5CDTsPdvkbT6gx/4rMlHoPA3qj/U0oZFlWJRPlKM0sVw23O4ugWjChd7L4UMs1kaNo/t2GEcm0El+xYbVsyPlDBFz5AxeBzPEnN7t7Nlu5wK8uLG2mQYpeaEu/aPn7jO3IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792128367; c=relaxed/simple;
	bh=WOFMl8dCS95x1OBTOow+2+p6dGWxbepPwb+UvnK3Eg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IH40Xmob2XDq62CYZXY7LOF/1GAYMdwtdYkP/HsycjRHBRxzo5C1Drgj+9eNGJFuWPhK6shgQFaBN/ahxqB3jy4Lc4xlBtLyQYMD4f9qGyn3KpauLliocbmGJ7FxZG/sUkPwzutosbqozKYCye7qAE31qh6EWM4v+wRkhpeQcqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OhYY52nl; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OhYY52nl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792128366; x=1823664366;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WOFMl8dCS95x1OBTOow+2+p6dGWxbepPwb+UvnK3Eg4=;
  b=OhYY52nlkML/nKcrEn8iy7x9kKcOxHoVZzrHRLYWb/NS+zqiT5yUP/Rv
   BHbVTZA2YFFHi7s0Wp8K9MPdp/E1Gy0E33nlUHgnqgTCYT1ON3PYPgHqn
   RJj64LgR7geRSn6QXA48dhkYWdxMlx0udCS9pR/RfxkQ3Ec53PwCeaE8B
   DYRuDBtjA6BwmnGixw0RWBUUyx54V5WmCxwmBPR40r1Sy87/ddv6jIGNR
   QEJOCx1lQYwv+klrtjATrWljtzeeg6eb5x4rQaYK5dAOKqdBOFpBo53bP
   88mCuGvhDnG0T+SJK8V/j7PPiOzDt0cLtP/j+iaALaiJEID1GJFz1TJEH
   A==;
X-CSE-ConnectionGUID: oQV2NtuAS06RFgkwzpcS4w==
X-CSE-MsgGUID: byiKNPcHTDSJvTzOrNHmAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="910619"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="910619"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 22:26:06 -0700
X-CSE-ConnectionGUID: 96r3v2i8T5G0Oc3/98M7UQ==
X-CSE-MsgGUID: Cyb4WDJ8REKyd6ETNoP1Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1873073"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 15 Oct 2026 22:26:04 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id CA7AF99; Fri, 16 Oct 2026 07:26:02 +0200 (CEST)
Date: Fri, 16 Oct 2026 07:26:02 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Abduvaliy Abdulazizov <abduvaliy.hbai@gmail.com>
Cc: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-kernel@vger.kernel.org,
	Trijan Koju <trijankoju11@gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Ignore GPIO 11 interrupt on Acer Nitro
 16S AI
Message-ID: <20261016052602.GU176164@black.igk.intel.com>
References: <20261007120944.1705014-1-abduvaliy.hbai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261007120944.1705014-1-abduvaliy.hbai@gmail.com>

On Wed, Oct 07, 2026 at 05:09:44PM +0500, Abduvaliy Abdulazizov wrote:
> The Acer Nitro 16S AI (AN16S-61) has the same problem as the Acer Nitro
> V 16S AI: the firmware powers the internal USB camera (0408:4059)
> through GPIO 11 of AMDI0030, but also lists that pin in _AEI. Requesting
> it as an input cuts the power, so the camera never enumerates. On this
> model the same rail also powers the internal microphones, so they do
> not work either.
> 
> Booting with gpiolib_acpi.ignore_interrupt=AMDI0030:00@11 fixes both
> the camera and the microphones. Add a DMI quirk for this family too.
> 
> Tested-by: Trijan Koju <trijankoju11@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Abduvaliy Abdulazizov <abduvaliy.hbai@gmail.com>

Acked-by: Mika Westerberg <westeri@kernel.org>
