From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [REGRESSION] [v2] ACPI / video: Default lcd_only to true on Win8
 ready and newer machines
Date: Mon, 16 Apr 2018 13:07:50 +0200
Message-ID: <18c72a70-577f-358e-fb82-095b75157a29@redhat.com>
References: <20171223184147.12016-1-hdegoede@redhat.com>
 <20180414230746.GA29537@saruman>
 <d5ff7ff3-4fa1-0f8c-e0a9-6779b9185e14@redhat.com>
 <20180415225403.GA6373@jamesdev>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180415225403.GA6373@jamesdev>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: James Hogan <jhogan@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, stable@vger.kernel.org, Sasha Levin <alexander.levin@microsoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

On 16-04-18 00:54, James Hogan wrote:
> On Sun, Apr 15, 2018 at 02:04:26PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 15-04-18 01:07, James Hogan wrote:
>>> On Sat, Dec 23, 2017 at 07:41:47PM +0100, Hans de Goede wrote:
>>>> We're seeing a lot of bogus backlight interfaces on newer machines without
>>>> a LCD such as desktops, servers and HDMI sticks. This causes userspace to
>>>> show a non-functional brightness slider in e.g. the GNOME3 system menu,
>>>> which is undesirable. More in general we should simply just not register
>>>> a non functional backlight interface.
>>>>
>>>> Checking the lcd flag causes the bogus acpi_video backlight interfaces to
>>>> go away (on the machines this was tested on).
>>>>
>>>> This commit enables the lcd_only option by default on any machines which
>>>> are win8 ready, fixing this.
>>>>
>>>> This is not entirely without risk of regressions, but video_detect.c
>>>> already prefers native-backlight interfaces over the acpi_video one
>>>> on win8 ready machines, calling acpi_video_unregister_backlight() as soon
>>>> as a native interface shows up. This is done because the acpi backlight
>>>> interface often is broken on win8 ready machines, because win8 does not
>>>> seem to actually use it.
>>>
>>> This patch (in the form of commit 965736ee654d ("ACPI / video: Default
>>> lcd_only to true on Win8-ready and newer machines") in stable v4.15.17),
>>> breaks backlight control on my 2013 XPS13 laptop.
>>>
>>> It normally uses the acpi backlight device, but after this patch that
>>> device no longer shows up in sysfs.
>>>
>>> This isn't the first time the backlight has gotton broken on this
>>> system, though I think last time it was because the intel backlight
>>> driver got used instead of the ACPI one and that didn't work properly
>>> with it, so it needed a quirk to make it use ACPI instead.
>>>
>>> Is some other quirk needed around here too?
>>
>> Yes looks like it (sigh), but I cannot find an existing quirk for
>> your laptop.
> 
> I did at one point have to revert commit bc0bb9fd1c78 ("drm/i915: remove
> QUIRK_NO_PCH_PWM_ENABLE") for a few kernel releases until 4.3,
> presumably fixed by commit b029e66fa8e3 ("drm/i915: Backlight control
> using CRC PMIC based PWM driver").
> 
>> When you say quirk do you mean you add something to
>> the kernel commandline to work around this?
> 
> No, it was automatic, in the source. I don't know this code well enough
> to know how they got it working.

Weird, if my only_lcd changes impact you then acpi_osi_is_win8()
returns true for you and you should get the intel backlight interface
by default, but maybe the i915 driver somehow detects that that
is not appropriate on your device ... ?

Before I can start working on a quirk to fix this I've some
questions:

1) With recent kernels without the 965736ee654d commit, what is
    the output of "ls /sys/class/backlight" ?

2) What is the output of "ls /sys/class/backlight" after
    commit 965736ee654d ?

3) Can you start a kernel with commit 965736ee654d in there and
    "video.only_lcd=0" on the kernel commandline and verify that
    this fixes backlight control for you ?

>> Normally we would add
>> a dmi based quirk so that future versions automatically do the
>> right thing.  I was looking for the existing quirk so that I
>> could re-use the dmi strings, but I don't see an existing quirk.
>>
>> Can you run:
>>
>> sudo dmidecode > dell-xps13-2013-dmi.log
>>
>> And then send me a *personal* mail with that file attached.
>> It is best to not send this to the list as it will contain you
>> machines serial number and other unique information.
> 
> Will do.

I've received it thanks.

Regards,

Hans
