From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: Fix in ACPICA tools broke cross compilation of tools/power/acpi
Date: Tue, 15 Nov 2016 16:23:50 +0200
Message-ID: <CAHp75VcA15mVwUYF75dWdSp=BZmf_KCsE+t5qBfsiXHPMdUJiw@mail.gmail.com>
References: <CAHp75VcyRzKPGQXB736EdvyXm9m3ShnLS3Xyrjnh7iRTE5M-uw@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886A25E72C@SHSMSX101.ccr.corp.intel.com>
 <CAHp75Vfp3v-SUk=ot35g9VReexCgYFjr1i=fVwyq1_Xg37ub8g@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886A25EA6F@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E886A25EBA3@SHSMSX101.ccr.corp.intel.com>
 <CAHp75Veg7XehhF_GcwQC4XxrjJGj6gxqd-sw044vOhE+2aGGBA@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886A2618E2@SHSMSX101.ccr.corp.intel.com> <CAHp75VccqXjwXg0s-n7r5-MzhzxmYS9AKpphckn=ytZNSkdyRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:34832 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbcKOOXv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Nov 2016 09:23:51 -0500
Received: by mail-yw0-f172.google.com with SMTP id i145so96716948ywg.2
        for <linux-acpi@vger.kernel.org>; Tue, 15 Nov 2016 06:23:51 -0800 (PST)
In-Reply-To: <CAHp75VccqXjwXg0s-n7r5-MzhzxmYS9AKpphckn=ytZNSkdyRw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, Nov 15, 2016 at 12:27 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Nov 3, 2016 at 5:04 PM, Zheng, Lv <lv.zheng@intel.com> wrote:
>>> On Sun, Oct 30, 2016 at 9:04 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
>
>>> >> > > Please try this patch:
>>> >> > > https://patchwork.kernel.org/patch/9392155/
>>> >> > > Which makes tools/power/acpi build more robust to survive toolch=
ains that are not generated
>>> from
>>> >> the
>>> >> > current kernel header.

Okay, I did a totally clean build (latest linux-next kernel and
buildroot) without mention patch and still see the issue described
below:

> But reveals another, the output path is broken:
>
> output/host/usr/bin/i586-buildroot-linux-uclibc-gcc -c -D_LINUX -I
> $OUT/include -I $SRC/tools/power/acpi/../../../drivers/acpi/acpica
> -Wall -Wst
> rict-prototypes -Wdeclaration-after-statement -O1 -g -DDEBUG
> -DACPI_APPLICATION -DACPI_SINGLE_THREAD -DACPI_DEBUGG
> ER -I. -o $OUT/tools/acpidbg/acpidbg.o acpidbg.c
> Assembler messages:
> Fatal error: can't create $OUT/tools/acpidbg/acpidbg.o: No such file
> or directory
> ../../Makefile.rules:26: recipe for target '$OUT/tools/acpidbg/acpidbg.o'=
 failed
>
> $OUT =E2=80=94 path to O=3D
> $SRC =E2=80=94 path to kernel sources

>From latest run

output/host/usr/bin/i586-buildroot-linux-uclibc-gcc -c -D_LINUX -I
$OUT/include -I $SRC/tools/power/acpi/../../../drivers/acpi/acpica
-Wall -Wst
rict-prototypes -Wdeclaration-after-statement -O1 -g -DDEBUG
-DACPI_APPLICATION -DACPI_SINGLE_THREAD -DACPI_DEBUGG
ER -I. -o $OUT/tools/acpidbg/acpidbg.o acpidbg.c

Of course it fails since proper folder name should be
'tools/power/acpi/tools' instead of 'tools'.

--=20
With Best Regards,
Andy Shevchenko
