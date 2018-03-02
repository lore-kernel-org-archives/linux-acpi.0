From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC] power/hibernate: Make passing hibernate offsets more friendly
Date: Fri, 2 Mar 2018 10:42:40 +0100
Message-ID: <CAJZ5v0jGr0VP9bNXprvyHfLvvvEgva6S9rAZM8EZEpGw=0PG+g@mail.gmail.com>
References: <1519839829-2191-1-git-send-email-mario.limonciello@dell.com>
 <CAHp75VcdsALCUBNoO4BoOj0rHuxurhr6B3GL2i7D79BxRL77kQ@mail.gmail.com> <ad15f3beb9f44c77b79f3038cb75b69c@ausx13mpc124.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ad15f3beb9f44c77b79f3038cb75b69c@ausx13mpc124.AMER.DELL.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: Mario Limonciello <Mario.Limonciello@dell.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 28, 2018 at 9:05 PM,  <Mario.Limonciello@dell.com> wrote:
>
>
>> -----Original Message-----
>> From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
>> Sent: Wednesday, February 28, 2018 12:11 PM
>> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
>> Cc: Rafael J . Wysocki <rjw@rjwysocki.net>; ACPI Devel Maling List <linux-
>> acpi@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>
>> Subject: Re: [RFC] power/hibernate: Make passing hibernate offsets more friendly
>>
>> On Wed, Feb 28, 2018 at 7:43 PM, Mario Limonciello
>> <mario.limonciello@dell.com> wrote:
>> > Currently the only way to specify a hibernate offset for a swap
>> > file is on the kernel command line.
>> >
>> > This makes some changes to improve:
>> > 1) Add a new /sys/power/disk_offset that lets userspace specify
>> > the offset and disk to use when initiating a hibernate cycle.
>> >
>> > 2) Adjust /sys/power/resume interpretation to also read in an
>> > offset.
>>
>> Read is okay per se (not consistent though), showing is not.
>> It might break an ABI.
>
> Right this is part of why I was proposing making a new attribute.
>
> The current RFC implementation I sent keeps the read output the
> same for /sys/power/resume.

You also need to retain the write behavior of it.

A new attribute is fine if it helps, but the behavior of the existing
one cannot change (both sides).
