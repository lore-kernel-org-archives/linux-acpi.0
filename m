From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: RFC: Cleanup firmware backlight control method selection
Date: Fri, 16 May 2014 10:06:15 +0200
Message-ID: <5375C6F7.7090305@redhat.com>
References: <53748332.50909@redhat.com> <20140515222938.GA29253@taihen.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:25077 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754997AbaEPIGh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 May 2014 04:06:37 -0400
In-Reply-To: <20140515222938.GA29253@taihen.jp>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Aaron Lu <aaron.lu@intel.com>, Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org

Hi,

On 05/16/2014 12:29 AM, Mattia Dongili wrote:
> On Thu, May 15, 2014 at 11:04:50AM +0200, Hans de Goede wrote:
>> Hi All,
>>
>> There are various issues with how the linux kernel currently select which
>> firmware backlight control (*) method to use:
>>
>> 1) There are various module loading ordering issues, leading to different
>> behavior depending on module load ordering:
>>
>> * http://www.spinics.net/lists/linux-acpi/msg50443.html
>> * Sometimes we register and immediately unregister the acpi_video# backlight
>>   devices, some ACPI implementations don't like this, so we've special
>>   quirks to avoid the register + unregister on some machines
>>
>> 2) There are 2 main kernel commandline options involved acpi_backlight and
>> video.use_native_backlight. With the latter only working if certain firmware
>> checks succeed *and* the former has the right value. This is confusing not
>> only for end users but also for people trying to read the code in question.
>> Note some vendor specific firmware backlight drivers, ie thinkpad_acpi.c
>> have their own related options, leading to 3 kernel cmdline options coming
>> into play.
>>
>> 3) We have quirks everywhere. I'm afraid we cannot get rid of these, but
>> at least we should try to clean up where they live and how they interact
>> with each other. acpi_backlight=vendor quirks mostly live in vendor specific
>> firmware backlight drivers. But we also have a couple in acpi/video_detect.c.
>> video.use_native_backlight=1 quirks otoh live in acpi/video.c.
>>
>> In the end all these options and quirks all work together in a complicated
>> manor to achieve one simple goal: decide which firmware interface to use
>> for backlight control (*). Which comes down to choosing between the
>> following 3 options:
>>
>> 1 Native (raw) backlight control (so no firmware backlight control)
>> 2 Control by the standard acpi-video firmware backlight driver
>> 3 Control by a vendor specific firmware backlight driver
>>
>> So I would like to propose to give the acpi_backlight= kernel commandline
>> option which currently accepts values "vendor" and "video" a third value
>> "native", and to get rid of the video.use_native_backlight option.
> 
> the "acpi_" prefix here sounds inappropriate at this point. And
> descending from that, shouldn't a mechanism like you describe being
> implemented in the backlight subsystem?

This is only a problem with crazy PC's which have multiple firmware
API's (both standardized and custom ACPI) to control the backlight, which
also are sometimes all broken. So this really is an acpi thing, and I believe
this should stay in acpi/video_detect.c where it already lives, I just think
the video.use_native_backlight option which clearly interacts with this needs
to be moved to acpi/video_detect.c too.

>> This would be combined with a major cleanup of the existing code for
>> firmware backlight control method selection:
>>
>> 1) Replace the ACPI_VIDEO_BACKLIGHT_* flags with an enum listing the 3 options
>> 2) Replace the acpi_video_support variable with
>>    acpi_backlight_method_cmdline and acpi_backlight_method_dmi variables,
>>    both initialzed to -1
>> 3) Add an acpi_backlight_method() function which will:
>>   - return acpi_backlight_method_cmdline if not -1; else
>>   - return acpi_backlight_method_dmi if not -1; else
>>   - return ACPI_BACKLIGHT_NATIVE if acpi_osi_is_win8(); else
>>   - return ACPI_BACKLIGHT_VIDEO if supported; else
>>   - return ACPI_BACKLIGHT_VENDOR
>> 4) Have all drivers that use acpi_video_dmi_promote_vendor move their
>>    quirks for this to acpi/video_detect.c, removing the need for them to
>>    call acpi_video_dmi_promote_vendor() and acpi_video_unregister(), removing
>>    the load ordering issues and removing them depending on video.ko
> 
> I think the whole idea of promote/demote_vendor was to avoid adding
> vendor specific quirks to acpi's video code. If it was the right
> implementation different story, but it sure sounded like a sensble idea.
> We do have platform drivers that know if they should control backlight
> or let it do to ACPI or even the native driver. Quirks in the patform
> specific code _is_ IMO the right place to have those quirks.

