From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [arch-general] powernow-k8 fails to load with linux 3.7.2
Date: Wed, 16 Jan 2013 23:33:21 +0100
Message-ID: <1448223.sdUJnNSRz4@vostro.rjw.lan>
References: <20130115224755.085aa6b7@bluemoon> <20130116131725.4e590c34@bluemoon> <CAG-2HqWBVf=RWXExeFgxYdPTzPfQYZnt-3ZKzULTwdP9+-5mVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:42182 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755473Ab3APW12 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jan 2013 17:27:28 -0500
In-Reply-To: <CAG-2HqWBVf=RWXExeFgxYdPTzPfQYZnt-3ZKzULTwdP9+-5mVQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tom Gundersen <teg@jklm.no>, Andre Przywara <andre.przywara@amd.com>
Cc: Matthew Garrett <mjg@redhat.com>, Leonid Isaev <lisaev@umail.iu.edu>, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org, Borislav Petkov <bp@alien8.de>

On Wednesday, January 16, 2013 09:37:58 PM Tom Gundersen wrote:
> [dropped arch-general, added kernel folks]
> 
> On Wed, Jan 16, 2013 at 8:17 PM, Leonid Isaev <lisaev@umail.iu.edu> wrote:
> > On Wed, 16 Jan 2013 11:10:19 +0100
> > Tom Gundersen <teg@jklm.no> wrote:
> >
> >> On Wed, Jan 16, 2013 at 5:47 AM, Leonid Isaev <lisaev@umail.iu.edu> wrote:
> >> >         I just installed linux 3.7.2 from [testing] on an AMD system and
> >> > noticed that powernow-k8 is not loaded.
> >>
> >> Probably due to this:
> >> <http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e1f0b8e9b04a262834ed1>.
> 
> [...]
> 
> >> Hm, I thought acpi_cpufreq should have been loaded instead, no idea
> >> why that does not happen for you. Could you try loading it manually?
> >
> > Neither acpi_cpufreq nor powernow_k8 is loaded automatically which of course
> > leads to failure of all custom units configuring ondemand governor via
> > sysfs. Manually modprob'ing acpi_cpufreq does work and indeed properly scales
> > down the frequancy, but is accompanied by an info-level kernel message
> > "acpi-cpufreq: overriding BIOS provided _PSD data".
> >
> > So, if the cpufreq driver works OK for other AMD users, I'll happily blame
> > asus...
> 
> Matthew, Andre, Rafael,
> 
> Is what Leonid experinces above expected behavior or is this a bug? He
> is using stock Arch kernel, which is almost vanilla 3.7.3 (see [0] for
> the applied patches, nothing looks relevant).

Well, I was afraid that something like this would happen after the recent AMD
cpufreq changes.

Andre, do we have a clear way to address these problems?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
