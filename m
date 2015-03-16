From: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Subject: Re: [PATCH v10 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Mon, 16 Mar 2015 05:07:49 +0000
Message-ID: <D12BCE95.15953%suravee.suthikulpanit@amd.com>
References: <55019423.3080506@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bn1bbn0104.outbound.protection.outlook.com ([157.56.111.104]:54755
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750785AbbCPFH5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Mar 2015 01:07:57 -0400
In-Reply-To: <55019423.3080506@codeaurora.org>
Content-Language: en-US
Content-ID: <EA805B8FC4B43B429DC057D508B9D22B@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>, Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>



On 3/12/15, 08:26, "Timur Tabi" <timur@codeaurora.org> wrote:

>Hanjun Guo wrote:
>> This patch set already tested on multi platforms:
>>   - AMD Seattle board;
>>   - Cavium Thunder board;
>>   - Huawei D02 board;
>>   - Qualcomm ARM64 platform
>>
>> This version 10 patch set address some minor comments and collect ACKs
>>and
>> Reviewed-bys for v9:
>>
>>   - new Acks from Rafael, Olof, Grant, Lorenzo
>>   - new way to handle typdef phys_cpuid_t which suggested by Rafael,
>>     but no functional change
>>   - Remove if(!phys) for early ioremappings
>>   - Rework sleep function for ARM64
>>   - Introduce linux/acpi_irq.h to hold acpi_irq_init()
>>   - Disable ACPI if not HW_REDUCED_ACPI compliant
>>   - Remove the doc of why ACPI on ARM
>
>v10 retested and working as before, so ...
>
>	Tested-by: Timur Tabi <timur@codeaurora.org>
>
>for the whole patchset.


Also retested on AMD Seattle.

Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

>
>-- 
>Sent by an employee of the Qualcomm Innovation Center, Inc.
>The Qualcomm Innovation Center, Inc. is a member of the
>Code Aurora Forum, hosted by The Linux Foundation.

