From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v6 4/4] gicv2m: acpi: Introducing GICv2m ACPI support
Date: Thu, 10 Dec 2015 10:11:01 -0600
Message-ID: <5669A415.60300@amd.com>
References: <1449689074-30609-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1449689074-30609-5-git-send-email-Suravee.Suthikulpanit@amd.com>
 <56694272.5050706@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-by2on0096.outbound.protection.outlook.com ([207.46.100.96]:19264
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750790AbbLJQLJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Dec 2015 11:11:09 -0500
In-Reply-To: <56694272.5050706@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, hanjun.guo@linaro.org, tomasz.nowicki@linaro.org, graeme.gregory@linaro.org, dhdang@apm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On 12/10/2015 3:14 AM, Marc Zyngier wrote:
>> +int __init gicv2m_init(struct fwnode_handle *parent_handle,
>> >+		       struct irq_domain *parent)
>> >+{
>> >+	int ret = gicv2m_of_init(parent_handle, parent);
>> >+
>> >+	if (ret)
>> >+		ret = gicv2m_acpi_init(parent);
>> >+	return ret;
> This should really read:
>
> 	if (is_of_node(parent_handle))
> 		return gicv2m_of_init(parent_handle, parent);
> 	
> 	return gicv2m_acpi_init(parent);
>
> and you can loose the test for NULL in gicv2m_of_init().
>

Right... Your style of returning which is cleaner ;)

I'll update in V7 and send it out shortly.

Thanks,
Suravee
