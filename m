From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH 3/4] ACPI / APEI: Drop uninformative messages during boot
Date: Thu, 20 Jul 2017 13:29:17 +0100
Message-ID: <87d18vmgv6.fsf@e105922-lin.cambridge.arm.com>
References: <20170720110402.15313-1-punit.agrawal@arm.com>
        <20170720110402.15313-4-punit.agrawal@arm.com>
        <20170720111732.GC18515@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170720111732.GC18515@nazgul.tnic> (Borislav Petkov's message
        of "Thu, 20 Jul 2017 13:17:32 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-acpi@vger.kernel.org

Hi Borislav,

Borislav Petkov <bp@suse.de> writes:

> On Thu, Jul 20, 2017 at 12:04:01PM +0100, Punit Agrawal wrote:
>> When booting an ACPI enabled system that does not provide the hardware
>> error source table (HEST), the ghes driver prints the following message
>> in the kernel log -
>> 
>> [    3.460067] GHES: HEST is not enabled!
>> 
>> which is not helpful.
>> 
>> The message is also output when HEST is explicitly disabled using kernel
>> command line parameter.
>> 
>> Drop this message. While we are touching this code, also drop similar
>> message when GHES is disabled using the module parameter.
>
> No.
>
> To the contrary, we want to know *why* GHES/HEST doesn't get enabled when
> booting. See
>
>   dba648300e89 ("ACPI / einj: Make error paths more talkative")
>
> for a good example why.

einj verbosity can't be used as a model here. einj by it's definition is
for development and testing. It can also be loaded as a module.

>
> If anything, you should do the total opposite patch and add more
>printks to the error paths so that it is obvious why GHES startup
>fails.

As mentioned in the commit log, the platform doesn't provide the HEST
(or any of the APEI tables for that matter). So it's not useful to see a
message complaining that HEST is not enabled. For such platforms, this
message at best adds no value and at worse gives the impression of
something gone wrong during boot.

I agree that where there is a genuine problem, relevant messages can
help to diagnose the problem. But what's printed now doesn't fit the
criteria.

Hope that makes sense.

Thanks,
Punit

>
> -- Regards/Gruss, Boris.
>
> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
