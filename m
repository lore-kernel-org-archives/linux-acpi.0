From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [GIT PULL] ACPI material for v4.9-rc1
Date: Wed, 5 Oct 2016 21:44:12 +0200
Message-ID: <CAJZ5v0hN-SR8Pq3U8Eg8poZsbvUbFprm2AwAZbtEOukv-ThLNg@mail.gmail.com>
References: <CAJZ5v0ij+mUnjJZ3RR37yUFgc+RPndwPNhTGa3RF4PNFQ+RH8Q@mail.gmail.com>
 <CA+55aFwFVZVkApwrei5A68kfc5+D32x5JKkvnuqiJS731Nv=Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33598 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753170AbcJEToP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Oct 2016 15:44:15 -0400
In-Reply-To: <CA+55aFwFVZVkApwrei5A68kfc5+D32x5JKkvnuqiJS731Nv=Ew@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Lv <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>

On Wed, Oct 5, 2016 at 7:29 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sun, Oct 2, 2016 at 3:56 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> This goes early as I will be traveling for a good part of the next week.
>
> So you're presumably traveling, but I thought I'd mention this anyway,
> since it seems to be new (but maybe I just never noticed before)..
>
> I now get this during early bootup:
>
>    ACPI Error: [\_SB_.PCI0.XHC_.RHUB.HS11] Namespace lookup failure,
> AE_NOT_FOUND (20160831/dswload-210)
>    ACPI Exception: AE_NOT_FOUND, During name lookup/catalog
> (20160831/psobject-227)
>    ACPI Exception: AE_NOT_FOUND, (SSDT:xh_rvp08) while loading table
> (20160831/tbxfload-228)
>    ACPI Error: 1 table load failures, 8 successful (20160831/tbxfload-246)
>
> and it has no actual other negative effects except that it makes my
> boot screen flicker (because the boot wants to show me errors in
> between the usual graphical "clean" boot screen).
>
> Are those failures so bad that they should be marked as errors?

They come from ACPICA that appears to have problems with some AML in
the ACPI tables, but I agree that they should rather be debug
messages.

Lv, it looks like these messages could only be useful for debugging,
so any chance to reduce their log level accordingly?

Thanks,
Rafael
