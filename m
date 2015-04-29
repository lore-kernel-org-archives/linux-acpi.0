From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH 2/2] ACPI / scan: Parse _CCA and setup device coherency
Date: Wed, 29 Apr 2015 09:45:43 -0500
Message-ID: <5540EE97.70202@amd.com>
References: <1430315049-4663-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1430315049-4663-3-git-send-email-Suravee.Suthikulpanit@amd.com>
 <5542288.z0SSOZ4xV7@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bn1on0137.outbound.protection.outlook.com ([157.56.110.137]:21440
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1423153AbbD2Op5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Apr 2015 10:45:57 -0400
In-Reply-To: <5542288.z0SSOZ4xV7@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, al.stone@linaro.org, linaro-acpi@lists.linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, leo.duran@amd.com, hanjun.guo@linaro.org, msalter@redhat.com, grant.likely@linaro.org



On 04/29/2015 09:03 AM, Arnd Bergmann wrote:
> On Wednesday 29 April 2015 08:44:09 Suravee Suthikulpanit wrote:
>> +                       device->flags.cca_seen = 1;
>> +               } else if (IS_ENABLED(CONFIG_ACPI_MUST_HAVE_CCA)) {
>> +                       /*
>> +                        * Architecture has specified that if the device
>> +                        * can do DMA, it must have ACPI _CCA object.
>> +                        * Here, there could be two cases:
>> +                        *   1. Not DMA-able device.
>> +                        *   2. DMA-able device, but missing _CCA object.
>> +                        *
>> +                        * In both cases, we will default to dma non-coherent.
>> +                        */
>> +                       cca = 0;
>> +               } else {
>> +                       /*
>> +                        * If architecture does not specify that device must
>> +                        * specify ACPI _CCA (e.g. x86), we default to use
>> +                        * dma coherent.
>> +                        */
>> +                       cca = 1;
>> +               }
>>
>
> What does it mean here if a device does DMA but is not coherent? Do you
> have an example of a server that needs this?
>
> Can we please make the default for ARM64 cca=1 as well?
>
> 	Arnd
>

Actually, I am trying to implement the logic for when missing _CCA to be 
consistent with the behavior when the devicetree entry does not specify 
"dma-coherent" property. IIUC, in such case, Linux will default to using 
non-coherent DMA.

Thanks,

Suravee
