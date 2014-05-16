From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: RFC: Cleanup firmware backlight control method selection
Date: Fri, 16 May 2014 17:06:17 +0800
Message-ID: <5375D509.60102@intel.com>
References: <53748332.50909@redhat.com> <20140515222938.GA29253@taihen.jp> <5375C6F7.7090305@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49871 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751233AbaEPJGW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 May 2014 05:06:22 -0400
In-Reply-To: <5375C6F7.7090305@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Mattia Dongili <malattia@linux.it>
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org

On 05/16/2014 04:06 PM, Hans de Goede wrote:
> Hi,
> 
> On 05/16/2014 12:29 AM, Mattia Dongili wrote:
>> On Thu, May 15, 2014 at 11:04:50AM +0200, Hans de Goede wrote:
>>> Hi All,
>>>
>>> There are various issues with how the linux kernel currently select which
>>> firmware backlight control (*) method to use:
>>>
>>> 1) There are various module loading ordering issues, leading to different
>>> behavior depending on module load ordering:
>>>
>>> * http://www.spinics.net/lists/linux-acpi/msg50443.html
>>> * Sometimes we register and immediately unregister the acpi_video# backlight
>>>   devices, some ACPI implementations don't like this, so we've special
>>>   quirks to avoid the register + unregister on some machines
>>>
>>> 2) There are 2 main kernel commandline options involved acpi_backlight and
>>> video.use_native_backlight. With the latter only working if certain firmware
>>> checks succeed *and* the former has the right value. This is confusing not
>>> only for end users but also for people trying to read the code in question.
>>> Note some vendor specific firmware backlight drivers, ie thinkpad_acpi.c
>>> have their own related options, leading to 3 kernel cmdline options coming
>>> into play.
>>>
>>> 3) We have quirks everywhere. I'm afraid we cannot get rid of these, but
>>> at least we should try to clean up where they live and how they interact
>>> with each other. acpi_backlight=vendor quirks mostly live in vendor specific
>>> firmware backlight drivers. But we also have a couple in acpi/video_detect.c.
>>> video.use_native_backlight=1 quirks otoh live in acpi/video.c.
>>>
>>> In the end all these options and quirks all work together in a complicated
>>> manor to achieve one simple goal: decide which firmware interface to use
>>> for backlight control (*). Which comes down to choosing between the
>>> following 3 options:
>>>
>>> 1 Native (raw) backlight control (so no firmware backlight control)
>>> 2 Control by the standard acpi-video firmware backlight driver
>>> 3 Control by a vendor specific firmware backlight driver
>>>
>>> So I would like to propose to give the acpi_backlight= kernel commandline
>>> option which currently accepts values "vendor" and "video" a third value
>>> "native", and to get rid of the video.use_native_backlight option.
>>
>> the "acpi_" prefix here sounds inappropriate at this point. And
>> descending from that, shouldn't a mechanism like you describe being
>> implemented in the backlight subsystem?
> 
> This is only a problem with crazy PC's which have multiple firmware
> API's (both standardized and custom ACPI) to control the backlight, which
> also are sometimes all broken. So this really is an acpi thing, and I believe
> this should stay in acpi/video_detect.c where it already lives, I just think
> the video.use_native_backlight option which clearly interacts with this needs
> to be moved to acpi/video_detect.c too.

The acpi_backlight= is used to tell the ACPI video module and the
platform module, who should create a backlight control interface. Since
the two modules both use ACPI to do the backlight control, hence the acpi
prefix in the cmdline option(my personal explanation :-). The
video.use_native_backlight is introduced to solve Win8 problem and
involves the third interface, raw. I agree that the acpi_backlight= and
video.use_native_backlight is confusing, I prefer the
backlight=platform/firmware/raw cmdline option if we can get rid of the
legacy.

> Not sure if you're referring to the above discussion here, or to my remark
> about hotkey issues, so let me answer both:
> 
> * As for why we cannot simply register all firmware backlight drivers
> and let userspace figure things out. There are 2 reasons:
> 1) Userspace will pick the first firmware driver it sees, to avoid this
> causing issues we've historically always registered only one. So we're
> stuck with this approach to avoid causing regressions

We shouldn't expose non-working interface from the kernel side, but if
they all work, I don't think we should hide them. The i915 driver always
creates its backlight control interface no matter what others did, I
think this is the right thing as long as it makes sure it's not exposing
a broken one. The vendor and video driver don't do things this way may
be that there is little chance they will work well at the same time.

> 2) Having multiple pieces of firmware code frob the same hardware seems
> like a really really bad idea.
> 
> * As for the hotkeys issue, the problem is actually very much the same as
> with the backlight control. laptop brightness hotkeys tend to generate 3
> events for each press:
> 1) A ps2 atkbd scancode
> 2) an acpi-video event
> 3) a vendor-wmi event.

What a mess...
I thought the WMI event could be stopped by calling some ACPI control
method and the vendor driver may already do this if it decides the
backlight control should be done by ACPI video. For the scancode and
video event, I thought it is the EC that does the decision - it should
either generate a scancode or sends out an ACPI notification to the
video output device and then have the video driver to send the event to
user space, but not both! But yes, things can go wrong and the worst
thing would be, a hotkey press gives three events as you have described.
I don't know the case for WMI, but the majority ECs seem to work OK in
this regard, i.e. it doesn't generate the two things but only one of them.

Thanks,
Aaron
