From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: updated ACPI patch against 2.6.13-rc1
Date: 30 Jun 2005 12:16:33 -0400
Message-ID: <1120148192.23586.15.camel@d845pe.worldpath.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hello everybody,

This patch includes all the dusty patches that have been
waiting in BK me for 2.6.13 to open.
It applies against 2.6.13-rc1.

ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.13/acpi-20050408-2.6.13-rc1.diff.gz

Please give it a go, and if nothing explodes I'll git it to Linus for
2.6.13-rc2 and we'll move onto the batch that is waiting in line behind
this one:-)

thanks,
-Len

ps.
Also available via BK
	bk pull bk://linux-acpi.bkbits.net/to-akpm
	or by using the open source BK puller:
	http://www.bitkeeper.com/press/2005-03-17.html

pps. I've posted a 2.6.12 plain patch in the analogous spot, but it
doesn't include everything.  Let me know if anybody is interested it
everything against 2.6.12 and I can look into augmenting that patch.

This will update the following files:

 Documentation/acpi-hotkey.txt                     |   35 
 arch/frv/mb93090-mb00/pci-irq.c                   |    2 
 arch/i386/Kconfig                                 |   12 
 arch/i386/kernel/acpi/Makefile                    |    4 
 arch/i386/kernel/acpi/cstate.c                    |  102 +
 arch/i386/kernel/acpi/wakeup.S                    |    5 
 arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c |    2 
 arch/i386/pci/irq.c                               |   16 
 arch/i386/pci/visws.c                             |    2 
 arch/ia64/kernel/acpi.c                           |   54 
 arch/ia64/kernel/mca.c                            |    2 
 arch/ia64/kernel/process.c                        |    1 
 arch/ia64/kernel/setup.c                          |    3 
 arch/ia64/kernel/topology.c                       |    7 
 arch/x86_64/Kconfig                               |   10 
 drivers/acpi/Kconfig                              |   40 
 drivers/acpi/Makefile                             |    5 
 drivers/acpi/asus_acpi.c                          |    4 
 drivers/acpi/bus.c                                |    8 
 drivers/acpi/button.c                             |  249 --
 drivers/acpi/dispatcher/dsfield.c                 |   58 
 drivers/acpi/dispatcher/dsinit.c                  |   28 
 drivers/acpi/dispatcher/dsmethod.c                |   11 
 drivers/acpi/dispatcher/dsmthdat.c                |  195 +
 drivers/acpi/dispatcher/dsobject.c                |   79 
 drivers/acpi/dispatcher/dsopcode.c                |  105 -
 drivers/acpi/dispatcher/dsutils.c                 |   41 
 drivers/acpi/dispatcher/dswexec.c                 |   57 
 drivers/acpi/dispatcher/dswload.c                 |  118 -
 drivers/acpi/dispatcher/dswscope.c                |   31 
 drivers/acpi/dispatcher/dswstate.c                |  458 ++--
 drivers/acpi/ec.c                                 |  420 ++--
 drivers/acpi/events/evevent.c                     |   33 
 drivers/acpi/events/evgpe.c                       |   39 
 drivers/acpi/events/evgpeblk.c                    |   63 
 drivers/acpi/events/evmisc.c                      |   97 
 drivers/acpi/events/evregion.c                    |   35 
 drivers/acpi/events/evrgnini.c                    |   14 
 drivers/acpi/events/evsci.c                       |   12 
 drivers/acpi/events/evxface.c                     |   19 
 drivers/acpi/events/evxfevnt.c                    |   25 
 drivers/acpi/executer/exconfig.c                  |   31 
 drivers/acpi/executer/exconvrt.c                  |   44 
 drivers/acpi/executer/excreate.c                  |   50 
 drivers/acpi/executer/exdump.c                    |  105 -
 drivers/acpi/executer/exfield.c                   |   25 
 drivers/acpi/executer/exfldio.c                   |  133 -
 drivers/acpi/executer/exmisc.c                    |    7 
 drivers/acpi/executer/exmutex.c                   |   45 
 drivers/acpi/executer/exnames.c                   |   70 
 drivers/acpi/executer/exoparg1.c                  |   94 
 drivers/acpi/executer/exoparg2.c                  |   69 
 drivers/acpi/executer/exoparg3.c                  |   25 
 drivers/acpi/executer/exoparg6.c                  |   26 
 drivers/acpi/executer/exprep.c                    |  104 -
 drivers/acpi/executer/exregion.c                  |   34 
 drivers/acpi/executer/exresnte.c                  |   24 
 drivers/acpi/executer/exresolv.c                  |   63 
 drivers/acpi/executer/exresop.c                   |   80 
 drivers/acpi/executer/exstore.c                   |  260 +-
 drivers/acpi/executer/exstoren.c                  |   20 
 drivers/acpi/executer/exstorob.c                  |    9 
 drivers/acpi/executer/exsystem.c                  |   48 
 drivers/acpi/executer/exutils.c                   |   37 
 drivers/acpi/glue.c                               |  360 +++
 drivers/acpi/hardware/hwacpi.c                    |   19 
 drivers/acpi/hardware/hwgpe.c                     |   31 
 drivers/acpi/hardware/hwregs.c                    |  114 -
 drivers/acpi/hardware/hwsleep.c                   |  101 
 drivers/acpi/hardware/hwtimer.c                   |    4 
 drivers/acpi/hotkey.c                             | 1019 ++++++++++
 drivers/acpi/ibm_acpi.c                           |    8 
 drivers/acpi/namespace/nsaccess.c                 |    5 
 drivers/acpi/namespace/nsalloc.c                  |  121 -
 drivers/acpi/namespace/nsdump.c                   |  109 -
 drivers/acpi/namespace/nsdumpdv.c                 |   18 
 drivers/acpi/namespace/nseval.c                   |   70 
 drivers/acpi/namespace/nsinit.c                   |   28 
 drivers/acpi/namespace/nsload.c                   |   28 
 drivers/acpi/namespace/nsnames.c                  |   12 
 drivers/acpi/namespace/nsobject.c                 |   14 
 drivers/acpi/namespace/nssearch.c                 |   29 
 drivers/acpi/namespace/nsutils.c                  |  167 -
 drivers/acpi/namespace/nswalk.c                   |    2 
 drivers/acpi/namespace/nsxfeval.c                 |   16 
 drivers/acpi/namespace/nsxfname.c                 |    8 
 drivers/acpi/namespace/nsxfobj.c                  |    4 
 drivers/acpi/osl.c                                |   12 
 drivers/acpi/parser/psargs.c                      |   55 
 drivers/acpi/parser/psopcode.c                    |  298 --
 drivers/acpi/parser/psparse.c                     |  144 -
 drivers/acpi/parser/psscope.c                     |   45 
 drivers/acpi/parser/pstree.c                      |  159 -
 drivers/acpi/parser/psutils.c                     |   15 
 drivers/acpi/parser/pswalk.c                      |   11 
 drivers/acpi/parser/psxface.c                     |   21 
 drivers/acpi/pci_link.c                           |   43 
 drivers/acpi/processor_core.c                     |   37 
 drivers/acpi/processor_idle.c                     |  138 -
 drivers/acpi/processor_perflib.c                  |   33 
 drivers/acpi/resources/rsaddr.c                   |  480 ++--
 drivers/acpi/resources/rscalc.c                   |  144 -
 drivers/acpi/resources/rscreate.c                 |   45 
 drivers/acpi/resources/rsdump.c                   |  402 ++-
 drivers/acpi/resources/rsio.c                     |  197 -
 drivers/acpi/resources/rsirq.c                    |  167 -
 drivers/acpi/resources/rslist.c                   |   68 
 drivers/acpi/resources/rsmemory.c                 |  236 --
 drivers/acpi/resources/rsmisc.c                   |  160 -
 drivers/acpi/resources/rsutils.c                  |   53 
 drivers/acpi/resources/rsxface.c                  |   43 
 drivers/acpi/scan.c                               |   12 
 drivers/acpi/sleep/main.c                         |   74 
 drivers/acpi/sleep/poweroff.c                     |   81 
 drivers/acpi/sleep/proc.c                         |    9 
 drivers/acpi/tables/tbconvrt.c                    |  105 -
 drivers/acpi/tables/tbget.c                       |   63 
 drivers/acpi/tables/tbgetall.c                    |   45 
 drivers/acpi/tables/tbinstal.c                    |   31 
 drivers/acpi/tables/tbrsdt.c                      |   19 
 drivers/acpi/tables/tbutils.c                     |   97 
 drivers/acpi/tables/tbxface.c                     |   39 
 drivers/acpi/tables/tbxfroot.c                    |  123 -
 drivers/acpi/toshiba_acpi.c                       |    8 
 drivers/acpi/utilities/utalloc.c                  |   84 
 drivers/acpi/utilities/utcopy.c                   |  126 -
 drivers/acpi/utilities/utdebug.c                  |  106 -
 drivers/acpi/utilities/utdelete.c                 |   63 
 drivers/acpi/utilities/uteval.c                   |   36 
 drivers/acpi/utilities/utglobal.c                 |  133 -
 drivers/acpi/utilities/utinit.c                   |   36 
 drivers/acpi/utilities/utmath.c                   |    2 
 drivers/acpi/utilities/utmisc.c                   |  187 -
 drivers/acpi/utilities/utobject.c                 |   68 
 drivers/acpi/utilities/utxface.c                  |   61 
 drivers/acpi/video.c                              |   15 
 drivers/base/sys.c                                |    1 
 drivers/net/b44.c                                 |    3 
 drivers/net/ne2k-pci.c                            |    3 
 drivers/pci/pci-acpi.c                            |  110 +
 drivers/pci/pci.c                                 |   18 
 drivers/pci/pci.h                                 |    4 
 drivers/pcmcia/yenta_socket.c                     |    3 
 drivers/pnp/pnpacpi/rsparser.c                    |   15 
 drivers/pnp/pnpbios/rsparser.c                    |    2 
 drivers/pnp/resource.c                            |    2 
 drivers/usb/core/hcd-pci.c                        |    1 
 include/acpi/acconfig.h                           |    7 
 include/acpi/acdebug.h                            |  146 -
 include/acpi/acdisasm.h                           |  114 -
 include/acpi/acdispat.h                           |  171 -
 include/acpi/acevents.h                           |   85 
 include/acpi/acexcep.h                            |    5 
 include/acpi/acglobal.h                           |   12 
 include/acpi/achware.h                            |   52 
 include/acpi/acinterp.h                           |  243 --
 include/acpi/aclocal.h                            |   10 
 include/acpi/acmacros.h                           |   10 
 include/acpi/acnames.h                            |   84 
 include/acpi/acnamesp.h                           |  163 -
 include/acpi/acobject.h                           |    2 
 include/acpi/acopcode.h                           |  325 +++
 include/acpi/acparser.h                           |  134 -
 include/acpi/acpi.h                               |    1 
 include/acpi/acpi_bus.h                           |   22 
 include/acpi/acpi_drivers.h                       |    5 
 include/acpi/acpiosxf.h                           |   18 
 include/acpi/acpixf.h                             |   13 
 include/acpi/acresrc.h                            |   67 
 include/acpi/acstruct.h                           |    1 
 include/acpi/actables.h                           |   70 
 include/acpi/actbl.h                              |    2 
 include/acpi/actypes.h                            |    2 
 include/acpi/acutils.h                            |  274 --
 include/acpi/amlcode.h                            |   12 
 include/acpi/pdc_intel.h                          |   29 
 include/acpi/platform/acenv.h                     |   20 
 include/acpi/processor.h                          |   34 
 include/asm-alpha/pci.h                           |    2 
 include/asm-arm/pci.h                             |    2 
 include/asm-h8300/pci.h                           |    2 
 include/asm-i386/acpi.h                           |   10 
 include/asm-i386/apicdef.h                        |    6 
 include/asm-i386/pci.h                            |    2 
 include/asm-ia64/acpi.h                           |    9 
 include/asm-ia64/pci.h                            |    2 
 include/asm-m68k/pci.h                            |    2 
 include/asm-mips/pci.h                            |    2 
 include/asm-ppc/pci.h                             |    2 
 include/asm-ppc64/pci.h                           |    2 
 include/asm-sh/pci.h                              |    2 
 include/asm-sh64/pci.h                            |    2 
 include/asm-sparc/pci.h                           |    2 
 include/asm-sparc64/pci.h                         |    2 
 include/asm-x86_64/acpi.h                         |    8 
 include/asm-x86_64/apicdef.h                      |    2 
 include/asm-x86_64/pci.h                          |    2 
 include/linux/acpi.h                              |    9 
 include/linux/device.h                            |    6 
 include/linux/pm.h                                |    2 
 kernel/power/main.c                               |   16 
 201 files changed, 7777 insertions(+), 5434 deletions(-)

