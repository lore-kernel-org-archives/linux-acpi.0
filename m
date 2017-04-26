From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH] ACPICA: Tables: Fix regression introduced by a too
 early mechanism enabling
Date: Wed, 26 Apr 2017 07:13:43 -0700
Message-ID: <CAPcyv4jmzN3GjH669W4xuaG62iTwdE+McC49EJpE1gO0SG70+Q@mail.gmail.com>
References: <1493171393-1825-1-git-send-email-lv.zheng@intel.com>
 <CAPcyv4gtYzkeUL-Ou8bap5Sye=1Tq2PmuhZM04nFPwdjmCwCgg@mail.gmail.com> <1AE640813FDE7649BE1B193DEA596E886CE98BCA@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34528 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3001054AbdDZONp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Apr 2017 10:13:45 -0400
Received: by mail-oi0-f48.google.com with SMTP id x184so2050152oia.1
        for <linux-acpi@vger.kernel.org>; Wed, 26 Apr 2017 07:13:45 -0700 (PDT)
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CE98BCA@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Tue, Apr 25, 2017 at 10:15 PM, Zheng, Lv <lv.zheng@intel.com> wrote:
> Hi,
>
>> From: Dan Williams [mailto:dan.j.williams@intel.com]
>> Subject: Re: [RFC PATCH] ACPICA: Tables: Fix regression introduced by a too early mechanism enabling
>>
>> On Tue, Apr 25, 2017 at 6:49 PM, Lv Zheng <lv.zheng@intel.com> wrote:
>> > In the Linux kernel side, acpi_get_table() hasn't been fully balanced by
>> > acpi_put_table() invocations. So it is not a good timing to report errors.
>> > The strict balanced validation count check should only be enabled after
>> > confirming that all kernel side invocations are safe.
>>
>> We've been living with this bug for 7 years, let's just go fix all
>> acpi_get_table() invocations to make sure they have a corresponding
>> acpi_put_table().
>
> We knew that, you should have already seen a series internally or
> externally from me achieving this.
> It's done several years ago. But it takes long time to make the
> ACPICA part upstreamed.
>
> Now my plan is:
> 1. introduce the APIs but allow old usage models in order not to
>    change old ACPICA behavior and its users.
> 2. fix all users
> 3. disallow old usage models.
> It's just my mistake to leak the final stage approach to the ACPICA
> upstream from my local repo.
> Now we can try to jump to the final step, but as far as I know,
> not only Linux, ACPICA itself also contains several broken cases.
>
> Bottom line of Linux kernel is we shouldn't break any running system.
> So IMO, we will need this commit during this special period.
>
> I didn't say the final step is wrong or is not required.
> We can do both in parallel.
>
> So could you please help to confirm if it's working.
> And I would like to suggest linux to take this first step fix along
> with other final step fixes during this period.

I just think "this period" is very short and we can skip the band-aid
and go straight to auditing the 48 call sites of acpi_get_table.
