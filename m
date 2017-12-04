From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: Can't even enter X after kernel 4.12
Date: Mon, 4 Dec 2017 23:40:08 +0100
Message-ID: <db8cecee-fa79-30de-b809-c00c2296b60f@redhat.com>
References: <CAB4CAwfOfsuOyuQqJvTMEUsWJi3dw=Ajqz_7YfusKXVz1JAQ_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:42575 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752130AbdLDWkL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Dec 2017 17:40:11 -0500
Received: by mail-wr0-f175.google.com with SMTP id s66so19021135wrc.9
        for <linux-acpi@vger.kernel.org>; Mon, 04 Dec 2017 14:40:10 -0800 (PST)
In-Reply-To: <CAB4CAwfOfsuOyuQqJvTMEUsWJi3dw=Ajqz_7YfusKXVz1JAQ_A@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chris Chiu <chiu@endlessm.com>, linux-acpi@vger.kernel.org, Linux Upstreaming Team <linux@endlessm.com>

Hi Chris,

On 30-11-17 07:27, Chris Chiu wrote:
> Hi,
>      I have a Intel cherry trail machine Haier HR101CW (CPU: x5-Z8350)
> which used to work fine in kernel 4.11, fails to enter X after I
> upgrade to kernel version later than 4.12. Even the latest 4.15, it
> can't even enter X now. There's no panic, oops and even no obvious
> error log. The panel backlight seems to be off but keyboard still
> responds.
> 
>      Then I tried to do bisect, it tells me the commit
> [b7ecf663c75eed1e764f57281f9508c49c18516e] ACPI / bus: Introduce a
> list of ids for "always present" devices is the one which causes this.
> After I revert this commit, the display back to normal.
> 
>      Maybe the DSDT file would help for your reference.
> https://gist.github.com/mschiu77/e84687cc928ac644117baf05aef47f16

Hmm, Daniel Drake from Endless send me a Vios LTH17 machine which
has similar symptoms. If this is indeed the same issue then adding:
i915.fastboot=1 to the kernel commandline should fix this.

This is going to be the default for newer kernels soon-ish (4.16
I think), so we can use this as a workaround for now.

As for the commit you bisected this to, can you try just commenting
out the: "80862288" entry in always_present_ids in
drivers/acpi/x86/utils.c ? I think that is triggering the problem.

Without that entry we don't get backlight control, so if you
comment it you will likely not be able to control brightness,
so i915.fastboot=1 is a better fix, but it would be good to know
if commenting out just that entry fixes things (and breaks
brightness control).

Without i915.fastboot=1 the i915 driver quickly turns the
backlight off and on again at boot, which I guess is confusing
the LCD panel...

Regards,

Hans




