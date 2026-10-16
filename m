Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEA42D5932;
	Fri, 16 Oct 2026 10:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146737; cv=none; b=Kzrrrv5fkI14Ozqp6LFHq/c/Zt0ituXVHNhp3/d6CDqqRtTnC/oGgx3HM94hwF4ajyXMUuzkgaK0g//rU6C+VnQ+oaruAYqoESvYBTyBfou4u1fD9oz49cTIv0l70qHmiyIApKFa/+VcyUMZj+5U2RgFMuxcwqqxboV0oBkDJS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146737; c=relaxed/simple;
	bh=QA6H725sNaaCumj0ZOWAynE1zh2dAh5usErDk4nYc9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=af43c+oxdXGxlW7u+xwHv/7WJ+EcqV/PSu/sAAQGGbQyO3FGtRI0mi+i1BV8AR1oAWYNNsDDzP/BHImM94WaSqMpkOZrIjw416wHzbMa8ZtV/yRBaGpI9jiBfm3LFkWFODANENWd/hPRQGchYs5otBbHULCcQfxQco/V09HkbPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MQ1uOra4; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MQ1uOra4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792146736; x=1823682736;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QA6H725sNaaCumj0ZOWAynE1zh2dAh5usErDk4nYc9Y=;
  b=MQ1uOra4WbEHwKoY9WXf6brSrOUajA0eY3gKWTbWq/L42wnQem4H0Xsy
   3cMpt9eTe67sG8gTOqZACsPgtFD2+6U1EZ1qMvz7+mQSBPYjqvmUOWfiO
   +Yur4O7q2q+Z+L4kio0Sua//yYv+oMoxiNFd9g8oWb1pRU6oRZd1PhTKm
   eX80a22NHocvi4pYkI6P6fqtDE/qP+HcPrAAz1l16EDuMp/eubSs0lq8S
   Tz01qxIikqlXLM264KQ8h8w7Vb/Kf6g5YyYH8g04AZn8dR1MFfXMlI3Bm
   bLyFR1NFGPVr90/vn79sUMN824X0Dj3HBYlNemGx4K8MNr87HWAo0T3ZK
   g==;
X-CSE-ConnectionGUID: 1J0cVEBQQOistqaDSc410g==
X-CSE-MsgGUID: yD5wAQD5RRu57Up2eK1i2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="923749"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="923749"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 03:32:16 -0700
X-CSE-ConnectionGUID: K9+WOhvtRHCc2DZHFsgaRA==
X-CSE-MsgGUID: uxxvin9sR/yveu3AxuWW2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="3666038"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa012.fm.intel.com with ESMTP; 16 Oct 2026 03:32:13 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 4BEC799; Fri, 16 Oct 2026 12:32:12 +0200 (CEST)
Date: Fri, 16 Oct 2026 12:32:12 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>, linux-kernel@vger.kernel.org,
	Trijan Koju <trijankoju11@gmail.com>,
	Abduvaliy Abdulazizov <abduvaliy.hbai@gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Ignore GPIO 11 interrupt on Acer Nitro
 16S AI
Message-ID: <20261016103212.GW176164@black.igk.intel.com>
References: <20261007120944.1705014-1-abduvaliy.hbai@gmail.com>
 <20261016052602.GU176164@black.igk.intel.com>
 <CAMRc=MdgwgA_h0mHzQ_Jd4hQYe0Z_zFWYE+T441Cc_kCRLFAbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMRc=MdgwgA_h0mHzQ_Jd4hQYe0Z_zFWYE+T441Cc_kCRLFAbw@mail.gmail.com>

Hi,

On Fri, Oct 16, 2026 at 05:02:11AM -0400, Bartosz Golaszewski wrote:
> On Fri, 16 Oct 2026 07:26:02 +0200, Mika Westerberg
> <mika.westerberg@linux.intel.com> said:
> > On Wed, Oct 07, 2026 at 05:09:44PM +0500, Abduvaliy Abdulazizov wrote:
> >> The Acer Nitro 16S AI (AN16S-61) has the same problem as the Acer Nitro
> >> V 16S AI: the firmware powers the internal USB camera (0408:4059)
> >> through GPIO 11 of AMDI0030, but also lists that pin in _AEI. Requesting
> >> it as an input cuts the power, so the camera never enumerates. On this
> >> model the same rail also powers the internal microphones, so they do
> >> not work either.
> >>
> >> Booting with gpiolib_acpi.ignore_interrupt=AMDI0030:00@11 fixes both
> >> the camera and the microphones. Add a DMI quirk for this family too.
> >>
> >> Tested-by: Trijan Koju <trijankoju11@gmail.com>
> >> Assisted-by: LLM
> >> Signed-off-by: Abduvaliy Abdulazizov <abduvaliy.hbai@gmail.com>
> >
> > Acked-by: Mika Westerberg <westeri@kernel.org>
> >
> 
> Andy, Mika: do you want me to queue this as well for next week's fixes PR to
> Linus?

That would be great, thanks!
