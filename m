From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] acpi: Revert "ACPI / video: Add Dell Inspiron 5737 to the
 blacklist"
Date: Fri, 22 Jan 2016 14:51:39 +0100
Message-ID: <56A233EB.6090009@redhat.com>
References: <1453459265-12564-1-git-send-email-hdegoede@redhat.com>
 <1562452.BybifopDHa@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1562452.BybifopDHa@vostro.rjw.lan>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: erusan@gmail.com, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On 22-01-16 14:44, Rafael J. Wysocki wrote:
> On Friday, January 22, 2016 11:41:05 AM Hans de Goede wrote:
>> The quirk to get "acpi_backlight=vendor" behavior by default on the
>> Dell Inspiron 5737 was added before we started doing
>> "acpi_backlight=native" by default on Win8 ready machines.
>>
>> Since we now avoid using acpi-video as backlight driver on these machines
>> by default (using the native driver instead) we no longer need this quirk.
>>
>> Moreover the vendor driver does not work after a suspend/resume where
>> as the native driver does.
>>
>> This reverts commit 08a56226d847 ("ACPI / video: Add Dell Inspiron 5737
>> to the blacklist").
>>
>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=111061
>> Cc: stable@vger.kernel.org
>
> OK, but I think we need to limit the range of "stable" kernels this is
> going to go into.
>
> What's the least recent "stable" series one you'd like this to be applied to?

3.19 and later have this commit:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/acpi/video.c?id=fbc9fe1b4f222a7c575e3bd8e9defe59c6190a04

And thus will use native backlight by default, so anything >= 3.19.

Regards,

Hans


>
>> Reported-and-tested-by: erusan@gmail.com
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/acpi/video_detect.c | 8 --------
>>   1 file changed, 8 deletions(-)
>>
>> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
>> index 90e2d54..1316ddd 100644
>> --- a/drivers/acpi/video_detect.c
>> +++ b/drivers/acpi/video_detect.c
>> @@ -135,14 +135,6 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>>   		DMI_MATCH(DMI_PRODUCT_NAME, "UL30A"),
>>   		},
>>   	},
>> -	{
>> -	.callback = video_detect_force_vendor,
>> -	.ident = "Dell Inspiron 5737",
>> -	.matches = {
>> -		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>> -		DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 5737"),
>> -		},
>> -	},
>>
>>   	/*
>>   	 * These models have a working acpi_video backlight control, and using
>>
>
