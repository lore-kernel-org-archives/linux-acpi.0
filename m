From: "Huang\, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH] ACPI, APEI: Fix BERT resources conflict with ACPI NVS area
Date: Thu, 16 Feb 2017 18:24:39 +0800
Message-ID: <87fujea0wo.fsf@yhuang-dev.intel.com>
References: <20170214020143.29713-1-ying.huang@intel.com>
        <4305135.N5b65JQej5@aspire.rjw.lan>
        <20170216095230.ecbb6hfqmcpk3jbw@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170216095230.ecbb6hfqmcpk3jbw@pd.tnic> (Borislav Petkov's
        message of "Thu, 16 Feb 2017 10:52:30 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Huang, Ying" <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Tony Luck <tony.luck@intel.com>, Fu Wei <fu.wei@linaro.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Borislav Petkov <bp@suse.de> writes:

> On Thu, Feb 16, 2017 at 12:42:00AM +0100, Rafael J. Wysocki wrote:
>> On Tuesday, February 14, 2017 10:01:13 AM Huang, Ying wrote:
>> > From: Huang Ying <ying.huang@intel.com>
>> > 
>> > It was reported that some firmware will use ACPI NVS area for BERT
>> > address range.  This will cause resources conflict because the ACPI
>> > NVS area is marked as busy already.  Fix this via excluding ACPI NVS
>> > area when requesting IO resources for BERT.
>> > 
>> > Reported-and-tested-by: Hans Kristian Rosbach <hansr@raskesider.no>
>> > Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> 
>> Boris, what do you think?
>
> Lemme see, so the BERT is for hw errors which have happened during the
> previous boot and the machine couldn't handle them. So they do get saved
> in some mem in the fw for inspection during the next boot.
>
> And "some firmware" has decided to write them into non-volatile storage
> - because you should never ever forget those errors! :-)
>
> And I don't understand the "fix" here: we're excluding the NVS area when
> mapping the BERT table but then how are we supposed to read those errors
> from there?

The NVS area is excluded when request the resources, because the NVS
area has been marked as busy already.  But the whole BERT memory area is
mapped, so we can read from it.

> Or am I missing something obvious?

Best Regards,
Huang, Ying
