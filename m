From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH 2.6.26-rc] ACPI Thermal Zone driver breaks lm-sensors 2
 userspace
Date: Mon, 23 Jun 2008 20:17:25 -0600
Message-ID: <48605935.5070407@shaw.ca>
References: <fa.4PGqX9CuLbgiTimfCcon+PlAMxk@ifi.uio.no>
 <fa.PWu620xEt5OlYdOezvRtQriuNjM@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:54419 "EHLO
	pd3mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbYFXCSA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jun 2008 22:18:00 -0400
In-reply-to: <fa.PWu620xEt5OlYdOezvRtQriuNjM@ifi.uio.no>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Rene Herman <rene.herman@keyaccess.nl>, Linus Torvalds <torvalds@linux-foundation.org>, Hans de Goede <j.w.r.degoede@hhs.nl>, Zhang Rui <rui.zhang@intel.com>, Jean Delvare <khali@linux-fr.org>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, Linux Kernel <linux-kernel@vger.kernel.org>

Mark M. Hoffman wrote:
> Linus, Rene, et al:
> 
> * Rene Herman <rene.herman@keyaccess.nl> [2008-06-23 17:06:14 +0200]:
>> drivers/thermal/thermal_sys.c |    2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
>> index 6098787..c21e03c 100644
>> --- a/drivers/thermal/thermal_sys.c
>> +++ b/drivers/thermal/thermal_sys.c
>> @@ -357,7 +357,7 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
>>
>> 	INIT_LIST_HEAD(&hwmon->tz_list);
>> 	strlcpy(hwmon->type, tz->type, THERMAL_NAME_LENGTH);
>> -	hwmon->device = hwmon_device_register(NULL);
>> +	hwmon->device = hwmon_device_register(&tz->device);
>> 	if (IS_ERR(hwmon->device)) {
>> 		result = PTR_ERR(hwmon->device);
>> 		goto free_mem;
> 
> NACK.
> 
> 1) The bug is in libsensors (2.10), not the kernel.

This doesn't matter. Breaking userspace in such a fashion is severely 
frowned upon unless essentially unavoidable, even if it is just 
triggering a bug.

> 
> - but more importantly -
> 
> 2) This patch is broken.

You didn't indicate what was wrong with the patch.
