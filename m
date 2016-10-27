From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Fix in ACPICA tools broke cross compilation of tools/power/acpi
Date: Fri, 28 Oct 2016 00:08:18 +0300
Message-ID: <CAHp75VcyRzKPGQXB736EdvyXm9m3ShnLS3Xyrjnh7iRTE5M-uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:33833 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934631AbcJ0VIU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Oct 2016 17:08:20 -0400
Received: by mail-oi0-f53.google.com with SMTP id p136so23485698oic.1
        for <linux-acpi@vger.kernel.org>; Thu, 27 Oct 2016 14:08:19 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi!

Reverting of the commit e323c02dee59 ("ACPICA: MSVC9: Fix <sys/stat.h>
inclusion order issue") fixes the following issue:

  DESCEND  power/acpi
  DESCEND  tools/acpidbg
output/host/usr/bin/i586-buildroot-linux-uclibc-gcc -D_LINUX
-I../../../include -I../../../drivers/acpi/acpica -Wall
-Wstrict-prototypes -Wdeclaration-after-statement -O1 -g -DDEBUG
-DACPI_APPLICATION -DACPI_SINGLE_THREAD -DACPI_DEBUGGER -I.
-I../../../../../drivers/acpi/acpica -I../../../../../include   -c -o
acpidbg.o acpidbg.c
In file included from
output/host/usr/i586-buildroot-linux-uclibc/sysroot/usr/include/asm/sigcont=
ext.h:18:0,
                 from
output/host/usr/i586-buildroot-linux-uclibc/sysroot/usr/include/bits/sigcon=
text.h:30,
                 from
output/host/usr/i586-buildroot-linux-uclibc/sysroot/usr/include/signal.h:33=
5,
                 from ../../../../../include/acpi/platform/acenv.h:365,
                 from ../../../../../include/acpi/acpi.h:56,
                 from acpidbg.c:12:
../../../../../include/linux/types.h:14:26: error: conflicting types
for =E2=80=98fd_set=E2=80=99
 typedef __kernel_fd_set  fd_set;
                          ^
In file included from
output/host/usr/i586-buildroot-linux-uclibc/sysroot/usr/include/sys/types.h=
:219:0,
                 from
output/host/usr/i586-buildroot-linux-uclibc/sysroot/usr/include/stdlib.h:19=
8,
                 from ../../../../../include/acpi/platform/acenv.h:357,
                 from ../../../../../include/acpi/acpi.h:56,
                 from acpidbg.c:12:
output/host/usr/i586-buildroot-linux-uclibc/sysroot/usr/include/sys/select.=
h:77:5:
note: previous declaration of =E2=80=98fd_set=E2=80=99 was here
   } fd_set;
     ^
In file included from
output/host/usr/i586-buildroot-linux-uclibc/sysroot/usr/include/asm/sigcont=
ext.h:18:0,
                 from
output/host/usr/i586-buildroot-linux-uclibc/sysroot/usr/include/bits/sigcon=
text.h:30,
                 from
output/host/usr/i586-buildroot-linux-uclibc/sysroot/usr/include/signal.h:33=
5,
                 from ../../../../../include/acpi/platform/acenv.h:365,
                 from ../../../../../include/acpi/acpi.h:56,
                 from acpidbg.c:12:
../../../../../include/linux/types.h:15:25: error: conflicting types for =
=E2=80=98dev_t=E2=80=99
 typedef __kernel_dev_t  dev_t;

And so on...

After revert:

  DESCEND  power/acpi
  DESCEND  tools/acpidbg
output/host/usr/bin/i586-buildroot-linux-uclibc-gcc -D_LINUX
-I../../../include -I../../../drivers/acpi/acpica -Wall
-Wstrict-prototypes -Wdeclaration-after-statement -O1 -g -DDEBUG
-DACPI_APPLICATION -DACPI_SINGLE_THREAD -DACPI_DEBUGGER -I.
-I../../../../../drivers/acpi/acpica -I../../../../../include   -c -o
acpidbg.o acpidbg.c
  LD       test-topic/acpidbg
/usr/bin/install -c -d output/target/usr/sbin
/usr/bin/install -c test-topic/acpidbg output/target/usr/sbin

Any ideas how to fix this properly?

--=20
With Best Regards,
Andy Shevchenko
