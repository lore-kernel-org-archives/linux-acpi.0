From: Len Brown <len.brown@intel.com>
Subject: Latest ACPI test patch: acpi-test-20060113-2.6.16-rc1.diff
Date: Fri, 20 Jan 2006 03:31:37 -0500
Message-ID: <200601200331.40496.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="CFGHIJKLMNOPQRSTUVWWXYZabcdefghijklmnopq"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sccrmhc13.comcast.net ([204.127.202.64]:45196 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1750753AbWATI6D (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Jan 2006 03:58:03 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: akpm@osdl.org

This is a multi-part message in MIME format.
--CFGHIJKLMNOPQRSTUVWWXYZabcdefghijklmnopq
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This message has been processed by Symantec's AntiVirus Technology.

Unknown00000000.data was not scanned for viruses because too many nested levels of files were found.


For more information on antivirus tips and technology, visit
http://ses.symantec.com/
--CFGHIJKLMNOPQRSTUVWWXYZabcdefghijklmnopq
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from intel.com (c-24-63-232-79.hsd1.ma.comcast.net[24.63.232.79])
          by comcast.net (sccrmhc11) with ESMTP
          id <2006012008552001100dda2ue>; Fri, 20 Jan 2006 08:55:20 +0000
From: Len Brown <len.brown@intel.com>
Organization: Intel Open Source Technology Center
To: linux-acpi@vger.kernel.org
Subject: Latest ACPI test patch: acpi-test-20060113-2.6.16-rc1.diff
Date: Fri, 20 Jan 2006 03:31:37 -0500
User-Agent: KMail/1.8.2
Cc: akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601200331.40496.len.brown@intel.com>

Here's an updated patch on top of 2.6.16-rc1.
Yes, there is more to come -- i'm still catching up on the backlog from traveling last week.

It is important to test this version because we're hoping to push the majority
of these patches into 2.6.16, which has already hit rc1.  In particular this
patch enables EC interrupt mode, the key _PDC BIOS workaround,
and a bunch of fixes from moving to a core that is 4-months
newer than the one in 2.6.15.

Please speak up if acpi-cpufreq stops loading -- there is 1 report of that.
Please speak up if you see any new dmesg warnings with CONFIG_ACPI_DEBUG=n.

thanks,
-Len

Either git pull from: 
git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git test

or apply latest from here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6.16/

This will update the files shown below.

 Documentation/kernel-parameters.txt               |    5 
 arch/i386/kernel/acpi/Makefile                    |    2 
 arch/i386/kernel/acpi/boot.c                      |    6 
 arch/i386/kernel/acpi/cstate.c                    |   58 
 arch/i386/kernel/acpi/processor.c                 |   75 
 arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c       |   71 
 arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c |   12 
 arch/i386/kernel/mpparse.c                        |    8 
 arch/ia64/kernel/Makefile                         |    5 
 arch/ia64/kernel/acpi-ext.c                       |   24 
 arch/ia64/kernel/acpi-processor.c                 |   67 
 arch/ia64/kernel/acpi.c                           |    6 
 arch/ia64/kernel/cpufreq/Makefile                 |    9 
 arch/ia64/kernel/cpufreq/acpi-cpufreq.c           |   51 
 arch/ia64/kernel/cpufreq/acpi-processor.c         |  134 
 arch/ia64/pci/pci.c                               |   10 
 arch/x86_64/kernel/acpi/Makefile                  |    5 
 arch/x86_64/kernel/acpi/processor.c               |   72 
 arch/x86_64/kernel/io_apic.c                      |   10 
 arch/x86_64/kernel/mpparse.c                      |   10 
 drivers/acpi/Kconfig                              |    1 
 drivers/acpi/Makefile                             |    2 
 drivers/acpi/acpi_memhotplug.c                    |   17 
 drivers/acpi/asus_acpi.c                          |   35 
 drivers/acpi/dispatcher/dsfield.c                 |    9 
 drivers/acpi/dispatcher/dsinit.c                  |   45 
 drivers/acpi/dispatcher/dsmethod.c                |  404 -
 drivers/acpi/dispatcher/dsmthdat.c                |   28 
 drivers/acpi/dispatcher/dsobject.c                |  102 
 drivers/acpi/dispatcher/dsopcode.c                |   41 
 drivers/acpi/dispatcher/dsutils.c                 |   30 
 drivers/acpi/dispatcher/dswexec.c                 |   69 
 drivers/acpi/dispatcher/dswload.c                 |  246 
 drivers/acpi/dispatcher/dswscope.c                |    6 
 drivers/acpi/dispatcher/dswstate.c                |  106 
 drivers/acpi/ec.c                                 |  301 -
 drivers/acpi/events/evevent.c                     |   46 
 drivers/acpi/events/evgpe.c                       |   38 
 drivers/acpi/events/evgpeblk.c                    |  189 
 drivers/acpi/events/evmisc.c                      |   12 
 drivers/acpi/events/evregion.c                    |   45 
 drivers/acpi/events/evrgnini.c                    |    2 
 drivers/acpi/events/evsci.c                       |    6 
 drivers/acpi/events/evxface.c                     |   17 
 drivers/acpi/events/evxfevnt.c                    |   30 
 drivers/acpi/events/evxfregn.c                    |    2 
 drivers/acpi/executer/exconfig.c                  |    6 
 drivers/acpi/executer/exconvrt.c                  |   27 
 drivers/acpi/executer/excreate.c                  |    2 
 drivers/acpi/executer/exdump.c                    |  683 +-
 drivers/acpi/executer/exfield.c                   |    2 
 drivers/acpi/executer/exfldio.c                   |   60 
 drivers/acpi/executer/exmisc.c                    |  102 
 drivers/acpi/executer/exmutex.c                   |    2 
 drivers/acpi/executer/exnames.c                   |   22 
 drivers/acpi/executer/exoparg1.c                  |   59 
 drivers/acpi/executer/exoparg2.c                  |   38 
 drivers/acpi/executer/exoparg3.c                  |   12 
 drivers/acpi/executer/exoparg6.c                  |   13 
 drivers/acpi/executer/exprep.c                    |   15 
 drivers/acpi/executer/exregion.c                  |   32 
 drivers/acpi/executer/exresnte.c                  |   50 
 drivers/acpi/executer/exresolv.c                  |   28 
 drivers/acpi/executer/exresop.c                   |   91 
 drivers/acpi/executer/exstore.c                   |   19 
 drivers/acpi/executer/exstoren.c                  |   13 
 drivers/acpi/executer/exstorob.c                  |    6 
 drivers/acpi/executer/exsystem.c                  |    4 
 drivers/acpi/executer/exutils.c                   |   12 
 drivers/acpi/glue.c                               |   14 
 drivers/acpi/hardware/hwacpi.c                    |   15 
 drivers/acpi/hardware/hwgpe.c                     |    2 
 drivers/acpi/hardware/hwregs.c                    |   32 
 drivers/acpi/hardware/hwsleep.c                   |    2 
 drivers/acpi/hardware/hwtimer.c                   |    2 
 drivers/acpi/motherboard.c                        |   34 
 drivers/acpi/namespace/nsaccess.c                 |   20 
 drivers/acpi/namespace/nsalloc.c                  |    7 
 drivers/acpi/namespace/nsdump.c                   |    9 
 drivers/acpi/namespace/nsdumpdv.c                 |    2 
 drivers/acpi/namespace/nseval.c                   |    5 
 drivers/acpi/namespace/nsinit.c                   |  107 
 drivers/acpi/namespace/nsload.c                   |    6 
 drivers/acpi/namespace/nsnames.c                  |   12 
 drivers/acpi/namespace/nsobject.c                 |   10 
 drivers/acpi/namespace/nsparse.c                  |    2 
 drivers/acpi/namespace/nssearch.c                 |   28 
 drivers/acpi/namespace/nsutils.c                  |   41 
 drivers/acpi/namespace/nswalk.c                   |    2 
 drivers/acpi/namespace/nsxfeval.c                 |   27 
 drivers/acpi/namespace/nsxfname.c                 |    2 
 drivers/acpi/namespace/nsxfobj.c                  |    2 
 drivers/acpi/osl.c                                |   10 
 drivers/acpi/parser/psargs.c                      |  360 -
 drivers/acpi/parser/psloop.c                      |   32 
 drivers/acpi/parser/psopcode.c                    |    4 
 drivers/acpi/parser/psparse.c                     |   60 
 drivers/acpi/parser/psscope.c                     |    2 
 drivers/acpi/parser/pstree.c                      |    5 
 drivers/acpi/parser/psutils.c                     |    2 
 drivers/acpi/parser/pswalk.c                      |    2 
 drivers/acpi/parser/psxface.c                     |  146 
 drivers/acpi/pci_irq.c                            |   48 
 drivers/acpi/pci_link.c                           |  102 
 drivers/acpi/pci_root.c                           |   14 
 drivers/acpi/processor_core.c                     |   30 
 drivers/acpi/processor_idle.c                     |  162 
 drivers/acpi/processor_perflib.c                  |    4 
 drivers/acpi/processor_thermal.c                  |    1 
 drivers/acpi/processor_throttling.c               |    1 
 drivers/acpi/resources/Makefile                   |    2 
 drivers/acpi/resources/rsaddr.c                   | 2000 ++----
 drivers/acpi/resources/rscalc.c                   | 1681 ++---
 drivers/acpi/resources/rscreate.c                 |  101 
 drivers/acpi/resources/rsdump.c                   | 2921 ++++------
 drivers/acpi/resources/rsinfo.c                   |  220 
 drivers/acpi/resources/rsio.c                     |  866 +-
 drivers/acpi/resources/rsirq.c                    |  988 +--
 drivers/acpi/resources/rslist.c                   | 1122 +--
 drivers/acpi/resources/rsmemory.c                 |  861 +-
 drivers/acpi/resources/rsmisc.c                   | 1860 +++---
 drivers/acpi/resources/rsutils.c                  |  818 ++
 drivers/acpi/resources/rsxface.c                  |  258 
 drivers/acpi/scan.c                               |    2 
 drivers/acpi/sleep/poweroff.c                     |   15 
 drivers/acpi/sleep/sleep.h                        |    2 
 drivers/acpi/sleep/wakeup.c                       |    6 
 drivers/acpi/tables/tbconvrt.c                    |    6 
 drivers/acpi/tables/tbget.c                       |    6 
 drivers/acpi/tables/tbgetall.c                    |    6 
 drivers/acpi/tables/tbinstal.c                    |    2 
 drivers/acpi/tables/tbrsdt.c                      |   20 
 drivers/acpi/tables/tbutils.c                     |   35 
 drivers/acpi/tables/tbxface.c                     |   17 
 drivers/acpi/tables/tbxfroot.c                    |   24 
 drivers/acpi/utilities/Makefile                   |    5 
 drivers/acpi/utilities/utalloc.c                  |   44 
 drivers/acpi/utilities/utcache.c                  |    2 
 drivers/acpi/utilities/utcopy.c                   |   26 
 drivers/acpi/utilities/utdebug.c                  |    2 
 drivers/acpi/utilities/utdelete.c                 |    9 
 drivers/acpi/utilities/uteval.c                   |   42 
 drivers/acpi/utilities/utglobal.c                 |  110 
 drivers/acpi/utilities/utinit.c                   |    7 
 drivers/acpi/utilities/utmath.c                   |   10 
 drivers/acpi/utilities/utmisc.c                   |  455 -
 drivers/acpi/utilities/utmutex.c                  |   41 
 drivers/acpi/utilities/utobject.c                 |   28 
 drivers/acpi/utilities/utresrc.c                  |  558 +
 drivers/acpi/utilities/utstate.c                  |    4 
 drivers/acpi/utilities/utxface.c                  |   59 
 drivers/acpi/video.c                              |    8 
 drivers/char/hpet.c                               |  197 
 drivers/pnp/pnpacpi/core.c                        |   14 
 drivers/pnp/pnpacpi/rsparser.c                    |  615 +-
 drivers/serial/8250_acpi.c                        |   28 
 include/acpi/acconfig.h                           |   36 
 include/acpi/acdebug.h                            |    2 
 include/acpi/acdisasm.h                           |  117 
 include/acpi/acdispat.h                           |    5 
 include/acpi/acevents.h                           |    8 
 include/acpi/acexcep.h                            |    2 
 include/acpi/acglobal.h                           |   27 
 include/acpi/achware.h                            |    2 
 include/acpi/acinterp.h                           |   48 
 include/acpi/aclocal.h                            |  139 
 include/acpi/acmacros.h                           |  210 
 include/acpi/acnames.h                            |    2 
 include/acpi/acnamesp.h                           |    4 
 include/acpi/acobject.h                           |    2 
 include/acpi/acopcode.h                           |    2 
 include/acpi/acoutput.h                           |   12 
 include/acpi/acparser.h                           |    2 
 include/acpi/acpi.h                               |    2 
 include/acpi/acpi_drivers.h                       |    4 
 include/acpi/acpiosxf.h                           |    6 
 include/acpi/acpixf.h                             |   13 
 include/acpi/acresrc.h                            |  802 +-
 include/acpi/acstruct.h                           |    2 
 include/acpi/actables.h                           |    2 
 include/acpi/actbl.h                              |    8 
 include/acpi/actbl1.h                             |    2 
 include/acpi/actbl2.h                             |    2 
 include/acpi/actypes.h                            |  676 +-
 include/acpi/acutils.h                            |   57 
 include/acpi/amlcode.h                            |    2 
 include/acpi/amlresrc.h                           |  319 -
 include/acpi/pdc_intel.h                          |    4 
 include/acpi/platform/acenv.h                     |   14 
 include/acpi/platform/acgcc.h                     |    2 
 include/acpi/platform/aclinux.h                   |    6 
 include/acpi/processor.h                          |   22 
 include/asm-i386/acpi.h                           |    2 
 include/asm-x86_64/mpspec.h                       |    2 
 include/linux/acpi.h                              |    2 
 include/linux/kernel.h                            |    1 
 include/linux/reboot.h                            |    3 
 kernel/power/disk.c                               |    9 
 kernel/power/main.c                               |    4 
 kernel/sys.c                                      |   25 
 200 files changed, 11684 insertions(+), 12167 deletions(-)

through these commits:

Al Viro:
      [ACPI] IA64 build: blacklist.c is used only on X86

Alexey Starikovskiy:
      [ACPI] fix reboot upon suspend-to-disk

Arjan van de Ven:
      [ACPI] move some run-time structure inits to compile time

Benoit Boissinot:
      [ACPI] fix acpi_cpufreq.c build warrning

Bjorn Helgaas:
      [ACPI] enable PNPACPI support for resource types used by HP serial ports

Bob Moore:
      [ACPI] ACPICA 20050930
      [ACPI] ACPICA 20051021
      [ACPI] ACPICA 20051102
      [ACPI] ACPICA 20051117
      [ACPI] ACPICA 20051202
      [ACPI] ACPICA 20051216
      [ACPI] ACPICA 20060113

David Shaohua Li:
      [ACPI] SMP S3 resume: evaluate _WAK after INIT

Janosch Machowinski:
      [ACPI] handle BIOS with implicit C1 in _CST

KAMEZAWA Hiroyuki:
      [ACPI] acpi_memhotplug.c build fix

Karol Kozimor:
      [ASUS_ACPI] work around Samsung P30s oops
      [ACPI_ASUS] M6R display reading
      [ACPI_ASUS] fix asus module param description

Kenji Kaneshige:
      [ACPI] build EC driver on IA64

Len Brown:
      [ACPI] handle ACPICA 20050916's acpi_resource.type rename
      [ACPI] clean up ACPICA 20050916's rscalc typedef syntax
      Merge release branch into test
      [ACPI] 8250_acpi.c buildfix
      [ACPI] Embedded Controller (EC) driver syntax update
      [ACPI] Enable Embedded Controller (EC) interrupt mode by default
      [ACPI] Embedded Controller (EC) driver printk syntax update
      [ACPI] acpi_register_gsi() fix needed for ACPICA 20051021
      [ACPI] revert owner_id limit 64 patch in prep limit 255 patch
      [ACPI] fix osl.c build warning
      [ACPI] fix pnpacpi regression resulting from ACPICA 20051117
      Revert "[ACPI] fix pnpacpi regression resulting from ACPICA 20051117"
      [ACPI] better fix for pnpacpi regression resulting from ACPICA 20051117
      [ACPI] delete message "**** SET: Misaligned resource pointer:"

Luming Yu:
      [ACPI] Disable EC burst mode w/o disabling EC interrupts

MAEDA Naoaki:
      [ACPI] ia64 build fix

matthieu castet:
      [PNPACPI] Ignore devices that have no resources
      [PNPACPI] clean excluded_id_list[]

Robert Moore:
      [ACPI] ACPICA 20050916

Thomas Rosner:
      [ACPI] Disable C2/C3 for _all_ IBM R40e Laptops

Venkatesh Pallipadi:
      [ACPI] Prefer _CST over FADT for C-state capabilities
      [ACPI] Add support for FADT P_LVL2_UP flag
      [ACPI] Avoid BIOS inflicted crashes by evaluating _PDC only once
      [ACPI] IA64 ZX1 buildfix for _PDC patch

Yu Luming:
      [ACPI] fix acpi_os_wait_sempahore() finite timeout case (AE_TIME warning)

with this log:

commit 9accd2d66a70f853c4e336d0388376b5d26660dd
Merge: e0c21375345f56e7a9f9ca2a876deb2f42d17e70 18a4144028f056b77d6576d4eb284246e9c7ea97
Author: Len Brown <len.brown@intel.com>
Date:   Fri Jan 20 02:36:14 2006 -0500

    merge linus into test branch

commit e0c21375345f56e7a9f9ca2a876deb2f42d17e70
Merge: 7880f4cc045eefc334f6ba31b6309e7007e201ec 4a90c7e86202f46fa9af011bdbcdf36e355d1721
Author: Len Brown <len.brown@intel.com>
Date:   Fri Jan 20 02:30:09 2006 -0500

    Pull acpica into test branch

commit 4a90c7e86202f46fa9af011bdbcdf36e355d1721
Author: Bob Moore <robert.moore@intel.com>
Date:   Fri Jan 13 16:22:00 2006 -0500

    [ACPI] ACPICA 20060113
    
    Added 2006 copyright.
    
    At SuSE's suggestion, enabled all error messages
    without enabling function tracing, ie with CONFIG_ACPI_DEBUG=n
    
    Replaced all instances of the ACPI_DEBUG_PRINT macro invoked at
    the ACPI_DB_ERROR and ACPI_DB_WARN debug levels with
    the ACPI_REPORT_ERROR and ACPI_REPORT_WARNING macros,
    respectively. This preserves all error and warning messages
    in the non-debug version of the ACPICA code (this has been
    referred to as the "debug lite" option.) Over 200 cases
    were converted to create a total of over 380 error/warning
    messages across the ACPICA code. This increases the code
    and data size of the default non-debug version by about 13K.
    Added ACPI_NO_ERROR_MESSAGES flag to enable deleting all messages.
    The size of the debug version remains about the same.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 3c5c363826e435cf4d54d917202567e5b57cae5f
Author: Len Brown <len.brown@intel.com>
Date:   Fri Jan 20 01:17:42 2006 -0500

    [ACPI] delete message "**** SET: Misaligned resource pointer:"
    
    This check, added in ACPICA 20051021, was overly paranoid.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 0af5853bccd263161df80c259d61fc71211c5ac3
Author: Len Brown <len.brown@intel.com>
Date:   Fri Jan 20 01:11:37 2006 -0500

    [ACPI] better fix for pnpacpi regression resulting from ACPICA 20051117
    
    Rather than tweaking acpi_walk_resource() again not return end tags,
    modify the pnpacpi code to ignore them.
    
    The pnpacpi resource type switch statements now include all known
    types in the order that they're defined -- so it is easy to see
    what is not implemented.  The code will squawk only if it sees
    a truly undefined type.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 2ae4117435b30c7f9c12c89bcb323ce48b08c16a
Author: Len Brown <len.brown@intel.com>
Date:   Mon Jan 16 15:22:45 2006 -0500

    Revert "[ACPI] fix pnpacpi regression resulting from ACPICA 20051117"
    
    This reverts ed349a8a0a780ed27e2a765f16cee54d9b63bfee commit.

commit 7880f4cc045eefc334f6ba31b6309e7007e201ec
Merge: 43d1cb7647596269f1645190d56c0121c4cf9200 3963f00831bc01f509c7dc38d050505fca64f67d
Author: Len Brown <len.brown@intel.com>
Date:   Sat Jan 7 10:47:10 2006 -0500

    Pull acpica into test branch

commit 43d1cb7647596269f1645190d56c0121c4cf9200
Merge: 52547d32973d9c6ceb2d14d46894c5b69f452cae f9a204e1de73a7007de66fb289e1d64a7665c9b4
Author: Len Brown <len.brown@intel.com>
Date:   Sat Jan 7 05:24:31 2006 -0500

    Pull release into test branch

commit 52547d32973d9c6ceb2d14d46894c5b69f452cae
Merge: 81f7895154055e8ae76f13f5c6047093519e4733 c4bb6f5ad968540d7f9619565bacd18d7419b85f
Author: Len Brown <len.brown@intel.com>
Date:   Sat Jan 7 05:18:17 2006 -0500

    Pull pnpacpi into test branch

commit c4bb6f5ad968540d7f9619565bacd18d7419b85f
Author: matthieu castet <castet.matthieu@free.fr>
Date:   Fri Jan 6 01:31:00 2006 -0500

    [PNPACPI] clean excluded_id_list[]
    
    Clean the blacklist.  Battery, Button, Fan have no _CRS
    and can be removed.  PCI root is in pnpbios and is harmless.
    
    Cc: Adam Belay <ambx1@neo.rr.com>
    Cc: "Li, Shaohua" <shaohua.li@intel.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 07b0120d53a3e7cbc88458a64a4d668fc416100f
Author: matthieu castet <castet.matthieu@free.fr>
Date:   Fri Jan 6 01:31:00 2006 -0500

    [PNPACPI] Ignore devices that have no resources
    
    Ignore devices that don't have a _CRS method.
    They are useless for the PNP layer as they don't provide any resources.
    
    Cc: Adam Belay <ambx1@neo.rr.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 81f7895154055e8ae76f13f5c6047093519e4733
Merge: 4ea5b274a37e65d95ef6b43327e7d2d39f2bb7d7 876c184b31dc73cc3f38c5b86dee55d091a56769
Author: Len Brown <len.brown@intel.com>
Date:   Sat Jan 7 04:58:13 2006 -0500

    Pull 3549 into test branch

commit 876c184b31dc73cc3f38c5b86dee55d091a56769
Author: Thomas Rosner <kernel-bugs@digital-trauma.de>
Date:   Fri Jan 6 01:31:00 2006 -0500

    [ACPI] Disable C2/C3 for _all_ IBM R40e Laptops
    
    This adds all known BIOS versions of IBM R40e Laptops to the C2/C3
    processor state blacklist and thus prevents them from crashing.
    workaround for http://bugzilla.kernel.org/show_bug.cgi?id=3549
    
    Signed-off-by: Thomas Rosner <kernel-bugs@digital-trauma.de>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 4ea5b274a37e65d95ef6b43327e7d2d39f2bb7d7
Merge: a44d7fa7bf5f8dbdaa7ad427a2f80bcbce9c7360 35f652b5ef4ef145ac5514f6302b3f4cebfbbad4
Author: Len Brown <len.brown@intel.com>
Date:   Sat Jan 7 04:53:35 2006 -0500

    Pull 5483 into test branch

commit 35f652b5ef4ef145ac5514f6302b3f4cebfbbad4
Author: Benoit Boissinot <bboissin@gmail.com>
Date:   Fri Jan 6 01:31:00 2006 -0500

    [ACPI] fix acpi_cpufreq.c build warrning
    
    Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 3963f00831bc01f509c7dc38d050505fca64f67d
Author: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Date:   Fri Jan 6 01:31:00 2006 -0500

    [ACPI] acpi_memhotplug.c build fix
    
    drivers/acpi/acpi_memhotplug.c: In function `acpi_memory_get_device_resources':
    drivers/acpi/acpi_memhotplug.c:101: error: structure has no member named `attribute'
    drivers/acpi/acpi_memhotplug.c:103: error: structure has no member named `attribute'
    drivers/acpi/acpi_memhotplug.c: In function `acpi_memory_disable_device':
    drivers/acpi/acpi_memhotplug.c:253: warning: unused variable `attr'
    
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a44d7fa7bf5f8dbdaa7ad427a2f80bcbce9c7360
Merge: bfaa3a0777f0fc3b82831cb1daf286f8ac3b4c8d d479e908457f4972205fcafa054f8030e91781ef
Author: Len Brown <len.brown@intel.com>
Date:   Sat Jan 7 04:34:41 2006 -0500

    Pull fops into test branch

commit d479e908457f4972205fcafa054f8030e91781ef
Author: Arjan van de Ven <arjan@infradead.org>
Date:   Fri Jan 6 16:47:00 2006 -0500

    [ACPI] move some run-time structure inits to compile time
    
    acpi_processor_limit_fops.write was written at run time,
    but can be initiailized at compile-time instead.
    
    Similar for acpi_video_bus_POST_fops.write and friends,
    but keep doing those at runtime to avoid prototype-hell.
    
    Signed-off-by: Arjan van de Ven <arjan@infradead.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit bfaa3a0777f0fc3b82831cb1daf286f8ac3b4c8d
Merge: e3627f3165301a7d946c2dc40be93f744f441c30 ed03f430cdc8c802652467e9097606fedc2c7abc
Author: Len Brown <len.brown@intel.com>
Date:   Sat Jan 7 03:51:29 2006 -0500

    Pull acpica into test branch

commit ed03f430cdc8c802652467e9097606fedc2c7abc
Merge: ed349a8a0a780ed27e2a765f16cee54d9b63bfee 6f957eaf79356a32e838f5f262ee9a60544b1d5b
Author: Len Brown <len.brown@intel.com>
Date:   Sat Jan 7 03:50:18 2006 -0500

    Pull pnpacpi into acpica branch

commit 6f957eaf79356a32e838f5f262ee9a60544b1d5b
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Sep 20 15:26:00 2005 -0400

    [ACPI] enable PNPACPI support for resource types used by HP serial ports
    
    PNPACPI complained about and ignored devices with ADDRESS16, ADDRESS32, or
    ADDRESS64 descriptors in _PRS.  HP firmware uses them for built-in serial
    ports, so this patch adds support for parsing these descriptors from _PRS.
    
    Note that this does not add the corresponding support for encoding them in
    preparation for _SRS, because I don't have any machine that supports _SRS
    on these descriptors, so I couldn't test that support.  Attempts to encode
    them will cause a warning and an -EINVAL return.
    
    http://sourceforge.net/mailarchive/forum.php?thread_id=8250154&forum_id=6102
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e3627f3165301a7d946c2dc40be93f744f441c30
Merge: 7125f95786ecdba47206daa8c62b9bdc4489b233 0aec63e67c69545ca757a73a66f5dcf05fa484bf
Author: Len Brown <len.brown@intel.com>
Date:   Sat Jan 7 02:06:39 2006 -0500

    Auto-update from upstream

commit 7125f95786ecdba47206daa8c62b9bdc4489b233
Merge: 5cfa3cf1f23ea070f342bf11654ae203453e8f27 ed349a8a0a780ed27e2a765f16cee54d9b63bfee
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jan 5 02:42:08 2006 -0500

    Pull acpica into test branch

commit ed349a8a0a780ed27e2a765f16cee54d9b63bfee
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jan 5 02:40:11 2006 -0500

    [ACPI] fix pnpacpi regression resulting from ACPICA 20051117
    
    In ACPICA 20051117, acpi_walk_resources() started
    sending ACPI_RESOURCE_TYPE_END_TAG to the callback
    routine which wasn't prepared for it, causing
    _CRS to fail and PnPACPI to not recognize any devices:
    
    pnp: ACPI device : hid PNP0C02
    pnp: PnPACPI: unknown resource type 7
    pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0c02
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 5cfa3cf1f23ea070f342bf11654ae203453e8f27
Merge: 2d895c07b612ec3895d5fd075dbe15897b11015c aea19aa0780d4b006372fedab8434226e1cc7686
Author: Len Brown <len.brown@intel.com>
Date:   Wed Jan 4 00:59:54 2006 -0500

    Pull asus into test branch

commit aea19aa0780d4b006372fedab8434226e1cc7686
Author: Karol Kozimor <sziwan@hell.org.pl>
Date:   Tue Jan 3 23:05:00 2006 -0500

    [ACPI_ASUS] fix asus module param description
    
    Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit bb84db937a875045de9e6d08d177ad3223ae0ae3
Author: Karol Kozimor <sziwan@hell.org.pl>
Date:   Tue Jan 3 23:03:00 2006 -0500

    [ACPI_ASUS] M6R display reading
    
    This patch corrects the node to read display settings on M6R laptops.
    
    Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 2d895c07b612ec3895d5fd075dbe15897b11015c
Merge: aeb3bc06aa44975ac865b82a0cd89e49a4664bd0 dacd9b80355525be0e3c519687868410e304ad1c
Author: Len Brown <len.brown@intel.com>
Date:   Tue Jan 3 16:34:14 2006 -0500

    Pull 4588 into test branch

commit dacd9b80355525be0e3c519687868410e304ad1c
Author: Yu Luming <luming.yu@intel.com>
Date:   Sat Dec 31 01:45:00 2005 -0500

    [ACPI] fix acpi_os_wait_sempahore() finite timeout case (AE_TIME warning)
    
    Before this fix, the finite timeout case
    behaved like the no-timeout (trylock) case.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4588
    
    Signed-off-by: Luming Yu <luming.yu@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit aeb3bc06aa44975ac865b82a0cd89e49a4664bd0
Merge: 81c6bc5d545e59374a8b865e62d1b895c329194c d78fef14c2218ba9666687aabc57392c54569048
Author: Len Brown <len.brown@intel.com>
Date:   Tue Jan 3 16:03:17 2006 -0500

    Pull release into test branch

commit 81c6bc5d545e59374a8b865e62d1b895c329194c
Merge: 609bc3fe3c0801385ffa358c05cd4b9eda818412 04348e69e7e78ad69a09b2e1157f628d6c764370
Author: Len Brown <len.brown@intel.com>
Date:   Fri Dec 30 02:45:43 2005 -0500

    Pull release into test branch

commit 609bc3fe3c0801385ffa358c05cd4b9eda818412
Merge: f1f1ccd6a001aa8805ff8e7938182df5c6e86776 c1a959d8ef4e343f11c8c0f9a693815b6dc76886
Author: Len Brown <len.brown@intel.com>
Date:   Fri Dec 30 00:36:02 2005 -0500

    Pull release into test branch

commit f1f1ccd6a001aa8805ff8e7938182df5c6e86776
Merge: 3b4f19b0ca8674432d1e79c2d035fbaef1a8156e b697b5372ecfe0c57ee26e0c3787fc2306109228
Author: Len Brown <len.brown@intel.com>
Date:   Thu Dec 29 02:46:11 2005 -0500

    Pull asus into test branch

commit b697b5372ecfe0c57ee26e0c3787fc2306109228
Author: Karol Kozimor <sziwan@hell.org.pl>
Date:   Thu Dec 22 12:42:00 2005 -0500

    [ASUS_ACPI] work around Samsung P30s oops
    
    The code used to rely on a certain method to return a NULL buffer, which
    is now hardly possible with the implicit return code on by default. This
    sort of fixes bugs #5067 and #5092 for now.
    
    Note: this patch makes the driver unusable on said machines (and on said
    machines only) iff acpi=strict is specified, but it seems noone really uses
    that.
    
    Signed-off-by: Karol Kozimor <sziwan@hell.org.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 3b4f19b0ca8674432d1e79c2d035fbaef1a8156e
Merge: 69a93f0d4f9be77a0d4a2901211eef8af4bc2656 0a5296dc34593e08c9e54b60e8f93684efff2f92
Author: Len Brown <len.brown@intel.com>
Date:   Wed Dec 28 23:43:35 2005 -0500

    Pull release into test branch

commit 69a93f0d4f9be77a0d4a2901211eef8af4bc2656
Merge: a0572c26b164ce9c241dde07159c92a6ae61d728 3173cdfe02995f6c6841a28b5148f94cefd8ab77
Author: Len Brown <len.brown@intel.com>
Date:   Wed Dec 28 03:23:48 2005 -0500

    Pull acpica into test branch

commit 3173cdfe02995f6c6841a28b5148f94cefd8ab77
Author: Len Brown <len.brown@intel.com>
Date:   Wed Dec 28 03:20:03 2005 -0500

    [ACPI] fix osl.c build warning
    
    typecheck complains on i386 that u32 != unsigned long
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a0572c26b164ce9c241dde07159c92a6ae61d728
Merge: d4d1ccac24bcdc7959fb67ef90ed8d897483ca46 defba1d8f233c0d5cf3e1ea6aeb898eca7231860
Author: Len Brown <len.brown@intel.com>
Date:   Wed Dec 28 03:12:09 2005 -0500

    Pull acpica into test branch

commit d4d1ccac24bcdc7959fb67ef90ed8d897483ca46
Merge: 01520dd4e3b5f8e394f7f62b9d1ed6f409f4d2bc f2bdf27b720a9a369d668558d6ab0c1ebfd6733e
Author: Len Brown <len.brown@intel.com>
Date:   Wed Dec 28 03:08:30 2005 -0500

    Pull owner_id into test branch

commit f2bdf27b720a9a369d668558d6ab0c1ebfd6733e
Author: Len Brown <len.brown@intel.com>
Date:   Wed Dec 28 03:05:59 2005 -0500

    [ACPI] revert owner_id limit 64 patch in prep limit 255 patch
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 01520dd4e3b5f8e394f7f62b9d1ed6f409f4d2bc
Merge: 0ef70bb300c60f19c30da302ea6d6ba315adc4c4 67dbb4ea33731415fe09c62149a34f472719ac1d
Author: Len Brown <len.brown@intel.com>
Date:   Wed Dec 28 02:56:19 2005 -0500

    Auto-update from upstream

commit defba1d8f233c0d5cf3e1ea6aeb898eca7231860
Author: Bob Moore <robert.moore@intel.com>
Date:   Fri Dec 16 17:05:00 2005 -0500

    [ACPI] ACPICA 20051216
    
    Implemented optional support to allow unresolved names
    within ASL Package objects. A null object is inserted in
    the package when a named reference cannot be located in
    the current namespace. Enabled via the interpreter slack
    flag which Linux has enabled by default (acpi=strict
    to disable slack).  This should eliminate AE_NOT_FOUND
    exceptions seen on machines that contain such code.
    
    Implemented an optimization to the initialization
    sequence that can improve boot time. During ACPI device
    initialization, the _STA method is now run if and only
    if the _INI method exists. The _STA method is used to
    determine if the device is present; An _INI can only be
    run if _STA returns present, but it is a waste of time to
    run the _STA method if the _INI does not exist. (Prototype
    and assistance from Dong Wei)
    
    Implemented use of the C99 uintptr_t for the pointer
    casting macros if it is available in the current
    compiler. Otherwise, the default (void *) cast is used
    as before.
    
    Fixed some possible memory leaks found within the
    execution path of the Break, Continue, If, and CreateField
    operators. (Valery Podrezov)
    
    Fixed a problem introduced in the 20051202 release where
    an exception is generated during method execution if a
    control method attempts to declare another method.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit cb654695f6b912cef7cb3271665b6ee0d416124c
Author: Len Brown <len.brown@intel.com>
Date:   Wed Dec 28 02:43:51 2005 -0500

    [ACPI] acpi_register_gsi() fix needed for ACPICA 20051021
    
    Use the #define for ACPI_LEVEL_SENSITIVE instead of assuming
    non-zero, because ACPICA 20051021 changes its value to zero.
    
    Also, use uniform variable names:
    edge_level -> triggering
    active_high_low -> polarity
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 0ef70bb300c60f19c30da302ea6d6ba315adc4c4
Merge: 56a0c1388ccaefd3257edc8169da8fd4bfd78904 cdcdb28623fb74d9564b102cd1cbe3854071e855
Author: Len Brown <len.brown@intel.com>
Date:   Sat Dec 24 16:41:31 2005 -0500

    Auto-update from upstream

commit 56a0c1388ccaefd3257edc8169da8fd4bfd78904
Merge: a754c7327710c87b768848e2386396c0f69b1a51 9d6be4bed65a3bd36ab2de12923bff4f4530bd86
Author: Len Brown <len.brown@intel.com>
Date:   Thu Dec 22 22:25:09 2005 -0500

    Pull owner_id into test branch

commit a754c7327710c87b768848e2386396c0f69b1a51
Merge: 2d7c78178970adf90e759021f04c37741cd38316 db9ace7083dbdcc3d02bdd6a1d26132c80b5b726
Author: Len Brown <len.brown@intel.com>
Date:   Thu Dec 22 22:02:34 2005 -0500

    Pull release into test branch

commit 2d7c78178970adf90e759021f04c37741cd38316
Merge: 7dbf4b8b10457977bbe5a5bfc06f67dfe94791d3 c162eeaa21fde6c27112690f5bc0a461a9f1763e
Author: Len Brown <len.brown@intel.com>
Date:   Thu Dec 22 22:02:16 2005 -0500

    Auto-update from upstream

commit 7dbf4b8b10457977bbe5a5bfc06f67dfe94791d3
Merge: 73cec8b4d7287d442671033a23d7adcc1d17cf36 75b245b3259133360845bc6de3aecb8a6bd6ab59
Author: Len Brown <len.brown@intel.com>
Date:   Thu Dec 22 22:00:55 2005 -0500

    Pull bug3410 into test branch

commit 73cec8b4d7287d442671033a23d7adcc1d17cf36
Merge: 41ecaa50bb4a67811fd0b25559254ab88bafe23b 63c94b68ec30847a6e2b36651703f41066f91480
Author: Len Brown <len.brown@intel.com>
Date:   Wed Dec 21 04:59:10 2005 -0500

    Pull 4980 into test branch

commit 63c94b68ec30847a6e2b36651703f41066f91480
Author: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Date:   Mon Dec 5 20:51:00 2005 -0500

    [ACPI] build EC driver on IA64
    
    Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 41ecaa50bb4a67811fd0b25559254ab88bafe23b
Merge: 1eb660c511029b7caae48107465bf346a471587d 05465fd5622202d65634b3a9a8bcc9cbb384a82a
Author: Len Brown <len.brown@intel.com>
Date:   Wed Dec 21 04:53:09 2005 -0500

    Pull owner_id into test branch

commit 1eb660c511029b7caae48107465bf346a471587d
Merge: ec0aa5917ca814864d262038af0511ec86008b79 b05948d9b7167e23af88cc65b9ffa4687eaf1f0d
Author: Len Brown <len.brown@intel.com>
Date:   Wed Dec 21 04:38:15 2005 -0500

    Auto-update from upstream

commit ec0aa5917ca814864d262038af0511ec86008b79
Merge: b20143b9736f7526c6b61850182e146d6d2d4a88 729b4d4ce1982c52040bbf22d6711cdf8db07ad8
Author: Len Brown <len.brown@intel.com>
Date:   Thu Dec 15 13:28:42 2005 -0500

    Pull 4320 into test branch

commit 729b4d4ce1982c52040bbf22d6711cdf8db07ad8
Author: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Date:   Thu Dec 1 04:29:00 2005 -0500

    [ACPI] fix reboot upon suspend-to-disk
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4320
    
    Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
    Acked-by: Pavel Machek <pavel@suse.cz>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit b20143b9736f7526c6b61850182e146d6d2d4a88
Merge: e88fa9667a7eb050c2b82a8e7a59fc187b56d982 7116317dc9148d783846299fc80a7d377baa6dca
Author: Len Brown <len.brown@intel.com>
Date:   Thu Dec 15 13:15:44 2005 -0500

    Auto-update from upstream

commit e88fa9667a7eb050c2b82a8e7a59fc187b56d982
Merge: 1bbd4932befea2b571228ebf6f9047e4e8365ed6 1a7bdfd65617add9b60f5afb96d25fe763aad36b
Author: Len Brown <len.brown@intel.com>
Date:   Sat Dec 10 00:35:32 2005 -0500

    Pull release into test branch

commit 1bbd4932befea2b571228ebf6f9047e4e8365ed6
Merge: 1d905dd30271c0aad9bd39ae694f692a92cb9916 e4f5c82a92c2a546a16af1614114eec19120e40a
Author: Len Brown <len.brown@intel.com>
Date:   Sat Dec 10 00:34:36 2005 -0500

    Auto-update from upstream

commit 1a7bdfd65617add9b60f5afb96d25fe763aad36b
Merge: 9115a6c787596e687df03010d97fccc5e0762506 e4f5c82a92c2a546a16af1614114eec19120e40a
Author: Len Brown <len.brown@intel.com>
Date:   Sat Dec 10 00:34:27 2005 -0500

    Auto-update from upstream

commit 28f55ebce5bd2fceec8adc7c8860953d3e4532a8
Author: Bob Moore <robert.moore@intel.com>
Date:   Fri Dec 2 18:27:00 2005 -0500

    [ACPI] ACPICA 20051202
    
    Modified the parsing of control methods to no longer
    create namespace objects during the first pass of the
    parse. Objects are now created only during the execute
    phase, at the moment the namespace creation operator
    is encountered in the AML (Name, OperationRegion,
    CreateByteField, etc.) This should eliminate ALREADY_EXISTS
    exceptions seen on some machines where reentrant control
    methods are protected by an AML mutex. The mutex will now
    correctly block multiple threads from attempting to create
    the same object more than once.
    
    Increased the number of available Owner Ids for namespace
    object tracking from 32 to 255. This should eliminate the
    OWNER_ID_LIMIT exceptions seen on some machines with a
    large number of ACPI tables (either static or dynamic).
    
    Enhanced the namespace dump routine to output the owner
    ID for each namespace object.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c51a4de85de720670f2fbc592a6f8040af72ad87
Author: Bob Moore <robert.moore@intel.com>
Date:   Thu Nov 17 13:07:00 2005 -0500

    [ACPI] ACPICA 20051117
    
    Fixed a problem in the AML parser where the method thread
    count could be decremented below zero if any errors
    occurred during the method parse phase. This should
    eliminate AE_AML_METHOD_LIMIT exceptions seen on some
    machines. This also fixed a related regression with the
    mechanism that detects and corrects methods that cannot
    properly handle reentrancy (related to the deployment of
    the new OwnerId mechanism.)
    
    Eliminated the pre-parsing of control methods (to detect
    errors) during table load. Related to the problem above,
    this was causing unwind issues if any errors occurred
    during the parse, and it seemed to be overkill. A table
    load should not be aborted if there are problems with
    any single control method, thus rendering this feature
    rather pointless.
    
    Fixed a problem with the new table-driven resource manager
    where an internal buffer overflow could occur for small
    resource templates.
    
    Implemented a new external interface, acpi_get_vendor_resource()
    This interface will find and return a vendor-defined
    resource descriptor within a _CRS or _PRS
    method via an ACPI 3.0 UUID match. (from Bjorn Helgaas)
    
    Removed the length limit (200) on string objects as
    per the upcoming ACPI 3.0A specification. This affects
    the following areas of the interpreter: 1) any implicit
    conversion of a Buffer to a String, 2) a String object
    result of the ASL Concatentate operator, 3) the String
    object result of the ASL ToString operator.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 96db255c8f014ae3497507104e8df809785a619f
Author: Bob Moore <robert.moore@intel.com>
Date:   Wed Nov 2 00:00:00 2005 -0500

    [ACPI] ACPICA 20051102
    
    Modified the subsystem initialization sequence to improve
    GPE support. The GPE initialization has been split into
    two parts in order to defer execution of the _PRW methods
    (Power Resources for Wake) until after the hardware is
    fully initialized and the SCI handler is installed. This
    allows the _PRW methods to access fields protected by the
    Global Lock. This will fix systems where a NO_GLOBAL_LOCK
    exception has been seen during initialization.
    
    Fixed a regression with the ConcatenateResTemplate()
    ASL operator introduced in the 20051021 release.
    
    Implemented support for "local" internal ACPI object
    types within the debugger "Object" command and the
    acpi_walk_namespace() external interfaces. These local
    types include RegionFields, BankFields, IndexFields, Alias,
    and reference objects.
    
    Moved common AML resource handling code into a new file,
    "utresrc.c". This code is shared by both the Resource
    Manager and the AML Debugger.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 0897831bb54eb36fd9e2a22da7f0f64be1b20d09
Author: Bob Moore <robert.moore@intel.com>
Date:   Fri Oct 21 00:00:00 2005 -0400

    [ACPI] ACPICA 20051021
    
    Implemented support for the EM64T and other x86_64
    processors. This essentially entails recognizing
    that these processors support non-aligned memory
    transfers. Previously, all 64-bit processors were assumed
    to lack hardware support for non-aligned transfers.
    
    Completed conversion of the Resource Manager to nearly
    full table-driven operation. Specifically, the resource
    conversion code (convert AML to internal format and the
    reverse) and the debug code to dump internal resource
    descriptors are fully table-driven, reducing code and data
    size and improving maintainability.
    
    The OSL interfaces for Acquire and Release Lock now use a
    64-bit flag word on 64-bit processors instead of a fixed
    32-bit word. (Alexey Starikovskiy)
    
    Implemented support within the resource conversion code
    for the Type-Specific byte within the various ACPI 3.0
    *WordSpace macros.
    
    Fixed some issues within the resource conversion code for
    the type-specific flags for both Memory and I/O address
    resource descriptors. For Memory, implemented support
    for the MTP and TTP flags. For I/O, split the TRS and TTP
    flags into two separate fields.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 50eca3eb89d73d9f0aa070b126c7ee6a616016ab
Author: Bob Moore <robert.moore@intel.com>
Date:   Fri Sep 30 19:03:00 2005 -0400

    [ACPI] ACPICA 20050930
    
    Completed a major overhaul of the Resource Manager code -
    specifically, optimizations in the area of the AML/internal
    resource conversion code. The code has been optimized to
    simplify and eliminate duplicated code, CPU stack use has
    been decreased by optimizing function parameters and local
    variables, and naming conventions across the manager have
    been standardized for clarity and ease of maintenance (this
    includes function, parameter, variable, and struct/typedef
    names.)
    
    All Resource Manager dispatch and information tables have
    been moved to a single location for clarity and ease of
    maintenance. One new file was created, named "rsinfo.c".
    
    The ACPI return macros (return_ACPI_STATUS, etc.) have
    been modified to guarantee that the argument is
    not evaluated twice, making them less prone to macro
    side-effects. However, since there exists the possibility
    of additional stack use if a particular compiler cannot
    optimize them (such as in the debug generation case),
    the original macros are optionally available.  Note that
    some invocations of the return_VALUE macro may now cause
    size mismatch warnings; the return_UINT8 and return_UINT32
    macros are provided to eliminate these. (From Randy Dunlap)
    
    Implemented a new mechanism to enable debug tracing for
    individual control methods. A new external interface,
    acpi_debug_trace(), is provided to enable this mechanism. The
    intent is to allow the host OS to easily enable and disable
    tracing for problematic control methods. This interface
    can be easily exposed to a user or debugger interface if
    desired. See the file psxface.c for details.
    
    acpi_ut_callocate() will now return a valid pointer if a
    length of zero is specified - a length of one is used
    and a warning is issued. This matches the behavior of
    acpi_ut_allocate().
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 3d5271f9883cba7b54762bc4fe027d4172f06db7
Merge: 378b2556f4e09fa6f87ff0cb5c4395ff28257d02 9115a6c787596e687df03010d97fccc5e0762506
Author: Len Brown <len.brown@intel.com>
Date:   Tue Dec 6 17:31:30 2005 -0500

    Pull release into acpica branch

commit 1d905dd30271c0aad9bd39ae694f692a92cb9916
Merge: 61b6dde82c772336697e66ff60320abb862fcae3 e4f5c82a92c2a546a16af1614114eec19120e40a
Author: Len Brown <len.brown@intel.com>
Date:   Tue Dec 6 16:29:33 2005 -0500

    Auto-update from upstream

commit 9115a6c787596e687df03010d97fccc5e0762506
Merge: 927fe18397b3b1194a5b26b1d388d97e391e5fd2 e4f5c82a92c2a546a16af1614114eec19120e40a
Author: Len Brown <len.brown@intel.com>
Date:   Tue Dec 6 16:27:40 2005 -0500

    Auto-update from upstream

commit 61b6dde82c772336697e66ff60320abb862fcae3
Merge: 27f0b7e1b9e645f5c2d9fa530c25235dc9bd5591 927fe18397b3b1194a5b26b1d388d97e391e5fd2
Author: Len Brown <len.brown@intel.com>
Date:   Mon Dec 5 17:34:17 2005 -0500

    Pull release into test branch

commit 27f0b7e1b9e645f5c2d9fa530c25235dc9bd5591
Merge: 7f836e502c7bfc1e0ce3df69df21b2ddfded595b c82e6abfb3182c84d0204b178363086b09881a4a
Author: Len Brown <len.brown@intel.com>
Date:   Mon Dec 5 17:25:25 2005 -0500

    Pull 5483 into test branch

commit c82e6abfb3182c84d0204b178363086b09881a4a
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Thu Dec 1 18:16:00 2005 -0500

    [ACPI] IA64 ZX1 buildfix for _PDC patch
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5483
    
    ZX1 config doesn't include cpufreq, so move move acpi-processor.c
    up out of ia64/cpufreq directory.
    
    no functional changes
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 7f836e502c7bfc1e0ce3df69df21b2ddfded595b
Merge: 129a98f787c671c845bb625cff3ff12fdc9bcb2c 1e8df53c925024548cca4374f03bed1a7e2b0c45
Author: Len Brown <len.brown@intel.com>
Date:   Mon Dec 5 17:08:13 2005 -0500

    Pull 4980 into test branch

commit 129a98f787c671c845bb625cff3ff12fdc9bcb2c
Merge: 17fad9c299d75f99f318d3880d52de8b3f547948 1e483969930a82e16767884449f3a121a817ef00
Author: Len Brown <len.brown@intel.com>
Date:   Mon Dec 5 17:05:00 2005 -0500

    Pull 5165 into test branch

commit 17fad9c299d75f99f318d3880d52de8b3f547948
Merge: cd8699c6287a8c641d29dc33880fe50a02522c95 e4f5c82a92c2a546a16af1614114eec19120e40a
Author: Len Brown <len.brown@intel.com>
Date:   Mon Dec 5 16:49:45 2005 -0500

    Pull release into test branch

commit 1e8df53c925024548cca4374f03bed1a7e2b0c45
Author: Len Brown <len.brown@intel.com>
Date:   Mon Dec 5 16:47:46 2005 -0500

    [ACPI] Embedded Controller (EC) driver printk syntax update
    
    no functional changes
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 53f11d4ff8797bcceaf014e62bd39f16ce84baec
Author: Len Brown <len.brown@intel.com>
Date:   Mon Dec 5 16:46:36 2005 -0500

    [ACPI] Enable Embedded Controller (EC) interrupt mode by default
    
    "ec_intr=0" reverts to polling
    "ec_burst=" no longer exists.
    
    Signed-off-by: Len Brown <len.brown@intel.com>
    Acked-by: Luming Yu <luming.yu@intel.com>

commit 02b28a33aae93a3b53068e0858d62f8bcaef60a3
Author: Len Brown <len.brown@intel.com>
Date:   Mon Dec 5 16:33:04 2005 -0500

    [ACPI] Embedded Controller (EC) driver syntax update
    
    "intr" largely replaces "burst" for syntax to follow semantics
    "poll" largely replaces "polling" for economy of expression
    append "interrupt mode" or "polling mode" to dmesg line
    
    no functional changes
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 06a2a3855e20ed3df380d69b37130ba86bec8001
Author: Luming Yu <luming.yu@intel.com>
Date:   Tue Sep 27 00:43:00 2005 -0400

    [ACPI] Disable EC burst mode w/o disabling EC interrupts
    
    Need to de-couple the concept of polling/interrupts
    vs burst/non-burst.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4980
    
    Signed-off-by: Luming Yu <luming.yu@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit cd8699c6287a8c641d29dc33880fe50a02522c95
Merge: eb53975791aaaedf4a5f4bcd800ded3e027054f2 cf82478840188f8c8494c1d7a668a8ae170d0e07
Author: Len Brown <len.brown@intel.com>
Date:   Thu Dec 1 20:45:03 2005 -0500

    Pull 4485 into test branch

commit cf82478840188f8c8494c1d7a668a8ae170d0e07
Author: Janosch Machowinski <jmachowinski@gmx.de>
Date:   Sat Aug 20 08:02:00 2005 -0400

    [ACPI] handle BIOS with implicit C1 in _CST
    
    The ASUS M6Ne specifies C2, implying C1
    but not explicitly specifying it.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4485
    
    Signed-off-by: Janosch Machowinski <jmachowinski@gmx.de>
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit eb53975791aaaedf4a5f4bcd800ded3e027054f2
Merge: 84e2593ab0d2804ff1f894182a97b8fd9bccd411 05131ecc99ea9da7f45ba3058fe8a2c1d0ceeab8
Author: Len Brown <len.brown@intel.com>
Date:   Thu Dec 1 01:30:59 2005 -0500

    Pull 5483 into test branch

commit 05131ecc99ea9da7f45ba3058fe8a2c1d0ceeab8
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Sun Oct 23 16:31:00 2005 -0400

    [ACPI] Avoid BIOS inflicted crashes by evaluating _PDC only once
    
    Linux invokes the AML _PDC method (Processor Driver Capabilities)
    to tell the BIOS what features it can handle.  While the ACPI
    spec says nothing about the OS invoking _PDC multiple times,
    doing so with changing bits seems to hopelessly confuse the BIOS
    on multiple platforms up to and including crashing the system.
    
    Factor out the _PDC invocation so Linux invokes it only once.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5483
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 84e2593ab0d2804ff1f894182a97b8fd9bccd411
Merge: fda422119362bbee9d988bec5053c6e114410ef3 cd8e2b48daee891011a4f21e2c62b210d24dcc9e
Author: Len Brown <len.brown@intel.com>
Date:   Wed Nov 30 23:29:07 2005 -0500

    Pull 5452 into test branch

commit fda422119362bbee9d988bec5053c6e114410ef3
Merge: bc9aad753371cf1a89700f8f2bd351def2fdd5f4 1a38416cea8ac801ae8f261074721f35317613dc
Author: Len Brown <len.brown@intel.com>
Date:   Wed Nov 30 23:16:40 2005 -0500

    Pull 5651 into test branch

commit 1a38416cea8ac801ae8f261074721f35317613dc
Author: David Shaohua Li <shaohua.li@intel.com>
Date:   Wed Nov 23 12:36:00 2005 -0500

    [ACPI] SMP S3 resume: evaluate _WAK after INIT
    
    On SMP resume from S3, we reset (INIT) the non-boot
    processors to boot them cleanly.  But the BIOS needs
    to execute _WAK after INIT in order to properly
    initialized these processors upon resume.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5651
    
    Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit bc9aad753371cf1a89700f8f2bd351def2fdd5f4
Merge: 0e78ce81c189ea850a2ffd6d727c8acc65f2d050 59d399d357a7705568f424c6e861ee8657f7f655
Author: Len Brown <len.brown@intel.com>
Date:   Wed Nov 30 23:04:13 2005 -0500

    Pull 5571 into test branch

commit 0e78ce81c189ea850a2ffd6d727c8acc65f2d050
Merge: bf98ccc91e2b0d3e082f434409c5c4011d61d1cd 1cbf4c563c0eaaf11c552a88b374e213181c6ddd
Author: Len Brown <len.brown@intel.com>
Date:   Wed Nov 30 22:53:35 2005 -0500

    Pull 3410 into test branch

commit bf98ccc91e2b0d3e082f434409c5c4011d61d1cd
Merge: 7fb853ec21ea153840c859b978c0fb2af2d44f50 c8734a9663806b7ebd3b5e33bae65a60ff6553bd
Author: Len Brown <len.brown@intel.com>
Date:   Wed Nov 30 22:28:21 2005 -0500

    Pull release into test branch

commit 7fb853ec21ea153840c859b978c0fb2af2d44f50
Merge: 637c9a35e7469c74e1b402f4716977d157760107 0a47c906342e2447003e207d23917dfa5c912071
Author: Len Brown <len.brown@intel.com>
Date:   Wed Nov 30 22:16:08 2005 -0500

    Pull release into test branch

commit 637c9a35e7469c74e1b402f4716977d157760107
Merge: 02f0cce041fffef4ff17764eb2befaf7e93ca5c6 d2149b542382bfc206cb28485108f6470c979566
Author: Len Brown <len.brown@intel.com>
Date:   Wed Nov 30 21:52:33 2005 -0500

    Auto-update from upstream

commit 02f0cce041fffef4ff17764eb2befaf7e93ca5c6
Merge: 493f4f3f9b790ed1945208c686f7730769d0ddd3 4c0335526c95d90a1d958e0059f40a5745fc7c5d
Author: Len Brown <len.brown@intel.com>
Date:   Wed Nov 30 21:47:35 2005 -0500

    Pull 5165 into test branch

commit 493f4f3f9b790ed1945208c686f7730769d0ddd3
Merge: 06856c23aaa77f83e35dcddfd340936bd31b5652 bd7ce5b5ff930c29b1c0405051e9c9388660b785
Author: Len Brown <len.brown@intel.com>
Date:   Wed Nov 30 21:46:52 2005 -0500

    Pull 5221 into test branch

commit 06856c23aaa77f83e35dcddfd340936bd31b5652
Merge: 9b19ef3ce1a3875f19b76a1d5350970d714b557c 378b2556f4e09fa6f87ff0cb5c4395ff28257d02
Author: Len Brown <len.brown@intel.com>
Date:   Wed Nov 30 21:06:24 2005 -0500

    Pull acpica into test branch

commit 378b2556f4e09fa6f87ff0cb5c4395ff28257d02
Author: Len Brown <len.brown@intel.com>
Date:   Wed Nov 30 21:03:21 2005 -0500

    [ACPI] 8250_acpi.c buildfix
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c780f964902a8c4e7f702ff3e0a2b754e82b3ca3
Author: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Date:   Wed Nov 30 18:00:24 2005 -0500

    [ACPI] ia64 build fix
    
    arch/ia64/kernel/acpi-ext.c: In function `acpi_vendor_resource_match':
    arch/ia64/kernel/acpi-ext.c:38: error: structure has no member named `id'
    
    Signed-off-by: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9b19ef3ce1a3875f19b76a1d5350970d714b557c
Author: Len Brown <len.brown@intel.com>
Date:   Wed Nov 30 03:18:22 2005 -0500

    Merge release branch into test

commit 018570ab26d8b48cf38539c32d176f81258f1a90
Merge: ef4611613657dfb8af8d336f2f61f08cfcdc9d8a d2ef5ebb4c4fe141a82252d4db8d8521e6765c5a
Author: Len Brown <len.brown@intel.com>
Date:   Wed Nov 30 03:17:34 2005 -0500

    Auto-update from upstream

commit ef4611613657dfb8af8d336f2f61f08cfcdc9d8a
Author: Al Viro <viro@ftp.linux.org.uk>
Date:   Thu Sep 22 01:15:57 2005 -0400

    [ACPI] IA64 build: blacklist.c is used only on X86
    
    Signed-off-by: Al Viro <viro@ftp.linux.org.uk>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 28b86b368af3944eb383078fc5797caf2dc8ce44
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Thu Sep 15 12:20:00 2005 -0400

    [ACPI] Add support for FADT P_LVL2_UP flag
    which tells us if C2 is valid for UP-only, or SMP.
    
    As there is no separate bit for C3,  use P_LVL2_UP
    bit to cover both C2 and C3.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5165
    
    Signed-off-by: Venkatesh Pallipadi<venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 883baf7f7e81cca26f4683ae0d25ba48f094cc08
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Thu Sep 15 12:19:00 2005 -0400

    [ACPI] Prefer _CST over FADT for C-state capabilities
    
    Note: This ACPI standard compliance may cause regression
    on some system, if they have _CST present, but _CST value
    is bogus. "nocst" module parameter should workaround
    that regression.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5165
    
    Signed-off-by: Venkatesh Pallipadi<venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 486368bf33a2844319ad4865039543cd50ac90dd
Author: Len Brown <len.brown@intel.com>
Date:   Thu Sep 22 01:57:01 2005 -0400

    [ACPI] clean up ACPICA 20050916's rscalc typedef syntax
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit eca008c8134df15262a0362623edb59902628c95
Author: Len Brown <len.brown@intel.com>
Date:   Thu Sep 22 00:25:18 2005 -0400

    [ACPI] handle ACPICA 20050916's acpi_resource.type rename
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit bda663d36b94c723153246a4231bbc0f1cd1836e
Author: Robert Moore <Robert.Moore@intel.com>
Date:   Fri Sep 16 16:51:15 2005 -0400

    [ACPI] ACPICA 20050916
    
    Fixed a problem within the Resource Manager where
    support for the Generic Register descriptor was not fully
    implemented.  This descriptor is now fully recognized,
    parsed, disassembled, and displayed.
    
    Restructured the Resource Manager code to utilize
    table-driven dispatch and lookup, eliminating many of the
    large switch() statements.  This reduces overall subsystem
    code size and code complexity.  Affects the resource parsing
    and construction, disassembly, and debug dump output.
    
    Cleaned up and restructured the debug dump output for all
    resource descriptors.  Improved readability of the output
    and reduced code size.
    
    Fixed a problem where changes to internal data structures
    caused the optional ACPI_MUTEX_DEBUG code to fail
    compilation if specified.
    
    Signed-off-by: Robert Moore <Robert.Moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

--CFGHIJKLMNOPQRSTUVWWXYZabcdefghijklmnopq--
