From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] ACPI / video: check _DOD list when creating backlight
 device
Date: Thu, 09 Oct 2014 16:27:55 +0800
Message-ID: <5436470B.3030306@intel.com>
References: <542A4949.2020208@intel.com> <1648939.GaN1bonAuX@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:5399 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824AbaJII15 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Oct 2014 04:27:57 -0400
In-Reply-To: <1648939.GaN1bonAuX@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ntrrgc@gmail.com, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On 10/01/2014 04:18 AM, Rafael J. Wysocki wrote:
> On Tuesday, September 30, 2014 02:10:17 PM Aaron Lu wrote:
>> The _DOD method lists which video output device is currently attached so
>> we should only care about them and ignore others. An user recently
>> reported that there are two acpi_video interfaces appeared on his system
>> and one of them doesn't work. From the acpidump, it is found that there
>> are more than one video output devices that have _BCM control method but
>> the _DOD lists only one of them. So this patch checks if the video output
>> device is in the _DOD list and will not create backlight device if it is
>> not in the list. Also, we consider the broken _DOD case(reflected by the
>> video->attached_count is 0) and do not change behaviour for those broken
>> _DOD systems.
>>
>> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=84111
>> Reported-and-tested-by: ntrrgc@gmail.com
>> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> 
> This looks reasonable to me, but I'm a little afraid that it may break
> systems which forget to list valid interfaces in the _DOD.

Indeed, this is possible.

> 
> For this reason, I'm queuing this up for 3.18, but not for -stable.

Agree.

> 
> We can request a backport after a while when we're reasonably sure that
> there are no regressions resulting from this.

Sounds good, thanks for taking care of this!

Regards,
Aaron

> 
>> ---
>>  drivers/acpi/video.c | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
>> index 7285c7f9a935..807a88a0f394 100644
>> --- a/drivers/acpi/video.c
>> +++ b/drivers/acpi/video.c
>> @@ -1154,6 +1154,23 @@ acpi_video_device_bind(struct acpi_video_bus *video,
>>  	}
>>  }
>>  
>> +static bool acpi_video_device_in_dod(struct acpi_video_device *device)
>> +{
>> +	struct acpi_video_bus *video = device->video;
>> +	int i;
>> +
>> +	/* If we have a broken _DOD, no need to test */
>> +	if (!video->attached_count)
>> +		return true;
>> +
>> +	for (i = 0; i < video->attached_count; i++) {
>> +		if (video->attached_array[i].bind_info == device)
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>>  /*
>>   *  Arg:
>>   *	video	: video bus device
>> @@ -1593,6 +1610,15 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
>>  	static int count;
>>  	char *name;
>>  
>> +	/*
>> +	 * Do not create backlight device for video output
>> +	 * device that is not in the enumerated list.
>> +	 */
>> +	if (!acpi_video_device_in_dod(device)) {
>> +		dev_dbg(&device->dev->dev, "not in _DOD list, ignore\n");
>> +		return;
>> +	}
>> +
>>  	result = acpi_video_init_brightness(device);
>>  	if (result)
>>  		return;
>>
> 

