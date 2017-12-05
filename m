From: Chris Chiu <chiu@endlessm.com>
Subject: Re: Can't even enter X after kernel 4.12
Date: Tue, 5 Dec 2017 23:42:09 +0800
Message-ID: <CAB4CAwerG4eOFAPP9bWP_cQiKmcmB7bEwTjSag9dzdkWy5E12g@mail.gmail.com>
References: <CAB4CAwfOfsuOyuQqJvTMEUsWJi3dw=Ajqz_7YfusKXVz1JAQ_A@mail.gmail.com>
 <db8cecee-fa79-30de-b809-c00c2296b60f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:44275 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752610AbdLEPmL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Dec 2017 10:42:11 -0500
Received: by mail-wm0-f52.google.com with SMTP id t8so2094078wmc.3
        for <linux-acpi@vger.kernel.org>; Tue, 05 Dec 2017 07:42:10 -0800 (PST)
In-Reply-To: <db8cecee-fa79-30de-b809-c00c2296b60f@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-acpi@vger.kernel.org, Linux Upstreaming Team <linux@endlessm.com>

On Tue, Dec 5, 2017 at 6:40 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi Chris,
>
> On 30-11-17 07:27, Chris Chiu wrote:
>>
>> Hi,
>>      I have a Intel cherry trail machine Haier HR101CW (CPU: x5-Z8350)
>> which used to work fine in kernel 4.11, fails to enter X after I
>> upgrade to kernel version later than 4.12. Even the latest 4.15, it
>> can't even enter X now. There's no panic, oops and even no obvious
>> error log. The panel backlight seems to be off but keyboard still
>> responds.
>>
>>      Then I tried to do bisect, it tells me the commit
>> [b7ecf663c75eed1e764f57281f9508c49c18516e] ACPI / bus: Introduce a
>> list of ids for "always present" devices is the one which causes this.
>> After I revert this commit, the display back to normal.
>>
>>      Maybe the DSDT file would help for your reference.
>> https://gist.github.com/mschiu77/e84687cc928ac644117baf05aef47f16
>
>
> Hmm, Daniel Drake from Endless send me a Vios LTH17 machine which
> has similar symptoms. If this is indeed the same issue then adding:
> i915.fastboot=1 to the kernel commandline should fix this.
>
> This is going to be the default for newer kernels soon-ish (4.16
> I think), so we can use this as a workaround for now.
>
> As for the commit you bisected this to, can you try just commenting
> out the: "80862288" entry in always_present_ids in
> drivers/acpi/x86/utils.c ? I think that is triggering the problem.
>
> Without that entry we don't get backlight control, so if you
> comment it you will likely not be able to control brightness,
> so i915.fastboot=1 is a better fix, but it would be good to know
> if commenting out just that entry fixes things (and breaks
> brightness control).
>
> Without i915.fastboot=1 the i915 driver quickly turns the
> backlight off and on again at boot, which I guess is confusing
> the LCD panel...
>
> Regards,
>
> Hans
>

Hmm...the i915.fastboot=1 seems not work on my Haier machine here.
However, comment out the: "80862288" entry in always_present_ids in
drivers/acpi/x86/utils.c do work. Do you need anything on this special
machine?

Chris
