From: Andrew Morton <akpm@osdl.org>
Subject: Re: acpi git versus x86_64 tree
Date: Thu, 14 Dec 2006 19:13:38 -0800
Message-ID: <20061214191338.946a056a.akpm@osdl.org>
References: <20061214153750.b70744ad.akpm@osdl.org>
	<200612142117.41944.lenb@kernel.org>
	<20061214183743.3509e4b4.akpm@osdl.org>
	<200612142154.41632.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:55025 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751617AbWLODOX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Dec 2006 22:14:23 -0500
In-Reply-To: <200612142154.41632.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andi Kleen <ak@suse.de>, linux-acpi@vger.kernel.org

On Thu, 14 Dec 2006 21:54:41 -0500
Len Brown <lenb@kernel.org> wrote:

> On Thursday 14 December 2006 21:37, Andrew Morton wrote:
> > On Thu, 14 Dec 2006 21:17:41 -0500
> >
> > Len Brown <lenb@kernel.org> wrote:
> > > > The moral here is simple: x86_64 patches go through the x86_64
> > > > maintainer. Please do not attempt to maintain foreign patches in the
> > > > acpi tree.
> > >
> > > Huh?  What x86_64 patches are in the acpi tree?
> >
> > I dunno.  This:
> >
> >  arch/i386/kernel/acpi/boot.c                |  234 ++--
> >  arch/i386/kernel/acpi/earlyquirk.c          |   10
> >  arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c |    1
> >  arch/i386/kernel/cpu/cpufreq/longhaul.c     |   15
> >  arch/i386/kernel/mpparse.c                  |    4
> >  arch/i386/mach-es7000/es7000.h              |   25
> >  arch/i386/mach-es7000/es7000plat.c          |   55 -
> >  arch/i386/pci/mmconfig.c                    |   26
> >  arch/ia64/kernel/acpi.c                     |  186 ++--
> >  arch/x86_64/kernel/early-quirks.c           |    4
> >  arch/x86_64/kernel/genapic.c                |    4
> >  arch/x86_64/kernel/io_apic.c                |    6
> >  arch/x86_64/kernel/mpparse.c                |   74 +
> >  arch/x86_64/kernel/setup.c                  |   65 +
> >  arch/x86_64/kernel/time.c                   |   52 -
> >  arch/x86_64/mm/srat.c                       |   48 -
> >  arch/x86_64/pci/mmconfig.c                  |   31 -
> 
> These are ACPI patches, mostly due to a rather large ACPICA
> update that brings the core up to date to 11/9 from 7/7.
> The biggest part is the update to the table code to teach the
> OS that it can simply map tables in place rather than copying them.

When will it be sent to Linus?

I cannot feasibly carry this work, the outstanding x86_64 work, the
outstanding i386 work and the outstanding ACPI work in -mm.

As the acpi patch is the one which has disrupted the other trees I dropped
that, so what little bit of testing gets donw in -mm won't be available.

> Nearly all of this series has been in -mm before.
> 
> I do regret that there are more variable re-names and whitespace
> cleanups in this batch than I'd prefer -- seems there is never
> a good time to do those...

There are ways of doing these things which don't cause such breakage. 
Whitespace cleanups go to the subsystem maintainer and NOT in the ACPI
tree.  For renames, you can add back-compat defines in the acpi headers,
send that and the rename patch to the subsytem maintainer and when it's all
merged up, remove the back-compat stuff.  