The problem with this is that it causes module load ordering issues where
we get the acpi_video# device registered first, then a vendor specific
custom acpi backlight driver (ie thinkpad_acpi) loads and unregisters it
again. This is ugly and on some models makes the firmware unhappy
(we currently have quirks for these models to work around this).

But I've recently learned that since for determining which firmware method to
load / expose we need to know if the video driver will register a raw backlight
interface or not, which introduces similar issues. So there is no way to
avoid these ordering issues, so I agree that it is best to keep the quirks
in the vendor specific acpi extension drivers where possible.

> 
>> 5) Switch all drivers from acpi_video_backlight_support() to
>>    acpi_backlight_method()
>>
>> The plan would be to do 1-3 in a single patch and ASAP and then do 4 and 5
>> driver by driver, and once done remove acpi_video_dmi_promote_vendor() and
>> acpi_video_backlight_support(), and mark acpi_video_register /
>> acpi_video_unregister as "only for i915 use".
>>
>> Regards,
>>
>> Hans
>>
>>
>> *) Note I'm only talking about controlling the actual brightness of the
>> backlight, not detecting brighness/backlight hotkey presses, there are
>> similar issues there. But I believe that that should be treated as an
>> orthogonal problem which should be fixed independently of this.
> 
> Maybe I'm missing some recent evolution but except for some special
> cases, backlight hotkeys generally result in an input event sent to
> userspace and it then becomese a userspace problem to choose which
> interface to use.

Not sure if you're referring to the above discussion here, or to my remark
about hotkey issues, so let me answer both:

* As for why we cannot simply register all firmware backlight drivers
and let userspace figure things out. There are 2 reasons:
1) Userspace will pick the first firmware driver it sees, to avoid this
causing issues we've historically always registered only one. So we're
stuck with this approach to avoid causing regressions
2) Having multiple pieces of firmware code frob the same hardware seems
like a really really bad idea.

* As for the hotkeys issue, the problem is actually very much the same as
with the backlight control. laptop brightness hotkeys tend to generate 3
events for each press:
1) A ps2 atkbd scancode
2) an acpi-video event
3) a vendor-wmi event.

1) may be mapped to generate input events through /lib/udev/hwdb.d/60-keyboard.hwdb
2) will generate input events if the acpi-video driver is registered
   (independent of it also exporting a backlight control interface)
3) may or may not generate events depending on the vendor specific driver

I know of at least one laptop where all 3 methods are hooked up, causing
the brightness to go down 3 levels for each keypress. This is something else
wrt backlight control which we clearly need to fix, to ensure that we only
send one input event per key press.

> Last, just to add another use case, vaio laptops in specific
> configurations require both ACPI and vendor backlight to be registered
> as the former will notify the latter to change the backlight rather than
> doing it itself. It's explained here (with a potential implementation):
> http://www.spinics.net/lists/platform-driver-x86/msg05191.html

Hmm, that sounds like something which is going to turn very ugly very soon.
Have tried using acpi_backlight=vendor, so that the acpi-video driver will
only catch events and not try to do any backlight control? Then the
vaio driver can register its own backlight device, and userspace gets the
event from the acpi-video driver, and can change the brightness accordingly
using the vaio driver backlight device.

Or are you trying to make the buttons work without a userspace component
being involved? Please forget about that, that ship has sailed a long time
ago. acpi-video used to that, but it actually causes more issues then it
fixes, and it is inconsistent with how things work on many other laptops.

Userspace simply does not deal with this at all, it will still respond to
the keypresses anyways, and you get the backlight level changing multiple
steps at once for each keypress.

Anyways I really think you need to find a different solution for this,
simply have the one part which you now want to do the signalling only
generate input events, and have the part with the working backlight control
be the only one to register a firmware backlight device.

Regards,

Hans
