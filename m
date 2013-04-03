From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] ACPI: Disable Windows 8 compatibility for some Lenovo
 ThinkPads
Date: Wed, 03 Apr 2013 15:27:46 +0800
Message-ID: <515BD9F2.4010001@intel.com>
References: <1360599681-24781-1-git-send-email-seth.forshee@canonical.com> <5158E8A0.3050904@intel.com> <20130401130340.GA3269@thinkpad-t410> <515AA007.1050305@intel.com> <20130402130000.GA12381@thinkpad-t410> <515BD48B.7000901@bjencks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57887 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762754Ab3DCH0b (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 3 Apr 2013 03:26:31 -0400
In-Reply-To: <515BD48B.7000901@bjencks.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ben Jencks <ben@bjencks.net>
Cc: Seth Forshee <seth.forshee@canonical.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, joeyli <jlee@suse.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Danny Baumann <dannybaumann@web.de>

On 04/03/2013 03:04 PM, Ben Jencks wrote:
> On 04/02/2013 09:00 AM, Seth Forshee wrote:
>> On Tue, Apr 02, 2013 at 05:08:23PM +0800, Aaron Lu wrote:
>>> On 04/01/2013 09:03 PM, Seth Forshee wrote:
>>>> On Mon, Apr 01, 2013 at 09:53:36AM +0800, Aaron Lu wrote:
>>>>> On 02/12/2013 12:21 AM, Seth Forshee wrote:
>>>>>> The AML implementation for brightness control on several ThinkPads
>>>>>> contains a workaround to meet a Windows 8 requirement of 101 brightness
>>>>>> levels [1]. The implementation is flawed, as only 16 of the brighness
>>>>>> values reported by _BCL affect a change in brightness. _BCM silently
>>>>>> discards the rest of the values. Disabling Windows 8 compatibility on
>>>>>> these machines reverts them to the old behavior, making _BCL only report
>>>>>> the 16 brightness levels which actually work. Add a quirk to do this
>>>>>> along with a dmi callback to disable Win8 compatibility.
>>>>>
>>>>> If we disable the _BQC(i.e. set cap._BQC=0) for these systems, will the
>>>>> problem go away? If so, I think perhaps we can put these systems into a
>>>>> _BQC quirk table and set cap._BQC=0 for them.
>>>>
>>>> That helps a little, but we're still left with only 16 of the 101
>>>> brightness levels causing any change in brightness. The firmware isn't
>>>> rounding the "bad" values or anything like that; it just silently
>>>> ignores them.
>>>
>>> I really wondered, how Windows handled this, it should have the same
>>> problem, unless they are not using the acpi video interface?
>>
>> I can only guess.
>>
>> I think I remember reading that Windows 8 does smooth backlight
>> transitions, so it may well hit every intermediate brightness value.
>> Lenovo could also be supplying a driver which rounds values to the
>> nearest working value or uses some other interface or something else.
> 
> Just checked; Windows 8 doesn't use the ACPI interface. It seems to have
> access to at least 100 distinct brightness levels.
> 
> I'd guess it's using the same interface as
> /sys/class/backlight/intel_backlight, which on my system has a
> max_brightness of 4438 and all the values seem to be actually distinct,
> if not necessarily discernible to the naked eye.

Thanks for the information.

If all these affected systems have gpu driver's interface, I think we
can simply add them to the video_detect_dmi_table so that no acpi
backlight interface will be created for them, and gpu's interface will
be used by user space and hotkey processing can still be handled by acpi
video driver.

Best regards,
Aaron

