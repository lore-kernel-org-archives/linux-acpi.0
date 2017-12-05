From: Chris Chiu <chiu@endlessm.com>
Subject: Re: GemniLake laptops goes power off directly after performing suspend
Date: Wed, 6 Dec 2017 00:19:03 +0800
Message-ID: <CAB4CAwe-uahS0HECtqcQ4Mobwb6vD-pxb-v8vPY52t6z+sT5pg@mail.gmail.com>
References: <CAB4CAwc3q+L9UyHL8W541HXOCUTG0tTx51TfZRyzn61qbyOeEA@mail.gmail.com>
 <CAJZ5v0jS=E0mcm=R2xQSftSnzZXUbzL3RjjWafSYAB=Wd7=ECQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38294 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbdLEQTF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Dec 2017 11:19:05 -0500
Received: by mail-wm0-f45.google.com with SMTP id 64so2284403wme.3
        for <linux-acpi@vger.kernel.org>; Tue, 05 Dec 2017 08:19:04 -0800 (PST)
In-Reply-To: <CAJZ5v0jS=E0mcm=R2xQSftSnzZXUbzL3RjjWafSYAB=Wd7=ECQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Upstreaming Team <linux@endlessm.com>

On Tue, Dec 5, 2017 at 11:01 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Tue, Dec 5, 2017 at 11:32 AM, Chris Chiu <chiu@endlessm.com> wrote:
>> Hi,
>>     I have 2 GemniLake laptops from ASUS, named X441MB and X507MA,
>> both go power off after I do "systemctl suspend" on top of kerne head
>> fd6d2e506ce6 (Merge tag 'docs-4.15-fixes' of git://git.lwn.net/linux).
>> I then wipe it out and install Windows RS3 instead, also goes to power
>> off after pressing media key for suspend(S3). Then I installed intel
>> graphic driver with the following version number, Windows has no
>> problem on suspend resume then.
>
> There is a suspend-related fix missing in 4.15-rc at this point, so
> please test 4.14.y or wait for the fix to be merged.
>
> Thanks,
> Rafael

You mean the suspend-related fix used to exist in 4.14? Could you point me
out which commit it is? Thanks

Chris
