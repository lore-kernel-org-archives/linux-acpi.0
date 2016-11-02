From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: Fix in ACPICA tools broke cross compilation of tools/power/acpi
Date: Thu, 3 Nov 2016 00:21:24 +0200
Message-ID: <CAHp75Veg7XehhF_GcwQC4XxrjJGj6gxqd-sw044vOhE+2aGGBA@mail.gmail.com>
References: <CAHp75VcyRzKPGQXB736EdvyXm9m3ShnLS3Xyrjnh7iRTE5M-uw@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886A25E72C@SHSMSX101.ccr.corp.intel.com>
 <CAHp75Vfp3v-SUk=ot35g9VReexCgYFjr1i=fVwyq1_Xg37ub8g@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886A25EA6F@SHSMSX101.ccr.corp.intel.com> <1AE640813FDE7649BE1B193DEA596E886A25EBA3@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:36275 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932782AbcKBWV0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Nov 2016 18:21:26 -0400
Received: by mail-oi0-f46.google.com with SMTP id v84so42308904oie.3
        for <linux-acpi@vger.kernel.org>; Wed, 02 Nov 2016 15:21:26 -0700 (PDT)
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886A25EBA3@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sun, Oct 30, 2016 at 9:04 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
> Hi, Andy
>
>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.ker=
nel.org] On Behalf Of Zheng,
>> Lv
>> Subject: RE: Fix in ACPICA tools broke cross compilation of tools/power/=
acpi
>>
>> Hi,
>>
>> > From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
>> > Subject: Re: Fix in ACPICA tools broke cross compilation of tools/powe=
r/acpi
>> >
>> > On Sat, Oct 29, 2016 at 3:23 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
>> > > Hi,
>> > >
>> > > Please try this patch:
>> > > https://patchwork.kernel.org/patch/9392155/
>> > > Which makes tools/power/acpi build more robust to survive toolchains=
 that are not generated from
>> the
>> > current kernel header.
>> >
>> >
>> > Better, but no, it doesn't fully fix the issue.
>> >
>> >  DESCEND  power/acpi
>> >  DESCEND  tools/acpidbg
>> > output/host/usr/bin/i586-buildroot-linux-uclibc-gcc -D_LINUX
>> > -I../../../include -I..
>> > /../../drivers/acpi/acpica -Wall -Wstrict-prototypes
>> > -Wdeclaration-after-statement -O1 -g -DDEBUG -DACPI_APPLICATI
>> > ON -DACPI_SINGLE_THREAD -DACPI_DEBUGGER -I.
>> > -I../../../../../drivers/acpi/acpica -I../../include   -c -o acpidbg.o
>> > acpidbg.c
>> > acpidbg.c:12:23: fatal error: acpi/acpi.h: No such file or directory
>> > #include <acpi/acpi.h>
>> >                       ^
>
> How did you trigger this?

I'm compiling it as a package in Buildroot environment which uses
uClibc and cross compiler.

> I just tried to cross compile all tools, similar failures can be seen on =
many other tools.
>
> Could you stay in the kernel srctree, and

I'm afraid I can't do exactly this one. I'm using make
O=3D/path/to/kernel/build. But I will try to look what I have there.

> # cd tools
> # make ARCH=3Dyour_arch CROSS_COMPILE=3Dyour_compiler-prefix acpi_clean
> # make ARCH=3Dyour_arch CROSS_COMPILE=3Dyour_compiler-prefix acpi
> # ls power/acpi/include/acpi
>
> What will be shown then?

$ ls -l tools/power/acpi/
total 4
drwxr-xr-x 3 andy andy 4096 Oct 29 19:03 tools

There is no include folder.

