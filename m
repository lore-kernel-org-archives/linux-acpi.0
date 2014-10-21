From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [resend PATCH 1/3] ACPI / platform: provide default DMA mask
Date: Tue, 21 Oct 2014 15:27:45 +0300
Message-ID: <54465141.1080408@intel.com>
References: <1411545639-18741-1-git-send-email-heikki.krogerus@linux.intel.com> <1411545639-18741-2-git-send-email-heikki.krogerus@linux.intel.com> <2261149.pJ2DW810R9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:43477 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755191AbaJUM3O (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Oct 2014 08:29:14 -0400
In-Reply-To: <2261149.pJ2DW810R9@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 24/09/14 16:49, Rafael J. Wysocki wrote:
> On Wednesday, September 24, 2014 11:00:37 AM Heikki Krogerus wrote:
>> Most devices are configured for 32-bit DMA addresses.
>> Setting the mask to 32-bit here removes the need for the
>> drivers to do it separately.
>>
>> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> 
> ACK

Hi

I need this for another driver.  Did this patch go anywhere?
Note Heikki is away at the moment.

Regards
Adrian

> 
>> ---
>>  drivers/acpi/acpi_platform.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
>> index 2bf9082..8d099e6 100644
>> --- a/drivers/acpi/acpi_platform.c
>> +++ b/drivers/acpi/acpi_platform.c
>> @@ -16,6 +16,7 @@
>>  #include <linux/err.h>
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>> +#include <linux/dma-mapping.h>
>>  #include <linux/platform_device.h>
>>  
>>  #include "internal.h"
>> @@ -102,6 +103,7 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev)
>>  	pdevinfo.res = resources;
>>  	pdevinfo.num_res = count;
>>  	pdevinfo.acpi_node.companion = adev;
>> +	pdevinfo.dma_mask = DMA_BIT_MASK(32);
>>  	pdev = platform_device_register_full(&pdevinfo);
>>  	if (IS_ERR(pdev))
>>  		dev_err(&adev->dev, "platform device creation failed: %ld\n",
>>
> 

