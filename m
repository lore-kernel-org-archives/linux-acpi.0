From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 3/3] acpi-video: change acpi-video brightness_switch_enabled
 default to 0
Date: Tue, 06 May 2014 14:46:17 +0200
Message-ID: <5368D999.9080700@redhat.com>
References: <1399282690-5381-1-git-send-email-hdegoede@redhat.com> <1399282690-5381-3-git-send-email-hdegoede@redhat.com> <53684260.1050806@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:5428 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757646AbaEFMq3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 May 2014 08:46:29 -0400
In-Reply-To: <53684260.1050806@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>, Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: edm <fuffi.il.fuffo@gmail.com>, Balint Szigeti <balint.szgt@gmail.com>, AnAkkk <anakin.cs@gmail.com>, lou.cardone@gmail.com, linux-acpi@vger.kernel.org

Hi,

On 05/06/2014 04:01 AM, Aaron Lu wrote:
> On 05/05/2014 05:38 PM, Hans de Goede wrote:
>> acpi-video is unique in that it not only generates brightness up/down
>> keypresses, but also (sometimes) actively changes the brightness itself.
>>
>> This presents an inconsistent kernel interface to userspace, basically there
>> are 2 different scenarios, depending on the laptop model:
>>
>> 1) On some laptops a brightness up/down keypress means: show a brightness osd
>> with the current brightness, iow it is a brightness has changed notification.
>>
>> 2) Where as on (a lot of) other laptops it means a brightness up/down key was
>> pressed, deal with it.
>>
>> Most of the desktop environments interpret any press as in scenario 2, and
>> change the brightness up / down as a response to the key events, causing it
>> to be changed twice, once by acpi-video and once by the DE.
>>
>> With the new default for video.use_native_backlight we will be moving even
>> more laptops over to behaving as in scenario 2. Making the remaining laptops
>> even more of a weird exception. Also note that it is hard to detect scenario
>> 1 properly in userspace, and AFAIK none of the DE-s deals with it.
>>
>> Therefor this commit changes the default of brightness_switch_enabled to 0
>> making its behavior consistent with all the other backlight drivers.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Reviewed-by: Aaron Lu <aaron.lu@intel.com>
> 
> Note that the Documentation/kernel-parameters.txt has to be modified
> accordingly to change the default value for video.brightness_switch_enabled
> to 0.

Good one, I'll send a v2 with this fixed.

Regards,

Hans
