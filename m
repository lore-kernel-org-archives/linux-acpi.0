From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH 1/2] [PATCH] ACPI: video: Don't call absent methods
Date: Tue, 02 Oct 2007 19:52:53 +0400
Message-ID: <47026955.9050308@gmail.com>
References: <20070903122958.20082.6843.stgit@z61m> <4702462F.4070909@ou.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:44192 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755318AbXJBPxB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Oct 2007 11:53:01 -0400
Received: by ug-out-1314.google.com with SMTP id z38so2136042ugc
        for <linux-acpi@vger.kernel.org>; Tue, 02 Oct 2007 08:52:59 -0700 (PDT)
In-Reply-To: <4702462F.4070909@ou.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ryan May <rmay@ou.edu>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Thomas Tuttle <linux-kernel@ttuttle.net>, linux-acpi@vger.kernel.org, lenb@kernel.org

Ryan,
It is in queue for 2.6.24... Too late for .23

Regards,
Alex.
Ryan May wrote:
> Hi,
> 
> What's the status of this patch?  AFAICT, it hasn't been applied
> upstream anywhere.  This fixes the problems on my HP dv2125nr with the
> new BIOS, so I'd really like to see it merged.
> 
> Thanks,
> 
> Ryan
> 
> Alexey Starikovskiy wrote:
>> Signed-off-by: Ryan May <rmay@ou.edu>
>> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
>> ---
>>
>>  drivers/acpi/video.c |   18 ++++++++++--------
>>  1 files changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
>> index 3c9bb85..83aa41c 100644
>> --- a/drivers/acpi/video.c
>> +++ b/drivers/acpi/video.c
>> @@ -409,14 +409,16 @@ acpi_video_device_lcd_query_levels(struct acpi_video_device *device,
>>  static int
>>  acpi_video_device_lcd_set_level(struct acpi_video_device *device, int level)
>>  {
>> -	int status;
>> +	int status = AE_OK;
>>  	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
>>  	struct acpi_object_list args = { 1, &arg0 };
>>  
>>  
>>  	arg0.integer.value = level;
>> -	status = acpi_evaluate_object(device->dev->handle, "_BCM", &args, NULL);
>> -
>> +	if (device->cap._BCM)
>> +		status = acpi_evaluate_object(device->dev->handle, "_BCM",
>> +					      &args, NULL);
>> +	device->brightness->curr = level;
>>  	printk(KERN_DEBUG "set_level status: %x\n", status);
>>  	return status;
>>  }
>> @@ -425,11 +427,11 @@ static int
>>  acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
>>  					unsigned long *level)
>>  {
>> -	int status;
>> -
>> -	status = acpi_evaluate_integer(device->dev->handle, "_BQC", NULL, level);
>> -
>> -	return status;
>> +	if (device->cap._BQC)
>> +		return acpi_evaluate_integer(device->dev->handle, "_BQC", NULL,
>> +					     level);
>> +	*level = device->brightness->curr;
>> +	return AE_OK;
>>  }
>>  
>>  static int
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> 
> 

