From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: Fix in ACPICA tools broke cross compilation of tools/power/acpi
Date: Mon, 12 Dec 2016 22:58:14 +0200
Message-ID: <CAHp75Vf3-RG+HR5uNYo_J-fYaYC=op6dZXCwm=4jtef-d58+pw@mail.gmail.com>
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
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35425 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752366AbcLLU6Q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Dec 2016 15:58:16 -0500
Received: by mail-oi0-f65.google.com with SMTP id v84so12670059oie.2
        for <linux-acpi@vger.kernel.org>; Mon, 12 Dec 2016 12:58:16 -0800 (PST)
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886A28FB87@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, Nov 17, 2016 at 5:10 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
>>
>> > It contains correct header inclusion cleanups.
>>
>> Cleanups are not a good enough reason for breaking builds.
>
> It doesn't break, build is OK in my environment.

You know, before you did that first clean up for MSVC it worked for me.

Now I got the following

 DESCEND  power/acpi
 DESCEND  tools/acpidbg
 DESCEND  tools/acpidump
 DESCEND  tools/ec
 MKDIR    include
 INST     acpidbg
 MKDIR    include
 INST     ec
 MKDIR    include
 CP       include
 CP       include
/usr/bin/install: cannot stat '.../power/acpi/acpidbg': No such file
or directory
 INST     acpidump
../../Makefile.rules:41: recipe for target 'install-tools' failed
make[6]: *** [install-tools] Error 1
/usr/bin/install: make[6]: *** Waiting for unfinished jobs....
cannot stat '.../power/acpi/ec': No such file or directory
../../Makefile.rules:41: recipe for target 'install-tools' failed
make[6]: *** [install-tools] Error 1
make[6]: *** Waiting for unfinished jobs....
 INST     acpidump.8
 CP       include
Makefile:23: recipe for target 'acpidbg_install' failed
make[5]: *** [acpidbg_install] Error 2
make[5]: *** Waiting for unfinished jobs....
/usr/bin/install: cannot stat '.../power/acpi/acpidump': No such file
or directory
../../Makefile.rules:41: recipe for target 'install-tools' failed
make[6]: *** [install-tools] Error 1
make[6]: *** Waiting for unfinished jobs....
Makefile:23: recipe for target 'ec_install' failed
make[5]: *** [ec_install] Error 2
Makefile:23: recipe for target 'acpidump_install' failed
make[5]: *** [acpidump_install] Error 2
Makefile:95: recipe for target 'acpi_install' failed
make[4]: *** [acpi_install] Error 2

.../Makefile:1613: recipe for target 'tools/acpi_install' failed

>>> Just to notice that above Makefile comes from the source tree not the O= variant
The rest of ... related to O=/my/output/path.

make[3]: *** [tools/acpi_install] Error 2
Makefile:150: recipe for target 'sub-make' failed
make[2]: *** [sub-make] Error 2
Makefile:24: recipe for target '__sub-make' failed
make[1]: *** [__sub-make] Error 2

So, it doesn't even try to build anything.

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

See above.

This is how make started. $(KERNEL_TOOLS_TARGET) is a list of folders
under tools (for now just "acpi gpio turbostat"). $(1) either
"install" or "clean".
KERNEL_SRC the output folder of kernel build (it might be the same as
sources, but not my case, I used O=). The rest from the list are
compiled and installed nicely. This *was* the case for acpi tools.

+       $(Q)for t in $(KERNEL_TOOLS_TARGET); do                 \
+               $(MAKE) -C $(KERNEL_SRC)                        \
+                       CROSS_COMPILE="$(TARGET_CROSS)"         \
+                       DESTDIR="$(TARGET_DIR)"                 \
+                       tools/$${t}_$(1);                       \
+       done

So. there is no magic here.

Can you add this simple test to your test cases?

-- 
With Best Regards,
Andy Shevchenko
