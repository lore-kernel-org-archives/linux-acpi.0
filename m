From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH V4 2/7] irqchip, GICv3, ITS: Cleanup for ITS domain
 initialization.
Date: Wed, 13 Apr 2016 15:18:07 +0100
Message-ID: <570E551F.608@arm.com>
References: <1459759975-24097-1-git-send-email-tn@semihalf.com>
 <1459759975-24097-3-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34866 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753542AbcDMOSM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Apr 2016 10:18:12 -0400
In-Reply-To: <1459759975-24097-3-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomasz Nowicki <tn@semihalf.com>, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com, shijie.huang@arm.com, Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org
Cc: al.stone@linaro.org, mw@semihalf.com, graeme.gregory@linaro.org, Catalin.Marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ddaney.cavm@gmail.com, okaya@codeaurora.org

On 04/04/16 09:52, Tomasz Nowicki wrote:
> There is no point to initialize ITS without having msi-controller
> property in corresponding DT node. However, its_probe is checking
> msi-controller presence at the end, so we can save our time and do that
> check prior to its_probe call. Also, for the code clarity purpose,
> we put domain initialization to separate function.
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