>
> Thanks and best regards
> Lv
>
>> > compilation terminated.
>> > <builtin>: recipe for target 'acpidbg.o' failed
>>
>> If you mean this line is not correct:
>> +     ln -s ../../../../include/acpi include/acpi
>> I'll try to improve it.
>>
>> Thanks
>> Lv
>>
>> >
>> >
>> >
>> > >
>> > > Thanks
>> > > Lv
>> > >
>> > >> From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
>> > >> Subject: Fix in ACPICA tools broke cross compilation of tools/power=
/acpi
>> > >>
>> > >> Hi!
>> > >>
>> > >> Reverting of the commit e323c02dee59 ("ACPICA: MSVC9: Fix <sys/stat=
.h>
>> > >> inclusion order issue") fixes the following issue:
>> > >>
>> > >>   DESCEND  power/acpi
>> > >>   DESCEND  tools/acpidbg
>> > >> output/host/usr/bin/i586-buildroot-linux-uclibc-gcc -D_LINUX
>> > >> -I../../../include -I../../../drivers/acpi/acpica -Wall
>> > >> -Wstrict-prototypes -Wdeclaration-after-statement -O1 -g -DDEBUG
>> > >> -DACPI_APPLICATION -DACPI_SINGLE_THREAD -DACPI_DEBUGGER -I.
>> > >> -I../../../../../drivers/acpi/acpica -I../../../../../include   -c =
-o
>> > >> acpidbg.o acpidbg.c
>> > >> In file included from
>> > >> output/host/usr/i586-buildroot-linux-uclibc/sysroot/usr/include/asm=
/sigcontext.h:18:0,
>> > >>                  from
>> > >> output/host/usr/i586-buildroot-linux-uclibc/sysroot/usr/include/bit=
s/sigcontext.h:30,
>> > >>                  from
>> > >> output/host/usr/i586-buildroot-linux-uclibc/sysroot/usr/include/sig=
nal.h:335,
>> > >>                  from ../../../../../include/acpi/platform/acenv.h:=
365,
>> > >>                  from ../../../../../include/acpi/acpi.h:56,
>> > >>                  from acpidbg.c:12:
>> > >> ../../../../../include/linux/types.h:14:26: error: conflicting type=
s
>> > >> for =E2=80=98fd_set=E2=80=99
>> > >>  typedef __kernel_fd_set  fd_set;
>> > >>                           ^
>> > >> In file included from
>> > >> output/host/usr/i586-buildroot-linux-uclibc/sysroot/usr/include/sys=
/types.h:219:0,
>> > >>                  from
>> > >> output/host/usr/i586-buildroot-linux-uclibc/sysroot/usr/include/std=
lib.h:198,
>> > >>                  from ../../../../../include/acpi/platform/acenv.h:=
357,
>> > >>                  from ../../../../../include/acpi/acpi.h:56,
>> > >>                  from acpidbg.c:12:
>> > >> output/host/usr/i586-buildroot-linux-uclibc/sysroot/usr/include/sys=
/select.h:77:5:
>> > >> note: previous declaration of =E2=80=98fd_set=E2=80=99 was here
>> > >>    } fd_set;
>> > >>      ^
>> > >> In file included from
>> > >> output/host/usr/i586-buildroot-linux-uclibc/sysroot/usr/include/asm=
/sigcontext.h:18:0,
>> > >>                  from
>> > >> output/host/usr/i586-buildroot-linux-uclibc/sysroot/usr/include/bit=
s/sigcontext.h:30,
>> > >>                  from
>> > >> output/host/usr/i586-buildroot-linux-uclibc/sysroot/usr/include/sig=
nal.h:335,
>> > >>                  from ../../../../../include/acpi/platform/acenv.h:=
365,
>> > >>                  from ../../../../../include/acpi/acpi.h:56,
>> > >>                  from acpidbg.c:12:
>> > >> ../../../../../include/linux/types.h:15:25: error: conflicting type=
s for =E2=80=98dev_t=E2=80=99
>> > >>  typedef __kernel_dev_t  dev_t;
>> > >>
>> > >> And so on...
>> > >>
>> > >> After revert:
>> > >>
>> > >>   DESCEND  power/acpi
>> > >>   DESCEND  tools/acpidbg
>> > >> output/host/usr/bin/i586-buildroot-linux-uclibc-gcc -D_LINUX
>> > >> -I../../../include -I../../../drivers/acpi/acpica -Wall
>> > >> -Wstrict-prototypes -Wdeclaration-after-statement -O1 -g -DDEBUG
>> > >> -DACPI_APPLICATION -DACPI_SINGLE_THREAD -DACPI_DEBUGGER -I.
>> > >> -I../../../../../drivers/acpi/acpica -I../../../../../include   -c =
-o
>> > >> acpidbg.o acpidbg.c
>> > >>   LD       test-topic/acpidbg
>> > >> /usr/bin/install -c -d output/target/usr/sbin
>> > >> /usr/bin/install -c test-topic/acpidbg output/target/usr/sbin
>> > >>
>> > >> Any ideas how to fix this properly?
>> > >>
>> > >> --
>> > >> With Best Regards,
>> > >> Andy Shevchenko
>> >
>> >
>> >
>> > --
>> > With Best Regards,
>> > Andy Shevchenko
>>  =EF=BF=BD=EF=BF=BD=EC=B9=BB =EF=BF=BD&=EF=BF=BD~=EF=BF=BD&=EF=BF=BD =EF=
=BF=BD=EF=BF=BD+-=EF=BF=BD=EF=BF=BD=DD=B6 =EF=BF=BD=EF=BF=BDw=EF=BF=BD=EF=
=BF=BD=CB=9B=EF=BF=BD=EF=BF=BD=EF=BF=BDm=EF=BF=BDb=EF=BF=BD=EF=BF=BDZr=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD^n=EF=BF=BDr=EF=BF=BD=EF=BF=BD=EF=BF=BDz=
=EF=BF=BD =EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD&=EF=BF=BD=
=EF=BF=BD =EF=BF=BDG=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD (=EF=BF=BD=E9=9A=
=8E
>> =EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD =EF=BF=BD m=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=DE=96=EF=BF=BD=EF=BF=BD=EF=BF=BDf=EF=BF=BD=
=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BD~=EF=BF=BDm=EF=BF=BD



--=20
With Best Regards,
Andy Shevchenko
