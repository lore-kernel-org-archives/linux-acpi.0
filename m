From: G Gregory <graeme.gregory@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH v4 00/10] ACPI GIC Self-probing, GICv2m and
 GICv3 support
Date: Tue, 11 Aug 2015 23:24:56 +0100
Message-ID: <CAGCh1+mPLhk24bTTkJ2+k5M9UFO2Sf=aVGipSgf1W+3DwTHiuA@mail.gmail.com>
References: <1438164539-29256-1-git-send-email-hanjun.guo@linaro.org>
	<55CA70D5.6040300@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:34861 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301AbbHKWY5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Aug 2015 18:24:57 -0400
Received: by obbop1 with SMTP id op1so160344990obb.2
        for <linux-acpi@vger.kernel.org>; Tue, 11 Aug 2015 15:24:56 -0700 (PDT)
In-Reply-To: <55CA70D5.6040300@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Wei Huang <wei@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 11 August 2015 at 23:01, Timur Tabi <timur@codeaurora.org> wrote:
> On 07/29/2015 05:08 AM, Hanjun Guo wrote:
>>
>> Patches are on top of Marc's branch irq/gsi-irq-domain-v2, and available
>> at:
>>
>> git://git.linaro.org/leg/acpi/acpi.git gsi-irqdomain
>
>
> Is it my imagination, or is Marc's branch based on v3.9-rc7?
>
Looks like 4.2-rc2 to me.

> Also, shouldn't this code be based on the upstream kernel, and not the LEG
> kernel?
>
Nothing LEG kernelly in there.

Graeme
