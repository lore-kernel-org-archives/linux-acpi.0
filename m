From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v8 08/21] dt / chosen: Add linux,uefi-stub-generated-dtb
 property
Date: Sat, 07 Feb 2015 11:36:42 +0800
Message-ID: <54D5884A.6050009@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>	<1422881149-8177-9-git-send-email-hanjun.guo@linaro.org>	<20150202134033.GR4278@bivouac.eciton.net>	<20150202135051.GA3825@xora-haswell.xora.org.uk>	<20150202163253.GG21175@leverpostej> <CAGCh1+nL7YMXYp42ekWAqmw_m5cy=s_7NszLDAXj=bUr2aZVig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:51352 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899AbbBGDgx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Feb 2015 22:36:53 -0500
Received: by mail-pa0-f46.google.com with SMTP id lj1so21237582pab.5
        for <linux-acpi@vger.kernel.org>; Fri, 06 Feb 2015 19:36:53 -0800 (PST)
In-Reply-To: <CAGCh1+nL7YMXYp42ekWAqmw_m5cy=s_7NszLDAXj=bUr2aZVig@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: G Gregory <graeme.gregory@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Leif Lindholm <leif.lindholm@linaro.org>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, "suravee.suthikulpanit@amd.com" <suravee.suthiku>

On 2015=E5=B9=B402=E6=9C=8806=E6=97=A5 18:34, G Gregory wrote:
[...]
>>>>>   ---------------------------------------------------------------=
-----------------
>>>>>   linux,uefi-stub-kern-ver  | string | Copy of linux_banner from =
build.
>>>>>   ---------------------------------------------------------------=
-----------------
>>>>> +linux,uefi-stub-generated-dtb  | bool | Indication for no DTB pr=
ovided by
>>>>> +                        |      | firmware.
>>>>> +----------------------------------------------------------------=
----------------
>>>>
>>>> Apologies for the late bikeshedding, but the discussion on this to=
pic
>>>> previsously was lively enough that I thought I'd let it die down a=
 bit
>>>> before seeing if I had anything to add.
>>>>
>>>> That, and I just realised something:
>>>> One alternative to this added DT entry is that we could treat the
>>>> absence of a registered UEFI configuration table as the indication
>>>> that no HW description was provided from firmware, since the stub =
does
>>>> not call InstallConfigurationTable() on the DT it generates. This =
does
>>>> move the ability to detect to after efi_init(), but this should be
>>>> fine for ACPI-purposes.
>>>>
>>> That would not work as expected in the kexec/Xen use case though as=
 they
>>> may genuinely boot with DT from an ACPI host without UEFI.
>>
>> I'm a little concerned by this case. How do we intend to pass stuff =
from
>> Xen to the kernel in this case? When we initially discussed the stub
>> prior to merging, we weren't quite sure if ACPI without UEFI was
>> entirely safe.
>>
>> The linux,uefi-stub-kern-ver property was originally intended as a
>> sanity-check feature to ensure nothing (including Xen) masqueraded a=
s
>> the stub, but for some reason the actual sanity check was never
>> implemented.
>>
>>>> If that is deemed undesirable, I would still prefer Catalin's
>>>> suggested name ("linux,bare-dtb"), which describes the state rathe=
r
>>>> than the route we took to get there.
>>>>
>>> I agree.
>>
>> I guess this would be ok, though it would be nice to know which agen=
t
>> generated the DTB.
>>
>
> The most obvious scheme then is
>
> linux,bare-dtb =3D "uefi-stub";
>
> otherwise we generate a new binding for every component in the boot p=
ath.

Leif, Mark, any comments on this?

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
