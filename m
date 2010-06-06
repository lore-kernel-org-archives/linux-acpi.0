From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPI: Do not try to set up acpi processor stuff on cores exceeding maxcpus=
Date: Sun, 6 Jun 2010 23:04:36 +0200
Message-ID: <201006062304.36663.trenn@suse.de>
References: <1274886213-16337-1-git-send-email-trenn@suse.de> <201005282125.15681.trenn@suse.de> <1275441766.3718.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42937 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752842Ab0FFVEO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 6 Jun 2010 17:04:14 -0400
In-Reply-To: <1275441766.3718.15.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: Len Brown <lenb@kernel.org>, "travis@sgi.com" <travis@sgi.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wednesday 02 June 2010 03:22:46 am ykzhao wrote:
> On Sat, 2010-05-29 at 03:25 +0800, Thomas Renninger wrote:
...
> > This is not about "not creating proc files", but about setting up
> > throttling/c-states  for not booted CPUs.
> > The message:
> > ACPI: HARDWARE addr space,NOT supported yet
> > comes from throttling init code. It goes an undefined path because
> >
> > struct cpuinfo_x86 *c = &cpu_data(cpu);
> > is uninitialized (all is zero...):
> > if ((c->x86_vendor != X86_VENDOR_INTEL) ||
> >                 !cpu_has(c, X86_FEATURE_ACPI)) {
> >                 printk(KERN_ERR PREFIX
> >                         "HARDWARE addr space,NOT supported yet\n");
>
> Agree with your analysis.
>
> Can we add "online check" in the above throtting patch
Not really. You get corner cases you need to check for:
  CPUs get offlined manually -> processor driver gets loaded ->
  CPU gets onlined again -> Throttling/C-states wil be uninitialized.

> or simply use the 
> cpuinfo of the first boot CPU to fix the corresponding warning message?
This is an ugly hack (I also thought about it to be honest). Then the whole or 
quite some variables of the per_cpu cpuinfo_x86 structure could be made 
global and need not to be per_cpu based. This also indicates that something
in the processor driver is wrong by design.
> Maybe we will change the T-state for the hot-onlined cpu.
Not sure I understand this sentence:
If the CPU is beyond maxcpus=X you must not be able to change T-states
for this CPU.

Hm, the hotplug cleanup patch I sent recently would take care of above and 
make this tiny sanity check unnecessary (I sent that just for Len to get a 
picture what's missing in procoessor driver code for real CPU hotplug):
http://permalink.gmane.org/gmane.linux.power-management.general/19491
There still were issues with this patch (not sure when I try on this again, it 
has low prio for me currently), thus I'd appreciate if this safe sanity check 
could just go to Linus.

Thanks,

      Thomas
