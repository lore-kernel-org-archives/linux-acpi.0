Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0408743C7B9;
	Tue, 11 Aug 2026 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786460086; cv=none; b=In1gv9lCYgRWPWxx7nNYTbtUHnyPfqMnOkVF4qru+Dcl+K/2VCavezSOpiX+CIDplMXPUcVdJfOsRiHNlUGdnbepEWW0vR1ANXUYlVmPVdAWshLzhI4atEPxrMEZopVeezuo9R80/NT4k2AIier7QQnBC+TdYVsanhfH37GdYMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786460086; c=relaxed/simple;
	bh=ODKlWDGeZ75lFcU02yfuDf+viho387kpCxQEhpvtn78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uS4h/pZv3YbE9ImBh5d9nYCT6r/hEzimTjDtL7AAS8VouO1L8AfskezFR+N5oAQNnOlEPdnw2QmA0rsqJTLZIqwRtdQzf47VTRjqRBZt9YD9WIURnOAAWBi5fGTYRgnVLwSu+ld1ryZKcpUpg+0xJD8TaCkxhZjmi/4K/QK9yms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OR5b8hWv; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OR5b8hWv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786460080; x=1817996080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ODKlWDGeZ75lFcU02yfuDf+viho387kpCxQEhpvtn78=;
  b=OR5b8hWvv/7+yZ8/go95MHBdPF8fYEbt3eMJ/UMl9tPSwKpRgSMyAEX+
   NGLlPJDUalf0S5T2aI8uYMr4mC0ovDFytpJKE1bHLDHyxG2grdWDGdu4f
   cDnzegpT6bKsS5wJGX0gD+YbhjP3CaYRvGBL6TOOZkP1mEAmiDsMeod1d
   S73o84Lhoh4HKpM/psGzgUvpDtIenLAj8Ct3nNXtZalBVQEy6UqUu4KPg
   WpjPvLoF7uP7EEe7yyqj6pjquuVDErpAupoVHwkk96TDRk3QP95pf/qCn
   VZ5qf4YAbw96yQT/oZtACwnnEqGXWeVrnr2wef7mf8cZ+sUF93ROKUz8V
   Q==;
X-CSE-ConnectionGUID: 5qHSiwt7QDK+uP7oJ/igTw==
X-CSE-MsgGUID: FcU7szj9QKSjCQKC5g1WHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="86844804"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="86844804"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 07:54:35 -0700
X-CSE-ConnectionGUID: uFvrTcRDQs2w23w6s6uc2A==
X-CSE-MsgGUID: PVbUnmtTS5aciTj8bszvXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="267202713"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 07:54:32 -0700
Date: Tue, 11 Aug 2026 17:54:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Yao Qi <xnorigc@gmail.com>, westeri@kernel.org, brgl@kernel.org,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add ignore_wake quirk for ASUS TX Air
 FA401GM
Message-ID: <ans3pcNFEDVBYXXT@ashevche-desk.local>
References: <20260808155513.2221976-1-xnorigc@gmail.com>
 <aneGptJn8J7eF9tj@ashevche-desk.local>
 <CAD++jLkCYwTyK6C8LvZiYJ9fSc8bp3RPpb4d6EgQTRraJtJDzA@mail.gmail.com>
 <anmNf3rJGxso6nuc@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anmNf3rJGxso6nuc@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 10, 2026 at 11:36:19AM +0300, Andy Shevchenko wrote:
> On Mon, Aug 10, 2026 at 12:17:06AM +0200, Linus Walleij wrote:
> > On Sat, Aug 8, 2026 at 9:42 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Sat, Aug 08, 2026 at 03:55:13PM +0000, Yao Qi wrote:
> > 
> > > > The ASUS TX Air FA401GM experiences immediate wakeups from s2idle
> > > > (Modern Standby) when suspended with an external HDMI display connected.
> > > >
> > > > This issue is caused by spurious ACPI event signaling routed through
> > > > GPIO 24 on the AMD GPIO controller (AMDI0030:00), which triggers a
> > > > system-wide IRQ 7 (pinctrl_amd) wake-up interrupt during sleep.
> > > >
> > > > Add an ignore_wake quirk for GPIO 24 on this machine to prevent these
> > > > unwanted wakeups. This has been runtime-tested and verified using the
> > > > `gpiolib_acpi.ignore_wake=AMDI0030:00@24` kernel parameter.
> > >
> > > If AMD people will be quick enough to tag this, I will include in my PR to
> > > Linus W. on next week.
> > 
> > To Bartosz?
> > It's gpiolib...
> 
> Oh, true, I have also pin control stuff to send!

Okay, I have checked if I have anything to Bart and it seems I mixed that with
pin control stuff. So, Bart, if you feel confident about this patch, you can
take it directly. Here is my formal tag for that

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


