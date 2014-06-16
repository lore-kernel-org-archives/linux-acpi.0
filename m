From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] acpi: mv models with win8 brightness problems from win8
 blacklist to use_native_backlight
Date: Mon, 16 Jun 2014 11:54:43 +0200
Message-ID: <539EBEE3.9050609@redhat.com>
References: <1399042252-14172-1-git-send-email-hdegoede@redhat.com> <12075536.Y1QkyZAZU4@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55357 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755020AbaFPJyu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Jun 2014 05:54:50 -0400
In-Reply-To: <12075536.Y1QkyZAZU4@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Hi,

On 05/16/2014 01:54 PM, Rafael J. Wysocki wrote:
> On Friday, May 02, 2014 04:50:52 PM Hans de Goede wrote:
>> When the windows8 related backlight problems became evident, 2 approaches
>> were follow in parallel, one was to stop claiming to be windows 8 / 2012,
>> the other was to tell acpi_video to stop registering a backlight driver.
>>
>> I've read all the threads and it seems that which approach ended up being
>> applied to which model laptop was never really a concious decision (AFAIK).
>>
>> So lets move all the models which are only on the win8 blacklist because of
>> brightness issues to the use_native_backlight list, which is the smaller
>> hammer to use to solve the backlight issues.
>>
>> Note: this is not tested on any of the affected models, this just seems like
>> the sensible thing to do.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> This doesn't apply for me on top of current linux-next, care to rebase?

Just rebased this on top of 3.16-rc1, v2 coming up.

Regards,

Hans

