From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v6 17/17] Documentation: ACPI for ARM64
Date: Wed, 21 Jan 2015 20:37:00 +0800
Message-ID: <54BF9D6C.7020807@linaro.org>
References: <1420368918-5086-1-git-send-email-hanjun.guo@linaro.org> <1420368918-5086-18-git-send-email-hanjun.guo@linaro.org> <20150119203328.GB3766@cbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34695 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105AbbAUMhP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Jan 2015 07:37:15 -0500
Received: by mail-pa0-f49.google.com with SMTP id fa1so1046639pad.8
        for <linux-acpi@vger.kernel.org>; Wed, 21 Jan 2015 04:37:14 -0800 (PST)
In-Reply-To: <20150119203328.GB3766@cbox>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Graeme Gregory <graeme.gregory@linaro.org>, linaro-acpi@lists.linaro.org, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Timur Tabi <timur@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, Al Stone <al.stone@linaro.org>, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, suravee.suthikulpanit@amd.com, Sudeep Holla <Sudeep.Holla@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, phoenix.liyi@huawei.coml

Hi Christoffer,

Sorry for the late reply, I got no answer yet but
with one question below.

On 2015=E5=B9=B401=E6=9C=8820=E6=97=A5 04:33, Christoffer Dall wrote:
> Hi,
>
> On Sun, Jan 04, 2015 at 06:55:18PM +0800, Hanjun Guo wrote:
>> From: Graeme Gregory <graeme.gregory@linaro.org>
>>
>> Add documentation for the guidelines of how to use ACPI
>> on ARM64.
>>
>> Reviewed-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   Documentation/arm64/arm-acpi.txt | 327 +++++++++++++++++++++++++++=
++++++++++++
>>   1 file changed, 327 insertions(+)
>>   create mode 100644 Documentation/arm64/arm-acpi.txt
>>
>> diff --git a/Documentation/arm64/arm-acpi.txt b/Documentation/arm64/=
arm-acpi.txt
>> new file mode 100644
>> index 0000000..21e7020
>> --- /dev/null
>> +++ b/Documentation/arm64/arm-acpi.txt
>> @@ -0,0 +1,327 @@
>> +ACPI on ARMv8 Servers
>> +---------------------
>> +ACPI can be used for ARMv8 general purpose servers designed to foll=
ow
>> +the ARM SBSA (Server Base System Architecture) and SBBR (Server Bas=
e
>> +Boot Requirements) specifications, currently available to those wit=
h
>> +an ARM login at http://silver.arm.com.
>> +
>> +The ARMv8 kernel implements the reduced hardware model of ACPI vers=
ion
>> +5.1 and later.  Links to the specification and all external documen=
ts
>> +it refers to are managed by the UEFI Forum.  The specification is
>> +available at http://www.uefi.org/specifications and external docume=
nts
>> +can be found via http://www.uefi.org/acpi.
>> +
>> +If an ARMv8 system does not meet the requirements of the SBSA, or c=
annot
>> +be described using the mechanisms defined in the required ACPI spec=
ifications,
>> +then it is likely that Device Tree (DT) is more suitable than ACPI =
for the
>> +hardware.
>> +
>> +
>> +Relationship with Device Tree
>> +-----------------------------
>> +ACPI support in drivers and subsystems for ARMv8 should never be mu=
tually
>> +exclusive with DT support at compile time.
>> +
>> +At boot time the kernel will only use one description method depend=
ing on
>> +parameters passed from the bootloader (including kernel bootargs).
>> +
>> +Regardless of whether DT or ACPI is used, the kernel must always be=
 capable
>> +of booting with either scheme (in kernels with both schemes enabled=
 at compile
>> +time).
>> +
>> +
>> +Booting using ACPI tables
>> +-------------------------
>> +The only defined method for passing ACPI tables to the kernel on AR=
Mv8
>> +is via the UEFI system configuration table.
>> +
>
> This is a bit concerning for the approach we are currently taking to
> support ACPI on Xen [1].
>
> Background: Xen is a tiny hypervisor which cannot parse the DSDT or a=
ny
> other non-static table. Xen relies on Linux in Dom0 to manage most
> (basically everything except the GIC, serial port, SMMU, and timers)
> hardware resources and relies on Dom0 to parse the ACPI tables.
>
> While Xen itself is typically booted by UEFI and finds RSDP through t=
he
> UEFI system table, Xen does NOT run another UEFI instance to boot Dom=
0
> nor does it pass through the presence of UEFI to Dom0 in any way.
> Instead, it just created a DT (with modifications concerning the
> hardware mentioned above) and boots Linux in Dom0 directly (on x86 an=
y
> required UEFI call is performed through paravirtualized hypercalls).
>
> In the case of ACPI, Xen adds a property to the chosen node and
> populates it with the RDSP in Dom0's address space.  Patches have not

Sorry I'm not familiar with hypervisor, I have question here about
x86 on xen, how ACPI works on XEN for x86?

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
