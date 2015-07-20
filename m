From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [Linaro-acpi] [PATCH v3 0/8] Add self-probe
 infrastructure and stacked irqdomain support for ACPI based GICv2/3
 init
Date: Mon, 20 Jul 2015 07:06:21 -0500
Message-ID: <55ACE43D.4090306@codeaurora.org>
References: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org> <CAOZdJXXxJxxc9KAQK1VY9iTTVdj-FbpFpoWcexGMrqOS0TgDEQ@mail.gmail.com> <55ACBA00.4080101@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51055 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372AbbGTMG1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Jul 2015 08:06:27 -0400
In-Reply-To: <55ACBA00.4080101@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Wei Huang <wei@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linaro-acpi@lists.linaro.org, lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hanjun Guo wrote:

> I got a question, do you test GICv3 in this patch set too?
> if yes, that will be really great!

Yes, I specifically tested GICv3 on an ACPI-only system.

> Just let you know, I'm still working on this patch set to try
> to address Marc's comments (unify DT and ACPI to match the domain),
> I'm not sure if any obstacles ahead, I will let you know the progress.

Just CC me on all patches, and I will test each version.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
