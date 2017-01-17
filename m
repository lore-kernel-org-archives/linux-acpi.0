From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v19 10/15] clocksource/drivers/arm_arch_timer: Refactor
 the timer init code to prepare for GTDT
Date: Tue, 17 Jan 2017 06:18:12 -0600
Message-ID: <b977f47b-a85e-d4d5-666c-b8c9cd21c25e@codeaurora.org>
References: <20161221064603.11830-1-fu.wei@linaro.org>
 <20161221064603.11830-11-fu.wei@linaro.org>
 <20170116183032.GL5908@leverpostej>
 <CADyBb7tFaSshUmZsJbNO2tnbqAKEii39NQVfcx5CqDiDsK5OJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57326 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751071AbdAQMSW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2017 07:18:22 -0500
In-Reply-To: <CADyBb7tFaSshUmZsJbNO2tnbqAKEii39NQVfcx5CqDiDsK5OJA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Fu Wei <fu.wei@linaro.org>, Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rruigrok@codeaurora.org, "Abdulhamid, Harb" <harba@codeaurora.org>, Christopher Covington <cov@codeaurora.org>, G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>, Wei Huang <wei@redhat.com>, Arnd

Fu Wei wrote:
> if (i >= ARCH_TIMER_MEM_MAX_FRAMES) {
>         pr_err(FW_BUG "too many frames, ARMv8 spec only allows 8.\n");

pr_err(FW_BUG "too many frames, ARMv8 spec only allows %u.\n",
	ARCH_TIMER_MEM_MAX_FRAMES);

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
