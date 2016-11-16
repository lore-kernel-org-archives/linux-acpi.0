From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Fix in ACPICA tools broke cross compilation of tools/power/acpi
Date: Wed, 16 Nov 2016 13:58:08 +0100
Message-ID: <CAJZ5v0jtarN0svYwq6F6CmQJK=3MmY7CA77ywqHmVdi_3HVu8g@mail.gmail.com>
References: <CAHp75VcyRzKPGQXB736EdvyXm9m3ShnLS3Xyrjnh7iRTE5M-uw@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886A25E72C@SHSMSX101.ccr.corp.intel.com>
 <CAHp75Vfp3v-SUk=ot35g9VReexCgYFjr1i=fVwyq1_Xg37ub8g@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886A25EA6F@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E886A25EBA3@SHSMSX101.ccr.corp.intel.com>
 <CAHp75Veg7XehhF_GcwQC4XxrjJGj6gxqd-sw044vOhE+2aGGBA@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886A2618E2@SHSMSX101.ccr.corp.intel.com>
 <CAHp75VccqXjwXg0s-n7r5-MzhzxmYS9AKpphckn=ytZNSkdyRw@mail.gmail.com>
 <CAHp75VcA15mVwUYF75dWdSp=BZmf_KCsE+t5qBfsiXHPMdUJiw@mail.gmail.com>
 <CAHp75VdJ1Nb_qbRX9b=RfDX-8e2tOUvMcbgYx8aMr4COQN3p8Q@mail.gmail.com>
 <CAHp75Vc3aSW09AXzWs5yY=iGSFPcz9zeB1F+dA=cNZTbPUG1Lg@mail.gmail.com> <1AE640813FDE7649BE1B193DEA596E886A28F62C@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:32812 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752755AbcKPM6J (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Nov 2016 07:58:09 -0500
Received: by mail-qk0-f180.google.com with SMTP id x190so173487682qkb.0
        for <linux-acpi@vger.kernel.org>; Wed, 16 Nov 2016 04:58:09 -0800 (PST)
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886A28F62C@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, Nov 16, 2016 at 9:43 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
> Hi, Andy
>
>> From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
>> Subject: Re: Fix in ACPICA tools broke cross compilation of tools/power/acpi
>>
>> On Tue, Nov 15, 2016 at 5:01 PM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>
>> > The below + several runs (need to serialize makefile, by default it
>> > races install vs. build)  helped eventually.
>>
>> Isn't better just to revert patch I mention and continue from working case?
>
> It's not possible to revert that patch.

It surely is possible to revert things, but it may not be a good idea.
So I think you wanted to say that reverting this particular one would
not be a good idea.

> It contains correct header inclusion cleanups.

Cleanups are not a good enough reason for breaking builds.

> While this case is in fact a special case, bugs in tools/Makefile are triggered (about OUT/SRC).

I'm not sure what you mean.

> OTOH, this case is actually not a very useful case.

In your opinion I guess?

> We can see many tools build broken for cross-compilers, and tools/power/acpi is not the only one.

I guess the issue is that it was not broken before and it is broken
after your changes.  That's quite a bit of a difference.

> We are just to improve it.

That's nice, but see above.

Thanks,
Rafael
