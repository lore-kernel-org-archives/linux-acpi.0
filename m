From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] acpi-video: Add 4 new models to the use_native_backlight
 dmi list
Date: Mon, 05 May 2014 10:49:01 +0200
Message-ID: <5367507D.70600@redhat.com>
References: <1398940879-6455-1-git-send-email-hdegoede@redhat.com> <1940276.byRRIda2Hg@vostro.rjw.lan> <53674C87.9090901@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <53674C87.9090901@intel.com>
Sender: stable-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Vincent Gerris <vgerris@gmail.com>, linux-acpi@vger.kernel.org, stable@vger.kernel.org, edm <fuffi.il.fuffo@gmail.com>, AnAkkk <anakin.cs@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Hi Aaron,

On 05/05/2014 10:32 AM, Aaron Lu wrote:
> On 05/02/2014 04:16 AM, Rafael J. Wysocki wrote:
>> On Thursday, May 01, 2014 12:41:19 PM Hans de Goede wrote:
>>> Acer Aspire V5-171
>>> https://bugzilla.redhat.com/show_bug.cgi?id=983342
>>>
>>> Acer Aspire V5-471G
>>> Lenovo Yoga 2 11
>>> Reported-and-tested-by: Vincent Gerris <vgerris@gmail.com>
>>>
>>> HP EliteBook 8470p
>>> https://bugzilla.redhat.com/show_bug.cgi?id=1093120
>>>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>
>> OK, I'll take this and drop commit 170269a9d3c0 for now.
> 
> There are two additional machines that need to go to the quirk table:
> ThinkPad T430 and Acer Aspire 5742G, I didn't find a proper branch
> to base the quirk patch on, is this patch going to be merged soon?
> 
> BTW, Hans, it would be great if you can take the two machines into
> your patch too(the below diff is on top of v3.15-rc4):

I was just preparing a patch adding a quirk for the T530, I'll add
these 2 to the same patch.

Note my new patch applies on top of:
acpi-video: Add 4 new models to the use_native_backlight dmi list
acpi: mv models with win8 brightness problems from win8 blacklist to use_native_backlight

Thanks & Regards,

Hans


> 
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index b6ba88ed31ae..ddf9eeb6235b 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -459,10 +459,10 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>  	},
>  	{
>  	 .callback = video_set_use_native_backlight,
> -	 .ident = "ThinkPad T430s",
> +	 .ident = "ThinkPad T430 and T430s",
>  	 .matches = {
>  		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T430s"),
> +		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T430"),
>  		},
>  	},
>  	{
> @@ -571,6 +571,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 8780w"),
>  		},
>  	},
> +	{
> +	.callback = video_set_use_native_backlight,
> +	.ident = "Acer Aspire 5742G",
> +	.matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5742G"),
> +		},
> +	},
>  	{}
>  };
>  
> The T430 is reported-and-tested-by: edm <fuffi.il.fuffo@gmail.com>
> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=51231
> The 5742G is reported-and-tested-by: AnAkkk <anakin.cs@gmail.com>
> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=35622
> 
> But if you do not want to do that, feel free to let me know, I'll
> prepare a patch then.
> 
> Thanks,
> Aaron
> 
>>
>> Thanks!
>>
>>> ---
>>>  drivers/acpi/video.c | 32 ++++++++++++++++++++++++++++++++
>>>  1 file changed, 32 insertions(+)
>>>
>>> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
>>> index 8b6990e..48146fc 100644
>>> --- a/drivers/acpi/video.c
>>> +++ b/drivers/acpi/video.c
>>> @@ -488,6 +488,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>>>  		},
>>>  	},
>>>  	{
>>> +	 .callback = video_set_use_native_backlight,
>>> +	 .ident = "Lenovo Yoga 2 11",
>>> +	 .matches = {
>>> +		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>> +		DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Yoga 2 11"),
>>> +		},
>>> +	},
>>> +	{
>>>  	.callback = video_set_use_native_backlight,
>>>  	.ident = "Thinkpad Helix",
>>>  	.matches = {
>>> @@ -513,6 +521,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>>>  	},
>>>  	{
>>>  	 .callback = video_set_use_native_backlight,
>>> +	 .ident = "Acer Aspire V5-171",
>>> +	 .matches = {
>>> +		DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
>>> +		DMI_MATCH(DMI_PRODUCT_NAME, "V5-171"),
>>> +		},
>>> +	},
>>> +	{
>>> +	 .callback = video_set_use_native_backlight,
>>>  	 .ident = "Acer Aspire V5-431",
>>>  	 .matches = {
>>>  		DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
>>> @@ -520,6 +536,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>>>  		},
>>>  	},
>>>  	{
>>> +	 .callback = video_set_use_native_backlight,
>>> +	 .ident = "Acer Aspire V5-471G",
>>> +	 .matches = {
>>> +		DMI_MATCH(DMI_BOARD_VENDOR, "Acer"),
>>> +		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire V5-471G"),
>>> +		},
>>> +	},
>>> +	{
>>>  	.callback = video_set_use_native_backlight,
>>>  	.ident = "HP ProBook 4340s",
>>>  	.matches = {
>>> @@ -571,6 +595,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>>>  	},
>>>  	{
>>>  	.callback = video_set_use_native_backlight,
>>> +	.ident = "HP EliteBook 8470p",
>>> +	.matches = {
>>> +		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
>>> +		DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 8470p"),
>>> +		},
>>> +	},
>>> +	{
>>> +	.callback = video_set_use_native_backlight,
>>>  	.ident = "HP EliteBook 8780w",
>>>  	.matches = {
>>>  		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
>>>
>>
> 
