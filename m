From: Aaron Lu <aaron.lwe@gmail.com>
Subject: Re: Discussion on device's runtime wake capability
Date: Fri, 12 Oct 2012 22:15:10 +0800
Message-ID: <CAOzJMDRRao8B-BOeofnoT2a5Bzy7G9bhhi7fFuST2g-1wc+owQ@mail.gmail.com>
References: <5073C2D0.1080900@intel.com>
	<2385066.UqpHriJSiI@vostro.rjw.lan>
	<5076172F.5080708@intel.com>
	<2938573.5VAPp3FQcI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:60003 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932762Ab2JLOPM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Oct 2012 10:15:12 -0400
Received: by mail-qa0-f53.google.com with SMTP id s11so463314qaa.19
        for <linux-acpi@vger.kernel.org>; Fri, 12 Oct 2012 07:15:11 -0700 (PDT)
In-Reply-To: <2938573.5VAPp3FQcI@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

On Fri, Oct 12, 2012 at 1:18 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday 11 of October 2012 08:47:43 Aaron Lu wrote:
>> On 10/11/2012 06:59 AM, Rafael J. Wysocki wrote:
>> > On Wednesday 10 of October 2012 08:53:32 Aaron Lu wrote:
>> >
>> >> And if possible, we can change the way we do to arm the device for
>> >> run wake by not powering those _PRW power resources.
>> >
>> > No, we can't.
>> >
>> > Do you have examples of devices where it is harmful?
>>
>> Yes, for the ZPODD device.
>> It has _PRW specifying it can wake the system up from S4. And I tried
>> not to powering on the power resources referenced in _PRW, no problem
>> for it to generate wake event in S0.
>
> How does it do that? Through the _PRW GPE or something else?

Yes, through the GPE defined in _PRW.

>
>> Let me try to conclude:
>> - The behaviour of devices which only have _PRW should not be changed;
>> - We can change the way we check if a device is run wake capable by
>>   checking if it has _PRW or _S0W;
>> - For devices which have both _PRW and _S0W, we need consider if
>>   powering on _PRW is needed for run wake.
>
> Well, _S0W only tells us what power state(s) it is safe to put the device into
> without breaking its wakeup capability, but it doesn't really guarantee that,
> for example, the _PRW GPE will always work if the device is in one of the
> "safe" states.

Suppose _S0W returns 4, and its wake up event is sent through GPE
defined in _PRW, and system is at S0. Do we need to turn on the power
resources referenced in _PRW when we put the device into D3_COLD
and its run wake capability is desired?

>
> My interpretation of the _PRW output is that it tells us the wakeup GPE number
> and a list of resources needed for that GPE to actually work. In which case it
> shouldn't matter whether or not the system is in S0.

>From this, it sounds like if GPE is used, _PRW should always be turned on.

Thanks,
Aaron
