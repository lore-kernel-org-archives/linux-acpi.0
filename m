From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [RFC 1/3] acpi-video: Add an acpi_video_unregister_backlight
 function
Date: Thu, 15 May 2014 09:48:23 +0800
Message-ID: <53741CE7.402@intel.com>
References: <1399917824-10341-1-git-send-email-hdegoede@redhat.com> <1399917824-10341-2-git-send-email-hdegoede@redhat.com> <53723633.4030709@intel.com> <53733281.6060707@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:8557 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126AbaEOBsZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 May 2014 21:48:25 -0400
In-Reply-To: <53733281.6060707@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Lee Chun-Yi <jlee@suse.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org

On 05/14/2014 05:08 PM, Hans de Goede wrote:
> Hi,
> 
> On 05/13/2014 05:11 PM, Aaron Lu wrote:
>> On 05/13/2014 02:03 AM, Hans de Goede wrote:
>>> -static int acpi_video_bus_register_backlight(struct acpi_video_bus *video)
>>> +static void acpi_video_bus_register_backlight(struct acpi_video_bus *video)
>>>  {
>>>  	struct acpi_video_device *dev;
>>>  
>>> @@ -1851,10 +1851,6 @@ static int acpi_video_bus_register_backlight(struct acpi_video_bus *video)
>>>  	list_for_each_entry(dev, &video->video_device_list, entry)
>>>  		acpi_video_dev_register_backlight(dev);
>>>  	mutex_unlock(&video->device_list_lock);
>>> -
>>> -	video->pm_nb.notifier_call = acpi_video_resume;
>>> -	video->pm_nb.priority = 0;
>>> -	return register_pm_notifier(&video->pm_nb);
>>
>> Hmm, I don't understand this. The pm notifier is used to restore
>> backlight level on system resume, so should be there when we have
>> created the backlight interface and gone when we unregistered the
>> backlight interface. It doesn't have anything to do with hotkey
>> processing.
> 
> A valid point, I did things this way because I wanted the new
> acpi_video_unregister_backlight to result in the same behavior as
> having set the acpi_video=vendor / called acpi_video_dmi_promote_vendor()
> before acpi_video_register runs.
> 
> So this means undoing what-ever acpi_video_register() does, which it
> would not have done if acpi_video_dmi_promote_vendor() came first.
> 
> If you look at the current code (so without this patch) then
> the pm notifier gets installed unconditionally by
> acpi_video_bus_register_backlight() which gets called unconditionally
> by acpi_video_bus_add(). So even with acpi_video=vendor it still gets
> installed.
> 
> acpi_video=vendor / acpi_video_dmi_promote_vendor() influences
> acpi_video_backlight_support() which only gets called by
> acpi_video_verify_backlight_support() which only gets called by
> acpi_video_dev_register_backlight(). So acpi_video=vendor only causes
> the backlight devices to not register, the pm notifier will still be
> installed. My intend was to behave the same independent of module
> loading / init order hence I moved the pm notifier install / uninstall
> to keep the pm notifier installed when calling the new
> acpi_video_unregister_backlight().
> 
> Looking at the code you're right that this is not really sensible, since
> the acpi_video_resume call done by the notifier will be a nop when there
> are no backlight devices registered.
> 
> So I can split this patch into 2 patches, 1 to not install the pm notifier
> if we're not going to register backlight devices anyways, and a 2nd patch
> adding the new acpi_video_unregister_backlight().
> 
> Does that sound like a plan ?

Yes, sounds great, thanks!

-Aaron
