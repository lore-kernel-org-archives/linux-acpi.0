From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [PATCH] ACPI: Do not try to set up acpi processor stuff on
	cores exceeding maxcpus=
Date: Wed, 02 Jun 2010 09:22:46 +0800
Message-ID: <1275441766.3718.15.camel@localhost.localdomain>
References: <1274886213-16337-1-git-send-email-trenn@suse.de>
	 <alpine.LFD.2.00.1005281445170.4045@localhost.localdomain>
	 <201005282125.15681.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:34762 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754355Ab0FBBZu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Jun 2010 21:25:50 -0400
In-Reply-To: <201005282125.15681.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, "travis@sgi.com" <travis@sgi.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sat, 2010-05-29 at 03:25 +0800, Thomas Renninger wrote:
> On Friday 28 May 2010 08:46:27 pm Len Brown wrote:
> > On Wed, 26 May 2010, Thomas Renninger wrote:
> > > Patch is against latest Linus master branch and is expected to be
> > > safe bug fix.
> > >
> > > You get:
> > > ACPI: HARDWARE addr space,NOT supported yet
> > > for each ACPI defined CPU which status is active, but exceeds
> > > maxcpus= count.
> > >
> > > As these "not booted" CPUs do not run an idle routine
> > > and echo X >/proc/acpi/processor/*/throttling did not work
> > > I couldn't find a way to really access not onlined/booted
> > > machines. Still this should get fixed and
> > > /proc/acpi/processor/X dirs of cores exceeding maxcpus
> > > should not show up.
> >
> > Can we delete the /proc/acpi/processor/ dirs instead of maintaining them?
> 
> This is not about "not creating proc files", but about setting up 
> throttling/c-states  for not booted CPUs.
> The message:
> ACPI: HARDWARE addr space,NOT supported yet
> comes from throttling init code. It goes an undefined path because
> 
> struct cpuinfo_x86 *c = &cpu_data(cpu);
> is uninitialized (all is zero...):
> if ((c->x86_vendor != X86_VENDOR_INTEL) ||
>                 !cpu_has(c, X86_FEATURE_ACPI)) {
>                 printk(KERN_ERR PREFIX
>                         "HARDWARE addr space,NOT supported yet\n");

Agree with your analysis.

Can we add "online check" in the above throtting patch or simply use the
cpuinfo of the first boot CPU to fix the corresponding warning message?
Maybe we will change the T-state for the hot-onlined cpu.

thanks.

> 
> Similar to what happens (happened?) on acpi processor (real) hotplug.
> 
> The proc files should vanish in a separate patch, but I am not sure what
> could break.
> I saw powertop still reading battery info from /proc, I thought hal is also 
> still accessing it, but I cannot say for sure.
> 
>       Thomas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

