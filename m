From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPICA: Recognize the Windows 10 RS3 OSI string
Date: Thu, 15 Feb 2018 10:05:41 +0100
Message-ID: <CAJZ5v0iB0zLQoMOq3bZm+V2m_oZvmWyiGUHegnN9NQ_CrkBgZQ@mail.gmail.com>
References: <1518544819-1173-1-git-send-email-mario.limonciello@dell.com>
 <CAJZ5v0gYMTsG-t6VY3MurP-p5faT3kVdUoeA_LiSrL7moUW2yQ@mail.gmail.com> <083ff76874ae4cde8e15740ad98ce9b5@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45664 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754825AbeBOJFm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Feb 2018 04:05:42 -0500
Received: by mail-oi0-f67.google.com with SMTP id 23so6479982oip.12
        for <linux-acpi@vger.kernel.org>; Thu, 15 Feb 2018 01:05:41 -0800 (PST)
In-Reply-To: <083ff76874ae4cde8e15740ad98ce9b5@ausx13mpc120.AMER.DELL.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Limonciello <Mario.Limonciello@dell.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Wed, Feb 14, 2018 at 4:39 PM,  <Mario.Limonciello@dell.com> wrote:
>> -----Original Message-----
>> From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf Of Rafael J.
>> Wysocki
>> Sent: Wednesday, February 14, 2018 2:46 AM
>> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
>> Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>; Len Brown
>> <lenb@kernel.org>; Rafael J . Wysocki <rjw@rjwysocki.net>; Mika Westerberg
>> <mika.westerberg@linux.intel.com>
>> Subject: Re: [PATCH] ACPICA: Recognize the Windows 10 RS3 OSI string
>>
>> On Tue, Feb 13, 2018 at 7:00 PM, Mario Limonciello
>> <mario.limonciello@dell.com> wrote:
>> > Dell uses this string to activate Thunderbolt native mode on supported
>> > machines.
>> >
>> > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
>> > ---
>> > Thunderbolt Native mode requires other patches to be applied otherwise
>> > this patch will cause problems.
>
> I should have been clearer  - problems with thunderbolt driver in Linux.
>
> If you apply this patch without the rest of Mika's series there will be problems
> with Thunderbolt native mode in Linux.

Right.

> The patches you already reviewed in
>>    https://marc.info/?l=linux-acpi&m=151853954129169&w=2
>
> Are the more important ones, but a few of the fixes that came in the second
> series help with some of the corner cases (for example cold boot ICM timeout).

OK

> Mika might have a few more comments to add here from the testing he did
> to make those patches.
>
>> >
>> > This patch should only be applied with:
>> > 1) Acpiphp platches from
>> >    https://marc.info/?l=linux-acpi&m=151853954129169&w=2
>> > and
>> >
>> > 2) Thunderbolt patches from
>> >    https://lkml.org/lkml/2018/2/13/685
>>
>> Thanks for these pointers, they help a lot.
>>
>> > This has also been submited into ACPICA:
>> > https://github.com/acpica/acpica/pull/359
>>
>> Due to the dependencies outside of upstream ACPICA, I don't think that
>> this patch is suitable for upstream ACPICA at all.
>
> Actually ACPICA did merge it already:
> https://github.com/acpica/acpica/commit/24f7791789c49ec02eb024106c85d23322be5672

So there appear to be differing opinions. :-)
