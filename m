From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v5 01/18] ARM64: Move the init of cpu_logical_map(0) before
 unflatten_device_tree()
Date: Wed, 19 Nov 2014 08:29:48 +0800
Message-ID: <546BE47C.700@linaro.org>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org> <1413553034-20956-2-git-send-email-hanjun.guo@linaro.org> <546B4D8D.2020605@linaro.org> <20141118164312.GL28279@e104818-lin.cambridge.arm.com> <20141118165713.GT18842@arm.com> <546B7B8D.1070201@arm.com> <20141118170349.GU18842@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:47789 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754456AbaKSAb6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Nov 2014 19:31:58 -0500
Received: by mail-pa0-f49.google.com with SMTP id eu11so3830429pac.22
        for <linux-acpi@vger.kernel.org>; Tue, 18 Nov 2014 16:31:58 -0800 (PST)
In-Reply-To: <20141118170349.GU18842@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <Mark.Rutland@arm.com>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "jcm@redhat.com" <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "Kangkang.Shen@huawei.com" <Kangkang.Shen@huawei.c>

On 2014-11-19 1:03, Will Deacon wrote:
> On Tue, Nov 18, 2014 at 05:02:05PM +0000, Sudeep Holla wrote:
>> On 18/11/14 16:57, Will Deacon wrote:
>>> On Tue, Nov 18, 2014 at 04:43:13PM +0000, Catalin Marinas wrote:
>>>> On Tue, Nov 18, 2014 at 01:45:49PM +0000, Hanjun Guo wrote:
>>>>> On 2014=E5=B9=B410=E6=9C=8817=E6=97=A5 21:36, Hanjun Guo wrote:
>>>>>> It always make sense to initialize CPU0's logical map entry from=
 the
>>>>>> hardware values, so move the initialization of cpu_logical_map(0=
)
>>>>>> before unflatten_device_tree() which is needed by ACPI code late=
r.
>>>>>>
>>>>>> Acked-by: Olof Johansson <olof@lixom.net>
>>>>>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>>>>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>>>>
>>>>> Could you merge this patch first in 3.19? It was acked by Olof an=
d
>>>>> Mark, and it will make sense without ACPI too.
>>>>
>>>> I think it can go in for 3.19 (it's Will's turn this time ;)).
>>>
>>> This patch doesn't apply on for-next/core, as it conflicts with som=
e of
>>> Rutland's rework ("arm64: log physical ID of boot CPU").
>>>
>>
>> It's actually not required anymore, as "arm64: log physical ID of bo=
ot
>> CPU" move it quite early in the sequence from setup_arch to
>> smp_setup_processor_id while this patch just moves it up in setup_ar=
ch.
>=20
> Thanks Sudeep, I'd guessed as much :)

That's great, thanks for the reminding, I will drop this one.

Best regards
Hanjun

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
