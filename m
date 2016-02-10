From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH V3 01/10] irqchip / GICv3: Refactor gic_of_init() for
 GICv3 driver
Date: Wed, 10 Feb 2016 09:50:52 +0000
Message-ID: <56BB07FC.8040609@arm.com>
References: <1453209083-3358-1-git-send-email-tn@semihalf.com>
 <1453209083-3358-2-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45678 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751915AbcBJJu5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Feb 2016 04:50:57 -0500
In-Reply-To: <1453209083-3358-2-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomasz Nowicki <tn@semihalf.com>, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com, shijie.huang@arm.com, guohanjun@huawei.com, Suravee.Suthikulpanit@amd.com
Cc: mw@semihalf.com, graeme.gregory@linaro.org, Catalin.Marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, hanjun.guo@linaro.org, linux-arm-kernel@lists.infradead.org, ddaney.cavm@gmail.com, Tomasz Nowicki <tomasz.nowicki@linaro.org>

On 19/01/16 13:11, Tomasz Nowicki wrote:
> Isolate hardware abstraction (FDT) code to gic_of_init().
> Rest of the logic goes to gic_init_bases() and expects well
> defined data to initialize GIC properly. The same solution
> is used for GICv2 driver.
> 
> This is needed for ACPI initialization later.
> 
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
