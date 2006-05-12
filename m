From: Len Brown <len.brown@intel.com>
Subject: latest ACPI patch vs 2.6.17-rc4
Date: Fri, 12 May 2006 05:18:37 -0400
Message-ID: <200605120518.38033.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29838 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751096AbWELJSt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 12 May 2006 05:18:49 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Folks,
The latest ACPI patch is against 2.6.17-rc4 and is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git test
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6.17/acpi-test-20060310-2.6.17-rc4.diff.gz

Note that I removed the acpi_in_resume workaround, so you'll get some oops'
 during resume, until we replace it with something else.

Note that the kmalloc patches allow CONFIG_DEBUG_SLAB_LEAKS to put more
useful entries in /proc/slab_allocators for acpi.

cheers,
-Len


 Documentation/kernel-parameters.txt               |    3 
 arch/i386/kernel/acpi/boot.c                      |    5 
 arch/i386/kernel/acpi/processor.c                 |    2 
 arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c       |  289 +++++--
 arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c |  250 ++++--
 arch/ia64/Kconfig                                 |    1 
 arch/x86_64/Kconfig                               |    1 
 arch/x86_64/kernel/acpi/Makefile                  |    1 
 arch/x86_64/kernel/acpi/processor.c               |   74 -
 drivers/acpi/Kconfig                              |    3 
 drivers/acpi/ac.c                                 |   72 -
 drivers/acpi/acpi_memhotplug.c                    |  179 +---
 drivers/acpi/asus_acpi.c                          |   34 
 drivers/acpi/battery.c                            |  145 +--
 drivers/acpi/bus.c                                |  140 +--
 drivers/acpi/button.c                             |   82 --
 drivers/acpi/container.c                          |   42 -
 drivers/acpi/debug.c                              |   21 
 drivers/acpi/dispatcher/dsfield.c                 |    1 
 drivers/acpi/dispatcher/dsmethod.c                |    5 
 drivers/acpi/dispatcher/dsmthdat.c                |    3 
 drivers/acpi/dispatcher/dsobject.c                |   15 
 drivers/acpi/dispatcher/dsopcode.c                |    4 
 drivers/acpi/dispatcher/dsutils.c                 |    9 
 drivers/acpi/dispatcher/dswexec.c                 |    3 
 drivers/acpi/dispatcher/dswload.c                 |   10 
 drivers/acpi/dispatcher/dswscope.c                |    2 
 drivers/acpi/dispatcher/dswstate.c                |   13 
 drivers/acpi/ec.c                                 |  198 +----
 drivers/acpi/event.c                              |   21 
 drivers/acpi/events/evevent.c                     |    2 
 drivers/acpi/events/evgpe.c                       |    5 
 drivers/acpi/events/evgpeblk.c                    |   52 -
 drivers/acpi/events/evmisc.c                      |    6 
 drivers/acpi/events/evregion.c                    |   12 
 drivers/acpi/events/evrgnini.c                    |   14 
 drivers/acpi/events/evxface.c                     |   82 +-
 drivers/acpi/events/evxfevnt.c                    |   41 -
 drivers/acpi/events/evxfregn.c                    |    9 
 drivers/acpi/executer/exconfig.c                  |    9 
 drivers/acpi/executer/exconvrt.c                  |    2 
 drivers/acpi/executer/exdump.c                    |    4 
 drivers/acpi/executer/exfield.c                   |    6 
 drivers/acpi/executer/exfldio.c                   |    5 
 drivers/acpi/executer/exmisc.c                    |    1 
 drivers/acpi/executer/exmutex.c                   |    3 
 drivers/acpi/executer/exnames.c                   |   10 
 drivers/acpi/executer/exoparg1.c                  |   61 +
 drivers/acpi/executer/exoparg2.c                  |   81 +-
 drivers/acpi/executer/exoparg3.c                  |   11 
 drivers/acpi/executer/exoparg6.c                  |    1 
 drivers/acpi/executer/exprep.c                    |   17 
 drivers/acpi/executer/exregion.c                  |   11 
 drivers/acpi/executer/exresnte.c                  |    5 
 drivers/acpi/executer/exresolv.c                  |   43 -
 drivers/acpi/executer/exresop.c                   |    4 
 drivers/acpi/executer/exstore.c                   |    2 
 drivers/acpi/executer/exstoren.c                  |    3 
 drivers/acpi/executer/exstorob.c                  |   11 
 drivers/acpi/executer/exsystem.c                  |    2 
 drivers/acpi/executer/exutils.c                   |    3 
 drivers/acpi/fan.c                                |   60 -
 drivers/acpi/glue.c                               |    8 
 drivers/acpi/hardware/hwgpe.c                     |    2 
 drivers/acpi/hardware/hwregs.c                    |   12 
 drivers/acpi/hardware/hwsleep.c                   |   19 
 drivers/acpi/hardware/hwtimer.c                   |   10 
 drivers/acpi/hotkey.c                             |  157 +---
 drivers/acpi/motherboard.c                        |   69 -
 drivers/acpi/namespace/nsaccess.c                 |   26 
 drivers/acpi/namespace/nsalloc.c                  |   14 
 drivers/acpi/namespace/nsdump.c                   |    4 
 drivers/acpi/namespace/nsdumpdv.c                 |    2 
 drivers/acpi/namespace/nseval.c                   |    5 
 drivers/acpi/namespace/nsinit.c                   |    7 
 drivers/acpi/namespace/nsload.c                   |    3 
 drivers/acpi/namespace/nsnames.c                  |   10 
 drivers/acpi/namespace/nsobject.c                 |    3 
 drivers/acpi/namespace/nsparse.c                  |    2 
 drivers/acpi/namespace/nssearch.c                 |    5 
 drivers/acpi/namespace/nsutils.c                  |   23 
 drivers/acpi/namespace/nswalk.c                   |    4 
 drivers/acpi/namespace/nsxfeval.c                 |   86 +-
 drivers/acpi/namespace/nsxfname.c                 |   17 
 drivers/acpi/namespace/nsxfobj.c                  |   11 
 drivers/acpi/osl.c                                |  101 --
 drivers/acpi/parser/psargs.c                      |    7 
 drivers/acpi/parser/psloop.c                      |    7 
 drivers/acpi/parser/psopcode.c                    |    2 
 drivers/acpi/parser/psparse.c                     |    8 
 drivers/acpi/parser/psscope.c                     |    1 
 drivers/acpi/parser/pstree.c                      |    8 
 drivers/acpi/parser/psutils.c                     |    9 
 drivers/acpi/parser/pswalk.c                      |    3 
 drivers/acpi/parser/psxface.c                     |    2 
 drivers/acpi/pci_bind.c                           |   91 +-
 drivers/acpi/pci_irq.c                            |   98 +-
 drivers/acpi/pci_link.c                           |  217 ++---
 drivers/acpi/pci_root.c                           |   43 -
 drivers/acpi/power.c                              |  162 +---
 drivers/acpi/processor_core.c                     |  203 +----
 drivers/acpi/processor_idle.c                     |   96 --
 drivers/acpi/processor_perflib.c                  |  374 +++++++---
 drivers/acpi/processor_thermal.c                  |   53 -
 drivers/acpi/processor_throttling.c               |   50 -
 drivers/acpi/resources/rscalc.c                   |  122 +--
 drivers/acpi/resources/rscreate.c                 |    2 
 drivers/acpi/resources/rsinfo.c                   |    1 
 drivers/acpi/resources/rslist.c                   |   18 
 drivers/acpi/resources/rsmisc.c                   |   12 
 drivers/acpi/resources/rsutils.c                  |   65 -
 drivers/acpi/resources/rsxface.c                  |   31 
 drivers/acpi/scan.c                               |  174 +---
 drivers/acpi/sleep/wakeup.c                       |    3 
 drivers/acpi/system.c                             |   29 
 drivers/acpi/tables/tbconvrt.c                    |   11 
 drivers/acpi/tables/tbget.c                       |   11 
 drivers/acpi/tables/tbgetall.c                    |    1 
 drivers/acpi/tables/tbinstal.c                    |    9 
 drivers/acpi/tables/tbrsdt.c                      |    1 
 drivers/acpi/tables/tbutils.c                     |    2 
 drivers/acpi/tables/tbxface.c                     |   18 
 drivers/acpi/tables/tbxfroot.c                    |   33 
 drivers/acpi/thermal.c                            |  261 ++----
 drivers/acpi/utilities/utalloc.c                  |   25 
 drivers/acpi/utilities/utcache.c                  |   14 
 drivers/acpi/utilities/utcopy.c                   |   25 
 drivers/acpi/utilities/utdebug.c                  |   27 
 drivers/acpi/utilities/utdelete.c                 |    7 
 drivers/acpi/utilities/uteval.c                   |    8 
 drivers/acpi/utilities/utglobal.c                 |    8 
 drivers/acpi/utilities/utinit.c                   |    8 
 drivers/acpi/utilities/utmisc.c                   |   39 -
 drivers/acpi/utilities/utmutex.c                  |    4 
 drivers/acpi/utilities/utobject.c                 |    7 
 drivers/acpi/utilities/utresrc.c                  |    4 
 drivers/acpi/utilities/utstate.c                  |    2 
 drivers/acpi/utilities/utxface.c                  |   24 
 drivers/acpi/utils.c                              |  112 +-
 drivers/acpi/video.c                              |  338 +++------
 drivers/char/hpet.c                               |    5 
 drivers/char/sonypi.c                             |   10 
 drivers/pci/hotplug/acpi_pcihp.c                  |   16 
 drivers/pci/hotplug/acpiphp_dock.c                |    4 
 drivers/pci/hotplug/acpiphp_glue.c                |    2 
 drivers/pci/hotplug/pciehp_hpc.c                  |    4 
 drivers/pnp/pnpacpi/rsparser.c                    |  199 ++---
 include/acpi/acconfig.h                           |   10 
 include/acpi/acdisasm.h                           |   24 
 include/acpi/aclocal.h                            |    8 
 include/acpi/acmacros.h                           |   50 -
 include/acpi/acnamesp.h                           |    5 
 include/acpi/acpiosxf.h                           |    7 
 include/acpi/actypes.h                            |   25 
 include/acpi/acutils.h                            |    6 
 include/acpi/amlresrc.h                           |   61 -
 include/acpi/pdc_intel.h                          |    5 
 include/acpi/platform/acenv.h                     |   10 
 include/acpi/platform/aclinux.h                   |   29 
 include/acpi/processor.h                          |   27 
 include/asm-i386/apicdef.h                        |    1 
 include/asm-x86_64/acpi.h                         |    2 
 include/asm-x86_64/apicdef.h                      |    2 
 include/linux/cpufreq.h                           |    4 
 164 files changed, 3044 insertions(+), 3168 deletions(-)

