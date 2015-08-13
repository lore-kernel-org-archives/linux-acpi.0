From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [Intel-gfx] [4.2-rc4] acpi|drm|i915: circular locking dependency: acpi_video_get_backlight_type
Date: Thu, 13 Aug 2015 22:46:57 +0200
Message-ID: <CA+icZUVNru+Rh_-=cY27jRXCU8cjH_onCGHUd9Vu1wamPocbJQ@mail.gmail.com>
References: <CA+icZUWh+qH0KuF7dcc0gJxM9myssapbPbOboeMoc-WjU-TK+A@mail.gmail.com>
	<CA+icZUWitjMzjhLKs+NLAaUdxQxkW7PNZ19HQfmi8oy2qmC1rA@mail.gmail.com>
	<CA+icZUVoUx3qMp7oChVyo8yN6D+Juf3VHqs25aCKShN1czkROw@mail.gmail.com>
	<20150812192620.GN5176@intel.com>
	<55CCAACF.7040109@redhat.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35246 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbbHMUq7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Aug 2015 16:46:59 -0400
In-Reply-To: <55CCAACF.7040109@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Airlie <airlied@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, Aug 13, 2015 at 4:33 PM, Hans de Goede <hdegoede@redhat.com> wr=
ote:
> Hi,
>
> On 12-08-15 21:26, Ville Syrj=C3=A4l=C3=A4 wrote:
>>
>> On Mon, Aug 10, 2015 at 08:29:00PM +0200, Sedat Dilek wrote:
>>>
>>> On Sat, Aug 1, 2015 at 2:23 PM, Sedat Dilek <sedat.dilek@gmail.com>
>>> wrote:
>>>>
>>>> On Mon, Jul 27, 2015 at 12:33 AM, Sedat Dilek <sedat.dilek@gmail.c=
om>
>>>> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> this my first build of a 4.2-rcN Linux-kernel and I see this...
>>>>>
>>>>
>>>> Just FYI:
>>>>
>>>> I am *not* seeing this with drm-intel-nightly from below url.
>>>>
>>>> Also, I plan to test Linux v4.2-rc5.
>>>>
>>>
>>> [ CC Linus ]
>>>
>>> Knock Knock Knock.
>>>
>>> This issue still remains here (with CONFIG_DRM_I915=3Dm)...
>>>
>>> [   18.269792] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> [   18.269798] [ INFO: possible circular locking dependency detecte=
d ]
>>> [   18.269805] 4.2.0-rc6-1-iniza-small #1 Not tainted
>>> [   18.269810] ----------------------------------------------------=
---
>>> [   18.269816] modprobe/727 is trying to acquire lock:
>>> [   18.269822]  (init_mutex){+.+.+.}, at: [<ffffffffa0090f2d>]
>>> acpi_video_get_backlight_type+0x17/0x164 [video]
>>> [   18.269840]
>>> [   18.269840] but task is already holding lock:
>>> [   18.269848]  (&(&backlight_notifier)->rwsem){++++..}, at:
>>> [<ffffffff810a6519>] __blocking_notifier_call_chain+0x39/0x70
>>> [   18.269864]
>>> [   18.269864] which lock already depends on the new lock.
>>> [   18.269864]
>>> [   18.269875]
>>> [   18.269875] the existing dependency chain (in reverse order) is:
>>> [   18.269884]
>>> ...
>>>
>>> Full dmesg log and kernel-config attached.
>>>
>>> Shall I add Rusty and modules/modprobe folks?
>>
>>
>> Just got back from vacation and was greeted by this same lockdep spl=
at.
>>
>> On a hunch I reverted
>>
>> commit 93a291dfaf9c328ca5a9cea1733af1a128efe890
>> Author: Hans de Goede <hdegoede@redhat.com>
>> Date:   Tue Jun 16 16:27:52 2015 +0200
>>
>>      ACPI / video: Move backlight notifier to video_detect.c
>>
>> and the problem seems to be gone. Hans, any thoughts?
>
>
> Looking into this atm, lockdep clearly is right.
>
> Sorry about this I have put a lot of thinking into avoiding
> these kind of issues with this patch-set, but I did not realize
> there was another lock "hiding" inside the notifier-chain.
>
> Further analysis shows that the lock inside the notifier-chain
> causes similar problems vs register_count_mutex from
> drivers/acpi/acpi_video.c. I'm working on a fix for this
> atm.
>

"[PATCH] ACPI / video: Fix circular lock dependency issue in the
video-detect code" (see [1])

=2E..fixes the issue for me.

- sed@ -

[1] https://patchwork.kernel.org/patch/7009441/

> Regards,
>
> Hans
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
