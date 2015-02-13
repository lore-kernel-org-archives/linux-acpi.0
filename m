From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v8 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Fri, 13 Feb 2015 15:50:32 +0800
Message-ID: <54DDACC8.1010509@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org> <a314cdbbefb349acbb8f47d6e806989f@NASANEXM01D.na.qualcomm.com> <003301d04727$1390fcb0$3ab2f610$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:42415 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbbBMHu2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Feb 2015 02:50:28 -0500
Received: by mail-pa0-f49.google.com with SMTP id fb1so17212403pad.8
        for <linux-acpi@vger.kernel.org>; Thu, 12 Feb 2015 23:50:28 -0800 (PST)
In-Reply-To: <003301d04727$1390fcb0$3ab2f610$@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>, 'Catalin Marinas' <catalin.marinas@arm.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Olof Johansson' <olof@lixom.net>, 'Arnd Bergmann' <arnd@arndb.de>, 'Mark Rutland' <mark.rutland@arm.com>, 'Grant Likely' <grant.likely@linaro.org>, 'Will Deacon' <will.deacon@arm.com>
Cc: 'Lorenzo Pieralisi' <Lorenzo.Pieralisi@arm.com>, 'Graeme Gregory' <graeme.gregory@linaro.org>, 'Sudeep Holla' <Sudeep.Holla@arm.com>, 'Jon Masters' <jcm@redhat.com>, 'Jason Cooper' <jason@lakedaemon.net>, 'Marc Zyngier' <marc.zyngier@arm.com>, 'Bjorn Helgaas' <bhelgaas@google.com>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Mark Brown' <broonie@kernel.org>, 'Rob Herring' <robh@kernel.org>, 'Robert Richter' <rric@kernel.org>, 'Randy Dunlap' <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, phoenix.liyi@huawei.com, 'Timur Tabi' <timur@codeaurora.org>, 'Ashwin Chaugule' <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, 'Mark Langsdorf' <mlangsdo@redhat.com>, wangyijing@huawei.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, lauraa@codeaurora.org

Hi Jonathan,

On 2015=E5=B9=B402=E6=9C=8813=E6=97=A5 08:50, Jonathan (Zhixiong) Zhang=
 wrote:
> On 02/02/2015 05:45 AM, Hanjun Guo wrote:
>> From: Al Stone <al.stone at linaro.org>
>>
>> Two more documentation files are also being added:
>> (1) A verbatim copy of the "Why ACPI on ARM?" blog posting by Grant
> Likely,
>>      which is also summarized in arm-acpi.txt, and
>>
>> (2) A section by section review of the ACPI spec (acpi_object_usage.=
txt)
>>      to note recommendations and prohibitions on the use of the nume=
rous
>>      ACPI tables and objects.  This sets out the current expectation=
s of
>>      the firmware by Linux very explicitly (or as explicitly as I ca=
n, for
>>      now).
>>
> [snip....]
>> +ERST	Section 18.5 (signature =3D=3D "ERST")
>> +	=3D=3D Error Record Serialization Table =3D=3D
>> +	Must be supplied if RAS support is provided by the platform.  It
>> +	is recommended this table be supplied.
>
> The above text related to ERST table could lead to misunderstanding.
> Following is what the ACPI spec (section 18.5) says:
> "The error record serialization feature is used to save and retrieve
> hardware error information to and from a persistent store. OSPM inter=
acts
> with the platform through a platform interface. On UEFI-based platfor=
ms, the
> UEFI runtime variable services can be used to carry out error record
> persistence operations. On non-UEFI based platforms, the ACPI solutio=
n
> described below is used."

Thanks for the reminding, it is well documented in the spec as you
mentioned here.

>
> When RAS support is provided by the platform, ERST table may not be s=
upplied
> when it is UEFI-based and when UEFI run time service provides the abi=
lity to
> save and retrieve hardware error information to and from a persistent=
 store
> (UEFI spec section 7.2.3). Therefore, following text might be more ac=
curate:
> " On a platform supports RAS, this table must be supplied if it is no=
t
> UEFI-based; if it is UEFI-based, this table may be supplied, consult =
your
> firmware vendor if you are not sure.

We can scan all the ACPI tables to see if we have one, so we just meed
to scan all the table then we will know if ERST table is available.

> When this table is not present, UEFI
> run time service will be utilized to save and retrieve hardware error
> information to and from a persistent store."

Other than that, the comments pretty fine to me :)

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
