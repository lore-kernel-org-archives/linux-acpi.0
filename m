From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Possible regression caused by commit a192aa923b66a
Date: Wed, 13 Jun 2018 09:53:42 +0200
Message-ID: <CAJZ5v0h_062K-MJrEr0zAjthZgxU9RFpu_b86N4zBKvOqpejdQ@mail.gmail.com>
References: <DEA1AE84-B0FD-481E-8E0D-788CD4EF59AE@canonical.com>
 <CAJZ5v0iyNo+ZZ1O0_j4p6w-+eS1W9MUYs-vjeNHVENFVhReGzw@mail.gmail.com>
 <CAJZ5v0jiWugSt98MXOLUKAsig=uWFsTHK1Mntvy6z0JfiWt9sQ@mail.gmail.com>
 <2505591.oRh3ktjo9V@aspire.rjw.lan> <A05971DC-4453-4615-9AE9-8C4608569427@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <A05971DC-4453-4615-9AE9-8C4608569427@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, P HeLiOn <perryhelionsemail@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 13, 2018 at 4:45 AM, Kai Heng Feng
<kai.heng.feng@canonical.com> wrote:
> Hi Rafael,
>
>> On Jun 12, 2018, at 5:17 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>
>> On Monday, June 11, 2018 11:52:34 PM CEST Rafael J. Wysocki wrote:
>>>
>>> --000000000000703623056e64c488
>>> Content-Type: text/plain; charset="UTF-8"
>>>
>>> On Mon, Jun 11, 2018 at 10:09 AM, Rafael J. Wysocki <rafael@kernel.org>
>>> wrote:
>>>>
>>>> On Mon, Jun 11, 2018 at 8:26 AM, Kai-Heng Feng
>>>> <kai.heng.feng@canonical.com> wrote:
>>>>>
>>>>> Hi Rafael,
>>>>>
>>>>> There's a regression report [1] that says commit a192aa923b66a ("ACPI /
>>>>> LPSS: Consolidate runtime PM and system sleep handling") is the first
>>>>> bad
>>>>> commit.
>>>>>
>>>>> From the looks of it, it didn't introduce any behavioral change. So
>>>>> your
>>>>> help is appreciated.
>>>>>
>>>>> [1] https://bugs.launchpad.net/bugs/1774950
>>>>
>>>>
>>>> Well, the only difference is the iosf quirk AFAICS, but that should be
>>>> easy enough to check.  I'll try to cut a patch for that later today.
>>>
>>>
>>> If the iosf quirk is the source of the problem, the attached patch should
>>> help.
>>
>>
>> The one below should be slightly better, please test this one.
>
>
> Affected users reported that this patch solves the issue for them.

OK, thanks for verifying.  Let me add a changelog to it and resend it, then.

Thanks,
Rafael
