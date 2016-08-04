From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH 00/30] ACPICA: 20160629 Release
Date: Thu, 4 Aug 2016 10:12:02 -0600
Message-ID: <13c8b6e0-c9a1-68a0-ebff-942136faba25@redhat.com>
References: <cover.1470299677.git.lv.zheng@intel.com>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:35326 "EHLO
	mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758699AbcHDQMI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Aug 2016 12:12:08 -0400
Received: by mail-it0-f47.google.com with SMTP id u186so325960591ita.0
        for <linux-acpi@vger.kernel.org>; Thu, 04 Aug 2016 09:12:05 -0700 (PDT)
In-Reply-To: <cover.1470299677.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

On 08/04/2016 02:36 AM, Lv Zheng wrote:
> The 20160629 ACPICA kernel-resident subsystem updates are linuxized based
> on the linux-pm/linux-next branch.
> 
> The patchset has passed the following build/boot tests.
> Build tests are performed as follows:
> 1. i386 + allyes
> 2. i386 + allno
> 3. i386 + default + ACPI_DEBUGGER=y
> 4. i386 + default + ACPI_DEBUGGER=n + ACPI_DEBUG=y
> 5. i386 + default + ACPI_DEBUG=n + ACPI=y
> 6. i386 + default + ACPI=n
> 7. x86_64 + allyes
> 8. x86_64 + allno
> 9. x86_64 + default + ACPI_DEBUGGER=y
> 10.x86_64 + default + ACPI_DEBUGGER=n + ACPI_DEBUG=y
> 11.x86_64 + default + ACPI_DEBUG=n + ACPI=y
> 12.x86_64 + default + ACPI=n
> Boot tests are performed as follows:
> 1. i386 + default + ACPI_DEBUGGER=y
> 2. x86_64 + default + ACPI_DEBUGGER=y
> Where:
> 1. i386: machine named as "Dell Inspiron Mini 1010"
> 2. x86_64: machine named as "HP Compaq 8200 Elite SFF PC"
> 3. default: kernel configuration with following items enabled:
>    All hardware drivers related to the machines of i386/x86_64
>    All "drivers/acpi" configurations
>    All "drivers/platform" drivers
>    All other drivers that link the APIs provided by ACPICA subsystem
> 
> The divergences checking result:
> Before applying (20160422 Release):
>   494 lines
> After applying (20160629 Release):
>   508 lines
> 
> Bob Moore (8):
>   ACPICA: Interpreter: Remove temporary code for External() opcode
>   ACPICA: Debugger: Extend some max line lengths
>   ACPICA: Disassembler: Add option to emit embedded External
>     operators/opcodes
>   ACPICA: Simplify configuration for "Max Loops" system parameter
>   ACPICA: iASL/Disassembler: Add a check for missing filename
>   ACPICA: Use os_allocate_zeroed
>   ACPICA: FADT support cleanup
>   ACPICA: Update version to 20160629
> 
> Jung-uk Kim (2):
>   ACPICA: Fix deconstification warnings (-Wcast-qual) with function
>     traces.
>   ACPICA: Fix deconstification warnings (-Wcast-qual) with
>     acpi_ns_root_initialize().
> 
> Lv Zheng (20):
>   ACPICA: Utilities: Introduce facility to allow Linux to set correct
>     logging levels
>   ACPICA: Divergence: Port declarators back to ACPICA
>   ACPICA: Events: Introduce acpi_mask_gpe() to implement GPE masking
>     mechanism
>   ACPI / sysfs: Update /sys/firmware/acpi/interrupts/gpexx using new
>     GPE masking mechanism
>   ACPI / sysfs: Provide quirk mechanism to prevent GPE flooding
>   ACPICA: Debugger: Fix wrong inclusions in dbfileio.c
>   ACPICA: OSL: Add correct acpi_gbl_debug_timeout export to allow
>     acpiexec to link
>   ACPICA: acpidump: Fix a duplicate variable definition
>   ACPICA: Applications: Enable USE_NATIVE_ALLOCATE_ZEROED environment
>     for all applications
>   ACPICA: Clib: Fix build issues when ACPI_USE_STANDARD_HEADERS is not
>     defined by converting size_t to acpi_size
>   ACPICA: Clib: Cleanup va_arg related code
>   ACPICA: Clib: Fix wrong mini C library usage
>   ACPICA: Clib/EFI: Fix wrong order of standard integer types/IO
>     handles
>   ACPICA: MSVC9: Fix <sys/stat.h> inclusion order issue
>   ACPICA: Clib: Add -nostdinc support for EFI layer
>   ACPICA: Clib: Eliminate acpi_os_XXXFile()/acpi_log_error and link
>     clibrary fxxx()/errno/perror() instead
>   ACPICA: Applications: Fix a potential issue that help messages may be
>     dumped to acpi_gbl_debug_file
>   ACPICA: EFI: Port acpidump to EDK2 environment
>   ACPICA: OSL: Cleanup the inclusion order of the compiler-specific
>     headers
>   ACPICA: OSL: Fix a regression that old GCC requires a workaround for
>     strchr()
> 
>  Documentation/kernel-parameters.txt                |   10 +
>  drivers/acpi/acpica/acapps.h                       |   10 +-
>  drivers/acpi/acpica/acevents.h                     |    3 +
>  drivers/acpi/acpica/acglobal.h                     |    2 +
>  drivers/acpi/acpica/aclocal.h                      |    2 +
>  drivers/acpi/acpica/actables.h                     |    3 +-
>  drivers/acpi/acpica/acutils.h                      |   36 ++--
>  drivers/acpi/acpica/dbfileio.c                     |   20 +-
>  drivers/acpi/acpica/dbobject.c                     |    4 +-
>  drivers/acpi/acpica/dsutils.c                      |   17 +-
>  drivers/acpi/acpica/evgpe.c                        |   57 +++++
>  drivers/acpi/acpica/evxfgpe.c                      |   43 ++++
>  drivers/acpi/acpica/hwgpe.c                        |   23 ++-
>  drivers/acpi/acpica/nsaccess.c                     |    6 +-
>  drivers/acpi/acpica/nsdump.c                       |    2 +-
>  drivers/acpi/acpica/tbfadt.c                       |   10 +-
>  drivers/acpi/acpica/tbutils.c                      |    3 +-
>  drivers/acpi/acpica/tbxface.c                      |    4 +-
>  drivers/acpi/acpica/tbxfload.c                     |    4 +-
>  drivers/acpi/acpica/tbxfroot.c                     |    5 +-
>  drivers/acpi/acpica/utbuffer.c                     |   30 ++-
>  drivers/acpi/acpica/utdebug.c                      |   61 +++---
>  drivers/acpi/acpica/utdecode.c                     |    2 +-
>  drivers/acpi/acpica/utinit.c                       |    2 +-
>  drivers/acpi/acpica/utpredef.c                     |    2 -
>  drivers/acpi/acpica/utprint.c                      |  105 ++++++++--
>  drivers/acpi/acpica/uttrack.c                      |    4 +-
>  drivers/acpi/acpica/utxface.c                      |    2 +-
>  drivers/acpi/acpica/utxfinit.c                     |    6 +-
>  drivers/acpi/internal.h                            |    1 +
>  drivers/acpi/scan.c                                |    1 +
>  drivers/acpi/sleep.c                               |    2 +-
>  drivers/acpi/sysfs.c                               |   89 +++++++-
>  include/acpi/acconfig.h                            |    4 +
>  include/acpi/acoutput.h                            |    6 +-
>  include/acpi/acpiosxf.h                            |   43 +---
>  include/acpi/acpixf.h                              |   37 ++--
>  include/acpi/actbl.h                               |  164 ++++++++-------
>  include/acpi/actypes.h                             |   48 ++---
>  include/acpi/platform/acenv.h                      |   90 +++-----
>  include/acpi/platform/acenvex.h                    |   21 +-
>  include/acpi/platform/acgcc.h                      |   17 +-
>  include/acpi/platform/acgccex.h                    |   58 ++++++
>  include/acpi/platform/aclinux.h                    |   22 +-
>  include/acpi/platform/aclinuxex.h                  |    2 +-
>  tools/power/acpi/common/cmfsize.c                  |   13 +-
>  tools/power/acpi/common/getopt.c                   |    4 +-
>  .../acpi/os_specific/service_layers/oslibcfs.c     |  217 --------------------
>  .../acpi/os_specific/service_layers/osunixxf.c     |    3 -
>  tools/power/acpi/tools/acpidump/Makefile           |    1 -
>  tools/power/acpi/tools/acpidump/acpidump.h         |   12 +-
>  tools/power/acpi/tools/acpidump/apdump.c           |   71 +++----
>  tools/power/acpi/tools/acpidump/apfiles.c          |   56 ++---
>  tools/power/acpi/tools/acpidump/apmain.c           |   33 +--
>  54 files changed, 796 insertions(+), 697 deletions(-)
>  create mode 100644 include/acpi/platform/acgccex.h
>  delete mode 100644 tools/power/acpi/os_specific/service_layers/oslibcfs.c
> 

I'm very confused.  I don't see a 20160629 release on the ACPICA .org
download site.  There is a 20160729, though; is this just a typo?  Patch
30/30 indicates it is...

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
