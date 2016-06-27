From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v6 5/5] ACPI : enable ACPI_PROCESSOR_IDLE on ARM64
Date: Mon, 27 Jun 2016 17:05:11 +0200
Message-ID: <577140A7.60904@linaro.org>
References: <1465915719-8409-1-git-send-email-sudeep.holla@arm.com>
 <1465915719-8409-6-git-send-email-sudeep.holla@arm.com>
 <5771392B.3080002@linaro.org> <57714043.5020207@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35612 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770AbcF0PFM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jun 2016 11:05:12 -0400
Received: by mail-wm0-f43.google.com with SMTP id v199so104146664wmv.0
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jun 2016 08:05:12 -0700 (PDT)
In-Reply-To: <57714043.5020207@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: Vikas Sajjan <vikas.cha.sajjan@hpe.com>, Sunil <sunil.vl@hpe.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Prashanth Prakash <pprakash@codeaurora.org>, Al Stone <al.stone@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 06/27/2016 05:03 PM, Sudeep Holla wrote:
> Hi Daniel,
>
> On 27/06/16 15:33, Daniel Lezcano wrote:
>> On 06/14/2016 04:48 PM, Sudeep Holla wrote:
>>> Now that ACPI processor idle driver supports LPI(Low Power Idle), l=
ets
>>> enable ACPI_PROCESSOR_IDLE for ARM64 too.
>>>
>>> This patch just removes the IA64 and X86 dependency on
>>> ACPI_PROCESSOR_IDLE
>>>
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>> ---
>>
>> Hi Sudeep,
>>
>> now that ACPI processor supports ARM64 did you check the
>> CPUIDLE_DRIVER_STATE_START trick in the code and its derivative ?
>>
>
> No, that is used only for C-State and ARM64 doesn't support it.
> Patch 1/5 puts all the C-State code under #ifdef so that it's not
> compiled on ARM64.
>
>> I deleted the patch 2/5 but there is a place where:
>>
>
> Sorry, I don't follow what you mean by that.

I meant I just deleted from my mailbox the patch 2/5, so I can't do=20
inline comment.

>> if (max_cstate=3D0)
>>      max_cstate=3D1;
>>
>> Probably this is because the POLL state is inserted, so there is alw=
ays
>> an idle state. But for ARM, that is not the case.
>>
>
> Yes
>
>> Also, there are some places where the idle state index begins to 1. =
I
>> think it should be 0 for ARM.
>>
>
> Yes for LPI, it does start from 0.
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
