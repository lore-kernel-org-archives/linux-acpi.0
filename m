From: =?ISO-8859-1?Q?Andr=E9?= Przywara <andre@andrep.de>
Subject: Re: [arch-general] powernow-k8 fails to load with linux 3.7.2
Date: Fri, 18 Jan 2013 13:32:33 +0100
Message-ID: <20130118133233.4521ddb6@hydra>
References: <20130115224755.085aa6b7@bluemoon>
	<20130116131725.4e590c34@bluemoon>
	<CAG-2HqWBVf=RWXExeFgxYdPTzPfQYZnt-3ZKzULTwdP9+-5mVQ@mail.gmail.com>
	<1448223.sdUJnNSRz4@vostro.rjw.lan>
	<20130116231728.GA10204@x1.alien8.de>
	<20130116181600.4c48ee3b@bluemoon>
	<20130117094648.GD30700@pd.tnic>
	<20130117194044.7a18a29d@bluemoon>
	<20130118113717.GA6808@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.andrep.de ([217.160.17.100]:58294 "EHLO mail.andrep.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755766Ab3ARMmh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2013 07:42:37 -0500
In-Reply-To: <20130118113717.GA6808@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Leonid Isaev <lisaev@umail.iu.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>, Tom Gundersen <teg@jklm.no>, Matthew Garrett <matthew.garrett@nebula.com>, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, 18 Jan 2013 12:37:17 +0100
Borislav Petkov <bp@alien8.de> wrote:

(updating Matthew's email as per MAINTAINERS)

> On Thu, Jan 17, 2013 at 07:40:44PM -0600, Leonid Isaev wrote:
> > Arrh, modprobe still does not exit cleanly with this...
> 
> As I said already above:
> 
> >> That's correct - we say ENODEV on your CPU which supports hardware
> >> P-states and hand off to acpi-cpufreq which has that functionality
> >> now.
> 
> It is supposed to work that way: we return an error from the
> powernow-k8 init function so that it doesn't load but hand off to
> acpi-cpufreq so that it gets loaded instead.
> 
> > > But, we also have the CPU autoprobing deal:
> > > 
> > > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=644e9cbbe3fc032cc92d0936057e166a994dc246
> > > 
> > > so, *actually*, powernow-k8 should be loaded by default. I dunno,
> > > maybe upgrade udev on your distro?
> > 
> > Udev 196 and 197 + linux <= 3.6.11 yield correct CPU autoprobing.
> > However, udev 197 + linux 3.7.2 do not. I haven't tested udev 196
> > with 3.7.2 though, but it does not look like a udev issue.
> 
> Hmm, I'll bet this has something to do with the fact that HW_PSTATE is
> in another CPUID function on AMD than on Intel and udev doesn't see
> that bit to load acpi-cpufreq automatically.

But the acpi-cpufreq does not export it's dependency on some CPUID
flags, since it is an _ACPI_ module. Shouldn't the load be triggered
while parsing the ACPI tree instead?

$ /sbin/modinfo drivers/cpufreq/acpi-cpufreq.ko | grep alias
alias:          acpi

$ /sbin/modinfo drivers/cpufreq/powernow-k8.ko | grep alias
alias:          x86cpu:vendor:0002:family:000F:model:*:feature:*

How does ArchLinux loads acpi-cpufreq on Intel CPUs? It should now be
the same mechanism on AMD. Or does it have acpi-cpufreq somehow
hard-coded in the scripts for GenuineIntel?

Regards,
Andre.
