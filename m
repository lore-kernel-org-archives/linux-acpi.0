From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Additional ACPICA material for v4.2-rc1
Date: Fri, 3 Jul 2015 01:31:40 +0200
Message-ID: <CAJZ5v0juqrZe6o4M94TqvMCUNy=QowT=BNARPHEEdMmA0WKnbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:38088 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058AbbGBXbm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Jul 2015 19:31:42 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpica-4.2-rc1

to receive additional ACPICA material for v4.2-rc1 with
top-most commit ea7d521569a70418aa9f6309a1d1916709818b62

 Revert 'Revert "ACPICA: Permanently set _REV to the value '2'."'

on top of commit f3b6ced236259a87829b829e8e542ff53bfb9a4f

 ACPICA: Fix for ill-formed GUID strings for NFIT tables.

merged earlier during the current merge window.

This will update the ACPICA code in the kernel to upstream revision
20150619 (a bug-fix release mostly including stable-candidate fixes)
and restore an earlier ACPICA commit that had to be reverted due to
a regression introduced by it (the regression is addressed by
blacklisting the only known system affected by it to date).

The only new feature added by this update is the support for
overriding objects in the ACPI namespace and a new ACPI table
that can be used for that called the Override System Definition
Table (OSDT).  That should allow us to "patch" the ACPI namespace
built from incomplete or incorrect ACPI System Definition tables
(DSDT, SSDT) during system startup without the need to provide
replacements for all of those tables in the future.

Specifics:

 - Fix system resume problems related to 32-bit and 64-bit versions
   of the Firmware ACPI Control Structure (FACS) in the firmare (Lv
   Zheng).

 - Fix double initialization of the FACS (Lv Zheng).

 - Add _CLS object processing code to ACPICA (Suravee Suthikulpanit).

 - Add support for the (currently missing) new GIC version field in
   the Multiple APIC Description Table (MADT) (Hanjun Guo).

 - Add support for overriding objects in the ACPI namespace to
   ACPICA and OSDT support (Lv Zheng, Bob Moore, Zhang Rui).

 - Updates related to the TCPA and TPM2 ACPI tables (Bob Moore).

 - Restore the commit modifying _REV to always return "2" (as
   required by ACPI 6) and add a blacklisting mechanism for
   systems that may be affected by that change (Rafael J Wysocki).

 - Assorted fixes and cleanups (Bob Moore, Lv Zheng, Sascha Wildner).

Thanks!


---------------

Bob Moore (8):
      ACPICA: Namespace: Add support of OSDT table
      ACPICA: Namespace: Change namespace override to avoid node deletion
      ACPICA: Cleanup output for the ASL Debug object
      ACPICA: De-macroize calls to standard C library functions
      ACPICA: Split C library prototypes to new header
      ACPICA: Update definitions for the TCPA and TPM2 ACPI tables
      ACPICA: Update TPM2 ACPI table
      ACPICA: Update version to 20150619

Hanjun Guo (1):
      ACPICA: ACPI 6.0: Add values for MADT GIC version field

Lv Zheng (13):
      ACPICA: Linuxize: Reduce divergences for 20150616 release
      ACPICA: Linuxize: Replace __FUNCTION__ with __func__
      ACPICA: Hardware: Enable 64-bit firmware waking vector for selected FACS
      ACPICA: Tables: Enable both 32-bit and 64-bit FACS
      ACPICA: Hardware: Enable firmware waking vector for both 32-bit
and 64-bit FACS
      ACPICA: Tables: Fix an issue that FACS initialization is performed twice
      ACPICA: Tables: Enable default 64-bit FADT addresses favor
      ACPICA: MSVC6: Fix build issue for variable argument macros
      ACPICA: EFI: Add EFI interface definitions to eliminate
dependency of GNU EFI
      ACPICA: Namespace: Add support to allow overriding objects
      ACPICA: acpidump: Allow customized tables to be dumped without
accessing /dev/mem
      ACPICA: acpidump: Convert the default behavior to dump from
/sys/firmware/acpi/tables
      ACPI / acpidump: Update acpidump manual

Rafael J. Wysocki (2):
      ACPI / init: Make it possible to override _REV
      Revert 'Revert "ACPICA: Permanently set _REV to the value '2'."'

Sascha Wildner (1):
      ACPICA: Add dragon_fly support to unix file mapping file

Suravee Suthikulpanit (1):
      ACPICA: Utilities: Add _CLS processing

Zhang Rui (1):
      ACPICA: Update for acpi_install_table memory types

ongzg (1):
      ACPICA: Comment update, no functional change

