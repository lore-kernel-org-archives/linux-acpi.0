From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH 00/30] ACPICA: 20160629 Release
Date: Fri, 5 Aug 2016 08:43:44 -0600
Message-ID: <79879f34-e449-e2d1-edf7-c5d81b35aca8@redhat.com>
References: <cover.1470299677.git.lv.zheng@intel.com>
 <13c8b6e0-c9a1-68a0-ebff-942136faba25@redhat.com>
 <1AE640813FDE7649BE1B193DEA596E883BC0A44D@SHSMSX101.ccr.corp.intel.com>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:35303 "EHLO
	mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759770AbcHEOnr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Aug 2016 10:43:47 -0400
Received: by mail-it0-f54.google.com with SMTP id u186so23596121ita.0
        for <linux-acpi@vger.kernel.org>; Fri, 05 Aug 2016 07:43:46 -0700 (PDT)
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BC0A44D@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 08/04/2016 06:42 PM, Zheng, Lv wrote:
> Hi,
> 
>> From: Al Stone [mailto:ahs3@redhat.com]
>> Subject: Re: [PATCH 00/30] ACPICA: 20160629 Release
>>
>> On 08/04/2016 02:36 AM, Lv Zheng wrote:
>>> The 20160629 ACPICA kernel-resident subsystem updates are linuxized
>> based
>>> on the linux-pm/linux-next branch.
>>>
>>> The patchset has passed the following build/boot tests.
>>> Build tests are performed as follows:
>>> 1. i386 + allyes
>>> 2. i386 + allno
>>> 3. i386 + default + ACPI_DEBUGGER=y
>>> 4. i386 + default + ACPI_DEBUGGER=n + ACPI_DEBUG=y
>>> 5. i386 + default + ACPI_DEBUG=n + ACPI=y
>>> 6. i386 + default + ACPI=n
>>> 7. x86_64 + allyes
>>> 8. x86_64 + allno
>>> 9. x86_64 + default + ACPI_DEBUGGER=y
>>> 10.x86_64 + default + ACPI_DEBUGGER=n + ACPI_DEBUG=y
>>> 11.x86_64 + default + ACPI_DEBUG=n + ACPI=y
>>> 12.x86_64 + default + ACPI=n
>>> Boot tests are performed as follows:
>>> 1. i386 + default + ACPI_DEBUGGER=y
>>> 2. x86_64 + default + ACPI_DEBUGGER=y
>>> Where:
>>> 1. i386: machine named as "Dell Inspiron Mini 1010"
>>> 2. x86_64: machine named as "HP Compaq 8200 Elite SFF PC"
>>> 3. default: kernel configuration with following items enabled:
>>>    All hardware drivers related to the machines of i386/x86_64
>>>    All "drivers/acpi" configurations
>>>    All "drivers/platform" drivers
>>>    All other drivers that link the APIs provided by ACPICA subsystem
>>>
>>> The divergences checking result:
>>> Before applying (20160422 Release):
>>>   494 lines
>>> After applying (20160629 Release):
>>>   508 lines
>>>
>>> Bob Moore (8):
>>>   ACPICA: Interpreter: Remove temporary code for External() opcode
>>>   ACPICA: Debugger: Extend some max line lengths
>>>   ACPICA: Disassembler: Add option to emit embedded External
>>>     operators/opcodes
>>>   ACPICA: Simplify configuration for "Max Loops" system parameter
>>>   ACPICA: iASL/Disassembler: Add a check for missing filename
>>>   ACPICA: Use os_allocate_zeroed
>>>   ACPICA: FADT support cleanup
>>>   ACPICA: Update version to 20160629
>>>
>>> Jung-uk Kim (2):
>>>   ACPICA: Fix deconstification warnings (-Wcast-qual) with function
>>>     traces.
>>>   ACPICA: Fix deconstification warnings (-Wcast-qual) with
>>>     acpi_ns_root_initialize().
>>>
>>> Lv Zheng (20):
>>>   ACPICA: Utilities: Introduce facility to allow Linux to set correct
>>>     logging levels
>>>   ACPICA: Divergence: Port declarators back to ACPICA
>>>   ACPICA: Events: Introduce acpi_mask_gpe() to implement GPE masking
>>>     mechanism
>>>   ACPI / sysfs: Update /sys/firmware/acpi/interrupts/gpexx using new
>>>     GPE masking mechanism
>>>   ACPI / sysfs: Provide quirk mechanism to prevent GPE flooding
>>>   ACPICA: Debugger: Fix wrong inclusions in dbfileio.c
>>>   ACPICA: OSL: Add correct acpi_gbl_debug_timeout export to allow
>>>     acpiexec to link
>>>   ACPICA: acpidump: Fix a duplicate variable definition
>>>   ACPICA: Applications: Enable USE_NATIVE_ALLOCATE_ZEROED
>> environment
>>>     for all applications
>>>   ACPICA: Clib: Fix build issues when ACPI_USE_STANDARD_HEADERS is
>> not
>>>     defined by converting size_t to acpi_size
>>>   ACPICA: Clib: Cleanup va_arg related code
>>>   ACPICA: Clib: Fix wrong mini C library usage
>>>   ACPICA: Clib/EFI: Fix wrong order of standard integer types/IO
>>>     handles
>>>   ACPICA: MSVC9: Fix <sys/stat.h> inclusion order issue
>>>   ACPICA: Clib: Add -nostdinc support for EFI layer
>>>   ACPICA: Clib: Eliminate acpi_os_XXXFile()/acpi_log_error and link
>>>     clibrary fxxx()/errno/perror() instead
>>>   ACPICA: Applications: Fix a potential issue that help messages may be
>>>     dumped to acpi_gbl_debug_file
>>>   ACPICA: EFI: Port acpidump to EDK2 environment
>>>   ACPICA: OSL: Cleanup the inclusion order of the compiler-specific
>>>     headers
>>>   ACPICA: OSL: Fix a regression that old GCC requires a workaround for
>>>     strchr()
>>>
>>>  Documentation/kernel-parameters.txt                |   10 +
>>>  drivers/acpi/acpica/acapps.h                       |   10 +-
>>>  drivers/acpi/acpica/acevents.h                     |    3 +
>>>  drivers/acpi/acpica/acglobal.h                     |    2 +
>>>  drivers/acpi/acpica/aclocal.h                      |    2 +
>>>  drivers/acpi/acpica/actables.h                     |    3 +-
>>>  drivers/acpi/acpica/acutils.h                      |   36 ++--
>>>  drivers/acpi/acpica/dbfileio.c                     |   20 +-
>>>  drivers/acpi/acpica/dbobject.c                     |    4 +-
>>>  drivers/acpi/acpica/dsutils.c                      |   17 +-
>>>  drivers/acpi/acpica/evgpe.c                        |   57 +++++
>>>  drivers/acpi/acpica/evxfgpe.c                      |   43 ++++
>>>  drivers/acpi/acpica/hwgpe.c                        |   23 ++-
>>>  drivers/acpi/acpica/nsaccess.c                     |    6 +-
>>>  drivers/acpi/acpica/nsdump.c                       |    2 +-
>>>  drivers/acpi/acpica/tbfadt.c                       |   10 +-
>>>  drivers/acpi/acpica/tbutils.c                      |    3 +-
>>>  drivers/acpi/acpica/tbxface.c                      |    4 +-
>>>  drivers/acpi/acpica/tbxfload.c                     |    4 +-
>>>  drivers/acpi/acpica/tbxfroot.c                     |    5 +-
>>>  drivers/acpi/acpica/utbuffer.c                     |   30 ++-
>>>  drivers/acpi/acpica/utdebug.c                      |   61 +++---
>>>  drivers/acpi/acpica/utdecode.c                     |    2 +-
>>>  drivers/acpi/acpica/utinit.c                       |    2 +-
>>>  drivers/acpi/acpica/utpredef.c                     |    2 -
>>>  drivers/acpi/acpica/utprint.c                      |  105 ++++++++--
>>>  drivers/acpi/acpica/uttrack.c                      |    4 +-
>>>  drivers/acpi/acpica/utxface.c                      |    2 +-
>>>  drivers/acpi/acpica/utxfinit.c                     |    6 +-
>>>  drivers/acpi/internal.h                            |    1 +
>>>  drivers/acpi/scan.c                                |    1 +
>>>  drivers/acpi/sleep.c                               |    2 +-
>>>  drivers/acpi/sysfs.c                               |   89 +++++++-
>>>  include/acpi/acconfig.h                            |    4 +
>>>  include/acpi/acoutput.h                            |    6 +-
>>>  include/acpi/acpiosxf.h                            |   43 +---
>>>  include/acpi/acpixf.h                              |   37 ++--
>>>  include/acpi/actbl.h                               |  164 ++++++++-------
>>>  include/acpi/actypes.h                             |   48 ++---
>>>  include/acpi/platform/acenv.h                      |   90 +++-----
>>>  include/acpi/platform/acenvex.h                    |   21 +-
>>>  include/acpi/platform/acgcc.h                      |   17 +-
>>>  include/acpi/platform/acgccex.h                    |   58 ++++++
>>>  include/acpi/platform/aclinux.h                    |   22 +-
>>>  include/acpi/platform/aclinuxex.h                  |    2 +-
>>>  tools/power/acpi/common/cmfsize.c                  |   13 +-
>>>  tools/power/acpi/common/getopt.c                   |    4 +-
>>>  .../acpi/os_specific/service_layers/oslibcfs.c     |  217 --------------------
>>>  .../acpi/os_specific/service_layers/osunixxf.c     |    3 -
>>>  tools/power/acpi/tools/acpidump/Makefile           |    1 -
>>>  tools/power/acpi/tools/acpidump/acpidump.h         |   12 +-
>>>  tools/power/acpi/tools/acpidump/apdump.c           |   71 +++----
>>>  tools/power/acpi/tools/acpidump/apfiles.c          |   56 ++---
>>>  tools/power/acpi/tools/acpidump/apmain.c           |   33 +--
>>>  54 files changed, 796 insertions(+), 697 deletions(-)
>>>  create mode 100644 include/acpi/platform/acgccex.h
>>>  delete mode 100644
>> tools/power/acpi/os_specific/service_layers/oslibcfs.c
>>>
>>
>> I'm very confused.  I don't see a 20160629 release on the ACPICA .org
>> download site.  There is a 20160729, though; is this just a typo?  Patch
>> 30/30 indicates it is...
> [Lv Zheng] 
> I couldn't see 20160729 on acpica.org.
> This is the original commit:
> https://github.com/acpica/acpica/commit/1e997ab9a
> 
> I just followed the rule and generated the ACPICA release according to the indicator in the last commit.
> I'm not sure if this is a typo or just a delayed release.
> 
> Ciao,
> Lv
> 

Weird.  Something is wrong with someone's browser, then (either yours or mine),
or with the website.  When I go to https://www.acpica.org/downloads, there is
no 20160629 listed.  The most recent version is shown as 20160729.

There is also no tag in the git tree for R06_29_16 -- there is a tag for the
R07_29_16 release, though.  The odd thing is the 1e997ab9a commit says it is
the "Version 20160629", and the commit immediately prior to that is 08869b98,
saying "Version 20160729".  I don't really care which one it is supposed to be,
but it's not clear to me which one is correct.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
