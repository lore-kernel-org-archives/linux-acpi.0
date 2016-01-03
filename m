From: David Lang <david@lang.hm>
Subject: Re: [PATCH 00/42] ACPICA: 20151218 Release
Date: Sat, 2 Jan 2016 22:45:24 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1601022243520.20790@nftneq.ynat.uz>
References: <cover.1451367388.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.lang.hm ([64.81.33.126]:50995 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750934AbcACGyG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 3 Jan 2016 01:54:06 -0500
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

what is ACPICA and why should we care about divergence between it and the linux 
upstream? Where is it to be found?

This may be common knowlege to many people, but it should probably be documented 
in the patch bundle and it's explination.

David Lang

On Tue, 29 Dec 2015, Lv Zheng wrote:

> Date: Tue, 29 Dec 2015 13:52:19 +0800
> From: Lv Zheng <lv.zheng@intel.com>
> To: Rafael J. Wysocki <rafael.j.wysocki@intel.com>,
>     Len Brown <len.brown@intel.com>
> Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>,
>     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
> Subject: [PATCH 00/42] ACPICA: 20151218 Release
> 
> The 20151218 ACPICA kernel-resident subsystem updates are linuxized based
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
>   All hardware drivers related to the machines of i386/x86_64
>   All "drivers/acpi" configurations
>   All "drivers/platform" drivers
>   All other drivers that link the APIs provided by ACPICA subsystem
>
> The divergences checking result:
> Before applying (20150930 Release):
>  517 lines
> After applying (20151218 Release):
>  506 lines
>
> Bob Moore (25):
>  ACPICA: exmutex: General cleanup, restructured some code
>  ACPICA: Core: Major update for code formatting, no functional changes
>  ACPICA: Split interpreter tracing functions to a new file
>  ACPICA: acpiexec: Add support for AML files containing multiple
>    tables
>  ACPICA: Disassembler/tools: Support for multiple ACPI tables in one
>    file
>  ACPICA: iasl/acpiexec: Update input file handling and verification
>  ACPICA: Revert "acpi_get_object_info: Add support for ACPI 5.0 _SUB
>    method."
>  ACPICA: Add comment explaining _SUB removal
>  ACPICA: acpiexec/acpinames: Update for error checking macros
>  ACPICA: Concatenate operator: Add extensions to support all ACPI
>    objects
>  ACPICA: Debug Object: Cleanup output
>  ACPICA: Debug object: Fix output for a NULL object
>  ACPICA: Update for output of the Debug Object
>  ACPICA: getopt: Comment update, no functional change
>  ACPICA: Add new exception code, AE_IO_ERROR
>  ACPICA: iasl/Disassembler: Support ASL ElseIf operator
>  ACPICA: Parser: Add constants for internal namepath function
>  ACPICA: Parser: Fix for SuperName method invocation
>  ACPICA: Update parameter type for ObjectType operator
>  ACPICA: Update internal #defines for ObjectType operator. No
>    functional change
>  ACPICA: Update for CondRefOf and RefOf operators
>  ACPICA: Cleanup code related to the per-table module level
>    improvement
>  ACPICA: Add "root node" case to the ACPI name repair code
>  ACPICA: Add per-table execution of module-level code
>  ACPICA: Update version to 20151218
>
> Colin Ian King (1):
>  ACPICA: Tools: Add spacing and missing options in acpibin tool
>
> David E. Box (1):
>  ACPICA: Fix SyncLevel support interaction with method
>    auto-serialization
>
> LABBE Corentin (1):
>  ACPICA: Add "const" to some functions that return fixed strings
>
> Lv Zheng (12):
>  ACPICA: Linuxize: reduce divergences for 20151218 release
>  ACPICA: Namespace: Fix wrong error log
>  ACPICA: Debugger: reduce old external path format
>  ACPICA: Namespace: Add scope information to the simple object repair
>    mechanism
>  ACPICA: Namespace: Add String -> ObjectReference conversion support
>  ACPICA: Events: Deploys acpi_ev_find_region_handler()
>  ACPICA: Events: Uses common_notify for address space handlers
>  ACPICA: Utilities: Reorder initialization code
>  ACPICA: Events: Fix an issue that region object is re-attached to
>    another scope when it is already attached
>  ACPICA: Events: Split acpi_ev_associate_reg_method() from region
>    initialization code
>  ACPICA: Events: Enhance acpi_ev_execute_reg_method() to ensure no
>    _REG evaluations can happen during OS early boot stages
>  ACPICA: Events: Introduce ACPI_REG_DISCONNECT invocation to
>    acpi_ev_execute_reg_methods()
>
> Markus Elfring (1):
>  ACPICA: Debugger: Remove some unecessary NULL checks
>
> Prarit Bhargava (1):
>  ACPICA: acpi_get_sleep_type_data: Reduce warnings
>
> drivers/acpi/acpica/Makefile                       |    4 +-
> drivers/acpi/acpica/acapps.h                       |   58 +-
> drivers/acpi/acpica/acdebug.h                      |    5 +-
> drivers/acpi/acpica/acevents.h                     |   11 +-
> drivers/acpi/acpica/acglobal.h                     |    3 +-
> drivers/acpi/acpica/aclocal.h                      |   12 +-
> drivers/acpi/acpica/acnamesp.h                     |   12 +-
> drivers/acpi/acpica/acobject.h                     |    7 +-
> drivers/acpi/acpica/acopcode.h                     |   10 +-
> drivers/acpi/acpica/acparser.h                     |    8 +-
> drivers/acpi/acpica/acutils.h                      |   26 +-
> drivers/acpi/acpica/amlcode.h                      |    5 +-
> drivers/acpi/acpica/dbcmds.c                       |   11 +-
> drivers/acpi/acpica/dbdisply.c                     |   84 ++-
> drivers/acpi/acpica/dbfileio.c                     |  123 +---
> drivers/acpi/acpica/dbinput.c                      |   22 +-
> drivers/acpi/acpica/dbnames.c                      |    2 +-
> drivers/acpi/acpica/dbstats.c                      |    1 +
> drivers/acpi/acpica/dbtest.c                       |    2 +-
> drivers/acpi/acpica/dbutils.c                      |    1 +
> drivers/acpi/acpica/dsargs.c                       |    7 +-
> drivers/acpi/acpica/dsdebug.c                      |    5 +-
> drivers/acpi/acpica/dsfield.c                      |   39 +-
> drivers/acpi/acpica/dsinit.c                       |    2 +-
> drivers/acpi/acpica/dsmethod.c                     |   39 +-
> drivers/acpi/acpica/dsmthdat.c                     |   20 +-
> drivers/acpi/acpica/dsobject.c                     |   19 +-
> drivers/acpi/acpica/dsopcode.c                     |   21 +-
> drivers/acpi/acpica/dsutils.c                      |   29 +-
> drivers/acpi/acpica/dswexec.c                      |   19 +-
> drivers/acpi/acpica/dswload.c                      |   10 +-
> drivers/acpi/acpica/dswload2.c                     |   10 +-
> drivers/acpi/acpica/dswscope.c                     |    1 +
> drivers/acpi/acpica/evgpe.c                        |    2 +-
> drivers/acpi/acpica/evgpeblk.c                     |    1 +
> drivers/acpi/acpica/evgpeutil.c                    |    1 +
> drivers/acpi/acpica/evhandler.c                    |  165 +++---
> drivers/acpi/acpica/evmisc.c                       |    5 +-
> drivers/acpi/acpica/evregion.c                     |  114 +++-
> drivers/acpi/acpica/evrgnini.c                     |  115 ++--
> drivers/acpi/acpica/evxface.c                      |    9 +-
> drivers/acpi/acpica/evxfregn.c                     |   38 +-
> drivers/acpi/acpica/exconfig.c                     |    8 +-
> drivers/acpi/acpica/exconvrt.c                     |    9 +-
> drivers/acpi/acpica/excreate.c                     |   20 +-
> drivers/acpi/acpica/exdebug.c                      |  403 ++-----------
> drivers/acpi/acpica/exdump.c                       |    6 +-
> drivers/acpi/acpica/exfield.c                      |   74 +--
> drivers/acpi/acpica/exfldio.c                      |   35 +-
> drivers/acpi/acpica/exmisc.c                       |   49 +-
> drivers/acpi/acpica/exmutex.c                      |   82 ++-
> drivers/acpi/acpica/exnames.c                      |    4 +-
> drivers/acpi/acpica/exoparg1.c                     |   33 +-
> drivers/acpi/acpica/exoparg2.c                     |   12 +-
> drivers/acpi/acpica/exoparg3.c                     |   25 +-
> drivers/acpi/acpica/exoparg6.c                     |    1 +
> drivers/acpi/acpica/exprep.c                       |   25 +-
> drivers/acpi/acpica/exregion.c                     |   13 +-
> drivers/acpi/acpica/exresnte.c                     |    2 +-
> drivers/acpi/acpica/exresolv.c                     |   10 +-
> drivers/acpi/acpica/exresop.c                      |   43 +-
> drivers/acpi/acpica/exstore.c                      |   17 +-
> drivers/acpi/acpica/exstorob.c                     |    7 +-
> drivers/acpi/acpica/exsystem.c                     |    6 +-
> drivers/acpi/acpica/extrace.c                      |  377 ++++++++++++
> drivers/acpi/acpica/exutils.c                      |    7 +-
> drivers/acpi/acpica/hwesleep.c                     |    4 +-
> drivers/acpi/acpica/hwgpe.c                        |    6 +-
> drivers/acpi/acpica/hwsleep.c                      |    4 +-
> drivers/acpi/acpica/hwxface.c                      |   24 +-
> drivers/acpi/acpica/hwxfsleep.c                    |    1 +
> drivers/acpi/acpica/nsconvert.c                    |  105 +++-
> drivers/acpi/acpica/nsdump.c                       |    5 +-
> drivers/acpi/acpica/nseval.c                       |    2 +-
> drivers/acpi/acpica/nsinit.c                       |    3 +-
> drivers/acpi/acpica/nsload.c                       |   18 +-
> drivers/acpi/acpica/nsnames.c                      |    6 +-
> drivers/acpi/acpica/nsparse.c                      |    5 +-
> drivers/acpi/acpica/nsprepkg.c                     |   10 +-
> drivers/acpi/acpica/nsrepair.c                     |   19 +-
> drivers/acpi/acpica/nsrepair2.c                    |   24 +-
> drivers/acpi/acpica/nssearch.c                     |    2 +-
> drivers/acpi/acpica/nsutils.c                      |    8 +-
> drivers/acpi/acpica/nsxfeval.c                     |    4 +-
> drivers/acpi/acpica/nsxfname.c                     |   39 +-
> drivers/acpi/acpica/nsxfobj.c                      |    6 +-
> drivers/acpi/acpica/psargs.c                       |   19 +-
> drivers/acpi/acpica/psloop.c                       |   12 +-
> drivers/acpi/acpica/psopcode.c                     |  606 ++++++++++----------
> drivers/acpi/acpica/psparse.c                      |    8 +-
> drivers/acpi/acpica/psutils.c                      |    4 +-
> drivers/acpi/acpica/pswalk.c                       |    1 +
> drivers/acpi/acpica/rsaddr.c                       |    4 +-
> drivers/acpi/acpica/rscalc.c                       |   81 +--
> drivers/acpi/acpica/rscreate.c                     |   32 +-
> drivers/acpi/acpica/rsdump.c                       |    6 +
> drivers/acpi/acpica/rslist.c                       |    9 +-
> drivers/acpi/acpica/rsmisc.c                       |   22 +-
> drivers/acpi/acpica/rsutils.c                      |   42 +-
> drivers/acpi/acpica/rsxface.c                      |    2 +-
> drivers/acpi/acpica/tbdata.c                       |    1 +
> drivers/acpi/acpica/tbinstal.c                     |    4 +-
> drivers/acpi/acpica/tbprint.c                      |    1 +
> drivers/acpi/acpica/tbutils.c                      |   10 +-
> drivers/acpi/acpica/tbxfload.c                     |    3 +-
> drivers/acpi/acpica/utaddress.c                    |    5 +-
> drivers/acpi/acpica/utcopy.c                       |   23 +-
> drivers/acpi/acpica/utdecode.c                     |   32 +-
> drivers/acpi/acpica/utdelete.c                     |    5 +-
> drivers/acpi/acpica/uterror.c                      |   10 +-
> drivers/acpi/acpica/utfileio.c                     |  334 -----------
> drivers/acpi/acpica/uthex.c                        |    2 +-
> drivers/acpi/acpica/utids.c                        |   67 ---
> drivers/acpi/acpica/utinit.c                       |    1 -
> drivers/acpi/acpica/utmath.c                       |   10 +-
> drivers/acpi/acpica/utmisc.c                       |   11 +-
> drivers/acpi/acpica/utmutex.c                      |    5 +-
> drivers/acpi/acpica/utnonansi.c                    |    4 +-
> drivers/acpi/acpica/utobject.c                     |   24 +-
> drivers/acpi/acpica/utosi.c                        |   11 +-
> drivers/acpi/acpica/utownerid.c                    |   12 +-
> drivers/acpi/acpica/utpredef.c                     |    6 +-
> drivers/acpi/acpica/utprint.c                      |   15 +-
> drivers/acpi/acpica/utresrc.c                      |    8 +-
> drivers/acpi/acpica/utstate.c                      |    3 +
> drivers/acpi/acpica/utstring.c                     |    9 +
> drivers/acpi/acpica/uttrack.c                      |   50 +-
> drivers/acpi/acpica/utxface.c                      |    2 -
> drivers/acpi/acpica/utxferror.c                    |    1 +
> drivers/acpi/acpica/utxfinit.c                     |   47 +-
> drivers/acpi/acpica/utxfmutex.c                    |    6 +-
> include/acpi/acexcep.h                             |    6 +-
> include/acpi/acpixf.h                              |   11 +-
> include/acpi/actypes.h                             |    6 +-
> include/acpi/platform/aclinuxex.h                  |    1 +
> tools/power/acpi/common/getopt.c                   |    2 +
> .../acpi/os_specific/service_layers/oslibcfs.c     |    3 +
> tools/power/acpi/tools/acpidump/apfiles.c          |   13 +
> 138 files changed, 2113 insertions(+), 2140 deletions(-)
> create mode 100644 drivers/acpi/acpica/extrace.c
> delete mode 100644 drivers/acpi/acpica/utfileio.c
>
>
