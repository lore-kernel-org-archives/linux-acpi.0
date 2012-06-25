From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Fix not loading acpi-cpufreq driver regression
Date: Mon, 25 Jun 2012 16:39:39 +0200
Message-ID: <201206251639.39892.trenn@suse.de>
References: <201206251300.10957.trenn@suse.de> <1340633114.741.92.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46666 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756429Ab2FYOjp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Jun 2012 10:39:45 -0400
In-Reply-To: <1340633114.741.92.camel@deadeye.wl.decadent.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: linux-acpi@vger.kernel.org, Lin Ming <ming.m.lin@intel.com>, stable@vger.kernel.org, wallak@free.fr, len.brown@intel.com, Jiri Slaby <jslaby@suse.cz>

...
> > Such platforms may be rare, but do exist. This problem has been
> > observed on a:
> > HP Proliant BL280c G6 blade
> > This patch restricts the introduced workaround to platforms
> > with nr_cpu_ids <= 1.
> 
> This is not the correct way to submit a patch to stable.  See
> Documentation/stable_kernel_rules.txt.
I guess I should add
CC: stable@vger.kernel.org
in the signed-off area, not in the mail header?

 
> Also, patches to mainline should be made against mainline, not the
> distribution branch you have to hand.
Wow, the diff patched with offset only against a reasonable recent
kernel (3.5-rcX). But yes: It does not anymore after doing a git pull.
I'll resend.

> 
> [...]
> > -                * Ignores apic_id and always return 0 for CPU0's handle.
> > +                * Ignores apic_id and always returns 0 for the processor
> > +                * handle with apic id 0 if nr_cpu_ids is 1.
> > +                * This should be the case if SMP tables are not found.
> [...]
> 
> Second 'apic id' should be 'acpi_id'.
Correct.

Thanks,

   Thomas
