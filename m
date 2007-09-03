From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH 1/2] [PATCH] ACPI: video: Don't call absent methods
Date: Mon, 03 Sep 2007 19:15:16 +0400
Message-ID: <46DC2504.5040604@gmail.com>
References: <20070903122958.20082.6843.stgit@z61m> <200709031049.28282.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:7760 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbXICPPX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Sep 2007 11:15:23 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1402603fkz
        for <linux-acpi@vger.kernel.org>; Mon, 03 Sep 2007 08:15:22 -0700 (PDT)
In-Reply-To: <200709031049.28282.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Thomas Tuttle <linux-kernel@ttuttle.net>, linux-acpi@vger.kernel.org

Len Brown wrote:
> Is it a good idea to return AE_OK when no operation was actually performed?
There is a write into device->brightness->curr, so _some_ operation was performed.
Do you suggest any other error code?

Alex
> 
> -Len
> 
> On Monday 03 September 2007 08:29, Alexey Starikovskiy wrote:
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
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

