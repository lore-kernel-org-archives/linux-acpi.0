From: Borislav Petkov <bp@alien8.de>
Subject: Re: [arch-general] powernow-k8 fails to load with linux 3.7.2
Date: Thu, 17 Jan 2013 00:17:28 +0100
Message-ID: <20130116231728.GA10204@x1.alien8.de>
References: <20130115224755.085aa6b7@bluemoon>
 <20130116131725.4e590c34@bluemoon>
 <CAG-2HqWBVf=RWXExeFgxYdPTzPfQYZnt-3ZKzULTwdP9+-5mVQ@mail.gmail.com>
 <1448223.sdUJnNSRz4@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448223.sdUJnNSRz4@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Tom Gundersen <teg@jklm.no>, =?utf-8?B?QW5kcsOp?= Przywara <andre@andrep.de>, Matthew Garrett <mjg@redhat.com>, Leonid Isaev <lisaev@umail.iu.edu>, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

[ fixup Andre's address. ]

On Wed, Jan 16, 2013 at 11:33:21PM +0100, Rafael J. Wysocki wrote:
> > down the frequancy, but is accompanied by an info-level kernel message
> > "acpi-cpufreq: overriding BIOS provided _PSD data".

That just says that BIOS has crappy data and we're using our own.

> Well, I was afraid that something like this would happen after the
> recent AMD cpufreq changes.
>
> Andre, do we have a clear way to address these problems?

I'm working on a patch (see thread at
http://marc.info/?l=linux-pm&m=135791578516584&w=2) that should take
care of really fixing handoff to acpi_cpufreq from powernow-k8, need to
sort out some stuff first though.

Btw, the handoff from powernow-k8 to acpi_cpufreq works on my systems,
but I haven't tested 3.7.2 so maybe we're missing some patches there.
Leonid, can you send your config pls?

Thanks.

-- 
Regards/Gruss,
Boris.
