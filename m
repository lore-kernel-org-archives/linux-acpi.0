From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: Fix in ACPICA tools broke cross compilation of tools/power/acpi
Date: Tue, 15 Nov 2016 12:27:20 +0200
Message-ID: <CAHp75VccqXjwXg0s-n7r5-MzhzxmYS9AKpphckn=ytZNSkdyRw@mail.gmail.com>
References: <CAHp75VcyRzKPGQXB736EdvyXm9m3ShnLS3Xyrjnh7iRTE5M-uw@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886A25E72C@SHSMSX101.ccr.corp.intel.com>
 <CAHp75Vfp3v-SUk=ot35g9VReexCgYFjr1i=fVwyq1_Xg37ub8g@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886A25EA6F@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E886A25EBA3@SHSMSX101.ccr.corp.intel.com>
 <CAHp75Veg7XehhF_GcwQC4XxrjJGj6gxqd-sw044vOhE+2aGGBA@mail.gmail.com> <1AE640813FDE7649BE1B193DEA596E886A2618E2@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:36211 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941399AbcKOK10 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Nov 2016 05:27:26 -0500
Received: by mail-it0-f44.google.com with SMTP id q124so162356016itd.1
        for <linux-acpi@vger.kernel.org>; Tue, 15 Nov 2016 02:27:26 -0800 (PST)
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886A2618E2@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, Nov 3, 2016 at 5:04 PM, Zheng, Lv <lv.zheng@intel.com> wrote:
>> On Sun, Oct 30, 2016 at 9:04 AM, Zheng, Lv <lv.zheng@intel.com> wrote:

>> >> > > Please try this patch:
>> >> > > https://patchwork.kernel.org/patch/9392155/
>> >> > > Which makes tools/power/acpi build more robust to survive toolcha=
ins that are not generated
>> from
>> >> the
>> >> > current kernel header.
>> >> >
>> >> >
>> >> > Better, but no, it doesn't fully fix the issue.
>> >> >
>> >> >  DESCEND  power/acpi
>> >> >  DESCEND  tools/acpidbg
>> >> > output/host/usr/bin/i586-buildroot-linux-uclibc-gcc -D_LINUX
>> >> > -I../../../include -I..
>> >> > /../../drivers/acpi/acpica -Wall -Wstrict-prototypes
>> >> > -Wdeclaration-after-statement -O1 -g -DDEBUG -DACPI_APPLICATI
>> >> > ON -DACPI_SINGLE_THREAD -DACPI_DEBUGGER -I.
>> >> > -I../../../../../drivers/acpi/acpica -I../../include   -c -o acpidb=
g.o
>> >> > acpidbg.c
>> >> > acpidbg.c:12:23: fatal error: acpi/acpi.h: No such file or director=
y
>> >> > #include <acpi/acpi.h>
>> >> >                       ^
>> >

The following fixing the above issue...

--- a/tools/power/acpi/Makefile.rules
+++ b/tools/power/acpi/Makefile.rules
@@ -10,13 +10,13 @@

objdir :=3D $(OUTPUT)tools/$(TOOL)/
toolobjs :=3D $(addprefix $(objdir),$(TOOL_OBJS))
-$(OUTPUT)$(TOOL): $(KERNEL_INCLUDE) $(toolobjs) FORCE
+$(OUTPUT)$(TOOL): $(KERNEL_INCLUDE)/acpi $(toolobjs) FORCE
       $(ECHO) "  LD      " $(subst $(OUTPUT),,$@)
       $(QUIET) $(LD) $(CFLAGS) $(LDFLAGS) $(toolobjs) -L$(OUTPUT) -o $@
       $(ECHO) "  STRIP   " $(subst $(OUTPUT),,$@)
       $(QUIET) $(STRIPCMD) $@

-$(KERNEL_INCLUDE):
+$(KERNEL_INCLUDE)/acpi:
       $(ECHO) "  MKDIR   " $(subst $(OUTPUT),,$@)
       $(QUIET) mkdir -p $(KERNEL_INCLUDE)
       $(ECHO) "  CP      " $(subst $(OUTPUT),,$@)


But reveals another, the output path is broken:

output/host/usr/bin/i586-buildroot-linux-uclibc-gcc -c -D_LINUX -I
$OUT/include -I $SRC/tools/power/acpi/../../../drivers/acpi/acpica
-Wall -Wst
rict-prototypes -Wdeclaration-after-statement -O1 -g -DDEBUG
-DACPI_APPLICATION -DACPI_SINGLE_THREAD -DACPI_DEBUGG
ER -I. -o $OUT/tools/acpidbg/acpidbg.o acpidbg.c
Assembler messages:
Fatal error: can't create $OUT/tools/acpidbg/acpidbg.o: No such file
or directory
../../Makefile.rules:26: recipe for target '$OUT/tools/acpidbg/acpidbg.o' f=
ailed

$OUT =E2=80=94 path to O=3D
$SRC =E2=80=94 path to kernel sources

--=20
With Best Regards,
Andy Shevchenko
