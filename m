From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v5 18/18] Documentation: ACPI for ARM64
Date: Fri, 19 Dec 2014 21:53:13 +0800
Message-ID: <54942DC9.9070306@linaro.org>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>	<1413553034-20956-19-git-send-email-hanjun.guo@linaro.org> <CAOZdJXWaQk+f6MLngDzdmUU8x=4cPrt9kpJG6L529MhV0uQwdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:38672 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381AbaLSNx1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Dec 2014 08:53:27 -0500
Received: by mail-pa0-f50.google.com with SMTP id bj1so1238897pad.23
        for <linux-acpi@vger.kernel.org>; Fri, 19 Dec 2014 05:53:26 -0800 (PST)
In-Reply-To: <CAOZdJXWaQk+f6MLngDzdmUU8x=4cPrt9kpJG6L529MhV0uQwdA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, Kangkang.Shen@huawei.com, linu

Hi Timur,

On 2014=E5=B9=B412=E6=9C=8819=E6=97=A5 04:04, Timur Tabi wrote:
> On Fri, Oct 17, 2014 at 8:37 AM, Hanjun Guo <hanjun.guo@linaro.org> w=
rote:
>
>> If acpi=3Dforce is used, the kernel
>> +will ONLY use device configuration information contained in the ACP=
I tables.
>
> Based on this statement, ...
>
>> +In order for the kernel to load and use ACPI tables, the UEFI imple=
mentation
>> +MUST set the ACPI_20_TABLE_GUID to point to the RSDP table (the tab=
le with
>> +the ACPI signature "RSD PTR ").  If this pointer is incorrect and a=
cpi=3Dforce
>> +is used, the kernel will disable ACPI and try to use DT to boot.
>
> wouldn't it be more correct to say "If this pointer is incorrect OR
> acpi=3Dforce is used"?

Good catch, some inconsistency here. Actually it means if the pointer t=
o
RSDP is incorrect, the ACPI code will catch that error, then ACPI will
be disabled and tries to boot with DT even if acpi=3Dforce is passed, I
think that makes sense.

I will fix the inconsistency anyway in next version.

>
>> +Forum provides a mechanism for registering such bindings [URL TBD b=
y ASWG]
>
> Did you intend to replace the text in []?

Yes, it is TBD by ASWG, and we already agreed that the bindings will be
reviewed by ASWG which proposed by Al. the URL will be ready when next
version of ACPI spec is released.

>
>> +so that they may be used on any operating system supporting ACPI.  =
Device
>> +properties that have not been registered with the UEFI Forum should=
 not be
>> +used.
>
> Blech.  I guess it's necessary, but the information needs to be docum=
ented here.
>
>> +Drivers should look for device properties in the _DSD object ONLY; =
the _DSD
>> +object is described in the ACPI specification section 6.2.5, but mo=
re
>> +specifically, use the _DSD Device Properties UUID:
>> +
>> +   -- UUID: daffd814-6eba-4d8c-8a91-bc9bbf4aa301
>> +
>> +   -- http://www.uefi.org/sites/default/files/resources/_DSD-device=
-properties-UUID.pdf)
>
> Extra ) here.

Good catch :)

>
>> +The kernel has an interface for looking up device properties in a m=
anner
>> +independent of whether DT or ACPI is being used and that interface =
should
>> +be used; it can eliminate some duplication of code paths in driver =
probing
>> +functions and discourage divergence between DT bindings and ACPI de=
vice
>> +properties.
>
> How about a pointer to the documentation for this method?

This is a patch set posted by Rafael and goes into 3.19:
https://lkml.org/lkml/2014/10/21/762

No documentation as far as I know.

>
>> +Such code in _PS? methods will of course be very platform specific.=
  But,
>
> I would use _PSx instead of _PS? here.

I will update it.

>
>> +this allows the driver to abstract out the interface for operating =
the device
>> +and avoid having to read special non-standard values from ACPI tabl=
es. Further,
>> +abstracting the use of these resources allows the hardware to chang=
e over time
>> +without requiring updates to the driver.
>> +
>> +
>> +Clocks
>> +------
>> +ACPI makes the assumption that clocks are initialized by the firmwa=
re --
>> +UEFI, in this case -- to some working value before control is hande=
d over
>> +to the kernel.  This has implications for devices such as UARTs, or=
 SoC
>> +driven LCD displays, for example.
>
> SOC-driven should be hyphenated.
>
>> +When the kernel boots, the clock is assumed to be set to reasonable
>
> to A reasonable
>
>> +working value.  If for some reason the frequency needs to change --=
 e.g.,
>> +throttling for power management -- the device driver should expect =
that
>> +process to be abstracted out into some ACPI method that can be invo=
ked
>> +(please see the ACPI specification for further recommendations on s=
tandard
>> +methods to be expected).  If is not, there is no direct way for ACP=
I to
>
> If IT is not
>
>> +control the clocks.
>> +
>> +
>> +Driver Recommendations
>> +----------------------
>> +DO NOT remove any DT handling when adding ACPI support for a driver=
=2E  The
>> +same device may be used on many different systems.
>> +
>> +DO try to structure the driver so that it is data driven.  That is,=
 set up
>
> data-driven

I will update them.

Thanks a lot for your review!

Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
