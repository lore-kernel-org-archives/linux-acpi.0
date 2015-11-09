From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] acpi: add support for extended IRQ to PCI link
Date: Mon, 9 Nov 2015 11:28:43 -0500
Message-ID: <5640C9BB.70003@codeaurora.org>
References: <1446998832-7023-1-git-send-email-okaya@codeaurora.org>
 <56402E23.1070805@linux.intel.com> <56403311.2020806@codeaurora.org>
 <5640A4B8.9020602@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45864 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212AbbKIQ2s (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2015 11:28:48 -0500
In-Reply-To: <5640A4B8.9020602@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>, Jiang Liu <jiang.liu@linux.intel.com>, linux-acpi@vger.kernel.org, cov@codeaurora.org, jcm@redhat.com
Cc: agross@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org



On 11/9/2015 8:50 AM, Timur Tabi wrote:
> Sinan Kaya wrote:
>>
>> I'm concerned about this though since you warned. This used to consume
>> 1024 bytes now 4096 bytes.
>>
>> static int acpi_irq_penalty[ACPI_MAX_IRQS] = {
>>      PIRQ_PENALTY_ISA_ALWAYS,    /* IRQ0 timer */
>> ...
>> }
>
> As long as it's not ever put on the stack, it should be fine.
>

Alright...

If 1k global is OK, 4k global should be OK too.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
