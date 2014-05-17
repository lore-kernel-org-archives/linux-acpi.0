From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] acpi-video: Revert native brightness quirk for ThinkPad
 T530
Date: Sat, 17 May 2014 09:47:03 +0200
Message-ID: <537713F7.4090000@redhat.com>
References: <1400267441-6267-1-git-send-email-hdegoede@redhat.com> <13216709.cQDcpMa84k@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <13216709.cQDcpMa84k@vostro.rjw.lan>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Aaron Lu <aaron.lu@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On 05/16/2014 10:50 PM, Rafael J. Wysocki wrote:
> On Friday, May 16, 2014 09:10:41 PM Hans de Goede wrote:
>> Seems it helps some users, but causes issues for other users:
>> https://bugzilla.redhat.com/show_bug.cgi?id=1089545
>>
>> So lets drop it for now until we've figured out a better fix.
> 
> So you hadn't even waited for all of your users to have a chance to test the
> blacklist patch and you asked me to push it for -rc5 nevertheless.  You don't
> even realize how disappointing that is.

That is not how it happened, after the patch going out a new user with a T530
showed up, who did not have any problems before so never was part of the bug
reports about this before, but got problems after the patch.
So it seems that different T530's behave differently.

This may have something todo with whether they were booted in EFI mode or not,
or maybe there are just 2 different revisions out there.

Note that this is all not in vain:

1) We would have never heard from that user without the patch
2) The behavior the patch causes is going to be the default in 3.16, so now we've
caught it early and can work on a fix before 3.16-rc1.

> I had to rebase this patch, so it has to go through autobuild testing and
> I'll try to add it to my -rc6 pull request, but I'm not going to take any new
> blacklist entries for anything later than -rc4 in the future.  And don't even
> *try* to argue with that.

I can see that being reasonable, although I believe this time it does actually work
in out advantage, esp. with the default behavior change planned for 3.15.

Regards,

Hans


> 
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/acpi/video.c | 8 --------
>>  1 file changed, 8 deletions(-)
>>
>> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
>> index 0fec70d..8309100 100644
>> --- a/drivers/acpi/video.c
>> +++ b/drivers/acpi/video.c
>> @@ -516,14 +516,6 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>>  	},
>>  	{
>>  	 .callback = video_set_use_native_backlight,
>> -	 .ident = "ThinkPad T530",
>> -	 .matches = {
>> -		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> -		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T530"),
>> -		},
>> -	},
>> -	{
>> -	 .callback = video_set_use_native_backlight,
>>  	 .ident = "ThinkPad W530",
>>  	 .matches = {
>>  		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>
> 
