From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH V3 05/10] irqchip, gicv3, its: Mark its_init() and its
 children as __init
Date: Wed, 10 Feb 2016 10:30:46 +0000
Message-ID: <56BB1156.4070507@arm.com>
References: <1453209083-3358-1-git-send-email-tn@semihalf.com>
 <1453209083-3358-6-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46018 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800AbcBJKau (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Feb 2016 05:30:50 -0500
In-Reply-To: <1453209083-3358-6-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomasz Nowicki <tn@semihalf.com>, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com, shijie.huang@arm.com, guohanjun@huawei.com, Suravee.Suthikulpanit@amd.com
Cc: mw@semihalf.com, graeme.gregory@linaro.org, Catalin.Marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, hanjun.guo@linaro.org, linux-arm-kernel@lists.infradead.org, ddaney.cavm@gmail.com

On 19/01/16 13:11, Tomasz Nowicki wrote:
> gicv3_init_bases() is the only caller for its_init(),
> also it is a __init function, so mark its_init() as __init too,
> then recursively mark the functions called as __init.
> 
> This will help to introduce ITS initialization using ACPI tables as
> we will use acpi_table_parse_entries family functions there which
> belong to __init section as well.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
