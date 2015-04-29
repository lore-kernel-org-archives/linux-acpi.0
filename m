From: Alex Hung <alex.hung@canonical.com>
Subject: Re: [PATCH] ACPI / blacklist: blacklist Win8 OSI for Dell Inspiron 7437
Date: Wed, 29 Apr 2015 18:09:27 +0800
Message-ID: <CAJ=jquZMMBNsKO2CZe649OcXTBxfzO43gkxwkJn2mvHhnp+zSQ@mail.gmail.com>
References: <1429759476-13186-1-git-send-email-alex.hung@canonical.com>
	<20150424082115.GA3783@srcf.ucam.org>
	<CAJ=jquYe97ObpE=3eTij705QsopnH4+hChssdj0qu7YFHGsSXg@mail.gmail.com>
	<20150427174646.GA22664@srcf.ucam.org>
	<CAJ=jquZ7wTNBMEwZaxKRd6B2iC6qaum5h+oW=Qf364+xhs20kg@mail.gmail.com>
	<20150428052448.GA3458@srcf.ucam.org>
	<CAJ=jquYYDixG7-XtVJRvuHDWHgF3Ww3fiafDbmgD5KY8QJjeQQ@mail.gmail.com>
	<20150428171100.GA24599@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:36040 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbbD2KJ2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Apr 2015 06:09:28 -0400
Received: by qgeb100 with SMTP id b100so9026629qge.3
        for <linux-acpi@vger.kernel.org>; Wed, 29 Apr 2015 03:09:27 -0700 (PDT)
In-Reply-To: <20150428171100.GA24599@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>

Matthew,

Your conclusion is correct. Disabling OSI(Windows 2012/2013) in kernel
4.1rc will not work. I will take a closer look into this machine.

Thanks.

On Wed, Apr 29, 2015 at 1:11 AM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> With Windows 8 enabled you're going down this path:
>
>         If (_OSI (WIN8))
>         {
>             Local0 = 0x81
>         }
>
> With it blacklisted, you're going down this path:
>
>         If (_OSI (WIN7))
>         {
>             Local0 = 0x80
>             Local1 = _REV /* \_REV */
>             If ((Local1 == 0x05))
>             {
>                 Local0 = 0x40
>             }
>         }
>
> So your guess about _REV was actually correct - if the OS claims to be
> Windows 7 and returns 5 to _REV, it'll let Local0 to 0x40. This results
> in:
>
>         If ((Local0 == 0x40))
>         {
>             MIS0 = SMI (0x98, Zero)
>             MIS0 &= 0x13
>         }
>
> MIS0 appears to be involved in various event delivery paths, so my
> suspicion is that the firmware is deliberately working around a quirk of
> Linux behaviour in order to deliver events appropriately. If so, your
> patch won't help in 4.1 because _REV now returns 2, and so we need to
> root cause the actual problem and fix that instead.
>
> --
> Matthew Garrett | mjg59@srcf.ucam.org



-- 
Cheers,
Alex Hung
