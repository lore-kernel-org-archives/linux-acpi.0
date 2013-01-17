From: Borislav Petkov <bp@alien8.de>
Subject: Re: [arch-general] powernow-k8 fails to load with linux 3.7.2
Date: Thu, 17 Jan 2013 10:46:48 +0100
Message-ID: <20130117094648.GD30700@pd.tnic>
References: <20130115224755.085aa6b7@bluemoon>
 <20130116131725.4e590c34@bluemoon>
 <CAG-2HqWBVf=RWXExeFgxYdPTzPfQYZnt-3ZKzULTwdP9+-5mVQ@mail.gmail.com>
 <1448223.sdUJnNSRz4@vostro.rjw.lan>
 <20130116231728.GA10204@x1.alien8.de>
 <20130116181600.4c48ee3b@bluemoon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130116181600.4c48ee3b@bluemoon>
Sender: cpufreq-owner@vger.kernel.org
To: Leonid Isaev <lisaev@umail.iu.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Tom Gundersen <teg@jklm.no>, =?utf-8?B?QW5kcsOp?= Przywara <andre@andrep.de>, Matthew Garrett <mjg@redhat.com>, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 16, 2013 at 06:16:00PM -0600, Leonid Isaev wrote:
> > [ fixup Andre's address. ]
> > 
> > On Wed, Jan 16, 2013 at 11:33:21PM +0100, Rafael J. Wysocki wrote:
> > > > down the frequancy, but is accompanied by an info-level kernel message
> > > > "acpi-cpufreq: overriding BIOS provided _PSD data".
> > 
> > That just says that BIOS has crappy data and we're using our own.
> 
> OK. Yes, my BIOS is broken, so I thought it was the reason why autoloading does
> not work.

Hmm, come to think of it, we're issuing this message on SMP on *all*
AMDs with HW_PSTATE. Andre, remind me again why we're doing this? We're
basically saying that we're overriding ACPI data but we still read it
out from acpi_perf_data and use *that* data to prepare the frequencies
table. What am I missing?

> To be more precise: "modprobe powernow-k8" returns a "no such device" error,

That's correct - we say ENODEV on your CPU which supports hardware
P-states and hand off to acpi-cpufreq which has that functionality now.

> but in kernel logs I see that acpi-cpufreq is indeed loaded:
> -------
> Jan 15 22:42:19 metal-0 kernel: [  534.003995] acpi-cpufreq: overriding BIOS
> provided _PSD data
> Jan 15 22:42:32 metal-0 kernel: [  547.122695] powernow-k8: this CPU is not
> supported anymore, using acpi-cpufreq instead.
> Jan 15 22:42:45 metal-0 kernel: [  559.623068] powernow-k8: this CPU is not 
> supported anymore, using acpi-cpufreq instead.
> -------
> (the CPU in question is phenom II x4 955). However, this is only after I
> attempt to _manually_ load powernow-k8 (the timestamps in [...] are ~6 mins
> after boot is completed). So the above-mentioned handoff seems to work, but
> please find attached my kernel config.

Ok, this is maybe the issue. What used to load powernow-k8 on your
distro before? Because basically it's enough if some script did
'modprobe powernow-k8' for the handoff to just work.

But, we also have the CPU autoprobing deal:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=644e9cbbe3fc032cc92d0936057e166a994dc246

so, *actually*, powernow-k8 should be loaded by default. I dunno, maybe
upgrade udev on your distro?

Btw, your config looks fine:

CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_ACPI_CPUFREQ=m

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
