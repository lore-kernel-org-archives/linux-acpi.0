From: Tvrtko Ursulin <tvrtko.ursulin@sophos.com>
Subject: Re: [PATCH] Detect mmconfig on nVidia MCP55
Date: Fri, 6 Feb 2009 16:10:10 +0000
Message-ID: <200902061610.11033.tvrtko.ursulin@sophos.com>
References: <1233765552.16414.6.camel@localhost.localdomain> <200902061130.05740.tvrtko.ursulin@sophos.com> <20090206154231.GN18368@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pmx1.sophos.com ([213.31.172.16]:54784 "EHLO pmx1.sophos.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759251AbZBFQKN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 6 Feb 2009 11:10:13 -0500
In-Reply-To: <20090206154231.GN18368@elte.hu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Ed Swierk <eswierk@aristanetworks.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>

On Friday 06 February 2009 15:42:31 Ingo Molnar wrote:
> * Tvrtko Ursulin <tvrtko.ursulin@sophos.com> wrote:
> > On Thursday 05 February 2009 18:00:19 Ingo Molnar wrote:
> > > * Tvrtko Ursulin <tvrtko.ursulin@sophos.com> wrote:
> > > > On Wednesday 04 February 2009 17:04:40 Ingo Molnar wrote:
> > > > > 2) Please use vertical spaces when initializing structure fields.
> > > > > Instead of the messy looking (and over-long-line generating)
> > > > > construct of:
> > > > >
> > > > >         pci_mmcfg_config[0].address = (extcfg & 0x00007fff) << 25;
> > > > >         pci_mmcfg_config[0].pci_segment = 0;
> > > > >         pci_mmcfg_config[0].start_bus_number = 0;
> > > > >         pci_mmcfg_config[0].end_bus_number = (1 << (8 - ((extcfg >>
> > > > > 28) & 3))) - 1; pci_mmcfg_config_num = 1;
> > > > >
> > > > >    You will get something like:
> > > > >
> > > > >         config->address                 = (extcfg & 0x00007fff) <<
> > > > > 25; config->pci_segment             = 0;
> > > > >         config->start_bus_number        = 0;
> > > > >         config->end_bus_number          = (1 << (8 - ((extcfg >>
> > > > > 28) & 3)));
> > > > >
> > > > >         pci_mmcfg_config = config;
> > > > >         pci_mmcfg_config_num = 1;
> > > > >
> > > > >    Which makes it more structured, more reviewable - and more
> > > > > pleasant to look at as well.
> > >
> > > It is arch/x86/ and scheduler / etc. policy for new code - and we
> > > follow that principle when we clean up code as well.
> >
> > You also didn't say anything about variable declarations I asked about?
> > And I can add structure definition to that question as well.
>
> Firstly, when posting on lkml please use proper line length breaks. Your
> email was almost unreadable in my mailer, so i had to stop reading it.
>
> Also, i'm surprised you see the need to try to influence things here - i
> dont see a single upstream contribution from you in the past ~4 years of
> git log so how can you have any knowledge and experience about such
> details?
>
> Both of those issues pretty materially weaken your standing to be taken
> seriously when it comes to fine details of Linux kernel coding style.

Sorry about the line length, I was trying not to word wrap code this time.

Apart from that, frankly, I find your reply a bit childish. I haven't
realised I need special talking points to express my opinion on a public 
mailing list. Especially since in my previous reply I said that I don't
want to argue about this very much and that I am just expressing my opinion.

Tvrtko
