From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Fix in ACPICA tools broke cross compilation of tools/power/acpi
Date: Thu, 17 Nov 2016 16:02:34 +0100
Message-ID: <CAJZ5v0hwV5gcGE-unmTdW6U5VFvoWs7RR17iKabbo5ahzgFTMw@mail.gmail.com>
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
 <CAHp75Vc3aSW09AXzWs5yY=iGSFPcz9zeB1F+dA=cNZTbPUG1Lg@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886A28F62C@SHSMSX101.ccr.corp.intel.com>
 <CAJZ5v0jtarN0svYwq6F6CmQJK=3MmY7CA77ywqHmVdi_3HVu8g@mail.gmail.com> <1AE640813FDE7649BE1B193DEA596E886A28FB87@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:33144 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751948AbcKQQ4w (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Nov 2016 11:56:52 -0500
Received: by mail-qt0-f170.google.com with SMTP id p16so135872948qta.0
        for <linux-acpi@vger.kernel.org>; Thu, 17 Nov 2016 08:56:52 -0800 (PST)
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886A28FB87@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, Nov 17, 2016 at 4:10 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
> Hi, Rafael
>
>> From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf Of Rafael J. Wysocki
>> Subject: Re: Fix in ACPICA tools broke cross compilation of tools/power/acpi
>>
>> On Wed, Nov 16, 2016 at 9:43 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
>> > Hi, Andy
>> >
>> >> From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
>> >> Subject: Re: Fix in ACPICA tools broke cross compilation of tools/power/acpi
>> >>
>> >> On Tue, Nov 15, 2016 at 5:01 PM, Andy Shevchenko
>> >> <andy.shevchenko@gmail.com> wrote:
>> >>
>> >> > The below + several runs (need to serialize makefile, by default it
>> >> > races install vs. build)  helped eventually.
>> >>
>> >> Isn't better just to revert patch I mention and continue from working case?
>> >
>> > It's not possible to revert that patch.
>>
>> It surely is possible to revert things, but it may not be a good idea.
>> So I think you wanted to say that reverting this particular one would
>> not be a good idea.
>
> Yes, it's not a good idea.
> The cleanup is correct.
>
>>
>> > It contains correct header inclusion cleanups.
>>
>> Cleanups are not a good enough reason for breaking builds.
>
> It doesn't break, build is OK in my environment.
>
>>
>> > While this case is in fact a special case, bugs in tools/Makefile are triggered (about OUT/SRC).
>>
>> I'm not sure what you mean.
>
> I'm wrong here.
> The only issue triggered is:
> The following line in the acenv.h need to be commented out:
> #include <signal.h>
>
>>
>> > OTOH, this case is actually not a very useful case.
>>
>> In your opinion I guess?
>
> Yes. IMO,
> The above breakage looks much more strange than the commit itself.
> It's better to make the build successful without commenting this line out.
>
> Such kind of regressions bothered me a lot.
> It seems we can easily fell into such old traps.
>
> If I cannot fix the new regression in time, I will sure suggest to revert breakage commit before a better solution can be offered after investigation.
> However, for this issue:
> 1. There is actually no serious breakage (only toolchains built with incompliant kernel headers)
> 2. We have fixed the issue, but the fix need to be improved.
> So reverting the correct commit isn't a good idea.
> Reverting it may trigger more serious issues because of wrong header inclusion orders.
> Let me improve it.
>
>>
>> > We can see many tools build broken for cross-compilers, and tools/power/acpi is not the only one.
>>
>> I guess the issue is that it was not broken before and it is broken
>> after your changes.  That's quite a bit of a difference.
>
> IMO, the non-updated toolchains/or ACPICA's sX/uX definitions are actually buggy while the commit isn't.
>
>>
>> > We are just to improve it.
>>
>> That's nice, but see above.
>
> Yes, we have fixed it.
> And Yisheng Xie has feedback that this issue has been fixed.
>
> However, the v1 fix contains problem:
> There is one line dependency not correct:
>  acpidbg acpidump ec: include/acpi FORCE
> I failed to correct it in v2/v3:
>  $(OUTPUT)$(TOOL): $(KERNEL_INCLUDE) $(toolobjs) FORCE
> Which was criticized by Andy, complaining new breaks for parallel builds.
> Now in v4, it is corrected:
>  $(objdir)%.o: %.c $(KERNEL_INCLUDE)
>
> However, in v2/v3, I cleaned up OUTPUT related code and changed its behavior of build with "O=".
> In v2/v3, build "O=" from tools/power/acpi folder passes, but build from tools folder fails.
> In v4, build "O=" from tools folder passes, but build from tools/power/acpi folder fails.
>
> There doesn't seem to be a solution to make both cases working.
> Because the "descend" macro in tools/scripts/Makefile.include cannot handle both cases.
> Stopping using "descend" macro in tools/power/acpi/Makefile could be the only possible fix...
> So we only need one of them working and IMO v4 is suitable for Andy's needs.
>
> As a conclusion, v4 should be OK now.

OK, I've queued it up and I'm going to push it for -rc6 tomorrow.

Thanks,
Rafael