through these commits:

Adrian Bunk:
      [ACPI] drivers/acpi/video.c: fix error path NULL pointer dereference
      ACPI: Kconfig: ACPI should depend on, not select PCI

Andi Kleen:
      [ACPI] fix "nolapic" flag in ACPI mode

Andrew Morton:
      ACPI: UP build fix for bugzilla-5737

Ashok Raj:
      ACPI: build fix for u8 cpu_index
      ACPI: Allow hot-add of ejected processor
      x86_64: Remove stale lapic definition from apicdef.h 

Bjorn Helgaas:
      PNPACPI: fix non-memory address space descriptor handling 
      PNPACPI: remove some code duplication
      PNPACPI: whitespace cleanup
      ACPI: request correct fixed hardware resource type (MMIO vs I/O port) 
      ACPI: Display "ACPI" to motherboard resources in /proc/io{mem,port} 
      ACPI: make acpi_bus_register_driver() return success/failure, not device 
count 
      ACPI: update asus_acpi driver registration to unload on failure
      ACPI: fix sonypi ACPI driver registration to unregister on failure
      ACPI: simplify scan.c coding
      ACPI: fix memory hotplug range length handling
      HPET: fix ACPI memory range length handling
      ACPI: remove __init/__exit from Asus .add()/.remove() methods 
      ACPI: Don't print internal BIOS names of wakeup devices

Bob Moore:
      [ACPI] ACPICA 20060210
      ACPI: ACPICA 20060217
      ACPI: ACPICA 20060310

Dave Jones:
      [ACPI] fix possible acpi thermal leak in failure path

Davi Arnaut:
      ACPI: acpi_os_acquire_object (GFP_KERNEL) called with IRQs disabled 
through suspend-resume 

David Shaohua Li:
      [ACPI] enable SMP C-states on x86_64

