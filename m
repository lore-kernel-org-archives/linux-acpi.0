From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v8 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Thu, 05 Feb 2015 18:16:15 +0800
Message-ID: <54D342EF.40606@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org> <54D2812E.9060804@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:39555 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756779AbbBEKQ2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Feb 2015 05:16:28 -0500
Received: by mail-pa0-f41.google.com with SMTP id kq14so9225575pab.0
        for <linux-acpi@vger.kernel.org>; Thu, 05 Feb 2015 02:16:28 -0800 (PST)
In-Reply-To: <54D2812E.9060804@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, phoenix.liyi@huawei.com, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, Mark Langsdorf <mlangsdo@redhat.com>, wangyijing@huawei.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On 2015=E5=B9=B402=E6=9C=8805=E6=97=A5 04:29, Timur Tabi wrote:
> On 02/02/2015 06:45 AM, Hanjun Guo wrote:
>> Hi,
>>
>> This is the v8 of ACPI core patches for ARM64 based on ACPI 5.1, the=
re
>> are
>> some updates since v7:
>
> All 21 patches:
>
> Tested-by: Timur Tabi <timur@codeaurora.org>

Hi Timur, thank you very much :)

>
> I no longer need to use "acpi=3Dforce", so that's nice.
>
>>
>>   - Add two more documantation to explain why we need ACPI in ARM64
>> servers
>
> "documentation"
>
>
>>     by Grant, and recommendations and prohibitions on the use of the
>> numerous
>>     ACPI tables and objects by Al Stone.
>>
>>   - Add two patches which is need to map acpi tables after
>> acpi_gbl_permanent_mmap
>>     is set
>>
>>   - Add another patch "dt / chosen: Add linux,uefi-stub-generated-dt=
b
>> property"
>>     to address that if firmware providing no dtb, we can try ACPI
>> configuration data
>>     even if no "acpi=3Dforce" is passed in early parameters. (I thin=
k
>> ACPI for XEN and
>>     kexec need consider sperately as disscussed, correct me if I'm
>> wrong).
>
> "need to be considered separately", "discussed"
>
>>
>>   - Add CC in the patch to the subsystem maintainers and modify the
>> subject
>>     of the patch to explicitly show the subsystem touched by this
>> patch set,
>>     please help us to review and ack them if they make sense, thanks=
=2E
>>
>>   - Add Tested-by from Qualcomm and Redhat;
>>
>>   - Make ACPI depends on PCI suggested by Catalin;
>>
>>   - Clean up SMP init function as Lorenzo suggested, remove physical
>>     CPU hot-plug code in the patch;
>>
>>   - Address some comments from Marc and explicitly state that will
>>     implment statcked irqdomain and GIC init framework when GICv3 an=
d
>
> "implement", "stacked"

Sorry for that, I'm not a native English speaker but I'm glad that you
you got the meaning of what I said :)

Thank you again for the test.

Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
