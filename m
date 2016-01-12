From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH V2 03/10] irqchip,GICv3,ACPI: Add redistributor support
 via GICC structures.
Date: Tue, 12 Jan 2016 18:14:25 +0100
Message-ID: <56953471.5000505@semihalf.com>
References: <1450353133-15992-1-git-send-email-tn@semihalf.com>
 <1450353133-15992-4-git-send-email-tn@semihalf.com>
 <5694EB92.9030109@arm.com> <56951645.6070704@linaro.org>
 <569526C3.1090701@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38589 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753214AbcALRQZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jan 2016 12:16:25 -0500
Received: by mail-wm0-f52.google.com with SMTP id b14so331534811wmb.1
        for <linux-acpi@vger.kernel.org>; Tue, 12 Jan 2016 09:16:25 -0800 (PST)
In-Reply-To: <569526C3.1090701@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com, shijie.huang@arm.com, guohanjun@huawei.com, Suravee.Suthikulpanit@amd.com, "Chalamarla, Tirumalesh" <Tirumalesh.Chalamarla@caviumnetworks.com>
Cc: mw@semihalf.com, graeme.gregory@linaro.org, Catalin.Marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ddaney.cavm@gmail.com

On 12.01.2016 17:16, Marc Zyngier wrote:
>>> >>Also, the spec says:
>>> >>
>>> >>"On systems supporting GICv3 and above, this field holds the 64-bit
>>> >>physical address of the associated Redistributor. If all of the GIC
>>> >>Redistributors are in the always-on power domain, GICR structures should
>>> >>be used to describe the Redistributors instead, and this field must be
>>> >>set to 0."
>>> >>
>>> >>which triggers two questions:
>>> >>- Can you access always the GICR_TYPER register without waking the
>>> >>redistributor up?
>> >
>> >I missed this part, can you suggest how can we do that? accessing some
>> >register before access to redistributor?
> This redistributor may be in a power-domain that is off. Are you
> guaranteed that you can access GICR_TYPER even when it is off?
>
>> >
>>> >>- How do you cope with situations where some redistributors are in the
>>> >>always-on domain, and some are not?
>> >
>> >I'm not sure if there is such hardware, if yes, do we need to fix
>> >the spec first?
> It is something that should definitely be clarified. Can we end-up in a
> situation where some redistributors are described via the GICR
> structure, and some via the GICC structure? The spec is a bit ambiguous.
>

To recap:
1. GICR and GICC subtables should be mutually exclusive, but ACPI spec 
should be clear about this.
2. We need to know if we can access GICR_TYPER without waking the 
redistributor up.

Tirumalesh, can you please advice?

Tomasz
