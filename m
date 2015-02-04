From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v8 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Wed, 04 Feb 2015 14:29:34 -0600
Message-ID: <54D2812E.9060804@codeaurora.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:50639 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161337AbbBDU3j (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Feb 2015 15:29:39 -0500
In-Reply-To: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, phoenix.liyi@huawei.com, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, Mark Langsdorf <mlangsdo@redhat.com>, wangyijing@huawei.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On 02/02/2015 06:45 AM, Hanjun Guo wrote:
> Hi,
>
> This is the v8 of ACPI core patches for ARM64 based on ACPI 5.1, there are
> some updates since v7:

All 21 patches:

Tested-by: Timur Tabi <timur@codeaurora.org>

I no longer need to use "acpi=force", so that's nice.

>
>   - Add two more documantation to explain why we need ACPI in ARM64 servers

"documentation"


>     by Grant, and recommendations and prohibitions on the use of the numerous
>     ACPI tables and objects by Al Stone.
>
>   - Add two patches which is need to map acpi tables after acpi_gbl_permanent_mmap
>     is set
>
>   - Add another patch "dt / chosen: Add linux,uefi-stub-generated-dtb property"
>     to address that if firmware providing no dtb, we can try ACPI configuration data
>     even if no "acpi=force" is passed in early parameters. (I think ACPI for XEN and
>     kexec need consider sperately as disscussed, correct me if I'm wrong).

"need to be considered separately", "discussed"

>
>   - Add CC in the patch to the subsystem maintainers and modify the subject
>     of the patch to explicitly show the subsystem touched by this patch set,
>     please help us to review and ack them if they make sense, thanks.
>
>   - Add Tested-by from Qualcomm and Redhat;
>
>   - Make ACPI depends on PCI suggested by Catalin;
>
>   - Clean up SMP init function as Lorenzo suggested, remove physical
>     CPU hot-plug code in the patch;
>
>   - Address some comments from Marc and explicitly state that will
>     implment statcked irqdomain and GIC init framework when GICv3 and

"implement", "stacked"


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
