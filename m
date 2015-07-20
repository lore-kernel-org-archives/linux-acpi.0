From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v3 2/8] ACPI / irqchip: Add self-probe infrastructure
 to initialize IRQ controller
Date: Mon, 20 Jul 2015 17:32:18 +0800
Message-ID: <55ACC022.1000800@linaro.org>
References: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>	<1436525114-14425-3-git-send-email-hanjun.guo@linaro.org> <CAOZdJXWB71tzc=OMm_UH23jc+_wsA5=pC5W9arrEM-URm_sywg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33199 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443AbbGTJca (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Jul 2015 05:32:30 -0400
Received: by pdbnt7 with SMTP id nt7so28459050pdb.0
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2015 02:32:30 -0700 (PDT)
In-Reply-To: <CAOZdJXWB71tzc=OMm_UH23jc+_wsA5=pC5W9arrEM-URm_sywg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Wei Huang <wei@redhat.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, linaro-acpi@lists.linaro.org, lkml <linux-kernel@vger.kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 07/18/2015 07:15 AM, Timur Tabi wrote:
> On Fri, Jul 10, 2015 at 5:45 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>
>> +void __init acpi_irqchip_init(void)
>> +{
>> +       struct acpi_table_id *id;
>> +
>> +       if (acpi_disabled)
>> +               return;
>> +
>> +       if (acpi_gic_version_init())
>> +               return;
>> +
>> +       /* scan the irqchip table to match the GIC version and its driver */
>> +       for (id = __irqchip_acpi_table; id->id[0]; id++) {
>> +               if (gic_version == (u8)id->driver_data)
>> +                       acpi_table_parse(id->id,
>> +                                        (acpi_tbl_table_handler)id->handler);
>> +       }
>
> Should we display an error message if we don't find a matching table?
> That can happen if the ACPI tables shows a GIC version number that is
> not listed in __irqchip_acpi_table[]?

Hmm, did you get the error message like: "Invalid GIC version 5 in
MADT"? or just use ACPI_MADT_GIC_VERSION_V1 as the gic_version? if
the later one, it will show everything is fine, but failed to probe
the GIC.

I agree with you that we need to print some error message here,
I will update my patch.

Thanks
Hanjun
