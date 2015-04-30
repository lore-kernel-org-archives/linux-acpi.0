From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 1/2] arm/arm64: ACPI: Introduce CONFIG_ACPI_MUST_HAVE_CCA
Date: Thu, 30 Apr 2015 22:14:43 +0800
Message-ID: <554238D3.7050806@linaro.org>
References: <1430315049-4663-1-git-send-email-Suravee.Suthikulpanit@amd.com> <1430315049-4663-2-git-send-email-Suravee.Suthikulpanit@amd.com> <20150429140445.GA18867@e104818-lin.cambridge.arm.com> <5540EB27.8060507@amd.com> <20150429144232.GC18867@e104818-lin.cambridge.arm.com> <55423261.4050008@linaro.org> <20150430135018.GH32373@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34662 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbbD3OPV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Apr 2015 10:15:21 -0400
Received: by pdbqa5 with SMTP id qa5so62001260pdb.1
        for <linux-acpi@vger.kernel.org>; Thu, 30 Apr 2015 07:15:20 -0700 (PDT)
In-Reply-To: <20150430135018.GH32373@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "al.stone@linaro.org" <al.stone@linaro.org>, "arnd@arndb.de" <arnd@arndb.de>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "leo.duran@amd.com" <leo.duran@amd.com>, "msalter@redhat.com" <msalter@redhat.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lenb@kernel.org" <lenb@kernel.org>

On 2015=E5=B9=B404=E6=9C=8830=E6=97=A5 21:50, Will Deacon wrote:
> On Thu, Apr 30, 2015 at 02:47:13PM +0100, Hanjun Guo wrote:
>> On 2015=E5=B9=B404=E6=9C=8829=E6=97=A5 22:42, Catalin Marinas wrote:
>>> On Wed, Apr 29, 2015 at 09:31:03AM -0500, Suravee Suthikulpanit wro=
te:
>>>> On 04/29/2015 09:04 AM, Catalin Marinas wrote:
>>>>> On Wed, Apr 29, 2015 at 08:44:08AM -0500, Suravee Suthikulpanit w=
rote:
>>>>> Any plans for ACPI on 32-bit ARM?
>>>>
>>>> Not that I am aware, but I could be totally wrong. The reason I am=
 adding
>>>> this here for 32-bit ARM is because the ACPI spec mentioned this.
>>>>
>>>> If you think this is not necessary until we introduce ACPI for ARM=
32, it can
>>>> be removed.
>>>
>>> I think it should be removed (as long as ACPI cannot be selected on
>>> arm32).
>>
>> I agree.
>>
>> Now there is no plan for ARM32 ACPI as I know, ACPI for ARM targets
>> for ARM64 based enterprise system at now.
>
> While we're at it, do we *really* need to support CONFIG_ACPI_PROCFS_=
POWER
> on arm64? It's a deprecated /proc/acpi interface and it would be nice=
 to
> avoid introducing deprecated behaviour if we can avoid it.

I agree. It is used for laptop ac adapter and battery, I will look
into that and clean it up for ARM64.

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
