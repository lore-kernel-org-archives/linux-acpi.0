From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 1/2] arm/arm64: ACPI: Introduce CONFIG_ACPI_MUST_HAVE_CCA
Date: Thu, 30 Apr 2015 21:47:13 +0800
Message-ID: <55423261.4050008@linaro.org>
References: <1430315049-4663-1-git-send-email-Suravee.Suthikulpanit@amd.com> <1430315049-4663-2-git-send-email-Suravee.Suthikulpanit@amd.com> <20150429140445.GA18867@e104818-lin.cambridge.arm.com> <5540EB27.8060507@amd.com> <20150429144232.GC18867@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35107 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbbD3NrV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Apr 2015 09:47:21 -0400
Received: by pabtp1 with SMTP id tp1so60363176pab.2
        for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2015 06:47:21 -0700 (PDT)
In-Reply-To: <20150429144232.GC18867@e104818-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: al.stone@linaro.org, arnd@arndb.de, linaro-acpi@lists.linaro.org, rjw@rjwysocki.net, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, leo.duran@amd.com, msalter@redhat.com, grant.likely@linaro.org, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, linux-arm-kernel@lists.infradead.org, lenb@kernel.org

On 2015=E5=B9=B404=E6=9C=8829=E6=97=A5 22:42, Catalin Marinas wrote:
> On Wed, Apr 29, 2015 at 09:31:03AM -0500, Suravee Suthikulpanit wrote=
:
>>
>>
>> On 04/29/2015 09:04 AM, Catalin Marinas wrote:
>>> On Wed, Apr 29, 2015 at 08:44:08AM -0500, Suravee Suthikulpanit wro=
te:
>>>>  From ACPIv6 (http://www.uefi.org/sites/default/files/resources/AC=
PI_6.0.pdf),
>>>> section 6.2.17 _CCA states that ARM platforms require ACPI _CCA ob=
ject to be
>>>> specified for DMA-cabpable devices. This patch introduces ACPI_MUS=
T_HAVE_CCA
>>>> in arm and arm64 Kconfig to specify such requirement.
>>>>
>>>> Note that when _CCA is required, if it is missing in the DSDT. ACP=
I driver
>>>> will default to setting up devices as non-coherent.
>>>>
>>>> Signed-off-by: Mark Salter <msalter@redhat.com>
>>>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.co=
m>
>>>> ---
>>>>   arch/arm/Kconfig     | 1 +
>>>>   arch/arm64/Kconfig   | 1 +
>>>>   drivers/acpi/Kconfig | 3 +++
>>>>   3 files changed, 5 insertions(+)
>>>>
>>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>>> index 45df48b..2a0d036 100644
>>>> --- a/arch/arm/Kconfig
>>>> +++ b/arch/arm/Kconfig
>>>> @@ -1,6 +1,7 @@
>>>>   config ARM
>>>>   	bool
>>>>   	default y
>>>> +	select ACPI_MUST_HAVE_CCA if ACPI
>>>>   	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>>>>   	select ARCH_HAS_ELF_RANDOMIZE
>>>>   	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>>>
>>> Any plans for ACPI on 32-bit ARM?
>>
>> Not that I am aware, but I could be totally wrong. The reason I am a=
dding
>> this here for 32-bit ARM is because the ACPI spec mentioned this.
>>
>> If you think this is not necessary until we introduce ACPI for ARM32=
, it can
>> be removed.
>
> I think it should be removed (as long as ACPI cannot be selected on
> arm32).

I agree.

Now there is no plan for ARM32 ACPI as I know, ACPI for ARM targets
for ARM64 based enterprise system at now.

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
