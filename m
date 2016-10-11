From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Tue, 11 Oct 2016 13:59:14 +0200
Message-ID: <CAJZ5v0gFy2_pV5zx2_zDm5fE4Q1bqatPRDUiF1gcTAvTvbSEbQ@mail.gmail.com>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon> <20161005114129.GI1765@lahna.fi.intel.com>
 <788f4bcd-605f-2694-5df5-ec7ef1bde233@arm.com> <CAJZ5v0iYPbLry-ZKeFqvm4Jeg24J7E6vQzV56jCh2N5fU6AQsw@mail.gmail.com>
 <0e56c5b2-0042-28e5-7445-6fe8422c728e@arm.com> <CAJZ5v0hy8V_WUuzOtT4oPt_hPRDUMHR5UYxVD0X3bVQe5AJf9Q@mail.gmail.com>
 <8999b937-4c06-6d82-aef5-6b7700a2a10c@arm.com> <CAJZ5v0g3MCBXXOn_txBE4E1-rjjwyXDu=wq=oD7xgXy=rhpm0w@mail.gmail.com>
 <957adfe3-5a17-47d5-f48c-2d47f727c387@arm.com> <CAJZ5v0hKnXiKTuQ5Ds57gnVQU3cEFj_YCaZn-he4x7tO8YdDrg@mail.gmail.com>
 <b4f0bedf-2473-b629-7dbb-90709c74226a@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35164 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752286AbcJKMAI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Oct 2016 08:00:08 -0400
Received: by mail-qk0-f181.google.com with SMTP id z190so29230374qkc.2
        for <linux-acpi@vger.kernel.org>; Tue, 11 Oct 2016 04:59:15 -0700 (PDT)
In-Reply-To: <b4f0bedf-2473-b629-7dbb-90709c74226a@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>

On Tue, Oct 11, 2016 at 10:57 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 11/10/16 01:05, Rafael J. Wysocki wrote:
>>
>> On Thu, Oct 6, 2016 at 7:20 PM, Sudeep Holla <sudeep.holla@arm.com>
>> wrote:
>
>
> [...]
>
>>>> Well, maybe they should have talked to the upstream before
>>>> shipping the product with that table?  Failing to do so is like
>>>> jumping to a pool from a tower without checking how much water is
>>>> there in it in the first place ...
>>>>
>>>
>>> Really ? I admit that I like this response and your stance here and
>>> I definitely support it but I have seen quite a few cases which
>>> tells me otherwise.
>>
>>
>> Was I involved in any of those?
>>
>
> No I wasn't referring to any particular case here. What I meant is we
> have quite a few hacks/workarounds even on x86 for various reasons like:
> other OS works, the product is shipped and firmware can't be fixed, and
> so on. We might encounter similar situations even with DSD in future and
> hence my worries.

There surely will be cases when people mess up their _DSD and
validation is insufficient and so on.  That seems to be the nature of
the business today.

What I'm talking about is not implementation mistakes, but cases when
people have a problem to address and decide to do that in a way that
cannot be done by the mainline (for technical reasons), and then
expect the mainline to accept this.  When in doubt about which way to
go, they should talk to the mainline in the first place or the
solution they choose may stay out of the tree forever (and become a
major pain to maintain going forward).

Thanks,
Rafael
