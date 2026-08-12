Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A9F44C66C;
	Wed, 12 Aug 2026 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786540607; cv=none; b=VuEH8XrV3veofL4TzI5Nuv+7vC6TGCNMrTOGvAuqoekK8djXP/obEQ2IOczTW43JkNfjJ86S7CPKzr3QxHUG4i0lZjdFo5xOwWd0X2w5sh2e0kZQrIeUjYLrTkLZuaUAVLWQ4YUEXXdCBqwcaZpxw9ZhtxipcYkpN26dPnNoP1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786540607; c=relaxed/simple;
	bh=CzBnYJfPYNqNZa6BeodRxrWTplke50AiNUnTXijZvAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyVxPuZj3USRCQunwUdhfRRXdcFiUFzOC9Om9rQhOK7sUfxq6ERLGb4z//Fjz3k+GGzdr5DIISsb8Zhiz7mokxxNngKLqPYcIKtcs1kVh6CynxOpuRbBnddD2mkhtsr72GV1WpnXWpW/Yx9/rJwUjbNjnuxh19+vtodgjHxBOB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U5Ji71O0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U5Ji71O0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786540601; x=1818076601;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=CzBnYJfPYNqNZa6BeodRxrWTplke50AiNUnTXijZvAI=;
  b=U5Ji71O02HQpYEDBG4fk4H3HpQ+UpwmBrTMch162H4z+Ua+bRG2vE3nQ
   wUXeHfz2cQsnyR1spMu8JoQEtxUh/AJHrX+fBLzkHZZC+tCjtOk8GV5qt
   lTzyDsakfGNh8sp+vclP5A9aEpL1XElM2DB0FvU6DG1mZrNmlquwIM49R
   xpPWA5CEhMK+yvuMHPrvL8zA05e0tBhD8sbjDGYX30Bl1XptrwL0ICw1C
   dZ6wCbTqO6hdlmduFPiZPKsZb/UzXvMtUHIHHE9UyaRiCSX2ESfI1klUc
   Drk6hwAswp/fhlhs3NRLXUj6cR2+mhFEYnNqTRtTYKnQbbB2sRXwsFA5Y
   A==;
X-CSE-ConnectionGUID: 2Lft6m4YSgCku9IJZp+Fmw==
X-CSE-MsgGUID: UECs/cz2Rmmlg4tFxFnnaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="97756634"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="97756634"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 06:16:39 -0700
X-CSE-ConnectionGUID: 27dfOVj7TEGRN/pYKDd0DQ==
X-CSE-MsgGUID: NgU2c3zHRXupH6/dz3CyiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="259816883"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.92])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 06:16:38 -0700
Date: Wed, 12 Aug 2026 16:16:36 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Yao Qi <xnorigc@gmail.com>, westeri@kernel.org,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH] gpiolib: acpi: Add ignore_wake quirk for ASUS TX Air
 FA401GM
Message-ID: <anxyNPJfvkVaa8L-@ashevche-desk.local>
References: <20260808155513.2221976-1-xnorigc@gmail.com>
 <aneGptJn8J7eF9tj@ashevche-desk.local>
 <CAD++jLkCYwTyK6C8LvZiYJ9fSc8bp3RPpb4d6EgQTRraJtJDzA@mail.gmail.com>
 <anmNf3rJGxso6nuc@ashevche-desk.local>
 <ans3pcNFEDVBYXXT@ashevche-desk.local>
 <CAMRc=MeDLc-LPwoCEA8yMw3+L9UcN-NgXpYpFPxtUNffAAffyw@mail.gmail.com>
 <anwxWXfqSt2bM8iy@ashevche-desk.local>
 <CAMRc=McGR_2V2mPJZwU6kBk8TzCV6iKu3-C9yF1bbWE0R73-cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McGR_2V2mPJZwU6kBk8TzCV6iKu3-C9yF1bbWE0R73-cw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 12, 2026 at 06:54:30AM -0500, Bartosz Golaszewski wrote:
> On Wed, 12 Aug 2026 10:39:53 +0200, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> said:
> > On Wed, Aug 12, 2026 at 01:23:53AM -0700, Bartosz Golaszewski wrote:
> >> On Tue, 11 Aug 2026 16:54:29 +0200, Andy Shevchenko
> >> <andriy.shevchenko@linux.intel.com> said:
> >> > On Mon, Aug 10, 2026 at 11:36:19AM +0300, Andy Shevchenko wrote:
> >> >> On Mon, Aug 10, 2026 at 12:17:06AM +0200, Linus Walleij wrote:
> >> >> > On Sat, Aug 8, 2026 at 9:42 PM Andy Shevchenko
> >> >> > <andriy.shevchenko@linux.intel.com> wrote:
> >> >> > > On Sat, Aug 08, 2026 at 03:55:13PM +0000, Yao Qi wrote:

...

> >> >> > > If AMD people will be quick enough to tag this, I will include in my PR to
> >> >> > > Linus W. on next week.
> >> >> >
> >> >> > To Bartosz?
> >> >> > It's gpiolib...
> >> >>
> >> >> Oh, true, I have also pin control stuff to send!
> >> >
> >> > Okay, I have checked if I have anything to Bart and it seems I mixed that with
> >> > pin control stuff. So, Bart, if you feel confident about this patch, you can
> >> > take it directly. Here is my formal tag for that
> >> >
> >> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >>
> >> Is this a bugfix? I'll be OoO until the end of August starting on Friday with
> >> the exception of a single day to catch up on email. I'll be sending my PRs for
> >> v7.3 tomorrow. Not sure if I should take it for v7.3 or v7.2?
> >
> > On one hand there is no rocket science behind this patch (that's why I gave my tag),
> > but if you strictly want AMD to confirm, then postpone, so it's up to you to decide.
> 
> If this is not an important bugfix, then let me postpone it until next cycle.

I believe a user may survive with this bug to be present for a bit longer.
But not my call, at Intel I have no such hardware :-)

-- 
With Best Regards,
Andy Shevchenko


