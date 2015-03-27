From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [patch v11 13/23] ACPI / processor: Introduce phys_cpuid_t for
 CPU hardware ID
Date: Fri, 27 Mar 2015 21:40:26 +0800
Message-ID: <55155DCA.3060006@linaro.org>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org> <1427205776-5060-14-git-send-email-hanjun.guo@linaro.org> <20150325172109.GJ14585@localhost> <551381CD.5010804@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33279 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561AbbC0Nkg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Mar 2015 09:40:36 -0400
Received: by pabxg6 with SMTP id xg6so96239567pab.0
        for <linux-acpi@vger.kernel.org>; Fri, 27 Mar 2015 06:40:36 -0700 (PDT)
In-Reply-To: <551381CD.5010804@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Hanjun Guo <guohanjun@huawei.com>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Robert Richter <rric@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ashwin Chaugule <ashwinc@codeaurora.org>, linaro-acpi@lists.linaro.org, Marc Zyngier <marc.zyngier@arm.com>, Timur Tabi <timur@codeaurora.org>, Mark Salter <msalter@redhat.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Sudeep Holla <Sudeep.Holla@arm.com>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Jon Masters <jcm@redhat.com>, Olof Johansson <olof@lixom.net>, Graeme Gregory <graeme.gregory@linaro.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 2015=E5=B9=B403=E6=9C=8826=E6=97=A5 11:49, Hanjun Guo wrote:
> On 2015/3/26 1:21, Catalin Marinas wrote:
>> On Tue, Mar 24, 2015 at 10:02:46PM +0800, Hanjun Guo wrote:
>>> CPU hardware ID (phys_id) is defined as u32 in structure acpi_proce=
ssor,
>>> but phys_id is used as int in acpi processor driver, so it will lea=
d to
>>> some inconsistence for the drivers.
>>>
>>> Furthermore, to cater for ACPI arch ports that implement 64 bits CP=
U
>>> ids a generic CPU physical id type is required.
>>>
>>> So introduce typedef u32 phys_cpuid_t in a common file, and introdu=
ce
>>> a macro PHYS_CPUID_INVALID as (phys_cpuid_t)(-1) if it's not define=
d
>>> by other archs, this will solve the inconsistence in acpi processor=
 driver,
>>> and will prepare for the ACPI on ARM64 for the 64 bit CPU hardware =
ID
>>> in the following patch.
>>>
>>> CC: Rafael J Wysocki <rjw@rjwysocki.net>
>>> Suggested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> Reviewed-by: Grant Likely <grant.likely@linaro.org>
>>> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>>> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>>> [hj: reworked cpu physid map return codes]
>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> BTW, am I still the author of this patch? If yes, it's missing a Fro=
m:
>> line.
>
> Oops, you should be the author, can Will fix this in his tree?
>
>>
>>> --- a/drivers/acpi/acpi_processor.c
>>> +++ b/drivers/acpi/acpi_processor.c
>>> @@ -170,7 +170,7 @@ static int acpi_processor_hotadd_init(struct ac=
pi_processor *pr)
>>>   	acpi_status status;
>>>   	int ret;
>>>
>>> -	if (pr->phys_id =3D=3D -1)
>>> +	if (pr->phys_id =3D=3D PHYS_CPUID_INVALID)
>>>   		return -ENODEV;
>> If PHYS_CPUID_INVALID is the same as INVALID_HWID, we should get rid=
 of
>> the latter in the arm64 code (as a subsequent clean-up patch).
>
> OK, I'm preparing a patch set to introduce invalid_phys_cpuid() and i=
nvalid_logical_cpuid()
> to remove the direct comparison of PHYS_CPUID_INVALID and -1 in ACPI =
processor drivers,
> which is suggested by Rafael, I will cleanup PHYS_CPUID_INVALID in th=
is patch set.

I met difficulty to do so, because we use

+#ifndef PHYS_CPUID_INVALID
+typedef u32 phys_cpuid_t;
+#define PHYS_CPUID_INVALID (phys_cpuid_t)(-1)
+#endif

in the common head file linux/acpi.h, we need macro
PHYS_CPUID_INVALID to identify if phys_cpuid_t is typedefed
for different arch, so if we want remove PHYS_CPUID_INVALID
for ARM64, we need to got back to typedef phys_cpuid_t for
each arch using ACPI. which means that

+typedef u32 phys_cpuid_t;  for ia64 and x86,

and
+typedef u64 phys_cpuid_t;  for arm64

and
+#define PHYS_CPUID_INVALID (phys_cpuid_t)(-1)
in this linux/acpi.h for common use.

Rafael, would you mind doing so?

Thanks
Hanjun

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
