From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v10 13/21] ACPI / processor: Introduce phys_cpuid_t for
 CPU hardware ID
Date: Thu, 12 Mar 2015 18:16:45 +0800
Message-ID: <5501678D.5090608@linaro.org>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org> <1426077587-1561-14-git-send-email-hanjun.guo@linaro.org> <20150312095151.GB18414@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:40957 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbbCLKQ4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Mar 2015 06:16:56 -0400
Received: by padfb1 with SMTP id fb1so19395167pad.7
        for <linux-acpi@vger.kernel.org>; Thu, 12 Mar 2015 03:16:55 -0700 (PDT)
In-Reply-To: <20150312095151.GB18414@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linaro-acpi@lists.linaro.

On 2015=E5=B9=B403=E6=9C=8812=E6=97=A5 17:51, Lorenzo Pieralisi wrote:
> On Wed, Mar 11, 2015 at 12:39:39PM +0000, Hanjun Guo wrote:
>> CPU hardware ID (phys_id) is defined as u32 in structure acpi_proces=
sor,
>> but phys_id is used as int in acpi processor driver, so it will lead=
 to
>> some inconsistence for the drivers.
>>
>> Furthermore, to cater for ACPI arch ports that implement 64 bits CPU
>> ids a generic CPU physical id type is required.
>>
>> So introduce typedef u32 phys_cpuid_t for x86 and ia64, and introduc=
e
>> a macro CPU_PHYS_ID_INVALID as (u32)(-1), use phys_cpuid_t when phys=
_id
>> defined in acpi processor driver, and replace CPU_PHYS_ID_INVALID as=
 -1
>> for phys_id, this will solve the inconsistence in acpi processor dri=
ver,
>> and will prepare for the ACPI on ARM64 for the 64 bit CPU hardware I=
D
>> in the following patch.
>
> Nit: Commit log above is stale (since you moved the phys_cpuid_t to
> common declaration for all archs that do not define PHYS_CPUID_INVALI=
D
> and the macro name itself changed) so you should rewrite it before

Oops, I will send a updated patch only for this one, good catch.

> asking to merge it. Furthermore you should not describe how you imple=
mented
> the change, you should describe why.

I'm prefer writing the commit log as following way (not always) :)
  - why the patch is needed
  - what the patch implements
  - How the patch is implemented

>
> Other than that:
>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Thanks!

Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
