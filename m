From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [2.6 patch] acpi/battery.c: make 2 functions static
Date: Mon, 3 Mar 2008 10:17:14 +0100
Message-ID: <20080303091714.GA18250@elte.hu>
References: <20080301161902.GN25835@cs181133002.pp.htv.fi> <47C99FE1.8080206@gmail.com> <20080301183550.GC25835@cs181133002.pp.htv.fi> <20080303085720.GD15943@elte.hu> <20080303091314.GC4457@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:59348 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752285AbYCCJRa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Mar 2008 04:17:30 -0500
Content-Disposition: inline
In-Reply-To: <20080303091314.GC4457@cs181133002.pp.htv.fi>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, lenb@kernel.org, astarikovskiy@suse.de, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org


* Adrian Bunk <bunk@kernel.org> wrote:

> On Mon, Mar 03, 2008 at 09:57:20AM +0100, Ingo Molnar wrote:
> > 
> > * Adrian Bunk <bunk@kernel.org> wrote:
> > 
> > > On Sat, Mar 01, 2008 at 09:26:41PM +0300, Alexey Starikovskiy wrote:
> > > > May I keep them inline?
> > > 
> > > The problem with such manual inlines is that we force gcc to always 
> > > inline them - and history has shown that functions grow without the 
> > > "inline" being removed.
> > 
> > what do you mean by "we force gcc to always inline them"?
> 
> #define inline          inline          __attribute__((always_inline))
> 
> > gcc is free to decide whether to inline or to not inline.
> 
> Not with __attribute__((always_inline)).

but that wasnt used in the code you patched:

  -inline int acpi_battery_present(struct acpi_battery *battery)
  +static int acpi_battery_present(struct acpi_battery *battery)

> > (and CONFIG_FORCED_INLINING got removed from 2.6.25)
> 
> CONFIG_FORCED_INLINING never had any effect.

my experience was that it had effects. Why do you say it 'never had any 
effect'?

	Ingo
