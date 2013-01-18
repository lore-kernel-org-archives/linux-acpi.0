From: Borislav Petkov <bp@alien8.de>
Subject: Re: [arch-general] powernow-k8 fails to load with linux 3.7.2
Date: Fri, 18 Jan 2013 12:37:17 +0100
Message-ID: <20130118113717.GA6808@pd.tnic>
References: <20130115224755.085aa6b7@bluemoon>
 <20130116131725.4e590c34@bluemoon>
 <CAG-2HqWBVf=RWXExeFgxYdPTzPfQYZnt-3ZKzULTwdP9+-5mVQ@mail.gmail.com>
 <1448223.sdUJnNSRz4@vostro.rjw.lan>
 <20130116231728.GA10204@x1.alien8.de>
 <20130116181600.4c48ee3b@bluemoon>
 <20130117094648.GD30700@pd.tnic>
 <20130117194044.7a18a29d@bluemoon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130117194044.7a18a29d@bluemoon>
Sender: cpufreq-owner@vger.kernel.org
To: Leonid Isaev <lisaev@umail.iu.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Tom Gundersen <teg@jklm.no>, =?utf-8?B?QW5kcsOp?= Przywara <andre@andrep.de>, Matthew Garrett <mjg@redhat.com>, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 17, 2013 at 07:40:44PM -0600, Leonid Isaev wrote:
> Arrh, modprobe still does not exit cleanly with this...

As I said already above:

>> That's correct - we say ENODEV on your CPU which supports hardware
>> P-states and hand off to acpi-cpufreq which has that functionality
>> now.

It is supposed to work that way: we return an error from the powernow-k8
init function so that it doesn't load but hand off to acpi-cpufreq so
that it gets loaded instead.

> > But, we also have the CPU autoprobing deal:
> > 
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=644e9cbbe3fc032cc92d0936057e166a994dc246
> > 
> > so, *actually*, powernow-k8 should be loaded by default. I dunno, maybe
> > upgrade udev on your distro?
> 
> Udev 196 and 197 + linux <= 3.6.11 yield correct CPU autoprobing. However,
> udev 197 + linux 3.7.2 do not. I haven't tested udev 196 with 3.7.2 though,
> but it does not look like a udev issue.

Hmm, I'll bet this has something to do with the fact that HW_PSTATE is
in another CPUID function on AMD than on Intel and udev doesn't see that
bit to load acpi-cpufreq automatically.

Before I go and install archlinux here, where can I get the udev sources
which are in your archlinux installation to stare at them a little? :)
Especially the cpu autoprobing part which supposedly uses the cpuid
kernel driver.

> I don't know if it matters, but I also have AMD microcode "0x10000c8",
> albeit it didn't cause problems with 3.6.11...

Nah, microcode doesn't have anything to do with it.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