---------------

 Documentation/kernel-parameters.txt                |   6 +
 drivers/acpi/Kconfig                               |  20 ++++
 drivers/acpi/acpica/accommon.h                     |   3 +
 drivers/acpi/acpica/acglobal.h                     |   2 +
 drivers/acpi/acpica/acinterp.h                     |   2 +
 drivers/acpi/acpica/aclocal.h                      |   1 +
 drivers/acpi/acpica/acnamesp.h                     |   1 +
 drivers/acpi/acpica/acobject.h                     |   1 +
 drivers/acpi/acpica/acstruct.h                     |   1 +
 drivers/acpi/acpica/acutils.h                      |  64 +----------
 drivers/acpi/acpica/dsfield.c                      |   2 +-
 drivers/acpi/acpica/dsinit.c                       |   2 +-
 drivers/acpi/acpica/dsobject.c                     |   7 +-
 drivers/acpi/acpica/dsutils.c                      |   4 +-
 drivers/acpi/acpica/dswload.c                      |  17 ++-
 drivers/acpi/acpica/evgpeinit.c                    |   2 +-
 drivers/acpi/acpica/exconfig.c                     |   2 +-
 drivers/acpi/acpica/exconvrt.c                     |   9 +-
 drivers/acpi/acpica/exdebug.c                      |  42 ++++++-
 drivers/acpi/acpica/exdump.c                       |   9 +-
 drivers/acpi/acpica/exfield.c                      |   2 +-
 drivers/acpi/acpica/exfldio.c                      |  52 ++++-----
 drivers/acpi/acpica/exmisc.c                       |  36 +++---
 drivers/acpi/acpica/exnames.c                      |   2 +-
 drivers/acpi/acpica/exoparg2.c                     |   8 +-
 drivers/acpi/acpica/exoparg3.c                     |   4 +-
 drivers/acpi/acpica/exregion.c                     |   9 +-
 drivers/acpi/acpica/exstorob.c                     |  18 +--
 drivers/acpi/acpica/exutils.c                      |  32 ++++++
 drivers/acpi/acpica/hwxfsleep.c                    | 125 +++++++++++++++++----
 drivers/acpi/acpica/nsaccess.c                     |  16 ++-
 drivers/acpi/acpica/nsconvert.c                    |  10 +-
 drivers/acpi/acpica/nsdump.c                       |   2 +-
 drivers/acpi/acpica/nseval.c                       |   7 +-
 drivers/acpi/acpica/nsinit.c                       |   4 +-
 drivers/acpi/acpica/nsparse.c                      |   7 ++
 drivers/acpi/acpica/nsrepair2.c                    |   2 +-
 drivers/acpi/acpica/nssearch.c                     |  37 +++++-
 drivers/acpi/acpica/nsutils.c                      |   3 +-
 drivers/acpi/acpica/nsxfeval.c                     |   5 +-
 drivers/acpi/acpica/nsxfname.c                     |  29 ++++-
 drivers/acpi/acpica/psutils.c                      |   7 +-
 drivers/acpi/acpica/rscreate.c                     |   6 +-
 drivers/acpi/acpica/rsmisc.c                       |   8 +-
 drivers/acpi/acpica/rsutils.c                      |  13 +--
 drivers/acpi/acpica/rsxface.c                      |   8 +-
 drivers/acpi/acpica/tbdata.c                       |   8 +-
 drivers/acpi/acpica/tbfadt.c                       |  27 +++--
 drivers/acpi/acpica/tbfind.c                       |  21 ++--
 drivers/acpi/acpica/tbinstal.c                     |   7 +-
 drivers/acpi/acpica/tbprint.c                      |  10 +-
 drivers/acpi/acpica/tbutils.c                      |  37 ++++--
 drivers/acpi/acpica/tbxface.c                      |  17 +--
 drivers/acpi/acpica/tbxfload.c                     |  17 ++-
 drivers/acpi/acpica/utalloc.c                      |   6 +-
 drivers/acpi/acpica/utbuffer.c                     |   4 +-
 drivers/acpi/acpica/utcache.c                      |   6 +-
 drivers/acpi/acpica/utcopy.c                       |  42 +++----
 drivers/acpi/acpica/utdebug.c                      |   4 +-
 drivers/acpi/acpica/utglobal.c                     |  13 ++-
 drivers/acpi/acpica/utids.c                        | 100 ++++++++++++++++-
 drivers/acpi/acpica/utmisc.c                       |   9 +-
 drivers/acpi/acpica/utosi.c                        |   9 +-
 drivers/acpi/acpica/utpredef.c                     |   4 +-
 drivers/acpi/acpica/utprint.c                      |   6 +-
 drivers/acpi/acpica/utstring.c                     |  33 +++---
 drivers/acpi/acpica/uttrack.c                      |   8 +-
 drivers/acpi/acpica/utxface.c                      |   8 +-
 drivers/acpi/acpica/utxfinit.c                     |  10 +-
 drivers/acpi/blacklist.c                           |  26 +++++
 drivers/acpi/internal.h                            |   1 +
 drivers/acpi/osl.c                                 |  18 +++
 include/acpi/acnames.h                             |   1 +
 include/acpi/acoutput.h                            |  13 ++-
 include/acpi/acpixf.h                              |  28 ++++-
 include/acpi/actbl.h                               |   1 +
 include/acpi/actbl1.h                              |  11 ++
 include/acpi/actbl2.h                              |  80 +++++++++++--
 include/acpi/actbl3.h                              |  34 +-----
 include/acpi/actypes.h                             |  33 +++---
 include/acpi/platform/acenv.h                      |  39 -------
 include/acpi/platform/acenvex.h                    |   6 +
 include/acpi/platform/acgcc.h                      |   4 +
 tools/power/acpi/common/getopt.c                   |   4 +-
 tools/power/acpi/man/acpidump.8                    |  17 ++-
 .../acpi/os_specific/service_layers/oslinuxtbl.c   |  95 ++++++++--------
 .../acpi/os_specific/service_layers/osunixmap.c    |   2 +-
 tools/power/acpi/tools/acpidump/acpidump.h         |   2 +-
 tools/power/acpi/tools/acpidump/apdump.c           |   8 +-
 tools/power/acpi/tools/acpidump/apfiles.c          |  12 +-
 tools/power/acpi/tools/acpidump/apmain.c           |  15 ++-
 91 files changed, 973 insertions(+), 532 deletions(-)