Irwan Djajadi:
      [ACPI] drivers/acpi/hotkey.c: check kmalloc return value

Jiri Slaby:
      ACPI: EC acpi-ecdt-uid-hack

Len Brown:
      ACPI: enable BIOS warning
      [ACPI] document cmdline acpi_os_name=
      Revert "ACPI: fix vendor resource length computation"
      ACPI: inline trivial acpi_os_get_thread_id()
      ACPI: delete remaining function tracing macros from drivers/acpi/*.c
      ACPI: delete newly added debugging macros in processor_perflib.c
      ACPI: disable ACPI_DBG_TRACK_ALLOCATIONS on debug kernel
      ACPI: use kfree(), delete acpi_os_free()
      ACPI: delete acpi_in_resume workaround
      ACPI: use kmalloc() and kzalloc(), delete acpi_os_allocate()
      ACPI: repair damage from overzealous bus.c cleanup patch

Patrick Mochel:
      ACPI: Remove debugging macros from drivers/acpi/thermal.c
      ACPI: Remove debugging macros from drivers/acpi/system.c
      ACPI: Remove debugging macros from drivers/acpi/processor_throttling.c
      ACPI: Remove debugging macros from drivers/acpi/processor_thermal.c
      ACPI: Remove debugging macros from drivers/acpi/processor_perflib.c
      ACPI: Remove debugging macros from drivers/acpi/processor_core.c
      ACPI: Remove debugging macros from drivers/acpi/processor_idle.c
      ACPI: Remove debugging macros from drivers/acpi/ec.c
      ACPI: Remove debugging macros from drivers/acpi/pci_link.c
      ACPI: Remove debugging macros from drivers/acpi/event.c
      ACPI: Remove debugging macros from drivers/acpi/power.c
      ACPI: Remove debugging macros from drivers/acpi/pci_root.c
      ACPI: Remove debugging macros from drivers/acpi/pci_irq.c
      ACPI: Remove debugging macros from drivers/acpi/motherboard.c
      ACPI: Remove debugging macros from drivers/acpi/hotkey.c
      ACPI: Remove debugging macros from drivers/acpi/pci_bind.c
      ACPI: Remove debugging macros from drivers/acpi/fan.c
      ACPI: Remove debugging macros from drivers/acpi/container.c
      ACPI: Remove debugging macros from drivers/acpi/debug.c
      ACPI: Remove debugging macros from drivers/acpi/button.c
      ACPI: Remove debugging macros from drivers/acpi/battery.c
      ACPI: Remove debugging macros from drivers/acpi/bus.c
      ACPI: Remove debugging macros from drivers/acpi/acpi_memhotplug.c
      ACPI: Remove debugging macros from drivers/acpi/ac.c

Thomas Renniger:
      [ACPI] Enable ACPI error messages w/o CONFIG_ACPI_DEBUG

Thomas Renninger:
      [ACPI] Export symbols for ACPI_ERROR/EXCEPTION/WARNING macros
      [ACPI] Print error message if remove/install notify handler fails

Venkatesh Pallipadi:
      P-state software coordination for ACPI core
      P-state software coordination for acpi-cpufreq
      P-state software coordination for speedstep-centrino
      Enable P-state software coordination via _PDC

with this log:

commit 42e3a90e5deafdbf482820158fc56696137d1730
Merge: cfab935... e4218b8...
Author: Len Brown <len.brown@intel.com>
Date:   Fri May 12 05:01:20 2006 -0400

    Pull kmalloc into test branch
    
    Conflicts:
    
    	drivers/acpi/acpi_memhotplug.c
    	drivers/acpi/osl.c
    	drivers/acpi/pci_link.c
    	drivers/acpi/scan.c
    	drivers/acpi/video.c
    	include/acpi/acmacros.h
    	include/acpi/platform/aclinux.h
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit cfab93573f6d0a65752648279d07282cf4dec2f5
Merge: b5689e1... d8c3291...
Author: Len Brown <len.brown@intel.com>
Date:   Fri May 12 04:25:23 2006 -0400

    merge linus into test branch

commit b5689e13f0b0e33acc7a1705c398c1f22a3bd46f
Merge: 7378614... 2637566...
Author: Len Brown <len.brown@intel.com>
Date:   Fri May 12 04:21:45 2006 -0400

    Pull dmesg into test branch

commit 26375665dd6ba2140790889f1761981dbda6efab
Author: Len Brown <len.brown@intel.com>
Date:   Fri May 12 04:19:11 2006 -0400

    ACPI: repair damage from overzealous bus.c cleanup patch
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e4218b8328d570082de636b865d6e874a451644d
Author: Len Brown <len.brown@intel.com>
Date:   Fri May 12 00:47:25 2006 -0400

    ACPI: use kmalloc() and kzalloc(), delete acpi_os_allocate()
    
    Also skip acpi_ut_allocate().
    
    In addition to deleting unnecessary code,
    this allows CONFIG_DEBUG_SLAB_LEAK to better track kmalloc users.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 6e1f1f6ef94d38b78f56ba728491a94de52cda0b
Author: Len Brown <len.brown@intel.com>
Date:   Thu May 11 01:43:04 2006 -0400

    ACPI: delete acpi_in_resume workaround
    
    All this workaround does is silence the may_sleep warning.
    But that can be silenced by using global system states in resume,
    just they are used during boot.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 1b35d6f69aad8780fbe01d0b21497aa2d616f392
Author: Len Brown <len.brown@intel.com>
Date:   Thu May 11 01:37:05 2006 -0400

    ACPI: use kfree(), delete acpi_os_free()
    
    acpi_os_free() serves no purpose.
    Inside the ACPICA core, ACPI_FREE() is used.
    Outside the ACPICA core, native kfree() can be used.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a2412c16d852826365d2caf7238dea6fb356c3c7
Author: Len Brown <len.brown@intel.com>
Date:   Thu May 11 01:17:16 2006 -0400

    ACPI: disable ACPI_DBG_TRACK_ALLOCATIONS on debug kernel
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 7378614c128b5ae7034899445537d49464ff0db0
Merge: 3f0bd1a... 9011bff...
Author: Len Brown <len.brown@intel.com>
Date:   Thu May 11 00:30:29 2006 -0400

    Pull bugzilla-5737 into test branch

commit 9011bff4bdc0fef1f9a782d7415c306ee61826c9
Author: Len Brown <len.brown@intel.com>
Date:   Thu May 11 00:28:12 2006 -0400

    ACPI: delete newly added debugging macros in processor_perflib.c
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 3f0bd1a08a992106c11b11d4b1230fcfbe919e24
Merge: 5b31856... 5d882e6...
Author: Len Brown <len.brown@intel.com>
Date:   Thu May 11 00:18:35 2006 -0400

    Pull dmesg into test branch
    
    Conflicts:
    
    	drivers/acpi/processor_core.c
    	drivers/acpi/scan.c
    	drivers/acpi/thermal.c

commit 5b31856b24f2e2874fa3fd2a87f4bcdcccad6b59
Merge: a4250b0... 0e44dc3...
Author: Len Brown <len.brown@intel.com>
Date:   Wed May 10 22:58:25 2006 -0400

    Pull linus into test branch
    
    Conflicts:
    
    	arch/i386/kernel/acpi/boot.c

commit a4250b0b64cfde4d1e8e805d62a75125f2e4a611
Merge: 46ae90f... e6f1f3c...
Author: Len Brown <len.brown@intel.com>
Date:   Wed May 10 22:56:12 2006 -0400

    Pull trivial1 into test branch

commit 5d882e684aafea30c508d86d235327d94e1d38ae
Author: Len Brown <len.brown@intel.com>
Date:   Tue May 9 10:55:56 2006 -0400

    ACPI: delete remaining function tracing macros from drivers/acpi/*.c
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 14394600cdfe0c952ce662a32a68c5c5524d32ac
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Mon Apr 17 21:22:00 2006 -0400

    ACPI: Remove debugging macros from drivers/acpi/ac.c
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit da95181baf3cf6a2bd81c0c8af1d4c6790703e4f
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Mon Apr 17 21:22:00 2006 -0400

    ACPI: Remove debugging macros from drivers/acpi/acpi_memhotplug.c
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit b128440ed11d108c375772b7fe9ad46d2ac07084
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Mon Apr 17 21:22:00 2006 -0400

    ACPI: Remove debugging macros from drivers/acpi/bus.c
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 61ce94e1f8b16b1694475adba9bf2e07fac02020
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Mon Apr 17 21:22:00 2006 -0400

    ACPI: Remove debugging macros from drivers/acpi/battery.c
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a48142ea89e02ed0aba0a481ead1e9302e1a4160
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Mon Apr 17 21:22:00 2006 -0400

    ACPI: Remove debugging macros from drivers/acpi/button.c
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d5c11d3ba31d6ead24f27de648dc2dcfde5092e3
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Mon Apr 17 21:22:00 2006 -0400

    ACPI: Remove debugging macros from drivers/acpi/debug.c
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit f6a08bf2cb06ee3d5be749cf20685b677619bc8e
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Mon Apr 17 21:22:00 2006 -0400

    ACPI: Remove debugging macros from drivers/acpi/container.c
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 2cb7f1704275905b7548eee299c554bcdc5cf357
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Mon Apr 17 21:22:00 2006 -0400

    ACPI: Remove debugging macros from drivers/acpi/fan.c
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 2ce2b16467f0d43d0f8933eb4821b2369b31888c
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Mon Apr 17 21:22:00 2006 -0400

    ACPI: Remove debugging macros from drivers/acpi/pci_bind.c
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 8ec0cbd9386a40a3afffad78334f4403b256dc4b
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Mon Apr 17 21:22:00 2006 -0400

    ACPI: Remove debugging macros from drivers/acpi/hotkey.c
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ba8acc597cff47fcbbd7b9f0d73a59e784852d8b
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Mon Apr 17 21:22:00 2006 -0400

    ACPI: Remove debugging macros from drivers/acpi/motherboard.c
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 7e9e8344848d80c9b6e1b9eaf32dd498b48ca5bb
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Mon Apr 17 21:22:00 2006 -0400

    ACPI: Remove debugging macros from drivers/acpi/pci_irq.c
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d2606159ffdf8e435f6a7714f8e8910672b944d5
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Mon Apr 17 21:22:00 2006 -0400

    ACPI: Remove debugging macros from drivers/acpi/pci_root.c
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 8fb1d47b74e2bad912f74783048b433a1e313799
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Mon Apr 17 21:22:00 2006 -0400

    ACPI: Remove debugging macros from drivers/acpi/power.c
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit f7c0fce6da5cb68b8b0e203df4ff8ef9b3265105
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Mon Apr 17 21:22:00 2006 -0400

    ACPI: Remove debugging macros from drivers/acpi/event.c
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 61e295946a248e43cf244cb24097e284d1d00e35
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Mon Apr 17 21:22:00 2006 -0400

    ACPI: Remove debugging macros from drivers/acpi/pci_link.c
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a32283362a7a8e7cff608fe25299a59925daea4d
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Mon Apr 17 21:22:00 2006 -0400

    ACPI: Remove debugging macros from drivers/acpi/ec.c
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 4cd5611ca16348b3805ddcf89b97fe670e76faaa
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Mon Apr 17 21:22:00 2006 -0400

    ACPI: Remove debugging macros from drivers/acpi/processor_idle.c
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 529758bad4b0f9a8eec56fcc5cad342e9680ea36
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Mon Apr 17 21:22:00 2006 -0400

    ACPI: Remove debugging macros from drivers/acpi/processor_core.c
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 91afb9e683426ff238aab159e60f6d6e792e7488
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Mon Apr 17 21:22:00 2006 -0400

    ACPI: Remove debugging macros from drivers/acpi/processor_perflib.c
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9f102deee398ea4dfcee3b2108dc00bc59ea877b
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Mon Apr 17 21:22:00 2006 -0400

    ACPI: Remove debugging macros from drivers/acpi/processor_thermal.c
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e85eb9a47f19a26b636b58106e309f8db6b2415d
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Mon Apr 17 21:22:00 2006 -0400

    ACPI: Remove debugging macros from drivers/acpi/processor_throttling.c
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 4597ac50598b85a09417df531849b80ce2e8e44b
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Mon Apr 17 21:22:00 2006 -0400

    ACPI: Remove debugging macros from drivers/acpi/system.c
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 74951d613e758f9709d6f2173107be68f18f77f4
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Mon Apr 17 21:22:00 2006 -0400

    ACPI: Remove debugging macros from drivers/acpi/thermal.c
    
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e6f1f3c54974a30c65ea0b699809d12f0aa04272
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Mon Apr 3 13:14:00 2006 -0400

    ACPI: Don't print internal BIOS names of wakeup devices
    
    Internal BIOS names like these should be exposed
    to the user as little as possible:
    
    ACPI wakeup devices: C069 C0CE C1D1 C0DE C1D4
    
    Eventually, the "wakeup" property of a device should be exported via the
    device tree, not by a printk of an internal BIOS name.  For the hard-core,
    these are still available in /proc/acpi/wakeup_devices, just not
    printed to dmesg.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 46ae90f0b636c22f05d46ea7a10f451f1034d939
Merge: 9d3482d... e4513a5...
Author: Len Brown <len.brown@intel.com>
Date:   Sat Apr 1 23:18:22 2006 -0500

    Pull acpi_bus_register_driver into test branch
    
    Conflicts:
    
    	drivers/acpi/asus_acpi.c

commit 9d3482d05b2bc317ef03013626248aff6091065a
Merge: e560d25... 5e15b92... 9224a86... eefa27a... ff2fc3e... 1300124... 
cd090ee... 1c6e7d0... c12ea91...
Author: Len Brown <len.brown@intel.com>
Date:   Sat Apr 1 23:15:50 2006 -0500

    merge acpi_in_resume address-range cpu-hotplug ec Kconfig motherboard 
pnpacpi trivial1 into test

commit e560d2547a203cb822d490f4be8ad65b75244b6f
Merge: 7b6efc8... 7e1f19e...
Author: Len Brown <len.brown@intel.com>
Date:   Sat Apr 1 23:15:08 2006 -0500

    merge bugzilla-5737 into test

commit c12ea918ee175ceb3a258cd81f1c43e897d0c0bc
Author: Ashok Raj <ashok.raj@intel.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    x86_64: Remove stale lapic definition from apicdef.h 
    
    Signed-off-by: Ashok Raj <ashok.raj@intel.com>
    Cc: Andi Kleen <ak@muc.de>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit eefa27a93a0490902f33837ac86dbcf344b3aa29
Author: Ashok Raj <ashok.raj@intel.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    ACPI: Allow hot-add of ejected processor
    
    acpi_eject_store() didn't trim processors, causing subsequent
    hot-add to fail.
    
    Signed-off-by: Ashok Raj <ashok.raj@intel.com>
    Cc: Andi Kleen <ak@muc.de>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ff2fc3e9e3edb918b6c6b288485c6cb267bc865e
Author: Jiri Slaby <jirislaby@gmail.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    ACPI: EC acpi-ecdt-uid-hack
    
    On some boxes ecdt uid may be equal to 0, so do not test for uids 
equality,
    so that fake handler will be unconditionally removed to allow loading the
    real one.
    
    See http://bugzilla.kernel.org/show_bug.cgi?id=6111
    
    Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
    Cc: Luming Yu <luming.yu@intel.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit df42baa0d8e54df18dd9366dd7c93d6be7d5d063
Author: Ashok Raj <ashok.raj@intel.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    ACPI: build fix for u8 cpu_index
    
    Local apic entries are only 8 bits, but it seemed to not be caught with u8
    return value result in the check
    
    cpu_index >= NR_CPUS becomming always false.
    
    drivers/acpi/processor_core.c: In function `acpi_processor_get_info':
    drivers/acpi/processor_core.c:483: warning: comparison is always false due 
to limited range of data type
    
    Signed-off-by: Ashok Raj <ashok.raj@intel.com>
    Cc: Dave Jones <davej@codemonkey.org.uk>
    Cc: Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 200739c179c63d21804e9e8e2ced265243831579
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    ACPI: remove __init/__exit from Asus .add()/.remove() methods 
    
    Even though the devices claimed by asus_acpi.c can not be hot-plugged, the
    driver registration infrastructure allows the .add() and .remove() methods 
to
    be called at any time while the driver is registered.  So remove __init 
and
    __exit from them.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 5e15b92d07fb11490c886c5dd7567f523ea43e2d
Author: Davi Arnaut <davi.arnaut@gmail.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    ACPI: acpi_os_acquire_object (GFP_KERNEL) called with IRQs disabled 
through suspend-resume 
    
    acpi_os_acquire_object() gets called, with IRQs disabled, from:
    
    Debug: sleeping function called from invalid context at mm/slab.c:2499
    in_atomic():0, irqs_disabled():1
     [<c01462f3>] kmem_cache_alloc+0x40/0x4f     [<c0202c85>] 
acpi_os_acquire_object+0xb/0x3c
     [<c02171b1>] acpi_ut_allocate_object_desc_dbg+0x13/0x49     [<c021704b>] 
acpi_ut_create_internal_object_dbg+0xf/0x5e
     [<c02136d4>] acpi_rs_set_srs_method_data+0x3d/0xb9     [<c021aa3d>] 
acpi_pci_link_set+0x102/0x17b
     [<c021aecb>] irqrouter_resume+0x1e/0x3c     [<c024d921>] 
__sysdev_resume+0x11/0x6b
     [<c024dbde>] sysdev_resume+0x34/0x52     [<c0251cb7>] 
device_power_up+0x5/0xa
     [<c0138787>] suspend_enter+0x44/0x46     [<c01386e5>] 
suspend_prepare+0x63/0xc1
     [<c0138813>] enter_state+0x5e/0x7c     [<c013894c>] state_store+0x81/0x8f
     [<c01388cb>] state_store+0x0/0x8f     [<c0196a0a>] 
subsys_attr_store+0x1e/0x22
     [<c0196c12>] flush_write_buffer+0x22/0x28     [<c0196c64>] 
sysfs_write_file+0x4c/0x71
     [<c0196c18>] sysfs_write_file+0x0/0x71     [<c015b2c9>] 
vfs_write+0xa2/0x15a
     [<c015b42c>] sys_write+0x41/0x6a     [<c0102e75>] syscall_call+0x7/0xb
    
    The patch also fixes a missing check for NULL return from
    acpi_os_acquire_object().
    
    Signed-off-by: Davi Arnaut <davi.arnaut@gmail.com>
    Cc: Pavel Machek <pavel@ucw.cz>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9224a867c497053842dc595e594ca6d32112221f
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    HPET: fix ACPI memory range length handling
    
    ACPI address space descriptors contain _MIN, _MAX, and _LEN.  _MIN and 
_MAX
    are the bounds within which the region can be moved (this is clarified in
    Table 6-38 of the ACPI 3.0 spec).  We should use _LEN to determine the 
size
    of the region, not _MAX - _MIN + 1.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 459c7266d7a5c1730169258217e25fdd1b7ca854
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    ACPI: fix memory hotplug range length handling
    
    Address space descriptors contain _MIN, _MAX, and _LEN.  _MIN and _MAX are
    the bounds within which the region can be moved (this is clarified in 
Table
    6-38 of the ACPI 3.0 spec).  We should use _LEN to determine the size of
    the region, not _MAX - _MIN + 1.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 1a36561607abf1405b56a41aac2fd163429cd1f8
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    ACPI: simplify scan.c coding
    
    No functional changes; just remove leftover, unused "buffer" and simplify
    control flow (no need to remember error values and goto the end, when we 
can
    simply return the value directly).
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e4513a57ef719d3d6d1cee0ca4d9f4016aa452bb
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    ACPI: fix sonypi ACPI driver registration to unregister on failure
    
    Remove the assumption that acpi_bus_register_driver() returns the number 
of
    devices claimed.  Returning the count is unreliable because devices may be
    hot-plugged in the future (admittedly not applicable for this driver).
    
    This also fixes a bug: if sonypi_acpi_driver was registered but found no
    devices, sonypi_exit() did not unregister it.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 578b333bfe8eb1360207a08a53c321822a8f40f3
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    ACPI: update asus_acpi driver registration to unload on failure
    
    Remove the assumption that acpi_bus_register_driver() returns the number 
of
    devices claimed.  Returning the count is unreliable because devices may be
    hot-plugged in the future (admittedly not applicable for this driver).
    
    Since the hardware for this driver is not hot-pluggable, determine whether 
the
    hardware is present by noticing calls to the .add() method.  It would be
    better to probe the ACPI namespace for the ASUS HIDs, and load the driver 
only
    when we find one, but ACPI doesn't support that yet.
    
    I don't have an ASUS laptop to test on, but on my HP dl360, it does report 
the
    appropriate error when attempting to load the module:
    
        $ sudo insmod drivers/acpi/asus_acpi.ko
        insmod: error inserting 'drivers/acpi/asus_acpi.ko': -1 No such device
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9d9f749b316ac21cb59ad3e595cbce469b409e1a
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    ACPI: make acpi_bus_register_driver() return success/failure, not device 
count 
    
    acpi_bus_register_driver() should not return the number of devices 
claimed.
    We're not asking to find devices, we're making a driver available to 
devices,
    including hot-pluggable devices that may appear in the future.
    
    I audited all callers of acpi_bus_register_driver(), and except 
asus_acpi.c
    and sonypi.c (fixed in previous patches), all either ignore the return 
value
    or test only for failure (<0).
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit cd090eedd85256829f762677d0752a846c1b88b9
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    ACPI: Display "ACPI" to motherboard resources in /proc/io{mem,port} 
    
    Add "ACPI" to motherboard resource allocation names, so people have a clue
    about where to look.  And remove some trailing spaces.
    
    Changes these /proc/iomem entries from this:
    
        ff5c1004-ff5c1007 : PM_TMR
        ff5c1008-ff5c100b : PM1a_EVT_BLK
        ff5c100c-ff5c100d : PM1a_CNT_BLK
        ff5c1010-ff5c1013 : GPE0_BLK
        ff5c1014-ff5c1017 : GPE1_BLK
    
    to this:
    
        ff5c1004-ff5c1007 : ACPI PM_TMR
        ff5c1008-ff5c100b : ACPI PM1a_EVT_BLK
        ff5c100c-ff5c100d : ACPI PM1a_CNT_BLK
        ff5c1010-ff5c1013 : ACPI GPE0_BLK
        ff5c1014-ff5c1017 : ACPI GPE1_BLK
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 81507ea9cfa64e9851b53e0fefebfa776eda9ecb
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    ACPI: request correct fixed hardware resource type (MMIO vs I/O port) 
    
    ACPI supports fixed hardware (PM_TMR, GPE blocks, etc) in either I/O port
    or MMIO space, but used to always request the regions from I/O space
    because it didn't check the address_space_id.
    
    Sample ACPI fixed hardware in MMIO space (HP rx2600), was incorrectly
    reported in /proc/ioports, now reported in /proc/iomem:
    
        ff5c1004-ff5c1007 : PM_TMR
        ff5c1008-ff5c100b : PM1a_EVT_BLK
        ff5c100c-ff5c100d : PM1a_CNT_BLK
        ff5c1010-ff5c1013 : GPE0_BLK
        ff5c1014-ff5c1017 : GPE1_BLK
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 1c6e7d0aeecac38e66b1bb63e3eff07b2a1c2f2c
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    PNPACPI: whitespace cleanup
    
    Tidy up whitespace.  No functional change.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit b5f2490b6e3317059e87ba40d4f659d1c30afc1f
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 28 17:04:00 2006 -0500

    PNPACPI: remove some code duplication
    
    Factor out the duplicated switch from pnpacpi_count_resources() and
    pnpacpi_type_resources().  Remove the unnecessary re-initialization of
    resource->type and length from all the encode functions (id and length are
    originally set in the pnpacpi_build_resource_template() ->
    pnpacpi_type_resources() path).
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 1acfb7f2b0d460ee86bdb25ad0679070ec8a5f0d
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Tue Mar 28 17:03:00 2006 -0500

    PNPACPI: fix non-memory address space descriptor handling 
    
    Fix resource_type handling for QWORD, DWORD, and WORD Address Space
    Descriptors.  Previously we ignored the resource_type, so I/O ports and 
bus
    number ranges were incorrectly parsed as memory ranges.
    
    Sample PCI root bridge resources from HP rx2600 before this patch:
    
        # cat /sys/bus/pnp/devices/00:02/resources
        state = active
        mem 0x0-0x1f
        mem 0x0-0x3af
        mem 0x3e0-0x1fff
        mem 0x80000000-0x8fffffff
    
    With this patch:
    
        # cat /sys/bus/pnp/devices/00:02/resources
        state = active
        io 0x0-0x3af
        io 0x3e0-0x1fff
        mem 0x80000000-0x8fffffff
        mem 0x80004000000-0x80103fffffe
    
    Changes:
        0x0-0x1f PCI bus number range was incorrectly reported as memory, now
    	not reported at all
        0x0-0x3af I/O port range was incorrectly reported as memory
        0x3e0-0x1fff I/O port range was incorrectly reported as memory
        0x80004000000-0x80103fffffe memory range wasn't reported at all 
because
    	we only support PNP_MAX_MEM (4) memory resources
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 7e1f19e50371e1d148226b64c8edc77fec47fa5b
Author: Andrew Morton <akpm@osdl.org>
Date:   Tue Mar 28 17:03:00 2006 -0500

    ACPI: UP build fix for bugzilla-5737
    
    cpu_online_map doesn't exist if !CONFIG_SMP.
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 1300124f69cafc54331bc06e968a8dd67863f989
Author: Adrian Bunk <bunk@stusta.de>
Date:   Tue Mar 28 17:04:00 2006 -0500

    ACPI: Kconfig: ACPI should depend on, not select PCI
    
    Otherwise, illegal configurations like X86_VOYAGER=y, PCI=y are
    possible.
    
    This patch also fixes the options select'ing ACPI to also select PCI.
    
    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 7b6efc8b701de5de4ec11d13fcee05b2ac3c1550
Merge: 7bddf82... 683aa40...
Author: Len Brown <lenb@toshiba.site>
Date:   Sat Apr 1 20:54:11 2006 -0500

    merge linus into test branch

commit 7bddf826d950dee0e0b3400cc45f6786ed4e5e75
Merge: 2ac9a40... f9ea7fd...
Author: Len Brown <lenb@toshiba.site>
Date:   Sat Apr 1 05:30:10 2006 -0500

    Pull dmesg into test branch
    
    Conflicts:
    
    	drivers/acpi/processor_core.c
    	drivers/acpi/video.c

commit 2ac9a40c2d27754eab5f24a7b24a9dc144ce10d3
Merge: 2d50670... 9cfda2c... 0eacee5...
Author: Len Brown <lenb@toshiba.site>
Date:   Sat Apr 1 05:27:55 2006 -0500

    Pull novell-bugzilla-156426 bugzilla-5452  into test branch

commit 2d50670edd7b34cfbef2683ff6fbe8103d4c2d31
Merge: ab87bbd... 6665bda...
Author: Len Brown <lenb@toshiba.site>
Date:   Sat Apr 1 05:27:32 2006 -0500

    Pull trivial into test branch

commit ab87bbd9264362ec955414cc7b617cf088a5d978
Merge: 1900d67... ec7381d...
Author: Len Brown <lenb@toshiba.site>
Date:   Sat Apr 1 05:24:29 2006 -0500

    Pull acpica into test branch

commit 1900d6702264e1193873bf849f20fe130e71d60b
Merge: 7d2c215... ffd642e...
Author: Len Brown <lenb@toshiba.site>
Date:   Sat Apr 1 05:23:50 2006 -0500

    Pull bugzilla-5653 into test branch
    
    Conflicts:
    
    	arch/x86_64/kernel/acpi/processor.c

commit 7d2c215b6bcf746b940224bde9f0c7b64048b1b1
Merge: a0f0678... d52bb94...
Author: Len Brown <lenb@toshiba.site>
Date:   Sat Apr 1 05:22:23 2006 -0500

    Pull bugzilla-5737 into test branch

commit ec7381d6bfd3e7b8d2880dd5e9d03b131b0603f6
Author: Len Brown <lenb@toshiba.site>
Date:   Sat Apr 1 05:12:23 2006 -0500

    ACPI: inline trivial acpi_os_get_thread_id()
    
    acpi_os_get_thread_id() is used only for debugging
    code that is not enabled on Linux, so stub it out.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 8313524a0d466f451a62709aaedf988d8257b21c
Author: Bob Moore <robert.moore@intel.com>
Date:   Tue Oct 3 00:00:00 2006 -0400

    ACPI: ACPICA 20060310
    
    Tagged all external interfaces to the subsystem with the
    new ACPI_EXPORT_SYMBOL macro. This macro can be defined
    as necessary to assist kernel integration. For Linux,
    the macro resolves to the EXPORT_SYMBOL macro. The default
    definition is NULL.
    
    Added the ACPI_THREAD_ID type for the return value from
    acpi_os_get_thread_id(). This allows the host to define this
    as necessary to simplify kernel integration. The default
    definition is ACPI_NATIVE_UINT.
    
    Valery Podrezov fixed two interpreter problems related
    to error processing, the deletion of objects, and placing
    invalid pointers onto the internal operator result stack.
    http://bugzilla.kernel.org/show_bug.cgi?id=6028
    http://bugzilla.kernel.org/show_bug.cgi?id=6151
    
    Increased the reference count threshold where a warning is
    emitted for large reference counts in order to eliminate
    unnecessary warnings on systems with large namespaces
    (especially 64-bit.) Increased the value from 0x400
    to 0x800.
    
    Due to universal disagreement as to the meaning of the
    'c' in the calloc() function, the ACPI_MEM_CALLOCATE
    macro has been renamed to ACPI_ALLOCATE_ZEROED so that the
    purpose of the interface is 'clear'. ACPI_MEM_ALLOCATE and
    ACPI_MEM_FREE are renamed to ACPI_ALLOCATE and ACPI_FREE.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ea936b78f46cbe089a4ac363e1682dee7d427096
Author: Bob Moore <robert.moore@intel.com>
Date:   Fri Feb 17 00:00:00 2006 -0500

    ACPI: ACPICA 20060217
    
    Implemented a change to the IndexField support to match
    the behavior of the Microsoft AML interpreter. The value
    written to the Index register is now a byte offset,
    no longer an index based upon the width of the Data
    register. This should fix IndexField problems seen on
    some machines where the Data register is not exactly one
    byte wide. The ACPI specification will be clarified on
    this point.
    
    Fixed a problem where several resource descriptor
    types could overrun the internal descriptor buffer due
    to size miscalculation: VendorShort, VendorLong, and
    Interrupt. This was noticed on IA64 machines, but could
    affect all platforms.
    
    Fixed a problem where individual resource descriptors were
    misaligned within the internal buffer, causing alignment
    faults on IA64 platforms.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 52fc0b026e99b5d5d585095148d997d5634bbc25
Author: Bob Moore <robert.moore@intel.com>
Date:   Mon Oct 2 00:00:00 2006 -0400

    [ACPI] ACPICA 20060210
    
    Removed a couple of extraneous ACPI_ERROR messages that
    appeared during normal execution. These became apparent
    after the conversion from ACPI_DEBUG_PRINT.
    
    Fixed a problem where the CreateField operator could hang
    if the BitIndex or NumBits parameter referred to a named
    object. From Valery Podrezov.
    http://bugzilla.kernel.org/show_bug.cgi?id=5359
    
    Fixed a problem where a DeRefOf operation on a buffer
    object incorrectly failed with an exception. This also
    fixes a couple of related RefOf and DeRefOf issues.
    From Valery Podrezov.
    http://bugzilla.kernel.org/show_bug.cgi?id=5360
    http://bugzilla.kernel.org/show_bug.cgi?id=5387
    http://bugzilla.kernel.org/show_bug.cgi?id=5392
    
    Fixed a problem where the AE_BUFFER_LIMIT exception was
    returned instead of AE_STRING_LIMIT on an out-of-bounds
    Index() operation. From Valery Podrezov.
    http://bugzilla.kernel.org/show_bug.cgi?id=5480
    
    Implemented a memory cleanup at the end of the execution
    of each iteration of an AML While() loop, preventing the
    accumulation of outstanding objects. From Valery Podrezov.
    http://bugzilla.kernel.org/show_bug.cgi?id=5427
    
    Eliminated a chunk of duplicate code in the object
    resolution code. From Valery Podrezov.
    http://bugzilla.kernel.org/show_bug.cgi?id=5336
    
    Fixed several warnings during the 64-bit code generation.
    
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 46358614ed5b031797522f1020e989c959a8d8a6
Author: Len Brown <lenb@toshiba.site>
Date:   Fri Mar 31 02:16:19 2006 -0500

    Revert "[PATCH] ACPI: fix vendor resource length computation"
    
    fixed in a different way by a subsequent ACPICA patch
    
    This reverts 35b73ceb9a7d10c81bd9e79e8485f7079ef2b40e commit.

commit 6665bda76461308868bd1e52caf627f4cb29ed32
Author: Adrian Bunk <bunk@stusta.de>
Date:   Sat Mar 11 10:12:00 2006 -0500

    [ACPI] drivers/acpi/video.c: fix error path NULL pointer dereference
    
    The Coverity checker spotted this bug in
    acpi_video_device_lcd_query_levels().
    
    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit fdc136ccd3332938e989439c025c363f8479f3e6
Author: Dave Jones <davej@redhat.com>
Date:   Wed Mar 8 22:12:00 2006 -0500

    [ACPI] fix possible acpi thermal leak in failure path
    
    Coverity: #601
    
    Signed-off-by: Dave Jones <davej@redhat.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a1f9e65e2085e0a87f28a4d5a8ae43b32c087f24
Author: Len Brown <len.brown@intel.com>
Date:   Wed Jan 25 23:47:36 2006 -0500

    [ACPI] document cmdline acpi_os_name=
    
    This can sometimes be used to work around broken BIOS.
    Use "Microsoft Windows" to take the same path
    through the BIOS as Windows98 would.
    
    The default is "Microsoft Windows NT", which
    is what NT and later versions of Windows use,
    and is the most tested path through most BIOS.
    
    Set it to anything else, including "Linux", at your
    own risk, as it seems that virtually no BIOS
    has been tested with anything but the two options above.
    
    Note that this uses the legacy _OS interface, so
    we don't expect this to ever change.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 1fee94034917aa711fcbd4ebf4c36f7ebd9fa7d6
Author: Irwan Djajadi <irwan.djajadi@iname.com>
Date:   Fri Jan 20 15:28:00 2006 -0500

    [ACPI] drivers/acpi/hotkey.c: check kmalloc return value
    
    Signed-off-by: Irwan Djajadi <irwan.djajadi@iname.com>
    Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 0eacee585a89ce5827b572a73a024931506bef48
Author: Len Brown <lenb@toshiba.site>
Date:   Fri Mar 31 00:37:23 2006 -0500

    ACPI: enable BIOS warning
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5452
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9cfda2c94df61c9f859b474abe774c65a4464d0a
Author: Andi Kleen <ak@suse.de>
Date:   Mon Mar 27 02:24:32 2006 -0500

    [ACPI] fix "nolapic" flag in ACPI mode
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d52bb94d56676acd9bdac8e097257a87b4b1b2e1
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Wed Dec 14 15:05:00 2005 -0500

    Enable P-state software coordination via _PDC
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5737
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c52851b60cc0aaaf974ff0e49989fb698220447d
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Wed Dec 14 15:05:00 2005 -0500

    P-state software coordination for speedstep-centrino
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5737
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 09b4d1ee881c8593bfad2a42f838d85070365c3e
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Wed Dec 14 15:05:00 2005 -0500

    P-state software coordination for acpi-cpufreq
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5737
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 3b2d99429e3386b6e2ac949fc72486509c8bbe36
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Wed Dec 14 15:05:00 2005 -0500

    P-state software coordination for ACPI core
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5737
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ffd642e748c867a7339b57225b8bf8b9a0dcd9c5
Author: David Shaohua Li <shaohua.li@intel.com>
Date:   Wed Feb 8 17:35:00 2006 -0500

    [ACPI] enable SMP C-states on x86_64
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5653
    
    Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit f9ea7fd8be9827791f407ca1191ff70ec25eb2d9
Author: Thomas Renninger <trenn@suse.de>
Date:   Fri Jun 2 15:58:00 2006 -0400

    [ACPI] Print error message if remove/install notify handler fails
    
    Signed-off-by: Thomas Renniger <trenn@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit b60e49b2383db0334bef1f0d9cdad9bec2336050
Author: Thomas Renninger <trenn@suse.de>
Date:   Fri Jun 2 15:58:00 2006 -0400

    [ACPI] Export symbols for ACPI_ERROR/EXCEPTION/WARNING macros
    
    Signed-off-by: Thomas Renninger <trenn@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 1ca218d3bd6acca0922a349cb76e3244d27ebfba
Author: Thomas Renniger <trenn@suse.de>
Date:   Fri Jun 2 15:58:00 2006 -0400

    [ACPI] Enable ACPI error messages w/o CONFIG_ACPI_DEBUG
    
    Signed-off-by: Thomas Renniger <trenn@suse.de>
    Signed-off-by: Len Brown <len.brown@intel.com>
