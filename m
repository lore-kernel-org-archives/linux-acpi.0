From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH 1/2] ACPI / video: Fix initial level validity test
Date: Thu, 07 Nov 2013 08:25:46 +0800
Message-ID: <527ADE0A.7060800@intel.com>
References: <52799553.7020406@intel.com> <3791074.PzqEb6VMU7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:21518 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752767Ab3KGAZC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Nov 2013 19:25:02 -0500
In-Reply-To: <3791074.PzqEb6VMU7@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Danny Baumann <dannybaumann@web.de>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On 11/07/2013 06:03 AM, Rafael J. Wysocki wrote:
> On Wednesday, November 06, 2013 09:03:15 AM Aaron Lu wrote:
>> When testing if the firmware's initial value is valid, we should use
>> the corrected level value instead of the raw value returned from
>> firmware.
>>
>> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
>> Cc: Danny Baumann <dannybaumann@web.de>
>> Cc: stable <stable@kernel.org>
> 
> Any pointers to bug reports, BZ entries, etc?

This patch doesn't solve any bugs, I found the problem while preparing
patch 2/2. Now I remembered some stable rule that patch that solves a
potential bug isn't acceptable, so the stable tag should be dropped.

Thanks,
Aaron

> 
>> ---
>>  drivers/acpi/video.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
>> index 38c3a28d6392..bf521b36c2f9 100644
>> --- a/drivers/acpi/video.c
>> +++ b/drivers/acpi/video.c
>> @@ -856,7 +856,7 @@ acpi_video_init_brightness(struct acpi_video_device *device)
>>  		 * or an index). Set the backlight to max_level in this case.
>>  		 */
>>  		for (i = 2; i < br->count; i++)
>> -			if (level_old == br->levels[i])
>> +			if (level == br->levels[i])
>>  				break;
>>  		if (i == br->count)
>>  			level = max_level;
>>

