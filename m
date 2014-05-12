From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] acpi-video: Add use native backlight quirk for the ThinkPad
 W530
Date: Mon, 12 May 2014 13:02:04 +0200
Message-ID: <5370AA2C.1080506@redhat.com>
References: <1399881432-26124-1-git-send-email-hdegoede@redhat.com> <5370837A.5070708@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40765 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752935AbaELLCO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 May 2014 07:02:14 -0400
In-Reply-To: <5370837A.5070708@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>, Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Dave Airlie <airlied@redhat.com>, Ben Skeggs <bskeggs@redhat.com>
Cc: linux-acpi@vger.kernel.org, stable@vger.kernel.org

Hi,

On 05/12/2014 10:16 AM, Aaron Lu wrote:
> On 05/12/2014 03:57 PM, Hans de Goede wrote:
>> Like all of the other *30 ThinkPad models, the W530 has a broken acpi-video
>> backlight control. Note in order for this to actually fix things on the
>> ThinkPad W530 the commit titled:
>> "nouveau: Don't check acpi_video_backlight_support() before registering backlight"
>> is also needed.
> 
> Note that the backlight_device_registered(raw) may return false as when
> acpi_video_verify_backlight_support is called, the nouveau driver may
> not run yet.
> 
> Previously, we don't know anything about how laptops with nvidia graphics
> card alone control backlight in Win8, so the existing solution doesn't
> consider this case. If nvidia graphics system also should favour native
> backlight control interface in Win8, the current solution needs
> modifications.

Hmm, how is this dealt with in the case of the intel gfx driver ?

Regards,

Hans



> 
> Thanks,
> Aaron
> 
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=1093171
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/acpi/video.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
>> index 34198b2..6a2099d 100644
>> --- a/drivers/acpi/video.c
>> +++ b/drivers/acpi/video.c
>> @@ -520,6 +520,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>>  		},
>>  	},
>>  	{
>> +	 .callback = video_set_use_native_backlight,
>> +	 .ident = "ThinkPad W530",
>> +	 .matches = {
>> +		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> +		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad W530"),
>> +		},
>> +	},
>> +	{
>>  	.callback = video_set_use_native_backlight,
>>  	.ident = "ThinkPad X1 Carbon",
>>  	.matches = {
>>
> 
