From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [patch v11 00/23] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Mon, 30 Mar 2015 11:49:44 -0500
Message-ID: <55197EA8.1000807@codeaurora.org>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:37222 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763AbbC3Qtt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Mar 2015 12:49:49 -0400
In-Reply-To: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Mark Salter <msalter@redhat.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On 03/24/2015 09:02 AM, Hanjun Guo wrote:
> Some fixes since last version:
>
>   - Add a patch 19/23 for disabling ACPI for Xen on ARM64 for now to fix
>     compile errors on XEN ACPI, Stefano and Julien are ok with this
>     temporary solution.
>   - Add patch "ARM64 / ACPI: Don't unflatten device tree if acpi=force
>     is passed", which will fix the problem that the device tree will
>     be unflattened even if acpi=force passed, that will not obey the
>     policy.
>   - update patch "irqchip: Add GICv2 specific ACPI boot support",
>     which will cause compile error on i386 with both DT and ACPI
>     enabled:

All 23 patches:

Tested-by: Timur Tabi <timur@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
