From: Andrew Morton <akpm@osdl.org>
Subject: Re: acpi git versus x86_64 tree
Date: Thu, 14 Dec 2006 18:37:43 -0800
Message-ID: <20061214183743.3509e4b4.akpm@osdl.org>
References: <20061214153750.b70744ad.akpm@osdl.org>
	<200612142117.41944.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:53191 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965050AbWLOCiV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Dec 2006 21:38:21 -0500
In-Reply-To: <200612142117.41944.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Brown, Len" <len.brown@intel.com>, Andi Kleen <ak@suse.de>, linux-acpi@vger.kernel.org

On Thu, 14 Dec 2006 21:17:41 -0500
Len Brown <lenb@kernel.org> wrote:

> 
> > The moral here is simple: x86_64 patches go through the x86_64 maintainer.
> > Please do not attempt to maintain foreign patches in the acpi tree.
> 
> Huh?  What x86_64 patches are in the acpi tree?

I dunno.  This:

 arch/i386/kernel/acpi/boot.c                |  234 ++--
 arch/i386/kernel/acpi/earlyquirk.c          |   10 
 arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c |    1 
 arch/i386/kernel/cpu/cpufreq/longhaul.c     |   15 
 arch/i386/kernel/mpparse.c                  |    4 
 arch/i386/mach-es7000/es7000.h              |   25 
 arch/i386/mach-es7000/es7000plat.c          |   55 -
 arch/i386/pci/mmconfig.c                    |   26 
 arch/ia64/kernel/acpi.c                     |  186 ++--
 arch/x86_64/kernel/early-quirks.c           |    4 
 arch/x86_64/kernel/genapic.c                |    4 
 arch/x86_64/kernel/io_apic.c                |    6 
 arch/x86_64/kernel/mpparse.c                |   74 +
 arch/x86_64/kernel/setup.c                  |   65 +
 arch/x86_64/kernel/time.c                   |   52 -
 arch/x86_64/mm/srat.c                       |   48 -
 arch/x86_64/pci/mmconfig.c                  |   31 -

