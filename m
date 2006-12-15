From: Len Brown <lenb@kernel.org>
Subject: Re: acpi git versus x86_64 tree
Date: Thu, 14 Dec 2006 21:54:41 -0500
Message-ID: <200612142154.41632.lenb@kernel.org>
References: <20061214153750.b70744ad.akpm@osdl.org> <200612142117.41944.lenb@kernel.org> <20061214183743.3509e4b4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42215 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957AbWLOCzX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Dec 2006 21:55:23 -0500
In-Reply-To: <20061214183743.3509e4b4.akpm@osdl.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, linux-acpi@vger.kernel.org

On Thursday 14 December 2006 21:37, Andrew Morton wrote:
> On Thu, 14 Dec 2006 21:17:41 -0500
>
> Len Brown <lenb@kernel.org> wrote:
> > > The moral here is simple: x86_64 patches go through the x86_64
> > > maintainer. Please do not attempt to maintain foreign patches in the
> > > acpi tree.
> >
> > Huh?  What x86_64 patches are in the acpi tree?
>
> I dunno.  This:
>
>  arch/i386/kernel/acpi/boot.c                |  234 ++--
>  arch/i386/kernel/acpi/earlyquirk.c          |   10
>  arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c |    1
>  arch/i386/kernel/cpu/cpufreq/longhaul.c     |   15
>  arch/i386/kernel/mpparse.c                  |    4
>  arch/i386/mach-es7000/es7000.h              |   25
>  arch/i386/mach-es7000/es7000plat.c          |   55 -
>  arch/i386/pci/mmconfig.c                    |   26
>  arch/ia64/kernel/acpi.c                     |  186 ++--
>  arch/x86_64/kernel/early-quirks.c           |    4
>  arch/x86_64/kernel/genapic.c                |    4
>  arch/x86_64/kernel/io_apic.c                |    6
>  arch/x86_64/kernel/mpparse.c                |   74 +
>  arch/x86_64/kernel/setup.c                  |   65 +
>  arch/x86_64/kernel/time.c                   |   52 -
>  arch/x86_64/mm/srat.c                       |   48 -
>  arch/x86_64/pci/mmconfig.c                  |   31 -

These are ACPI patches, mostly due to a rather large ACPICA
update that brings the core up to date to 11/9 from 7/7.
The biggest part is the update to the table code to teach the
OS that it can simply map tables in place rather than copying them.
Nearly all of this series has been in -mm before.

I do regret that there are more variable re-names and whitespace
cleanups in this batch than I'd prefer -- seems there is never
a good time to do those...

-Len
