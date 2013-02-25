From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 2/2] ACPI: Overriding ACPI tables via initrd only works
 with an initrd and on X86
Date: Mon, 25 Feb 2013 12:07:39 -0800
Message-ID: <CAE9FiQV1KetY9fENCx3D2ATc91Q6ydVrsyHHsqf8wJ8bVAvZGw@mail.gmail.com>
References: <1361538742-67599-1-git-send-email-trenn@suse.de>
	<1361538742-67599-3-git-send-email-trenn@suse.de>
	<CAE9FiQXnJF_qXgG5fN7xE7t40a5yF79hksei6YgYAcmjtaNwOg@mail.gmail.com>
	<512BC34A.9090504@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:61030 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759656Ab3BYUHk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Feb 2013 15:07:40 -0500
Received: by mail-ie0-f181.google.com with SMTP id 17so3511957iea.40
        for <linux-acpi@vger.kernel.org>; Mon, 25 Feb 2013 12:07:39 -0800 (PST)
In-Reply-To: <512BC34A.9090504@zytor.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org, lenb@kernel.org, rjw@sisk.pl, aaron.lu@intel.com, devurandom@gmx.net

On Mon, Feb 25, 2013 at 12:02 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 02/25/2013 12:00 PM, Yinghai Lu wrote:
>>
>> Can replace max_low_pfn_mapped with max_low_pfn instead ?
>> like to see if you can put acpi tables above 4G for x86_64.
>>
>> if it does not work, you can use min(max_low_pfn<<PAGE_SHIFT,  0xffffffffUL)
>> instead.
>>
>
> This is part of why we really need to get rid of these stupid variables
> one and for all.  The only exception should perhaps be to mark the
> HIGHMEM crossover point on HIGHMEM systems.

yes, we can drop max_low_pfn_mapped at least.

I should drop that in for-x86-mm2 time point, but saw ThomasR is using that,
so i dropped that patch to make the merge easy.

Now after Thomas change to max_low_pfn, we can drop max_low_pfn_mapped.

Yinghai
