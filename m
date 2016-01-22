From: Christopher Covington <cov@codeaurora.org>
Subject: Re: [PATCH V3 00/10] Introduce ACPI world to GICv3 & ITS irqchip
Date: Fri, 22 Jan 2016 16:56:34 -0500
Message-ID: <56A2A592.3040904@codeaurora.org>
References: <1453209083-3358-1-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45318 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289AbcAVV4q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Jan 2016 16:56:46 -0500
In-Reply-To: <1453209083-3358-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomasz Nowicki <tn@semihalf.com>, marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com, shijie.huang@arm.com, guohanjun@huawei.com, Suravee.Suthikulpanit@amd.com
Cc: graeme.gregory@linaro.org, Catalin.Marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, hanjun.guo@linaro.org, ddaney.cavm@gmail.com, mw@semihalf.com, linux-arm-kernel@lists.infradead.org

On 01/19/16 08:11, Tomasz Nowicki wrote:
> Patches base on Suravee's ACPI GICv2m support:
> https://lkml.org/lkml/2015/12/10/475
> 
> The following git branch contains submitted patches along with
> the useful patches from the test point of view (mainly ACPI ARM64 PCI support).
> https://github.com/semihalf-nowicki-tomasz/linux.git (gicv3-its-acpi-v3)
> 
> Series has been tested on Cavium ThunderX server.

Thanks Tomasz. Looks good on my Qualcomm Technologies QDF2xxx server.

Tested-by: Christopher Covington <cov@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
