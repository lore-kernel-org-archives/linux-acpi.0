From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5] ACPICA: Tables: Add mechanism to allow to balance late
 stage acpi_get_table() independently
Date: Wed, 7 Jun 2017 14:24:48 -0700
Message-ID: <CAPcyv4gF00UnF2+cnVxrGm_7vCqCb6Fr=qHnd2aBaBudvVR40Q@mail.gmail.com>
References: <5361b51c7c257b3216475018a3a5cc4f8b6b21c6.1493281247.git.lv.zheng@intel.com>
 <cb1126b2eb1b83a5a97a33c1c5c37a02c32fd688.1496811175.git.lv.zheng@intel.com>
 <CAA9_cmdmokPM0+MSiMzGPzkvUkKPELrVyRPoO2bZZZoNJ2sr3w@mail.gmail.com> <CAJZ5v0j6ZB=JXvDX3hjoRK-Eir3ZWVda2yvqkyT31X0EWLa03g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36359 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751463AbdFGVYt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Jun 2017 17:24:49 -0400
Received: by mail-oi0-f53.google.com with SMTP id k145so2396325oih.3
        for <linux-acpi@vger.kernel.org>; Wed, 07 Jun 2017 14:24:49 -0700 (PDT)
In-Reply-To: <CAJZ5v0j6ZB=JXvDX3hjoRK-Eir3ZWVda2yvqkyT31X0EWLa03g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lv Zheng <lv.zheng@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Wed, Jun 7, 2017 at 2:14 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Jun 7, 2017 at 8:41 AM, Dan Williams <dan.j.williams@intel.com> wrote:
>> On Tue, Jun 6, 2017 at 9:54 PM, Lv Zheng <lv.zheng@intel.com> wrote:
>>> Considering this case:
>>> 1. A program opens a sysfs table file 65535 times, it can increase
>>>    validation_count and first increment cause the table to be mapped:
>>>     validation_count = 65535
>>> 2. AML execution causes "Load" to be executed on the same table, this time
>>>    it cannot increase validation_count, so validation_count remains:
>>>     validation_count = 65535
>>> 3. The program closes sysfs table file 65535 times, it can decrease
>>>    validation_count and the last decrement cause the table to be unmapped:
>>>     validation_count = 0
>>> 4. AML code still accessing the loaded table, kernel crash can be observed.
>>>
>>> This is because orginally ACPICA doesn't support unmapping tables during
>>> OS late stage. So the current code only allows unmapping tables during OS
>>> early stage, and for late stage, no acpi_put_table() clones should be
>>> invoked, especially cases that can trigger frequent invocations of
>>> acpi_get_table()/acpi_put_table() are forbidden:
>>> 1. sysfs table accesses
>>> 2. dynamic Load/Unload opcode executions
>>> 3. acpi_load_table()
>>> 4. etc.
>>> Such frequent acpi_put_table() balance changes have to be done altogether.
>>>
>>> This philosophy is not convenient for Linux driver writers. Since the API
>>> is just there, developers will start to use acpi_put_table() during late
>>> stage. So we need to consider a better mechanism to allow them to safely
>>> invoke acpi_put_table().
>>>
>>> This patch provides such a mechanism by adding a validation_count
>>> threashold. When it is reached, the validation_count can no longer be
>>> incremented/decremented to invalidate the table descriptor (means
>>> preventing table unmappings) so that acpi_put_table() balance changes can be
>>> done independently to each others.
>>>
>>> Note: code added in acpi_tb_put_table() is actually a no-op but changes the
>>> warning message into a warning once message. Lv Zheng.
>>>
>>
>> This still seems to be unnecessary gymnastics to keep the validation
>> count around and make it work for random drivers.
>
> Well, I'm not sure I agree here.
>
> If we can make it work at one point, it should not be too hard to
> maintain that status.
>

I agree with that, my concern was with driver writers needing to be
worried about when it is safe to call acpi_put_table(). This reference
count behaves differently than other reference counts like kobjects.
The difference is not necessarily bad, but hopefully it can be
contained within the acpi core.
