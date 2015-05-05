From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v2 3/7] ACPI / processor: Introduce invalid_logical_cpuid()
Date: Tue, 05 May 2015 21:15:54 +0800
Message-ID: <5548C28A.5040509@linaro.org>
References: <1430793998-21631-1-git-send-email-hanjun.guo@linaro.org> <1430793998-21631-4-git-send-email-hanjun.guo@linaro.org> <5548A641.6050407@arm.com> <3818196.qc8c4isrQe@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36737 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422947AbbEENQD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 May 2015 09:16:03 -0400
Received: by pabsx10 with SMTP id sx10so192839608pab.3
        for <linux-acpi@vger.kernel.org>; Tue, 05 May 2015 06:16:02 -0700 (PDT)
In-Reply-To: <3818196.qc8c4isrQe@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>
Cc: Will Deacon <Will.Deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

On 2015=E5=B9=B405=E6=9C=8805=E6=97=A5 20:04, Rafael J. Wysocki wrote:
> On Tuesday, May 05, 2015 12:15:13 PM Sudeep Holla wrote:
>>
>> On 05/05/15 03:46, Hanjun Guo wrote:
>>> In ACPI processor drivers, we use direct comparisons of cpu logical
>>> id with -1 which are error prone in case logical cpuid is accidenta=
lly
>>> assinged an error code and prevents us from returning an error-enco=
ding
>>> cpuid directly in some cases.
>>>
>>> So introduce invalid_logical_cpuid() to identify cpu with invalid
>>> logical cpu num, then it will be used to replace the direct compari=
sons
>>> with -1.
>>>
>>
>> Ah, OK I see that this fixes the issue I raised in PATCH 1/7, so I t=
hink
>> you need to reorder this and 1/7 patch IMO.
>
> Well, comparing an unsigned int with -1 is not technically invalid (a=
lthough it
> involves an implicit type conversion), but yes, Hanjun, please reorde=
r the
> patches.

Sure, I will.

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
