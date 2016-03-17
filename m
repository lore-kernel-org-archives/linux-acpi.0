From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v4 0/5] acpi, clocksource, kvm: add GTDT and ARM
 memory-mapped timer support
Date: Thu, 17 Mar 2016 10:07:30 -0500
Message-ID: <56EAC832.6070203@codeaurora.org>
References: <1458199917-30699-1-git-send-email-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39531 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934982AbcCQPI1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Mar 2016 11:08:27 -0400
In-Reply-To: <1458199917-30699-1-git-send-email-fu.wei@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de, marc.zyngier@arm.com, hanjun.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org, graeme.gregory@linaro.org, al.stone@linaro.org, jcm@redhat.com, "wei@redhat.com--cc=arnd"@arndb.de, wim@iguana.be, catalin.marinas@arm.com, will.deacon@arm.com, Suravee.Suthikulpanit@amd.com, leo.duran@amd.com

fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> This patchset:
>      (1)Move some enums and marcos to header file for arm_arch_timer,
>      improve the pr_* code by defining "pr_fmt(fmt)" in arm_arch_timer.c
>
>      (2)Introduce ACPI GTDT parser: drivers/acpi/gtdt.c
>      Parse all kinds of timer in GTDT table of ACPI:arch timer,
>      memory-mapped timer and SBSA Generic Watchdog timer.
>      This driver can help to simplify all the relevant timer drivers,
>      and separate all the ACPI GTDT knowledge from them.
>
>      (3)Simplify ACPI code for arch timer in arm_arch_timer.c
>
>      (4)Add memory-mapped timer support in arm_arch_timer.c

The SBSA watchdog driver is already in watchdog-next and will be merged 
into 4.6.  These five patches are necessary for the watchdog driver to 
probe on an ACPI system.

I'm guessing since that v4 was posted in the middle of the 4.6 merge 
window, that these patches won't make it and we'll have to wait until 
4.7 (at the earliest)?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
