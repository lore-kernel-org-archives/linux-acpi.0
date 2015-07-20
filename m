From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v3 2/8] ACPI / irqchip: Add self-probe
 infrastructure to initialize IRQ controller
Date: Mon, 20 Jul 2015 07:12:06 -0500
Message-ID: <55ACE596.10709@codeaurora.org>
References: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>	<1436525114-14425-3-git-send-email-hanjun.guo@linaro.org> <CAOZdJXWB71tzc=OMm_UH23jc+_wsA5=pC5W9arrEM-URm_sywg@mail.gmail.com> <55ACC022.1000800@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52657 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024AbbGTMML (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Jul 2015 08:12:11 -0400
In-Reply-To: <55ACC022.1000800@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Wei Huang <wei@redhat.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, linaro-acpi@lists.linaro.org, lkml <linux-kernel@vger.kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hanjun Guo wrote:
>> Should we display an error message if we don't find a matching table?
>> That can happen if the ACPI tables shows a GIC version number that is
>> not listed in __irqchip_acpi_table[]?
>
> Hmm, did you get the error message like: "Invalid GIC version 5 in
> MADT"? or just use ACPI_MADT_GIC_VERSION_V1 as the gic_version? if
> the later one, it will show everything is fine, but failed to probe
> the GIC.

We had a bug in our ACPI tables that listed the GIC version as 1, and it 
failed to probe and then the kernel panicked.  It took me a while to 
figure out what was wrong, so I think it should print an error message 
that says that version X is unsupported.


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
