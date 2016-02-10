From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH V3 04/10] irqchip / GICv3: remove gic root node in ITS
Date: Wed, 10 Feb 2016 10:25:39 +0000
Message-ID: <56BB1023.4090005@arm.com>
References: <1453209083-3358-1-git-send-email-tn@semihalf.com>
 <1453209083-3358-5-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45964 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752708AbcBJKZo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Feb 2016 05:25:44 -0500
In-Reply-To: <1453209083-3358-5-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomasz Nowicki <tn@semihalf.com>, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com, shijie.huang@arm.com, guohanjun@huawei.com, Suravee.Suthikulpanit@amd.com
Cc: mw@semihalf.com, graeme.gregory@linaro.org, Catalin.Marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, hanjun.guo@linaro.org, linux-arm-kernel@lists.infradead.org, ddaney.cavm@gmail.com

On 19/01/16 13:11, Tomasz Nowicki wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> The gic_root_node defined in ITS driver is not actually
> used, and the ITS driver seems will not use it in the
> future, so just remove it.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
