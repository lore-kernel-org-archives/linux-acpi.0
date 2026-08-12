Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBEA337BB8;
	Wed, 12 Aug 2026 08:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786524001; cv=none; b=JhNhZJ00SecfiHI4FLvB3QzpfOY6S/AoUzszH76u1rfRlblkxaZH3XqT308iBQv1xP2SZIormMkgaHoFKryp+4fto0CsXDDwmN1RaCne3atC0xYv4vvTHuvh7sTA3vKssdqtyqTV2mcPXnItXoj2gb/dY7d1pgm2d4XH7wabVEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786524001; c=relaxed/simple;
	bh=33tG3yoQKv7JaweTP8sARbCKifTc49CzGIOdaTqxXvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYOlTPxUO30/KMYkyInP42cD38QbdDFvRHdPWXGs8rizh5nr0N6AGdLcLEtEEGeYr5k4l8eBEcuBwlp4f2VzZqFm5j/uIJ0tYZyz1tbqey/gwUe1gDRW/GTYBjHLt1Zq+EdNt5PT0NjSYyiuVdxLqeMBbt7gfg6ZjdG3SVGOTnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bLK+PS7N; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bLK+PS7N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786523999; x=1818059999;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=33tG3yoQKv7JaweTP8sARbCKifTc49CzGIOdaTqxXvk=;
  b=bLK+PS7Ndvx0SdRbv/rF8G6FiHthCD8Z56vFGsF+0VFiPJpdfd4wv4/e
   mRGDJosSa6fl9/U25MUsmktK+wN8tn/Cj1GdFYnvFnf2S5q3NKyUQHDiL
   v3rf0BuEB0dgNOttQeapTiBEF46ZiY5EwyE02P6OgOflHa88Z3bLTO94G
   dzekwjv2++RfJmS1rKG+nEatrKzfMuYU4AnITYQtOBhD1YN5koAMdGocG
   9FZPHU/uICXEIMAwHvM3IhO79yud7gYQCxX200EecvKDeFP6AwcSLAIeP
   WcoAJ6WctN85vt4YYhUmvTmVa3CwgbSd4QJUXgJZQF7W3TJgMkNCsBWuI
   g==;
X-CSE-ConnectionGUID: MBHE/AlFQJS/tZ/mHKZJeQ==
X-CSE-MsgGUID: BM6JotgjQo2jg3Cd0vcQ6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="90746914"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="90746914"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 01:39:58 -0700
X-CSE-ConnectionGUID: LI21q6wWTWCJsarsdu/Wsg==
X-CSE-MsgGUID: wDHlj5ogT165RldE+ih4kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="267073474"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.92])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 01:39:56 -0700
Date: Wed, 12 Aug 2026 11:39:53 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Yao Qi <xnorigc@gmail.com>, westeri@kernel.org,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH] gpiolib: acpi: Add ignore_wake quirk for ASUS TX Air
 FA401GM
Message-ID: <anwxWXfqSt2bM8iy@ashevche-desk.local>
References: <20260808155513.2221976-1-xnorigc@gmail.com>
 <aneGptJn8J7eF9tj@ashevche-desk.local>
 <CAD++jLkCYwTyK6C8LvZiYJ9fSc8bp3RPpb4d6EgQTRraJtJDzA@mail.gmail.com>
 <anmNf3rJGxso6nuc@ashevche-desk.local>
 <ans3pcNFEDVBYXXT@ashevche-desk.local>
 <CAMRc=MeDLc-LPwoCEA8yMw3+L9UcN-NgXpYpFPxtUNffAAffyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeDLc-LPwoCEA8yMw3+L9UcN-NgXpYpFPxtUNffAAffyw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 12, 2026 at 01:23:53AM -0700, Bartosz Golaszewski wrote:
> On Tue, 11 Aug 2026 16:54:29 +0200, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> said:
> > On Mon, Aug 10, 2026 at 11:36:19AM +0300, Andy Shevchenko wrote:
> >> On Mon, Aug 10, 2026 at 12:17:06AM +0200, Linus Walleij wrote:
> >> > On Sat, Aug 8, 2026 at 9:42 PM Andy Shevchenko
> >> > <andriy.shevchenko@linux.intel.com> wrote:
> >> > > On Sat, Aug 08, 2026 at 03:55:13PM +0000, Yao Qi wrote:

...

> >> > > If AMD people will be quick enough to tag this, I will include in my PR to
> >> > > Linus W. on next week.
> >> >
> >> > To Bartosz?
> >> > It's gpiolib...
> >>
> >> Oh, true, I have also pin control stuff to send!
> >
> > Okay, I have checked if I have anything to Bart and it seems I mixed that with
> > pin control stuff. So, Bart, if you feel confident about this patch, you can
> > take it directly. Here is my formal tag for that
> >
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Is this a bugfix? I'll be OoO until the end of August starting on Friday with
> the exception of a single day to catch up on email. I'll be sending my PRs for
> v7.3 tomorrow. Not sure if I should take it for v7.3 or v7.2?

On one hand there is no rocket science behind this patch (that's why I gave my tag),
but if you strictly want AMD to confirm, then postpone, so it's up to you to decide.

-- 
With Best Regards,
Andy Shevchenko


