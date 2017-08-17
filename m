From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH] ACPI/APEI: Add BERT data driver
Date: Thu, 17 Aug 2017 11:25:23 +0100
Message-ID: <8760dmpk30.fsf@e105922-lin.cambridge.arm.com>
References: <20170814165613.25561-1-tony.luck@intel.com>
        <87k225p1v5.fsf@e105922-lin.cambridge.arm.com>
        <20170815211556.nnnnbtlvorgc3ijh@intel.com>
        <87a82zpsd7.fsf@e105922-lin.cambridge.arm.com>
        <3908561D78D1C84285E8C5FCA982C28F61340302@ORSMSX114.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F61340302@ORSMSX114.amr.corp.intel.com>
        (Tony Luck's message of "Wed, 16 Aug 2017 15:22:44 +0000")
Sender: linux-kernel-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Boris Petkov <bp@suse.de>, Tyler Baicar <tbaicar@codeaurora.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

"Luck, Tony" <tony.luck@intel.com> writes:

>> One thing I missed commenting on in the previous version -
>>
>> Have you thought of exposing the error records via /sys/firmware/acpi?
>> The tables are already exposed there and as BERT is part of ACPI
>> logically that's a better fit compared to a misc device.
>
> That was my first thought :-)
>
> But I got stuck on how to name things.  The BERT entry appears in
> /sys/firmware/acpi/tables/ ... but the code doesn't know anything special
> about "BERT", it just iterates over all the tables and makes them all
> appear.
>
> I thought about making it /sys/firmware/acpi/tables/BERT.data, but that
> seemed very ugly (this file isn't a "table", so why does it appear in the
> "tables" directory? So maybe /sys/firmware/acpi/table-data/BERT? Now
> the driver has to make another directory.
>
> Thoughts?

I agree that keeping the error record out of the tables directory makes
sense as it's not an ACPI table.

The best I could come up with was bert-data or bert-region in
/sys/firmware/acpi/apei/.

Though, I am OK with "table-data/BERT" as well.

>
> -Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