> 
>> ---
>>  drivers/acpi/blacklist.c | 75 ------------------------------------------------
>>  drivers/acpi/video.c     | 72 +++++++++++++++++++++++++++++++++++++++++++---
>>  2 files changed, 68 insertions(+), 79 deletions(-)
>>
>> diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
>> index afec452..51b8f64 100644
>> --- a/drivers/acpi/blacklist.c
>> +++ b/drivers/acpi/blacklist.c
>> @@ -156,12 +156,6 @@ static int __init dmi_disable_osi_win7(const struct dmi_system_id *d)
>>  	acpi_osi_setup("!Windows 2009");
>>  	return 0;
>>  }
>> -static int __init dmi_disable_osi_win8(const struct dmi_system_id *d)
>> -{
>> -	printk(KERN_NOTICE PREFIX "DMI detected: %s\n", d->ident);
>> -	acpi_osi_setup("!Windows 2012");
>> -	return 0;
>> -}
>>  
>>  static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
>>  	{
>> @@ -247,75 +241,6 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
>>  	},
>>  
>>  	/*
>> -	 * The following machines have broken backlight support when reporting
>> -	 * the Windows 2012 OSI, so disable it until their support is fixed.
>> -	 */
>> -	{
>> -	.callback = dmi_disable_osi_win8,
>> -	.ident = "ASUS Zenbook Prime UX31A",
>> -	.matches = {
>> -		     DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>> -		     DMI_MATCH(DMI_PRODUCT_NAME, "UX31A"),
>> -		},
>> -	},
>> -	{
>> -	.callback = dmi_disable_osi_win8,
>> -	.ident = "ThinkPad Edge E530",
>> -	.matches = {
>> -		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> -		     DMI_MATCH(DMI_PRODUCT_VERSION, "3259A2G"),
>> -		},
>> -	},
>> -	{
>> -	.callback = dmi_disable_osi_win8,
>> -	.ident = "ThinkPad Edge E530",
>> -	.matches = {
>> -		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> -		     DMI_MATCH(DMI_PRODUCT_VERSION, "3259CTO"),
>> -		},
>> -	},
>> -	{
>> -	.callback = dmi_disable_osi_win8,
>> -	.ident = "ThinkPad Edge E530",
>> -	.matches = {
>> -		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> -		     DMI_MATCH(DMI_PRODUCT_VERSION, "3259HJG"),
>> -		},
>> -	},
>> -	{
>> -	.callback = dmi_disable_osi_win8,
>> -	.ident = "Acer Aspire V5-573G",
>> -	.matches = {
>> -		     DMI_MATCH(DMI_SYS_VENDOR, "Acer Aspire"),
>> -		     DMI_MATCH(DMI_PRODUCT_VERSION, "V5-573G/Dazzle_HW"),
>> -		},
>> -	},
>> -	{
>> -	.callback = dmi_disable_osi_win8,
>> -	.ident = "Acer Aspire V5-572G",
>> -	.matches = {
>> -		     DMI_MATCH(DMI_SYS_VENDOR, "Acer Aspire"),
>> -		     DMI_MATCH(DMI_PRODUCT_VERSION, "V5-572G/Dazzle_CX"),
>> -		},
>> -	},
>> -	{
>> -	.callback = dmi_disable_osi_win8,
>> -	.ident = "ThinkPad T431s",
>> -	.matches = {
>> -		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> -		     DMI_MATCH(DMI_PRODUCT_VERSION, "20AACTO1WW"),
>> -		},
>> -	},
>> -	{
>> -	.callback = dmi_disable_osi_win8,
>> -	.ident = "ThinkPad T430",
>> -	.matches = {
>> -		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> -		     DMI_MATCH(DMI_PRODUCT_VERSION, "2349D15"),
>> -		},
>> -	},
>> -
>> -	/*
>>  	 * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
>>  	 * Linux ignores it, except for the machines enumerated below.
>>  	 */
>> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
>> index 48146fc..e7a1190 100644
>> --- a/drivers/acpi/video.c
>> +++ b/drivers/acpi/video.c
>> @@ -457,18 +457,58 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>>  	},
>>  	{
>>  	 .callback = video_set_use_native_backlight,
>> -	 .ident = "ThinkPad T430s",
>> +	 .ident = "ThinkPad X230",
>>  	 .matches = {
>>  		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> -		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T430s"),
>> +		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X230"),
>> +		},
>> +	},
>> +	{
>> +	.callback = video_set_use_native_backlight,
>> +	.ident = "ThinkPad T430",
>> +	.matches = {
>> +		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> +		     DMI_MATCH(DMI_PRODUCT_VERSION, "2349D15"),
>>  		},
>>  	},
>>  	{
>>  	 .callback = video_set_use_native_backlight,
>> -	 .ident = "ThinkPad X230",
>> +	 .ident = "ThinkPad T430s",
>>  	 .matches = {
>>  		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> -		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X230"),
>> +		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T430s"),
>> +		},
>> +	},
>> +	{
>> +	.callback = video_set_use_native_backlight,
>> +	.ident = "ThinkPad T431s",
>> +	.matches = {
>> +		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> +		     DMI_MATCH(DMI_PRODUCT_VERSION, "20AACTO1WW"),
>> +		},
>> +	},
>> +	{
>> +	.callback = video_set_use_native_backlight,
>> +	.ident = "ThinkPad Edge E530",
>> +	.matches = {
>> +		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> +		     DMI_MATCH(DMI_PRODUCT_VERSION, "3259A2G"),
>> +		},
>> +	},
>> +	{
>> +	.callback = video_set_use_native_backlight,
>> +	.ident = "ThinkPad Edge E530",
>> +	.matches = {
>> +		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> +		     DMI_MATCH(DMI_PRODUCT_VERSION, "3259CTO"),
>> +		},
>> +	},
>> +	{
>> +	.callback = video_set_use_native_backlight,
>> +	.ident = "ThinkPad Edge E530",
>> +	.matches = {
>> +		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> +		     DMI_MATCH(DMI_PRODUCT_VERSION, "3259HJG"),
>>  		},
>>  	},
>>  	{
>> @@ -545,6 +585,22 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>>  	},
>>  	{
>>  	.callback = video_set_use_native_backlight,
>> +	.ident = "Acer Aspire V5-572G",
>> +	.matches = {
>> +		     DMI_MATCH(DMI_SYS_VENDOR, "Acer Aspire"),
>> +		     DMI_MATCH(DMI_PRODUCT_VERSION, "V5-572G/Dazzle_CX"),
>> +		},
>> +	},
>> +	{
>> +	.callback = video_set_use_native_backlight,
>> +	.ident = "Acer Aspire V5-573G",
>> +	.matches = {
>> +		     DMI_MATCH(DMI_SYS_VENDOR, "Acer Aspire"),
>> +		     DMI_MATCH(DMI_PRODUCT_VERSION, "V5-573G/Dazzle_HW"),
>> +		},
>> +	},
>> +	{
>> +	.callback = video_set_use_native_backlight,
>>  	.ident = "HP ProBook 4340s",
>>  	.matches = {
>>  		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
>> @@ -609,6 +665,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
>>  		DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 8780w"),
>>  		},
>>  	},
>> +	{
>> +	.callback = video_set_use_native_backlight,
>> +	.ident = "ASUS Zenbook Prime UX31A",
>> +	.matches = {
>> +		     DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>> +		     DMI_MATCH(DMI_PRODUCT_NAME, "UX31A"),
>> +		},
>> +	},
>>  	{}
>>  };
>>  
>>
> 
