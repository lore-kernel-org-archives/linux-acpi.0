From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: RFC: Cleanup firmware backlight control method selection
Date: Mon, 19 May 2014 14:18:37 +0200
Message-ID: <5379F69D.8050402@redhat.com>
References: <53748332.50909@redhat.com> <20140515222938.GA29253@taihen.jp> <5375C6F7.7090305@redhat.com> <20140518232442.GA2060@taihen.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20140518232442.GA2060@taihen.jp>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Aaron Lu <aaron.lu@intel.com>, Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On 05/19/2014 01:24 AM, Mattia Dongili wrote:
> On Fri, May 16, 2014 at 10:06:15AM +0200, Hans de Goede wrote:

<snip>

>> This is only a problem with crazy PC's which have multiple firmware
>> API's (both standardized and custom ACPI) to control the backlight, which
>> also are sometimes all broken. So this really is an acpi thing, and I believe
>> this should stay in acpi/video_detect.c where it already lives, I just think
>> the video.use_native_backlight option which clearly interacts with this needs
>> to be moved to acpi/video_detect.c too.
>
> I didn't realize the use_native_backlight option was in acpi/video.c.
> Nevemind what I said, leave this crazyness to stay in the acpi world
> only then.
> Don't you still have ordering issues though? can the raw device be
> loaded after video_detect runs?

Yes it can, so I've already withdrawn my part of the proposal to move
all the quirks to acpi/video_detect.c since we will simply have to
learn to live with the ordering issues it seems. A solution for dealing
with the raw interface showing up later is discussed here:

   http://www.spinics.net/lists/stable/msg45563.html
   http://www.spinics.net/lists/stable/msg45977.html

>>>> 3) Add an acpi_backlight_method() function which will:
>>>>   - return acpi_backlight_method_cmdline if not -1; else
>>>>   - return acpi_backlight_method_dmi if not -1; else
>>>>   - return ACPI_BACKLIGHT_NATIVE if acpi_osi_is_win8(); else
> 
> this seems to be a way more wide case than today's code that combines it
> with quirks or the kernel option.

Except for allowing to circumvent the acpi_osi_is_win8() check from
the cmdline / from dmi based quirks this will have 100% the same functionality
as today.

> 
>>>>   - return ACPI_BACKLIGHT_VIDEO if supported; else
>>>>   - return ACPI_BACKLIGHT_VENDOR
> 
> ...
>>>> *) Note I'm only talking about controlling the actual brightness of the
>>>> backlight, not detecting brighness/backlight hotkey presses, there are
>>>> similar issues there. But I believe that that should be treated as an
>>>> orthogonal problem which should be fixed independently of this.
>>>
>>> Maybe I'm missing some recent evolution but except for some special
>>> cases, backlight hotkeys generally result in an input event sent to
>>> userspace and it then becomese a userspace problem to choose which
>>> interface to use.
>>
>> Not sure if you're referring to the above discussion here, or to my remark
>> about hotkey issues, so let me answer both:
>>
>> * As for why we cannot simply register all firmware backlight drivers
>> and let userspace figure things out. There are 2 reasons:
>> 1) Userspace will pick the first firmware driver it sees, to avoid this
>> causing issues we've historically always registered only one. So we're
>> stuck with this approach to avoid causing regressions
> 
> well, in my limited experience I have seen userspace anyway blacklist
> the sony/acpi backlight control for the intel one since it is available
> regardless of acpi and gives (actually used to give) better granularity.

We really don't want this kind of blacklisting in user space, instead if
the interface is broken (or less functional then the alternative) we
should simply not register it at all.

Maybe if we were to redesign all this we would leave all this up to
userspace (so load no backlight driver at all, and let userspace pick one),
but that ship has sailed, so since we're determining what to do in kernel
space now, lets keep it in kernel space and not some crazy mix where
first kernel space does some quirks / blacklisting and then userspace
(depending on which DE also) adds its own magic. Lets not go there please.

<snip vaio discussion, which as said does not belong in this thread>

Regards,

Hans
