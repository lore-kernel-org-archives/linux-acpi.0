From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH] ACPI / video: Fix circular lock dependency issue in the
 video-detect code
Date: Fri, 14 Aug 2015 11:36:41 +0200
Message-ID: <CA+icZUXusiLBN0LishXE1GUZ+TYrDmzyoJ4QnoQ1JokjyxphDw@mail.gmail.com>
References: <1439484817-2888-1-git-send-email-hdegoede@redhat.com>
	<CA+icZUUz1ExQHWo1OhVJSZdLf6mopu4hWURcSd4tGtuyCj4TSQ@mail.gmail.com>
	<8673015.1SLQP2GE9q@vostro.rjw.lan>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34683 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093AbbHNJgn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Aug 2015 05:36:43 -0400
Received: by wicne3 with SMTP id ne3so13447784wic.1
        for <linux-acpi@vger.kernel.org>; Fri, 14 Aug 2015 02:36:41 -0700 (PDT)
In-Reply-To: <8673015.1SLQP2GE9q@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Hans de Goede <hdegoede@redhat.com>, Aaron Lu <aaron.lu@intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux ACPI <linux-acpi@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>

On Fri, Aug 14, 2015 at 11:39 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, August 13, 2015 10:39:08 PM Sedat Dilek wrote:
>>
>> --f46d04447e7fc2306e051d3753a5
>> Content-Type: text/plain; charset=UTF-8
>>
>> On Thu, Aug 13, 2015 at 6:53 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> > Before this commit, the following would happen:
>> >
>> > a) acpi_video_get_backlight_type() gets called
>> > b) acpi_video_get_backlight_type() calls acpi_video_init_backlight_type()
>> > c) acpi_video_init_backlight_type() locks its function static init_mutex
>> > d) acpi_video_init_backlight_type() calls backlight_register_notifier()
>> > e) backlight_register_notifier() takes its notifier-chain lock
>> >
>> > And when the backlight notifier chain gets called we've:
>> >
>> > 1) blocking_notifier_call_chain() gets called
>> > 2) blocking_notifier_call_chain() takes the notifier-chain lock
>> > 3) blocking_notifier_call_chain() calls acpi_video_backlight_notify()
>> > 4) acpi_video_backlight_notify() calls acpi_video_get_backlight_type()
>> > 5) acpi_video_get_backlight_type() calls acpi_video_init_backlight_type()
>> > 6) acpi_video_init_backlight_type() locks its function static init_mutex
>> >
>> > So in the first call sequence we have:
>> >
>> > a) init_mutex gets locked
>> > b) notifier-chain gets locked
>> >
>> > and in the second call sequence we have:
>> >
>> > 1) notifier-chain gets locked
>> > 2) init_mutex gets locked
>> >
>> > And we've a circular locking dependency. This specific locking dependency
>> > is fixable without using the big hammer otherwise known as a workqueue,
>> > but further analysis shows a similar problem with the backlight notifier
>> > chain lock vs register_count_mutex from drivers/acpi/acpi_video.c,
>> > and fixing that becomes problematic.
>> >
>> > So this commit simply fixes this with the big hammer, performance
>> > wise this is a non issue as we expect the work to get scheduled
>> > exactly zero or one times during normal system use.
>> >
>>
>> This patch on top of Linux v4.2-rc6 fixes the issue for me.
>>
>> Feel free to add my...
>>
>>    Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
>>    Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
>
> Applied, thanks!
>

Thanks for carrying this one.
Isn't this a for-4.2/acpi-video-fixes?
Why did you apply this in your linux-next Git branch?

- sed@ -

[1] http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=7231ed1a813e0a9d249bbbe58e66ca058aee83e1

> Rafael
>
