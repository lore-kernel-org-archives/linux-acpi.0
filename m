From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: Fix in ACPICA tools broke cross compilation of tools/power/acpi
Date: Tue, 15 Nov 2016 17:01:10 +0200
Message-ID: <CAHp75VdJ1Nb_qbRX9b=RfDX-8e2tOUvMcbgYx8aMr4COQN3p8Q@mail.gmail.com>
References: <CAHp75VcyRzKPGQXB736EdvyXm9m3ShnLS3Xyrjnh7iRTE5M-uw@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886A25E72C@SHSMSX101.ccr.corp.intel.com>
 <CAHp75Vfp3v-SUk=ot35g9VReexCgYFjr1i=fVwyq1_Xg37ub8g@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886A25EA6F@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E886A25EBA3@SHSMSX101.ccr.corp.intel.com>
 <CAHp75Veg7XehhF_GcwQC4XxrjJGj6gxqd-sw044vOhE+2aGGBA@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886A2618E2@SHSMSX101.ccr.corp.intel.com>
 <CAHp75VccqXjwXg0s-n7r5-MzhzxmYS9AKpphckn=ytZNSkdyRw@mail.gmail.com> <CAHp75VcA15mVwUYF75dWdSp=BZmf_KCsE+t5qBfsiXHPMdUJiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:33959 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752601AbcKOPBN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Nov 2016 10:01:13 -0500
Received: by mail-yw0-f178.google.com with SMTP id t125so97416216ywc.1
        for <linux-acpi@vger.kernel.org>; Tue, 15 Nov 2016 07:01:12 -0800 (PST)
In-Reply-To: <CAHp75VcA15mVwUYF75dWdSp=BZmf_KCsE+t5qBfsiXHPMdUJiw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, Nov 15, 2016 at 4:23 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Nov 15, 2016 at 12:27 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Thu, Nov 3, 2016 at 5:04 PM, Zheng, Lv <lv.zheng@intel.com> wrote:
>>>> On Sun, Oct 30, 2016 at 9:04 AM, Zheng, Lv <lv.zheng@intel.com> wrote:

>> But reveals another, the output path is broken:
>>
>> output/host/usr/bin/i586-buildroot-linux-uclibc-gcc -c -D_LINUX -I
>> $OUT/include -I $SRC/tools/power/acpi/../../../drivers/acpi/acpica
>> -Wall -Wst
>> rict-prototypes -Wdeclaration-after-statement -O1 -g -DDEBUG
>> -DACPI_APPLICATION -DACPI_SINGLE_THREAD -DACPI_DEBUGG
>> ER -I. -o $OUT/tools/acpidbg/acpidbg.o acpidbg.c
>> Assembler messages:
>> Fatal error: can't create $OUT/tools/acpidbg/acpidbg.o: No such file
>> or directory
>> ../../Makefile.rules:26: recipe for target '$OUT/tools/acpidbg/acpidbg.o=
' failed
>>
>> $OUT =E2=80=94 path to O=3D
>> $SRC =E2=80=94 path to kernel sources
>
> From latest run
>
> output/host/usr/bin/i586-buildroot-linux-uclibc-gcc -c -D_LINUX -I
> $OUT/include -I $SRC/tools/power/acpi/../../../drivers/acpi/acpica
> -Wall -Wst
> rict-prototypes -Wdeclaration-after-statement -O1 -g -DDEBUG
> -DACPI_APPLICATION -DACPI_SINGLE_THREAD -DACPI_DEBUGG
> ER -I. -o $OUT/tools/acpidbg/acpidbg.o acpidbg.c
>
> Of course it fails since proper folder name should be
> 'tools/power/acpi/tools' instead of 'tools'.

The below + several runs (need to serialize makefile, by default it
races install vs. build)  helped eventually.

--- a/tools/power/acpi/Makefile.rules
+++ b/tools/power/acpi/Makefile.rules
@@ -8,9 +8,9 @@
# as published by the Free Software Foundation; version 2
# of the License.

-objdir :=3D $(OUTPUT)tools/$(TOOL)/
+objdir :=3D $(OUTPUT)tools/power/acpi/tools/$(TOOL)/
toolobjs :=3D $(addprefix $(objdir),$(TOOL_OBJS))
-$(OUTPUT)$(TOOL): $(KERNEL_INCLUDE) $(toolobjs) FORCE
+$(objdir)$(TOOL): $(KERNEL_INCLUDE) $(toolobjs) FORCE
       $(ECHO) "  LD      " $(subst $(OUTPUT),,$@)
       $(QUIET) $(LD) $(CFLAGS) $(LDFLAGS) $(toolobjs) -L$(OUTPUT) -o $@
       $(ECHO) "  STRIP   " $(subst $(OUTPUT),,$@)
@@ -26,21 +26,21 @@ $(objdir)%.o: %.c
       $(ECHO) "  CC      " $(subst $(OUTPUT),,$@)
       $(QUIET) $(CC) -c $(CFLAGS) -o $@ $<

-all: $(OUTPUT)$(TOOL)
+all: $(objdir)$(TOOL)
clean:
       $(ECHO) "  RMOBJ   " $(subst $(OUTPUT),,$(objdir))
       $(QUIET) find $(objdir) \( -not -type d \)\
                -and \( -name '*~' -o -name '*.[oas]' \)\
                -type f -print | xargs rm -f
       $(ECHO) "  RM      " $(TOOL)
-       $(QUIET) rm -f $(OUTPUT)$(TOOL)
+       $(QUIET) rm -f $(objdir)$(TOOL)
       $(ECHO) "  RMINC   " $(subst $(OUTPUT),,$(KERNEL_INCLUDE))
       $(QUIET) rm -rf $(KERNEL_INCLUDE)

install-tools:
       $(ECHO) "  INST    " $(TOOL)
       $(QUIET) $(INSTALL) -d $(DESTDIR)$(sbindir)
-       $(QUIET) $(INSTALL_PROGRAM) $(OUTPUT)$(TOOL) $(DESTDIR)$(sbindir)
+       $(QUIET) $(INSTALL_PROGRAM) $(objdir)$(TOOL) $(DESTDIR)$(sbindir)
uninstall-tools:
       $(ECHO) "  UNINST  " $(TOOL)
       $(QUIET) rm -f $(DESTDIR)$(sbindir)/$(TOOL)


--=20
With Best Regards,
Andy Shevchenko
