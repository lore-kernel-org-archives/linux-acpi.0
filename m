From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Resend: ACPI/CPUFREQ: Introduce hw_limit per cpu cpufreq sysfs interface
Date: Fri, 4 Sep 2009 15:50:42 +0200
Message-ID: <200909041550.43607.trenn@suse.de>
References: <200909031323.29420.trenn@suse.de> <20090903214231.GB27880@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35707 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756778AbZIDNun (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Sep 2009 09:50:43 -0400
In-Reply-To: <20090903214231.GB27880@isilmar.linta.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Dave Jones <davej@redhat.com>, Len Brown <lenb@kernel.org>, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org, Pallipadi Venkatesh <venkatesh.pallipadi@intel.com>

On Thursday 03 September 2009 23:42:31 Dominik Brodowski wrote:
> Hey,
> 
> On Thu, Sep 03, 2009 at 01:23:28PM +0200, Thomas Renninger wrote:
> > I now realized that this patch somewhat clashes with
> > cpufrequtils cpufreq-info --hwlimits command.
> > IMO "cpufreq-info --hwlimits" is wrong here as it evaluates
> > max_freq sysfs value which could also get limited by the user.
> 
> huh?
> 
> brodo@comet:~$ cpufreq-info --hwlimits
> 800000 2001000
> brodo@comet:~$ sudo cpufreq-set --max 1.2G
> brodo@comet:~$ cpufreq-info --hwlimits
> 800000 2001000
Ah, I didn't look into cpufreqinfo details where hwlimits
is coming from.
But how would one then differ between:
- The max freq the CPU is really capable of
- Whether it's a BIOS limitation
I like to have the _PPC limitation exposed to userspace
in a way one can be sure it is a _PPC limitation.
cpuinfo.bios_limit?

Another, more intrusive idea (I mainly care about _PPC
distinction):

Best also thermal or whatever other limits there could happen.
Most generic approach which comes to my mind is something like:
 - Introduce
   cpufreq_verify_within_limits(policy, min, max)
   wrapper:
   cpufreq_set_limit(char *limit_name, policy, min, max)

Thermal or PPC(processor) driver could then use:
   cpufreq_set_limit("bios", policy, min, max)
   cpufreq_set_limit("thermal", policy, min, max)

cpufreq core's cpufreq_set_limit function will remember the limit
and where it comes from and calls cpufreq_verify_within_limits internally.

thermal, processor and possible other drivers would need to
register a cpufreq limit, a sysfs file could then dynamically be created
and the limit exposed, e.g. like:
cpu0/cpufreq/limits/thermal
cpu0/cpufreq/limits/bios (or ppc now?)
cpu0/cpufreq/limits/...

Any idea of an easier way to achieve this (provide a unique and easy
way to show freq limitations and what's the root cause
of it)?

   Thomas

> --hwlimits evaluates cpuinfo_{cur,min,max}_freq which are the hardware
> limits. Those may be limited further by the BIOS on runtime (firmware
> limits, so to speak). It seems to me that this is what you want to add with
> this patch?
> 
> Best,
> 	Dominik
> 


