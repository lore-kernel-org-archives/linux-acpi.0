From: Chris Chiu <chiu@endlessm.com>
Subject: Re: GemniLake laptops goes power off directly after performing suspend
Date: Wed, 6 Dec 2017 17:33:56 +0800
Message-ID: <CAB4CAwdia7RYVVthWAwz-nvpEbiSH+_MFc_zQeu_V7o-uWn8xA@mail.gmail.com>
References: <CAB4CAwc3q+L9UyHL8W541HXOCUTG0tTx51TfZRyzn61qbyOeEA@mail.gmail.com>
 <CAJZ5v0jS=E0mcm=R2xQSftSnzZXUbzL3RjjWafSYAB=Wd7=ECQ@mail.gmail.com>
 <CAB4CAwe-uahS0HECtqcQ4Mobwb6vD-pxb-v8vPY52t6z+sT5pg@mail.gmail.com> <18455542.KZ7HXfzeW6@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:40158 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754481AbdLFJd7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Dec 2017 04:33:59 -0500
Received: by mail-wm0-f41.google.com with SMTP id f206so5867877wmf.5
        for <linux-acpi@vger.kernel.org>; Wed, 06 Dec 2017 01:33:58 -0800 (PST)
In-Reply-To: <18455542.KZ7HXfzeW6@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Linux Upstreaming Team <linux@endlessm.com>

On Wed, Dec 6, 2017 at 5:56 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, December 5, 2017 5:19:03 PM CET Chris Chiu wrote:
>> On Tue, Dec 5, 2017 at 11:01 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> > On Tue, Dec 5, 2017 at 11:32 AM, Chris Chiu <chiu@endlessm.com> wrote:
>> >> Hi,
>> >>     I have 2 GemniLake laptops from ASUS, named X441MB and X507MA,
>> >> both go power off after I do "systemctl suspend" on top of kerne head
>> >> fd6d2e506ce6 (Merge tag 'docs-4.15-fixes' of git://git.lwn.net/linux).
>> >> I then wipe it out and install Windows RS3 instead, also goes to power
>> >> off after pressing media key for suspend(S3). Then I installed intel
>> >> graphic driver with the following version number, Windows has no
>> >> problem on suspend resume then.
>> >
>> > There is a suspend-related fix missing in 4.15-rc at this point, so
>> > please test 4.14.y or wait for the fix to be merged.
>> >
>> > Thanks,
>> > Rafael
>>
>> You mean the suspend-related fix used to exist in 4.14? Could you point me
>> out which commit it is? Thanks
>
> No.
>
> I mean that suspend generally works in 4.14 and is currently broken
> in 4.15-rc which requires a fix to be applied.  The fix in question is at:
>
> https://lkml.org/lkml/2017/11/30/546
>
> This is needed due to some changes made in 4.15-rc (with respect to 4.14)
> that broke resume from suspend to RAM.
>
> Thanks,
> Rafael
>

I think maybe for GemniLake is a different issue. I tried Ubuntu-4.14.0-11.13
kernel and 4.13 kernel. Both go power off immediately.
