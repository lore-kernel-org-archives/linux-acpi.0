From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: Re: [PATCH V2 4/4] PCI: ACPI: Add support for PCI device DMA
 coherency
Date: Wed, 26 Aug 2015 09:01:58 +0700
Message-ID: <55DD1E16.40607@amd.com>
References: <1440524009-5359-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1440524009-5359-5-git-send-email-Suravee.Suthikulpanit@amd.com>
 <5541922.5doADRYBJG@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bn1bon0058.outbound.protection.outlook.com ([157.56.111.58]:4205
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752277AbbHZCCJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Aug 2015 22:02:09 -0400
In-Reply-To: <5541922.5doADRYBJG@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: bhelgaas@google.com, lenb@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, hanjun.guo@linaro.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Murali Karicheri <m-karicheri2@ti.com>

Hi Rafael,

On 8/26/15 06:48, Rafael J. Wysocki wrote:
> On Wednesday, August 26, 2015 12:33:29 AM Suravee Suthikulpanit wrote:
>> This patch adds support for setting up PCI device DMA coherency from
>> ACPI _CCA object that should normally be specified in the DSDT node
>> of its PCI host bridge.
>>
>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> CC: Bjorn Helgaas <bhelgaas@google.com>
>> CC: Catalin Marinas <catalin.marinas@arm.com>
>> CC: Rob Herring <robh+dt@kernel.org>
>> CC: Will Deacon <will.deacon@arm.com>
>> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
>> CC: Murali Karicheri <m-karicheri2@ti.com>
>> ---
>>   drivers/pci/probe.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 4de6594..2fd2a60 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1551,17 +1551,22 @@ static void pci_init_capabilities(struct pci_dev *dev)
>>    * @dev: ptr to pci_dev struct of the PCI device
>>    *
>>    * Function to update PCI devices's DMA configuration using the same
>> - * info from the OF node of host bridge's parent (if any).
>> + * info from the OF node or ACPI node of host bridge's parent (if any).
>>    */
>>   static void pci_dma_configure(struct pci_dev *dev)
>>   {
>>   	struct device *bridge = pci_get_host_bridge_device(dev);
>>
>>   	if (IS_ENABLED(CONFIG_OF) && dev->dev.of_node) {
>> -		if (!bridge->parent)
>> -			return;
>> -
>> -		of_dma_configure(&dev->dev, bridge->parent->of_node);
>> +		if (bridge->parent)
>> +			of_dma_configure(&dev->dev,
>> +					 bridge->parent->of_node);
>> +	} else if (has_acpi_companion(bridge)) {
>> +		struct acpi_device *adev = to_acpi_node(bridge->fwnode);
>> +		int coherent = acpi_check_dma_coherency(adev);
>> +
>> +		if (-1 != coherent)
>
> The ordering of this check is somewhat unusual.

I'll fix this.

Thanks,
Suravee
