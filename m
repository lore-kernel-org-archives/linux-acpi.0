From: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH 2/3] Display a DMA error message
Date: Fri, 14 Aug 2015 16:44:12 -0500
Message-ID: <55CE612C.4010405@arm.com>
References: <1439416290-21228-1-git-send-email-jeremy.linton@arm.com>
 <1439416290-21228-3-git-send-email-jeremy.linton@arm.com>
 <2099290.n6l88bWDgg@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([207.82.80.143]:19166 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751776AbbHNVoT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Aug 2015 17:44:19 -0400
In-Reply-To: <2099290.n6l88bWDgg@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux@prisktech.co.nz" <linux@prisktech.co.nz>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>

Arnd,

On 08/14/2015 04:19 PM, Arnd Bergmann wrote:
> On Wednesday 12 August 2015 16:51:29 Jeremy Linton wrote:
>> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
>> index 2593def..82e396f 100644
>> --- a/drivers/usb/host/ehci-platform.c
>> +++ b/drivers/usb/host/ehci-platform.c
>> @@ -162,8 +162,10 @@ static int ehci_platform_probe(struct platform_device *dev)
>>
>>          err = dma_coerce_mask_and_coherent(&dev->dev,
>>                  pdata->dma_mask_64 ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
>> -       if (err)
>> +       if (err) {
>> +               dev_err(&dev->dev, "Error: DMA setup failed\n");
>>                  return err;
>> +       }
>
> We should really stop doing this: the platform should provide the
> correct dma mask when creating the device, instead of setting a
> bogus pdata field. Do not duplicate this bug for ACPI.


I'm not sure I understand, I'm not changing the mask anywhere, all I'm 
doing is printing a message if the mask cannot be set.

AKA if CCA is missing or set to 0 then, this line is triggered because 
the dma_coerce_mask_and_coherent() routine returns with a failure 
indicating there aren't any DMA ops to set a mask on. Right now what 
happens is the device detection displays that there is an EHCI 
controller then silently disappears with telling the user why it didn't 
configure.


Thanks,



	



