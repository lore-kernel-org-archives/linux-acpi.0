From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: Fix in ACPICA tools broke cross compilation of tools/power/acpi
Date: Sat, 29 Oct 2016 19:04:02 +0300
Message-ID: <CAHp75Vfp3v-SUk=ot35g9VReexCgYFjr1i=fVwyq1_Xg37ub8g@mail.gmail.com>
References: <CAHp75VcyRzKPGQXB736EdvyXm9m3ShnLS3Xyrjnh7iRTE5M-uw@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886A25E72C@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:34439 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755717AbcJ2QJW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 29 Oct 2016 12:09:22 -0400
Received: by mail-oi0-f52.google.com with SMTP id 62so41115405oif.1
        for <linux-acpi@vger.kernel.org>; Sat, 29 Oct 2016 09:09:21 -0700 (PDT)
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886A25E72C@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sat, Oct 29, 2016 at 3:23 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
> Hi,
>
> Please try this patch:
> https://patchwork.kernel.org/patch/9392155/
> Which makes tools/power/acpi build more robust to survive toolchains that=
 are not generated from the current kernel header.


Better, but no, it doesn't fully fix the issue.

 DESCEND  power/acpi
 DESCEND  tools/acpidbg
output/host/usr/bin/i586-buildroot-linux-uclibc-gcc -D_LINUX
-I../../../include -I..
/../../drivers/acpi/acpica -Wall -Wstrict-prototypes
-Wdeclaration-after-statement -O1 -g -DDEBUG -DACPI_APPLICATI
ON -DACPI_SINGLE_THREAD -DACPI_DEBUGGER -I.
-I../../../../../drivers/acpi/acpica -I../../include   -c -o acpidbg.o
acpidbg.c
acpidbg.c:12:23: fatal error: acpi/acpi.h: No such file or directory
#include <acpi/acpi.h>
                      ^
compilation terminated.
<builtin>: recipe for target 'acpidbg.o' failed



>
> Thanks
> Lv
>
>> From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
>> Subject: Fix in ACPICA tools broke cross compilation of tools/power/acpi
>>
>> Hi!
>>
>> Reverting of the commit e323c02dee59 ("ACPICA: MSVC9: Fix <sys/stat.h>
>> inclusion order issue") fixes the following issue:
>>
>>   DESCEND  power/acpi
>>   DESCEND  tools/acpidbg
>> output/host/usr/bin/i586-buildroot-linux-uclibc-gcc -D_LINUX
>> -I../../../include -I../../../drivers/acpi/acpica -Wall
>> -Wstrict-prototypes -Wdeclaration-after-statement -O1 -g -DDEBUG
>> -DACPI_APPLICATION -DACPI_SINGLE_THREAD -DACPI_DEBUGGER -I.
>> -I../../../../../drivers/acpi/acpica -I../../../../../include   -c -o
>> acpidbg.o acpidbg.c
>> In file included from
>> output/host/usr/i586-buildroot-linux-uclibc/sysroot/usr/include/asm/sigc=
ontext.h:18:0,
>>                  from
>> output/host/usr/i586-buildroot-linux-uclibc/sysroot/usr/include/bits/sig=
context.h:30,
>>                  from
>> output/host/usr/i586-buildroot-linux-uclibc/sysroot/usr/include/signal.h=
:335,
>>                  from ../../../../../include/acpi/platform/acenv.h:365,
>>                  from ../../../../../include/acpi/acpi.h:56,
>>                  from acpidbg.c:12:
>> ../../../../../include/linux/types.h:14:26: error: conflicting types
>> for =E2=80=98fd_set=E2=80=99
>>  typedef __kernel_fd_set  fd_set;
>>                           ^
>> In file included from
>> output/host/usr/i586-buildroot-linux-uclibc/sysroot/usr/include/sys/type=
s.h:219:0,
>>                  from
>> output/host/usr/i586-buildroot-linux-uclibc/sysroot/usr/include/stdlib.h=
:198,
>>                  from ../../../../../include/acpi/platform/acenv.h:357,
>>                  from ../../../../../include/acpi/acpi.h:56,
>>                  from acpidbg.c:12:
>> output/host/usr/i586-buildroot-linux-uclibc/sysroot/usr/include/sys/sele=
ct.h:77:5:
>> note: previous declaration of =E2=80=98fd_set=E2=80=99 was here
>>    } fd_set;
>>      ^
>> In file included from
>> output/host/usr/i586-buildroot-linux-uclibc/sysroot/usr/include/asm/sigc=
ontext.h:18:0,
>>                  from
>> output/host/usr/i586-buildroot-linux-uclibc/sysroot/usr/include/bits/sig=
context.h:30,
>>                  from
>> output/host/usr/i586-buildroot-linux-uclibc/sysroot/usr/include/signal.h=
:335,
>>                  from ../../../../../include/acpi/platform/acenv.h:365,
>>                  from ../../../../../include/acpi/acpi.h:56,
>>                  from acpidbg.c:12:
>> ../../../../../include/linux/types.h:15:25: error: conflicting types for=
 =E2=80=98dev_t=E2=80=99
>>  typedef __kernel_dev_t  dev_t;
>>
>> And so on...
>>
>> After revert:
>>
>>   DESCEND  power/acpi
>>   DESCEND  tools/acpidbg
>> output/host/usr/bin/i586-buildroot-linux-uclibc-gcc -D_LINUX
>> -I../../../include -I../../../drivers/acpi/acpica -Wall
>> -Wstrict-prototypes -Wdeclaration-after-statement -O1 -g -DDEBUG
>> -DACPI_APPLICATION -DACPI_SINGLE_THREAD -DACPI_DEBUGGER -I.
>> -I../../../../../drivers/acpi/acpica -I../../../../../include   -c -o
>> acpidbg.o acpidbg.c
>>   LD       test-topic/acpidbg
>> /usr/bin/install -c -d output/target/usr/sbin
>> /usr/bin/install -c test-topic/acpidbg output/target/usr/sbin
>>
>> Any ideas how to fix this properly?
>>
>> --
>> With Best Regards,
>> Andy Shevchenko



--=20
With Best Regards,
Andy Shevchenko
