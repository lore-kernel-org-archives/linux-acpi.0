From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH 5/5] acpi_video: Don't handle ACPI brightness notifications
 by default
Date: Fri, 02 Aug 2013 22:52:09 +0800
Message-ID: <51FBC799.4070204@intel.com>
References: <20130307193812.GD24233@thinkpad-t410> <1362685180-7768-5-git-send-email-seth.forshee@canonical.com> <51FB49E3.50604@intel.com> <1559797.9EdEoD0Bgy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:10577 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751855Ab3HBOvX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 2 Aug 2013 10:51:23 -0400
In-Reply-To: <1559797.9EdEoD0Bgy@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Seth Forshee <seth.forshee@canonical.com>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Ben Jencks <ben@bjencks.net>, joeyli <jlee@suse.com>, Micael Dias <kam1kaz3@gmail.com>, =?UTF-8?B?KiBT?= =?UTF-8?B?QU3DjSAq?= <miaousami@hotmail.com>, Yves-Alexis Perez <corsac@debian.org>

On 08/02/2013 10:41 PM, Rafael J. Wysocki wrote:
> On Friday, August 02, 2013 01:55:47 PM Aaron Lu wrote:
>> On 03/08/2013 03:39 AM, Seth Forshee wrote:
>>> Windows 8 requires all backlight interfaces to report 101 brightness
>>> values, and as a result we're starting to see machines with that many
>>> brightness levels in _BCL. For machines which send these notifications
>>> when the brightness up/down keys are pressed this means a lot of key
>>> presses to get any kind of noticeable change in brightness.
>>>
>>> For a while now we've had the ability to disable in-kernel handling of
>>> notifications via the video.brightness_switch_enabled parameter. Change
>>> this to default to off, and let userspace choose more reasonable
>>> increments for changing the brightness.
>>
>> I just found one more reason for this param to default 0.
> 
> Do you mean video.brightness_switch_enabled?

Yes.

> 
>> We are going to separate the backlight interface control and event
>> notification functionalities of the ACPI video module, it is highly
>> possible a lot of systems will use a combination of the event
>> notification handler and intel_backlight interface. So it doesn't make
>> sense to let video module to do any adjustment on its own if user space
>> has chosen a different interface to use. Actually, it can cause problems
>> as in ASUS's case:
>> https://bugzilla.kernel.org/show_bug.cgi?id=52951
>>
>> The problem there is, on hotkey brightness up, the video module will
>> adjust the brightness level first and since its _BQC is broken, it gets
>> a wrong number(too low or too high or whatever) and then does the _BCM
>> call. The _BCM method works. Then user space picks the intel_backlight
>> to do the adjustment, but since the _BCM already sets a wrong value, the
>> user space's adjustment is affected too. The result is, user has only
>> two visible levels, very low and very high.
>>
>> This only occurs on -rc3, since we removed the
>> acpi_video_verify_backlight_support from acpi_video_switch_brightness
>> function.
> 
> What did we do before -rc2?  Did we address that in any way?

No, before rc2, backlight is broken on that system.

In rc2, we added the win8 patch and a fix patch for the hotkey, then
the ACPI video module's backlight control and in kernel brightness
handling is disabled. With the working hotkey and intel_backlight, rc2
works for the system. Then with the revert in rc3, user needs to choose
intel_backlight in xorg.conf but the in kernel brightness handling from
ACPI video module is back. Since video module is broken, it breaks the
backlight hotkey functionality.

Thanks,
Aaron

> 
>> So either we make this param default to 0, or we make a new
>> function to avoid brightness switch in video module for Win8 systems.
>>
>> I prefer to set this param to 0 by default. What do you guys think?
> 
> That depends on what we did earlier.
> 
> Thanks,
> Rafael
> 
> 

