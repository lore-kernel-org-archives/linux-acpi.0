From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFC PATCH] acpi: mv models with win8 brightness problems from
 win8 blacklist to use_native_backlight
Date: Thu, 01 May 2014 12:24:39 +0200
Message-ID: <536220E7.7010805@redhat.com>
References: <1398865726-15264-1-git-send-email-hdegoede@redhat.com> <1830718.4HYQu7bYo0@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:13212 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838AbaEAKYt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 May 2014 06:24:49 -0400
In-Reply-To: <1830718.4HYQu7bYo0@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Vincent Gerris <vgerris@gmail.com>, linux-acpi@vger.kernel.org

Hi,

On 04/30/2014 09:56 PM, Rafael J. Wysocki wrote:
> On Wednesday, April 30, 2014 03:48:46 PM Hans de Goede wrote:
>> When the windows8 related backlight problems became evident, 2 approaches
>> were follow in paralellel, one was to stop claiming to be windows 8 / 2012,
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
> Since commit 170269a9d3c0 (ACPI / video: Default to using native backlight
> control on Windows 8 systems) in linux-next is effectively removing the black
> list from video.c, I guess what you really would like to do would be to drop
> the items from blacklist.c.  If so, please submit a patch to remove them on
> top of commit 170269a9d3c0.

Right, the RFC was mostly for discussing what to do in case commit 170269a9d3c0
does not work out well and ends up being reverted (as this was tried before and
got reverted pretty quickly).

I'll send a patch just removing all the entries for -next for now, and I'll try
to remember that we need a patch like this RFC if we end up reverting.

Regards,

Hans

> 
> Thanks!
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
>> index c688b77..6fd015b 100644
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
>> @@ -529,6 +569,22 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
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
>> @@ -585,6 +641,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
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
