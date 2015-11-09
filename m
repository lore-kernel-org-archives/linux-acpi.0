From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] acpi: add support for extended IRQ to PCI link
Date: Mon, 9 Nov 2015 00:45:53 -0500
Message-ID: <56403311.2020806@codeaurora.org>
References: <1446998832-7023-1-git-send-email-okaya@codeaurora.org>
 <56402E23.1070805@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42899 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671AbbKIFp6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2015 00:45:58 -0500
In-Reply-To: <56402E23.1070805@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>, linux-acpi@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com
Cc: agross@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org



On 11/9/2015 12:24 AM, Jiang Liu wrote:
>> +	u32 possible[ACPI_PCI_LINK_MAX_POSSIBLE];
>> >  	u8 initialized:1;
>> >  	u8 reserved:7;
>> >  };
> Hi Sinan,
> 	This data structure become some sort of big, any idea to reduce
> memory consumption?
> Thanks,
> Gerry
>
Hi Gerry,

There are two constants in the code.

#define ACPI_PCI_LINK_MAX_POSSIBLE	16

I changed the data type above. Previously it was consuming 16 bytes now 
64 bytes.

The second one is this.

#define ACPI_MAX_IRQS 256

I changed ACPI_MAX_IRQS to 1020 from 256. Let's assume 1024.

I'm concerned about this though since you warned. This used to consume 
1024 bytes now 4096 bytes.

static int acpi_irq_penalty[ACPI_MAX_IRQS] = {
	PIRQ_PENALTY_ISA_ALWAYS,	/* IRQ0 timer */
...
}

Sinan

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
