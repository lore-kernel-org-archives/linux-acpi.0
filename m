Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACC13AEF43;
	Mon, 10 Aug 2026 08:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350995; cv=none; b=hDu6o+xk/ZmG/5zUASmo83oq73/QhyfuJbxp+AoR/zJi9/whK95jIBPYuXhKkb3FMZs7DtdZYwwk4i/hTK52gS57vi44guuBGCVmmuCY2vwUxYm3q5x2/hF3TqpBjond9NQhH926eaUccNxpxLrNuKPLjUEIROXvCWg1S4l4I3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350995; c=relaxed/simple;
	bh=X649ZBWml+/Qao2Gz+SHSH0il0Q06CCVpfKK4qqF+9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIToMT5JaRFPsDNtTas8L49FkOj3Qqczy79JE+hrgM5WCEmBHRcGiIrosHhyEbkJKTHZreePtn8OmorUNze8HPzJx57/i/e1WUpLMPK3BWs6yzh104/lh34IoZztmYwvU+Sk7F+K+Po2omEpjbQX0aj39PNLQOOAf2QMg8egtKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DblL/v4f; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DblL/v4f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786350994; x=1817886994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=X649ZBWml+/Qao2Gz+SHSH0il0Q06CCVpfKK4qqF+9s=;
  b=DblL/v4fX/3/W3+RbGthQglpOaMZ/v6NMag93WDYm7OZYy+uRqhcZvM+
   okstTc2PHkxmb0EXBGcTLEsHPd2qVfW8mCxTOx4WOmnH2N513RtulnFH6
   aMj8ZLC48FcxNxMM1FOWasNAKg11G/XkjnxNOqGhG3RmuKsLUHq4fwM5L
   uNzUSX9gNzNL6+jKxjD6wFJXwqKjPR1FqtzQIZG0IqwCwQ+Jnxr5YDBkV
   vbe0qCB8EvBQ8x++R0yqpJrn33CsD4ZoMNaJuzF+PSqyq7dP375OFOZJQ
   hWzuCByflPs5FQfnjaDdzJxvKDRRXSurcLuy+qT3BEfAvpXOp2tWHwdge
   g==;
X-CSE-ConnectionGUID: QHlv3CDbTFiXFy4kVJsQPQ==
X-CSE-MsgGUID: op0hymW7RFaJlVVFOeOySQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="85826542"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="85826542"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 01:36:23 -0700
X-CSE-ConnectionGUID: UYLfkzwYRIC9i7twINhqag==
X-CSE-MsgGUID: cUUqrZHPQQWs3a5T3KfbpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="259656963"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 01:36:17 -0700
Date: Mon, 10 Aug 2026 11:36:15 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Yao Qi <xnorigc@gmail.com>, westeri@kernel.org, brgl@kernel.org,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add ignore_wake quirk for ASUS TX Air
 FA401GM
Message-ID: <anmNf3rJGxso6nuc@ashevche-desk.local>
References: <20260808155513.2221976-1-xnorigc@gmail.com>
 <aneGptJn8J7eF9tj@ashevche-desk.local>
 <CAD++jLkCYwTyK6C8LvZiYJ9fSc8bp3RPpb4d6EgQTRraJtJDzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLkCYwTyK6C8LvZiYJ9fSc8bp3RPpb4d6EgQTRraJtJDzA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 10, 2026 at 12:17:06AM +0200, Linus Walleij wrote:
> On Sat, Aug 8, 2026 at 9:42 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Sat, Aug 08, 2026 at 03:55:13PM +0000, Yao Qi wrote:
> 
> > > The ASUS TX Air FA401GM experiences immediate wakeups from s2idle
> > > (Modern Standby) when suspended with an external HDMI display connected.
> > >
> > > This issue is caused by spurious ACPI event signaling routed through
> > > GPIO 24 on the AMD GPIO controller (AMDI0030:00), which triggers a
> > > system-wide IRQ 7 (pinctrl_amd) wake-up interrupt during sleep.
> > >
> > > Add an ignore_wake quirk for GPIO 24 on this machine to prevent these
> > > unwanted wakeups. This has been runtime-tested and verified using the
> > > `gpiolib_acpi.ignore_wake=AMDI0030:00@24` kernel parameter.
> >
> > If AMD people will be quick enough to tag this, I will include in my PR to
> > Linus W. on next week.
> 
> To Bartosz?
> It's gpiolib...

Oh, true, I have also pin control stuff to send!

-- 
With Best Regards,
Andy Shevchenko


