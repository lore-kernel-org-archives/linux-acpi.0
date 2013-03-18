From: Danny Baumann <dannybaumann@web.de>
Subject: Re: [PATCH v2 1/3] ACPI video: Fix brightness control initialization
 for some laptops.
Date: Mon, 18 Mar 2013 09:22:22 +0100
Message-ID: <5146CEBE.3070909@web.de>
References: <1363342248-6496-1-git-send-email-dannybaumann@web.de> <5146C1B4.4050907@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cora.hrz.tu-chemnitz.de ([134.109.228.40]:59684 "EHLO
	cora.hrz.tu-chemnitz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506Ab3CRIW0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Mar 2013 04:22:26 -0400
In-Reply-To: <5146C1B4.4050907@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>

Hi,

>> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
>> index 313f959..9c33871 100644
>> --- a/drivers/acpi/video.c
>> +++ b/drivers/acpi/video.c
>> @@ -222,7 +222,7 @@ static int acpi_video_device_lcd_set_level(struct acpi_video_device *device,
>>   			int level);
>>   static int acpi_video_device_lcd_get_level_current(
>>   			struct acpi_video_device *device,
>> -			unsigned long long *level, int init);
>> +			unsigned long long *level, int raw);
>
> Why not bool?

For two reasons:
- It previous was int ;-)
- It allowed the invocations of this function to fit within one 80-char 
line.

Neither reason is terribly strong, so if you prefer, I can convert this 
argument to bool.

Regards,

Danny
