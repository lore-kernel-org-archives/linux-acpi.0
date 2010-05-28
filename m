From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPI: Do not try to set up acpi processor stuff on cores exceeding maxcpus=
Date: Fri, 28 May 2010 21:25:15 +0200
Message-ID: <201005282125.15681.trenn@suse.de>
References: <1274886213-16337-1-git-send-email-trenn@suse.de> <alpine.LFD.2.00.1005281445170.4045@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44529 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753088Ab0E1TZD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 May 2010 15:25:03 -0400
In-Reply-To: <alpine.LFD.2.00.1005281445170.4045@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: travis@sgi.com, linux-acpi@vger.kernel.org

On Friday 28 May 2010 08:46:27 pm Len Brown wrote:
> On Wed, 26 May 2010, Thomas Renninger wrote:
> > Patch is against latest Linus master branch and is expected to be
> > safe bug fix.
> >
> > You get:
> > ACPI: HARDWARE addr space,NOT supported yet
> > for each ACPI defined CPU which status is active, but exceeds
> > maxcpus= count.
> >
> > As these "not booted" CPUs do not run an idle routine
> > and echo X >/proc/acpi/processor/*/throttling did not work
> > I couldn't find a way to really access not onlined/booted
> > machines. Still this should get fixed and
> > /proc/acpi/processor/X dirs of cores exceeding maxcpus
> > should not show up.
>
> Can we delete the /proc/acpi/processor/ dirs instead of maintaining them?

This is not about "not creating proc files", but about setting up 
throttling/c-states  for not booted CPUs.
The message:
ACPI: HARDWARE addr space,NOT supported yet
comes from throttling init code. It goes an undefined path because

struct cpuinfo_x86 *c = &cpu_data(cpu);
is uninitialized (all is zero...):
if ((c->x86_vendor != X86_VENDOR_INTEL) ||
                !cpu_has(c, X86_FEATURE_ACPI)) {
                printk(KERN_ERR PREFIX
                        "HARDWARE addr space,NOT supported yet\n");

Similar to what happens (happened?) on acpi processor (real) hotplug.

The proc files should vanish in a separate patch, but I am not sure what
could break.
I saw powertop still reading battery info from /proc, I thought hal is also 
still accessing it, but I cannot say for sure.

      Thomas