through these ChangeSets:

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/06/30 1.2245.4.1)
   [ACPI] fix i386 LAPIC + !IOAPIC build
   in a perfect world, the IOAPIC code in mpparse.c wouldn't be built
for this case,
   but it is simpler to reduce the arrays to size 1 than clutter the
code for
   a config that few care about.

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/05/02 1.1982.185.15)
   [ACPI] create CONFIG_MAX_IO_APICS
   to support systems with many IO-APICS.
   
   http://bugzilla.kernel.org/show_bug.cgi?id=3754
   
   Signed-off-by: Natalie Protasevich <Natalie.Protasevich-GLv8BlqOqDDQT0dZR+AlfA@public.gmane.org>
   Signed-off-by: Jason Davis <Jason.Davis-GLv8BlqOqDDQT0dZR+AlfA@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/04/26 1.2245.1.8)
   [ACPI] fix build warning
   
   Signed-off-by: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/04/22 1.1982.185.14)
   [ACPI] fix alpha build
   
   Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/04/22 1.2181.59.7)
   [ACPI] enable C2 and C3 idle power states on SMP
   http://bugzilla.kernel.org/show_bug.cgi?id=4401
   
   Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/04/22 1.2181.59.6)
   [ACPI] EC GPE-disabled issue
   http://bugzilla.kernel.org/show_bug.cgi?id=3851
   
   Signed-off-by: Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/04/19 1.1982.185.13)
   Cset exclude:
