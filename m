From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI updates for v4.11-rc1
Date: Tue, 21 Feb 2017 00:40:55 +0100
Message-ID: <CAJZ5v0ioZdrsCWpBWZ_ZvZzGQUKLOAp2sp6WdMP1OEVFuKhR2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.11-rc1

with top-most commit ac18c0c4e2b1f84fc11d013cd7363377ae4cde43

 Merge branches 'acpi-ec', 'acpi-button' and 'acpi-apei'

on top of commit 7089db84e356562f8ba737c29e472cc42d530dbc

 Linux 4.10-rc8

to receive ACPI updates for v4.11-rc1.

These update the ACPICA code in the kernel to upstream revision
20170119, which among other things updates copyright notices in
all of the ACPICA files, fix a couple of issues in the ACPI EC
and button drivers, fix modalias handling for non-discoverable
devices with DT-compatible identification strings, add a suspend
quirk for one platform and fix a message in the APEI code.

Specifics:

 - Update of the ACPICA code in the kernel to upstream revision
   20170119 including:
   * Fixes related to the handling of the bit width and bit offset
     fields in Generic Address Structure (Lv Zheng).
   * ACPI resources handling fix related to invalid resource
     descriptors (Bob Moore).
   * Fix to enable implicit result conversion for several ASL
     library functions (Bob Moore).
   * Support for method invocations as target operands in AML
     (Bob Moore).
   * Fix to use a correct operand type for DeRefOf() in some
     situations (Bob Moore).
   * Utilities updates (Bob Moore, Lv Zheng).
   * Disassembler/debugger updates (David Box, Lv Zheng).
   * Build fixes (Colin Ian King, Lv Zheng).
   * Update of copyright notices in all files (Bob Moore).

 - Fix for modalias handling for SPI and I2C devices with
   DT-compatible identification strings (Dan O'Donovan).

 - Fixes for the ACPI EC and button drivers (Lv Zheng).

 - ACPI processor handling fix related to CPU hotplug (online/offline)
   on x86 (Vitaly Kuznetsov).

 - Suspend quirk to save/restore NVS memory over S3 transitions for
   Lenovo G50-45 (Zhang Rui).

 - Message formatting fix for the ACPI APEI code (Colin Ian King).

Thanks!

---------------

Bob Moore (11):
      ACPICA: Macro header: Fix some typos in comments
      ACPICA: Utilities: Update debug output
      ACPICA: Resources: Not a valid resource if buffer length too long
      ACPICA: Fix for implicit result conversion for the ToXXX functions
      ACPICA: Parser: Allow method invocations as target operands
      ACPICA: Fix a problem with recent extra support for control
method invocations
      ACPICA: Parser: Update parse info table for some operators
      ACPICA: Update version to 20161222
      ACPICA: Source tree: Update copyright notices to 2017
      ACPICA: Tools: Update common signon, remove compilation bit width
      ACPICA: Update version to 20170119

Colin Ian King (2):
      ACPICA: Linux-specific header: Add support for s390x compilation
      ACPI, APEI, EINJ: fix malformed newline escape

Dan O'Donovan (3):
      ACPI / bus: Introduce acpi_of_modalias() equiv of of_modalias_node()
      i2c: acpi: Initialize info.type from of_compatible
      spi: acpi: Initialize modalias from of_compatible

David E. Box (1):
      ACPICA: Disassembler: Add Switch/Case disassembly support

Lv Zheng (13):
      ACPICA: Debugger: Rename debugger OSL names
      ACPICA: Hardware: Remove bit_offset masking support
      ACPICA: Hardware: Add access_width/bit_offset support in acpi_hw_write()
      ACPICA: Utilities: Add power of two rounding support
      ACPICA: Hardware: Sort access bit width algorithm
      ACPICA: Hardware: Add sleep register hooks
      ACPICA: MSVC: Fix MSVC6 build issues
      ACPICA: EFI: Add efihello demo application
      ACPI / EC: Remove old CLEAR_ON_RESUME quirk
      ACPI / EC: Use busy polling mode when GPE is not enabled
      ACPI / button: Change default behavior to lid_init_state=open
      ACPI / button: Remove lid_init_state=method mode
      ACPICA: Linuxize: Restore and fix Intel compiler build

Vitaly Kuznetsov (1):
      x86/ACPI: keep x86_cpu_to_acpiid mapping valid on CPU hotplug

Zhang Rui (1):
      ACPI: save NVS memory for Lenovo G50-45

---------------

 Documentation/acpi/acpi-lid.txt                    |  16 +--
 arch/ia64/kernel/acpi.c                            |   3 +-
 arch/x86/kernel/acpi/boot.c                        |   5 +-
 drivers/acpi/acpi_processor.c                      |   4 +-
 drivers/acpi/acpica/acapps.h                       |  14 +-
 drivers/acpi/acpica/accommon.h                     |   2 +-
 drivers/acpi/acpica/acdebug.h                      |   2 +-
 drivers/acpi/acpica/acdispat.h                     |   2 +-
 drivers/acpi/acpica/acevents.h                     |   2 +-
 drivers/acpi/acpica/acglobal.h                     |   2 +-
 drivers/acpi/acpica/achware.h                      |   2 +-
 drivers/acpi/acpica/acinterp.h                     |   2 +-
 drivers/acpi/acpica/aclocal.h                      |   9 +-
 drivers/acpi/acpica/acmacros.h                     |  74 +++++++++-
 drivers/acpi/acpica/acnamesp.h                     |   2 +-
 drivers/acpi/acpica/acobject.h                     |   2 +-
 drivers/acpi/acpica/acopcode.h                     |  24 ++--
 drivers/acpi/acpica/acparser.h                     |   2 +-
 drivers/acpi/acpica/acpredef.h                     |   2 +-
 drivers/acpi/acpica/acresrc.h                      |   2 +-
 drivers/acpi/acpica/acstruct.h                     |   2 +-
 drivers/acpi/acpica/actables.h                     |   2 +-
 drivers/acpi/acpica/acutils.h                      |   2 +-
 drivers/acpi/acpica/amlcode.h                      |  22 ++-
 drivers/acpi/acpica/amlresrc.h                     |   2 +-
 drivers/acpi/acpica/dbcmds.c                       |   2 +-
 drivers/acpi/acpica/dbconvert.c                    |   2 +-
 drivers/acpi/acpica/dbdisply.c                     |   2 +-
 drivers/acpi/acpica/dbexec.c                       |   2 +-
 drivers/acpi/acpica/dbfileio.c                     |   2 +-
 drivers/acpi/acpica/dbhistry.c                     |   2 +-
 drivers/acpi/acpica/dbinput.c                      |   2 +-
 drivers/acpi/acpica/dbmethod.c                     |   2 +-
 drivers/acpi/acpica/dbnames.c                      |   2 +-
 drivers/acpi/acpica/dbobject.c                     |   2 +-
 drivers/acpi/acpica/dbstats.c                      |   2 +-
 drivers/acpi/acpica/dbtest.c                       |   2 +-
 drivers/acpi/acpica/dbutils.c                      |   2 +-
 drivers/acpi/acpica/dbxface.c                      |   6 +-
 drivers/acpi/acpica/dsargs.c                       |   2 +-
 drivers/acpi/acpica/dscontrol.c                    |   2 +-
 drivers/acpi/acpica/dsdebug.c                      |   2 +-
 drivers/acpi/acpica/dsfield.c                      |   2 +-
 drivers/acpi/acpica/dsinit.c                       |   2 +-
 drivers/acpi/acpica/dsmethod.c                     |   2 +-
 drivers/acpi/acpica/dsmthdat.c                     |   2 +-
 drivers/acpi/acpica/dsobject.c                     |   2 +-
 drivers/acpi/acpica/dsopcode.c                     |   2 +-
 drivers/acpi/acpica/dsutils.c                      |   2 +-
 drivers/acpi/acpica/dswexec.c                      |   2 +-
 drivers/acpi/acpica/dswload.c                      |   2 +-
 drivers/acpi/acpica/dswload2.c                     |   2 +-
 drivers/acpi/acpica/dswscope.c                     |   2 +-
 drivers/acpi/acpica/dswstate.c                     |   2 +-
 drivers/acpi/acpica/evevent.c                      |   2 +-
 drivers/acpi/acpica/evglock.c                      |   2 +-
 drivers/acpi/acpica/evgpe.c                        |   2 +-
 drivers/acpi/acpica/evgpeblk.c                     |   2 +-
 drivers/acpi/acpica/evgpeinit.c                    |   2 +-
 drivers/acpi/acpica/evgpeutil.c                    |   2 +-
 drivers/acpi/acpica/evhandler.c                    |   2 +-
 drivers/acpi/acpica/evmisc.c                       |   2 +-
 drivers/acpi/acpica/evregion.c                     |   2 +-
 drivers/acpi/acpica/evrgnini.c                     |   2 +-
 drivers/acpi/acpica/evsci.c                        |   2 +-
 drivers/acpi/acpica/evxface.c                      |   2 +-
 drivers/acpi/acpica/evxfevnt.c                     |   2 +-
 drivers/acpi/acpica/evxfgpe.c                      |   2 +-
 drivers/acpi/acpica/evxfregn.c                     |   2 +-
 drivers/acpi/acpica/exconcat.c                     |   2 +-
 drivers/acpi/acpica/exconfig.c                     |   2 +-
 drivers/acpi/acpica/exconvrt.c                     |   3 +-
 drivers/acpi/acpica/excreate.c                     |   2 +-
 drivers/acpi/acpica/exdebug.c                      |   2 +-
 drivers/acpi/acpica/exdump.c                       |   2 +-
 drivers/acpi/acpica/exfield.c                      |   2 +-
 drivers/acpi/acpica/exfldio.c                      |   2 +-
 drivers/acpi/acpica/exmisc.c                       |   2 +-
 drivers/acpi/acpica/exmutex.c                      |   2 +-
 drivers/acpi/acpica/exnames.c                      |   2 +-
 drivers/acpi/acpica/exoparg1.c                     |   2 +-
 drivers/acpi/acpica/exoparg2.c                     |   2 +-
 drivers/acpi/acpica/exoparg3.c                     |   2 +-
 drivers/acpi/acpica/exoparg6.c                     |   2 +-
 drivers/acpi/acpica/exprep.c                       |   2 +-
 drivers/acpi/acpica/exregion.c                     |   2 +-
 drivers/acpi/acpica/exresnte.c                     |   2 +-
 drivers/acpi/acpica/exresolv.c                     |   2 +-
 drivers/acpi/acpica/exresop.c                      |   3 +-
 drivers/acpi/acpica/exstore.c                      |   2 +-
 drivers/acpi/acpica/exstoren.c                     |   2 +-
 drivers/acpi/acpica/exstorob.c                     |   2 +-
 drivers/acpi/acpica/exsystem.c                     |   2 +-
 drivers/acpi/acpica/extrace.c                      |   2 +-
 drivers/acpi/acpica/exutils.c                      |   2 +-
 drivers/acpi/acpica/hwacpi.c                       |   2 +-
 drivers/acpi/acpica/hwesleep.c                     |  37 +++--
 drivers/acpi/acpica/hwgpe.c                        |   2 +-
 drivers/acpi/acpica/hwpci.c                        |   2 +-
 drivers/acpi/acpica/hwregs.c                       | 155 +++++++++++++++------
 drivers/acpi/acpica/hwsleep.c                      |  13 +-
 drivers/acpi/acpica/hwtimer.c                      |   2 +-
 drivers/acpi/acpica/hwvalid.c                      |   2 +-
 drivers/acpi/acpica/hwxface.c                      |   2 +-
 drivers/acpi/acpica/hwxfsleep.c                    |   2 +-
 drivers/acpi/acpica/nsaccess.c                     |   2 +-
 drivers/acpi/acpica/nsalloc.c                      |   2 +-
 drivers/acpi/acpica/nsarguments.c                  |   2 +-
 drivers/acpi/acpica/nsconvert.c                    |   2 +-
 drivers/acpi/acpica/nsdump.c                       |   2 +-
 drivers/acpi/acpica/nsdumpdv.c                     |   2 +-
 drivers/acpi/acpica/nseval.c                       |   2 +-
 drivers/acpi/acpica/nsinit.c                       |   2 +-
 drivers/acpi/acpica/nsload.c                       |   2 +-
 drivers/acpi/acpica/nsnames.c                      |   2 +-
 drivers/acpi/acpica/nsobject.c                     |   2 +-
 drivers/acpi/acpica/nsparse.c                      |   2 +-
 drivers/acpi/acpica/nspredef.c                     |   2 +-
 drivers/acpi/acpica/nsprepkg.c                     |   2 +-
 drivers/acpi/acpica/nsrepair.c                     |   2 +-
 drivers/acpi/acpica/nsrepair2.c                    |   2 +-
 drivers/acpi/acpica/nssearch.c                     |   2 +-
 drivers/acpi/acpica/nsutils.c                      |   2 +-
 drivers/acpi/acpica/nswalk.c                       |   2 +-
 drivers/acpi/acpica/nsxfeval.c                     |   2 +-
 drivers/acpi/acpica/nsxfname.c                     |   2 +-
 drivers/acpi/acpica/nsxfobj.c                      |   2 +-
 drivers/acpi/acpica/psargs.c                       |  99 ++++++++-----
 drivers/acpi/acpica/psloop.c                       |   6 +-
 drivers/acpi/acpica/psobject.c                     |  12 +-
 drivers/acpi/acpica/psopcode.c                     |   2 +-
 drivers/acpi/acpica/psopinfo.c                     |   2 +-
 drivers/acpi/acpica/psparse.c                      |   2 +-
 drivers/acpi/acpica/psscope.c                      |   2 +-
 drivers/acpi/acpica/pstree.c                       |  12 +-
 drivers/acpi/acpica/psutils.c                      |   2 +-
 drivers/acpi/acpica/pswalk.c                       |   2 +-
 drivers/acpi/acpica/psxface.c                      |   2 +-
 drivers/acpi/acpica/rsaddr.c                       |   2 +-
 drivers/acpi/acpica/rscalc.c                       |   2 +-
 drivers/acpi/acpica/rscreate.c                     |   2 +-
 drivers/acpi/acpica/rsdump.c                       |   2 +-
 drivers/acpi/acpica/rsdumpinfo.c                   |   2 +-
 drivers/acpi/acpica/rsinfo.c                       |   2 +-
 drivers/acpi/acpica/rsio.c                         |   2 +-
 drivers/acpi/acpica/rsirq.c                        |   2 +-
 drivers/acpi/acpica/rslist.c                       |   2 +-
 drivers/acpi/acpica/rsmemory.c                     |   2 +-
 drivers/acpi/acpica/rsmisc.c                       |   2 +-
 drivers/acpi/acpica/rsserial.c                     |   2 +-
 drivers/acpi/acpica/rsutils.c                      |   2 +-
 drivers/acpi/acpica/rsxface.c                      |   2 +-
 drivers/acpi/acpica/tbdata.c                       |   2 +-
 drivers/acpi/acpica/tbfadt.c                       |   2 +-
 drivers/acpi/acpica/tbfind.c                       |   2 +-
 drivers/acpi/acpica/tbinstal.c                     |   2 +-
 drivers/acpi/acpica/tbprint.c                      |   2 +-
 drivers/acpi/acpica/tbutils.c                      |   2 +-
 drivers/acpi/acpica/tbxface.c                      |   2 +-
 drivers/acpi/acpica/tbxfload.c                     |   2 +-
 drivers/acpi/acpica/tbxfroot.c                     |   2 +-
 drivers/acpi/acpica/utaddress.c                    |   2 +-
 drivers/acpi/acpica/utalloc.c                      |   2 +-
 drivers/acpi/acpica/utascii.c                      |   2 +-
 drivers/acpi/acpica/utbuffer.c                     |   2 +-
 drivers/acpi/acpica/utcache.c                      |   2 +-
 drivers/acpi/acpica/utcopy.c                       |   2 +-
 drivers/acpi/acpica/utdebug.c                      |   2 +-
 drivers/acpi/acpica/utdecode.c                     |   6 +-
 drivers/acpi/acpica/utdelete.c                     |   8 +-
 drivers/acpi/acpica/uterror.c                      |   2 +-
 drivers/acpi/acpica/uteval.c                       |   2 +-
 drivers/acpi/acpica/utexcep.c                      |   2 +-
 drivers/acpi/acpica/utglobal.c                     |   2 +-
 drivers/acpi/acpica/uthex.c                        |   2 +-
 drivers/acpi/acpica/utids.c                        |   2 +-
 drivers/acpi/acpica/utinit.c                       |   2 +-
 drivers/acpi/acpica/utlock.c                       |   2 +-
 drivers/acpi/acpica/utmath.c                       |   2 +-
 drivers/acpi/acpica/utmisc.c                       |   2 +-
 drivers/acpi/acpica/utmutex.c                      |   2 +-
 drivers/acpi/acpica/utnonansi.c                    |   2 +-
 drivers/acpi/acpica/utobject.c                     |   2 +-
 drivers/acpi/acpica/utosi.c                        |   2 +-
 drivers/acpi/acpica/utownerid.c                    |   2 +-
 drivers/acpi/acpica/utpredef.c                     |   2 +-
 drivers/acpi/acpica/utprint.c                      |   2 +-
 drivers/acpi/acpica/utresrc.c                      |  19 ++-
 drivers/acpi/acpica/utstate.c                      |   2 +-
 drivers/acpi/acpica/utstring.c                     |   2 +-
 drivers/acpi/acpica/utstrtoul64.c                  |   2 +-
 drivers/acpi/acpica/uttrack.c                      |   2 +-
 drivers/acpi/acpica/utuuid.c                       |   2 +-
 drivers/acpi/acpica/utxface.c                      |   2 +-
 drivers/acpi/acpica/utxferror.c                    |   2 +-
 drivers/acpi/acpica/utxfinit.c                     |   2 +-
 drivers/acpi/acpica/utxfmutex.c                    |   2 +-
 drivers/acpi/apei/einj.c                           |   2 +-
 drivers/acpi/bus.c                                 |  42 ++++++
 drivers/acpi/button.c                              |  11 +-
 drivers/acpi/ec.c                                  | 115 ++++-----------
 drivers/acpi/internal.h                            |   4 +-
 drivers/acpi/osl.c                                 |  27 +++-
 drivers/acpi/sleep.c                               |  19 +++
 drivers/i2c/i2c-core.c                             |   3 +-
 drivers/spi/spi.c                                  |   4 +-
 include/acpi/acbuffer.h                            |   2 +-
 include/acpi/acconfig.h                            |   2 +-
 include/acpi/acexcep.h                             |  11 +-
 include/acpi/acnames.h                             |   2 +-
 include/acpi/acoutput.h                            |   2 +-
 include/acpi/acpi.h                                |   2 +-
 include/acpi/acpi_bus.h                            |   2 +
 include/acpi/acpiosxf.h                            |  14 +-
 include/acpi/acpixf.h                              |   4 +-
 include/acpi/acrestyp.h                            |   2 +-
 include/acpi/actbl.h                               |   2 +-
 include/acpi/actbl1.h                              |   2 +-
 include/acpi/actbl2.h                              |   2 +-
 include/acpi/actbl3.h                              |   2 +-
 include/acpi/actypes.h                             |   2 +-
 include/acpi/acuuid.h                              |   2 +-
 include/acpi/platform/acenv.h                      |   9 +-
 include/acpi/platform/acenvex.h                    |   2 +-
 include/acpi/platform/acgcc.h                      |   2 +-
 include/acpi/platform/acgccex.h                    |   2 +-
 include/acpi/platform/acintel.h                    |  87 ++++++++++++
 include/acpi/platform/aclinux.h                    |   9 +-
 include/acpi/platform/aclinuxex.h                  |   6 +-
 include/linux/acpi.h                               |   3 +-
 tools/power/acpi/common/cmfsize.c                  |   2 +-
 tools/power/acpi/common/getopt.c                   |   2 +-
 .../acpi/os_specific/service_layers/oslinuxtbl.c   |   2 +-
 .../acpi/os_specific/service_layers/osunixdir.c    |   2 +-
 .../acpi/os_specific/service_layers/osunixmap.c    |   2 +-
 .../acpi/os_specific/service_layers/osunixxf.c     |  24 +++-
 tools/power/acpi/tools/acpidump/acpidump.h         |   2 +-
 tools/power/acpi/tools/acpidump/apdump.c           |   2 +-
 tools/power/acpi/tools/acpidump/apfiles.c          |   2 +-
 tools/power/acpi/tools/acpidump/apmain.c           |   2 +-
 240 files changed, 838 insertions(+), 506 deletions(-)