len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org[lenb]|ChangeSet|20050208142908|65087

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/04/19 1.1982.185.12)
   [ACPI] fix merge error that broke CONFIG_ACPI_DEBUG=y build
   
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/04/18 1.2245.2.1)
   [ACPI] cleanup: delete !IA64_SGI_SN from acpi/Kconfig
   
   Signed-off-by: Jesse Barnes <jbarnes-sJ/iWh9BUns@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/04/18 1.2181.59.5)
   [ACPI] fix C1 patch for IA64
   http://bugzilla.kernel.org/show_bug.cgi?id=4233
   
   Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/04/18 1.2181.59.4)
   [ACPI] quiet dmesg related to ACPI PM of PCI devices
   
   http://bugzilla.kernel.org/show_bug.cgi?id=4277
   
   Signed-off-by: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/04/18 1.1982.185.11)
   ACPICA 20050408 from Bob Moore
   
   Fixed three cases in the interpreter where an "index"
   argument to an ASL function was still (internally) 32
   bits instead of the required 64 bits.  This was the Index
   argument to the Index, Mid, and Match operators.
   
   The "strupr" function is now permanently local
   (acpi_ut_strupr), since this is not a POSIX-defined
   function and not present in most kernel-level C
   libraries. References to the C library strupr function
   have been removed from the headers.
   
   Completed the deployment of static
   functions/prototypes. All prototypes with the static
   attribute have been moved from the headers to the owning
   C file.
   
   ACPICA 20050329 from Bob Moore
   
   An error is now generated if an attempt is made to create
   a Buffer Field of length zero (A CreateField with a length
   operand of zero.)
   
   The interpreter now issues a warning whenever executable
   code at the module level is detected during ACPI table
   load. This will give some idea of the prevalence of this
   type of code.
   
   Implemented support for references to named objects (other
   than control methods) within package objects.
   
   Enhanced package object output for the debug
   object. Package objects are now completely dumped, showing
   all elements.
   
   Enhanced miscellaneous object output for the debug
   object. Any object can now be written to the debug object
   (for example, a device object can be written, and the type
   of the object will be displayed.)
   
   The "static" qualifier has been added to all local
   functions across the core subsystem.
   
   The number of "long" lines (> 80 chars) within the source
   has been significantly reduced, by about 1/3.
   
   Cleaned up all header files to ensure that all CA/iASL
   functions are prototyped (even static functions) and the
   formatting is consistent.
   
   Two new header files have been added, acopcode.h and
   acnames.h.
   
   Removed several obsolete functions that were no longer
   used.
   
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/04/14 1.1982.185.10)
   [ACPI] Deprecate /proc/acpi/sleep in favor of /sys/power/state
   
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/04/08 1.1982.185.9)
   [ACPI] S3 resume -- use lgdtl, not lgdt
   
   From: Nickolai Zeldovich <kolya-DPNOqEs/LNQ@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/04/01 1.2181.59.3)
   [ACPI] PNPACPI vs sound IRQ
   
   http://bugme.osdl.org/show_bug.cgi?id=4016
   
   Written-by: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
   Acked-by: Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/03/31 1.2181.59.2)
   [ACPI] update /proc/acpi/processor/*/power even if only C1 support
   
   Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/03/31 1.2224.2.3)
   [ACPI] Evaluate CPEI Processor Override flag
   
   ACPI 3.0 added a Correctable Platform Error Interrupt (CPEI)
   Processor Overide flag to MADT.Platform_Interrupt_Source.
   Record the processor that was provided as hint from ACPI.
   
   Signed-off-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/03/31 1.2222.1.2)
   [ACPI] fix build error resulting from merge
   
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/03/30 1.2181.58.2)
   [ACPI] hotplug Processor consideration in acpi_bus_add()
   
   Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/03/30 1.2181.21.17)
   [ACPI] fix debug-mode build warning in acpi/hotkey.c
   
   Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/03/30 1.1982.185.8)
   [ACPI] fix kmalloc size bug in acpi/video.c
   
   acpi_video_device_find_cap() used &p instead of *p
   when calculating storage size, thus allocating
   only 4 or 8 bytes instead of 12...
   
   Also, kfree(NULL) is legal, so remove some unneeded checks.
   
   From: Paulo Marques <pmarques-TSnNRl9vlf1Wk0Htik3J/w@public.gmane.org>
   Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/03/30 1.1982.185.7)
   [ACPI] fix potential NULL dereference in acpi/video.c
   
   Found-by: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/03/30 1.1982.185.6)
   [ACPI] check for kmalloc failure in toshiba_acpi.c
   
   Signed-off-by: Panagiotis Issaris <takis-8nu/KwtRnEU@public.gmane.org>
   Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/03/30 1.2181.21.16)
   [ACPI] fix build warning
   
   Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/03/30 1.2181.21.15)
   cleanup: remove unnecessary initializer on static pointers
   
   Suggested-by: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/03/25 1.1982.185.4)
   VIA Interrupt quirk
   
   Delete quirk_via_bridge()
   Restore quirk_via_irqpic()
   But now improved to be invoked upon device ENABLE,
   only for VIA devices -- not all devices behind VIA bridges
   and only in PIC mode.
   
   http://bugzilla.kernel.org/show_bug.cgi?id=3319
   
   Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/03/25 1.1982.185.2)
   [ACPI] PNPACPI parse error
   
   http://bugzilla.kernel.org/show_bug.cgi?id=3912
   
   Written-by: matthieu castet <castet.matthieu-GANU6spQydw@public.gmane.org>
   Acked-by: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/03/23 1.2181.21.14)
   [ACPI] gut acpi_pci_choose_state() to avoid conflict
   with pending pm_message_t re-definition.
   
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/03/19 1.2181.21.13)
   [ACPI] fix EC access width
   http://bugzilla.kernel.org/show_bug.cgi?id=4346
   
   From: David Shaohua Li and Luming Yu
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/03/19 1.2181.21.12)
   [ACPI] Enable EC Burst Mode
   
   Fixes several Embedded Controller issues, including
   button failure and battery status AE_TIME failure.
   
   http://bugzilla.kernel.org/show_bug.cgi?id=3851
   
   Based on patch by: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
   Signed-off-by: Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>
   Signed-off-by: Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/03/19 1.2181.21.11)
   [ACPI] pci_set_power_state() now calls
   	platform_pci_set_power_state()
   		and ACPI can answer
   
   http://bugzilla.kernel.org/show_bug.cgi?id=4277
   
   Signed-off-by: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/03/19 1.2181.21.10)
   [ACPI] PCI can now get suspend state from firmware
   
   pci_choose_state() can now call
   	platform_pci_choose_state()
   		and ACPI can answer
   
   http://bugzilla.kernel.org/show_bug.cgi?id=4277
   
   Signed-off-by: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/03/18 1.2181.21.9)
   [ACPI] Bind ACPI and PCI devices
   
   http://bugzilla.kernel.org/show_bug.cgi?id=4277
   
   Signed-off-by: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/03/18 1.2181.21.8)
   [ACPI] Bind PCI devices with ACPI devices
   
   Implement the framework for binding physical devices
   with ACPI devices. A physical bus like PCI bus
   should create a 'acpi_bus_type', with:
   
   .find_device:
           For device which has parent such as normal PCI devices.
   
   .find_bridge:
           It's for special devices, such as PCI root bridge
   	or IDE controller.  Such devices generally haven't a
   	parent or ->bus. We use the special method
   	to get an ACPI handle.
   
   Uses new field in struct device: firmware_data
   
   http://bugzilla.kernel.org/show_bug.cgi?id=4277
   
   Signed-off-by: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/03/18 1.2181.21.7)
   [ACPI] generic Hot Key support
   
   See Documentation/acpi-hotkey.txt
   
   Use cmdline "acpi_specific_hotkey" to enable
   legacy platform specific drivers.
   
   http://bugzilla.kernel.org/show_bug.cgi?id=3887
   
   Signed-off-by: Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/03/18 1.2181.21.6)
   [ACPI] S3 Suspend to RAM: fix driver suspend/resume methods
   
   Drivers should do this:
   
   .suspend()
   	pci_disable_device()
   
   .resume()
   	pci_enable_device()
   
   http://bugzilla.kernel.org/show_bug.cgi?id=3469
   
   Signed-off-by: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/03/18 1.2181.21.5)
   [ACPI] S3 Suspend to RAM: interrupt resume fix
   
   Delete PCI Interrupt Link Device .resume method --
   it is the device driver's job to request interrupts,
   not the Link's job to remember what the devices want.
   
   This addresses the issue of attempting to run
   the ACPI interpreter too early in resume, when
   interrupts are still disabled.
   
   http://bugzilla.kernel.org/show_bug.cgi?id=3469
   
   Signed-off-by: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/03/18 1.2181.21.4)
   [ACPI] Suspend to RAM fix
   
   Free some RAM before entering S3 so that upon
   resume we can be sure early allocations will succeed.
   
   http://bugzilla.kernel.org/show_bug.cgi?id=3469
   
   Signed-off-by: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/03/18 1.2181.21.3)
   [ACPI] ACPI poweroff fix
   
   Register an "acpi" system device to be notified of shutdown
preparation.
   This depends on CONFIG_PM
   
   http://bugzilla.kernel.org/show_bug.cgi?id=4041
   
   Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
   Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/03/18 1.2181.21.2)
   [ACPI] CONFIG_ACPI now depends on CONFIG_PM
   
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/03/18 1.1938.507.16)
   [ACPI] Allow simultaneous Fixed Feature and Control Method buttons
   delete /proc/acpi/button
   
   http://bugzilla.kernel.org/show_bug.cgi?id=1920
   
   Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/03/02 1.1938.508.1)
   [ACPI] update CONFIG_ACPI_CONTAINER Kconfig help
   
   Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
   Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (05/02/08 1.1938.505.13)
   [ACPI] GDT wakeup vector fix
   
   Written-by:  Hiroshi Itoh <hiroit-JE5g2YyFxFHQT0dZR+AlfA@public.gmane.org>
   Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>






-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
