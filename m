From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: latest ACPI patch vs 2.6.12
Date: Fri, 29 Jul 2005 23:25:26 -0400
Message-ID: <20050730032525.GA11537@toshiba.hsd1.ma.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The latest ACPI patch vs 2.6.12 is available here:

http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.12

Below is the commit log of what has changed since 2.6.12.

As all of these patches are either already in 2.6.13,
or queued for 2.6.13 or 2.6.14, please shout if you
notice any regressions.

thanks,
-Len


commit dd8f39bbf5154cdbfd698fc70c66faba33eafa44
Merge: c2c2e03409f5f5405e79d9d9156202b75cb5b35b 87bec66b9691522414862dd8d41e430b063735ef
Author: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Fri Jul 29 23:11:11 2005 -0400

    Merge ../to-linus

commit 87bec66b9691522414862dd8d41e430b063735ef
Author: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Wed Jul 27 23:02:00 2005 -0400

    [ACPI] suspend/resume ACPI PCI Interrupt Links
    
    Add reference count and disable ACPI PCI Interrupt Link
    when no device still uses it.
    
    Warn when drivers have not released Link at suspend time.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=3469
    
    Signed-off-by: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 68ac767686fd72f37a25bb4895fb4ab0080ba755
Author: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Mon Apr 25 14:38:00 2005 -0400

    [ACPI] delete boot-time printk()s from processor_idle.c
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4401
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 90158b83204842c0108d744326868d91cc9c4dfd
Author: Rafael J. Wysocki <rjwysocki-KKrjLPT3xs0@public.gmane.org>
Date:   Sun Jul 24 14:22:00 2005 -0400

    [ACPI] fix resume issues on Asus L5D
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4416
    
    Signed-off-by: Rafael J. Wysocki <rjwysocki-KKrjLPT3xs0@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 4b31e77455b868b43e665edceb111c9a330c8e0f
Author: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Date:   Wed May 18 13:49:00 2005 -0400

    [ACPI] Always set P-state on initialization
    
    Otherwise a platform that supports ACPI based cpufreq
    and boots up at lowest possible speed could stay there
    forever.  This because the governor may request max speed,
    but the code doesn't update if there is no change in
    speed, and it assumed the initial state of max speed.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4634
    
    Signed-off-by: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 45bea1555f5bf0cd5871b208b4b02d188f106861
Author: Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Sat Jul 23 04:08:00 2005 -0400

    [ACPI] Add "ec_polling" boot option
    
    EC burst mode benefits many machines, some of
    them significantly.  However, our current
    implementation fails on some machines such
    as Rafael's Asus L5D.
    
    This patch restores the alternative EC polling code,
    which can be enabled at boot time via "ec_polling"
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4665
    
    Signed-off-by: Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 335f16be5d917334f56ec9ef7ecf983476ac0563
Author: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Wed Jun 22 18:37:00 2005 -0400

    [ACPI] address boot-freeze with updated DMI blacklist for c-states
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4763
    
    Signed-off-by: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit c2c2e03409f5f5405e79d9d9156202b75cb5b35b
Author: Iacopo Spalletti <avvisi-m0DhsibC5ZROhR2lhbcafA@public.gmane.org>
Date:   Sun Jul 17 02:06:00 2005 -0400

    [ACPI] update hotkey documentation
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4903
    
    Signed-off-by: Iacopo Spalletti <avvisi-m0DhsibC5ZROhR2lhbcafA@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 0b6b2f08c24a65535cb18893ca27516389c5fc0f
Author: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Fri Jul 29 16:00:13 2005 -0400

    [ACPI] Fix memset arguments in acpi processor_idle.c
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4954
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 4a7164023959040e687e51663dee67cff4d2b770
Author: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Fri Jul 29 15:51:36 2005 -0400

    [ACPI] Fix the regression with c1_default_handler on some systems
    where C-states come from FADT.
    
    Thanks to Kevin Radloff for identifying the issue and
    isolating it to exact line of code that is causing the issue.
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 670fac79b9dcf16549a4c1f4c0b73c457e53bd7e
Author: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Fri Jul 29 00:16:54 2005 -0400

    [ACPI] disable module level AML code (for now)
    
    It is important that we support module level code --
    BIOS's implement it.  But this implementation needs
    more testing.
    
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 5d75ab45594c78d2d976a3248ea1ca281c9d7056
Author: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Fri Jul 29 00:03:55 2005 -0400

    [ACPI] handle const char * __FUNCTION__ in debug code
    build warning: discards qualifiers from pointer target type
    when mixing "const char *" and "char *"
    
    We should probably update the routines to expect const,
    but easier for now to shut up the warning with 1 cast.
    
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit feee9570753645f9f6888937ff9aee426b7afe55
Author: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Fri Jul 29 00:01:00 2005 -0400

    [ACPI] comment out prototypes for new unused debug routines
    
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 668d74c04c16bb69de564e25e85dd94eeb0175d9
Author: Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Sat Jul 23 00:26:33 2005 -0400

    ACPI: delete unnecessary EC console messages
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4534
    
    Signed-off-by: Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit f9f4601f331aa1226d7a798a01950efbb388f07f
Author: Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Fri Jul 8 00:00:00 2005 -0400

    ACPICA 20050708 from Bob Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    
    The use of the CPU stack in the debug version of the
    subsystem has been considerably reduced.  Previously, a
    debug structure was declared in every function that used
    the debug macros.  This structure has been removed in
    favor of declaring the individual elements as parameters
    to the debug functions.  This reduces the cumulative stack
    use during nested execution of ACPI function calls at the
    cost of a small increase in the code size of the debug
    version of the subsystem.  With assistance from Alexey
    Starikovskiy and Len Brown.
    
    Added the ACPI_GET_FUNCTION_NAME macro to enable the
    compiler-dependent headers to define a macro that will
    return the current function name at runtime (such as
    __FUNCTION__ or _func_, etc.) The function name is used
    by the debug trace output.  If ACPI_GET_FUNCTION_NAME
    is not defined in the compiler-dependent header, the
    function name is saved on the CPU stack (one pointer per
    function.) This mechanism is used because apparently there
    exists no standard ANSI-C defined macro that that returns
    the function name.
    
    Alexey Starikovskiy redesigned and reimplemented the
    "Owner ID" mechanism used to track namespace objects
    created/deleted by ACPI tables and control method
    execution.  A bitmap is now used to allocate and free the
    IDs, thus solving the wraparound problem present in the
    previous implementation.  The size of the namespace node
    descriptor was reduced by 2 bytes as a result.
    
    Removed the UINT32_BIT and UINT16_BIT types that were used
    for the bitfield flag definitions within the headers for
    the predefined ACPI tables.  These have been replaced by
    UINT8_BIT in order to increase the code portability of
    the subsystem.  If the use of UINT8 remains a problem,
    we may be forced to eliminate bitfields entirely because
    of a lack of portability.
    
    Alexey Starikovksiy enhanced the performance of
    acpi_ut_update_object_reference.  This is a frequently used
    function and this improvement increases the performance
    of the entire subsystem.
    
    Alexey Starikovskiy fixed several possible memory leaks
    and the inverse - premature object deletion.
    
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 4c3ffbd79529b680b3c3ef2b6f42f0c89c694ec5
Author: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Thu Jul 14 00:00:00 2005 -0400

    [ACPI] revert R40 workaround
    
    Should not be necessary...
    
    http://bugme.osdl.org/show_bug.cgi?id=1038
    
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 73459f73e5d1602c59ebec114fc45185521353c1
Author: Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Fri Jun 24 00:00:00 2005 -0400

    ACPICA 20050617-0624 from Bob Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    
    ACPICA 20050617:
    
    Moved the object cache operations into the OS interface
    layer (OSL) to allow the host OS to handle these operations
    if desired (for example, the Linux OSL will invoke the
    slab allocator).  This support is optional; the compile
    time define ACPI_USE_LOCAL_CACHE may be used to utilize
    the original cache code in the ACPI CA core.  The new OSL
    interfaces are shown below.  See utalloc.c for an example
    implementation, and acpiosxf.h for the exact interface
    definitions.  Thanks to Alexey Starikovskiy.
    	acpi_os_create_cache
    	acpi_os_delete_cache
    	acpi_os_purge_cache
    	acpi_os_acquire_object
    	acpi_os_release_object
    
    Modified the interfaces to acpi_os_acquire_lock and
    acpi_os_release_lock to return and restore a flags
    parameter.  This fits better with many OS lock models.
    Note: the current execution state (interrupt handler
    or not) is no longer passed to these interfaces.  If
    necessary, the OSL must determine this state by itself, a
    simple and fast operation.  Thanks to Alexey Starikovskiy.
    
    Fixed a problem in the ACPI table handling where a valid
    XSDT was assumed present if the revision of the RSDP
    was 2 or greater.  According to the ACPI specification,
    the XSDT is optional in all cases, and the table manager
    therefore now checks for both an RSDP >=2 and a valid
    XSDT pointer.  Otherwise, the RSDT pointer is used.
    Some ACPI 2.0 compliant BIOSs contain only the RSDT.
    
    Fixed an interpreter problem with the Mid() operator in the
    case of an input string where the resulting output string
    is of zero length.  It now correctly returns a valid,
    null terminated string object instead of a string object
    with a null pointer.
    
    Fixed a problem with the control method argument handling
    to allow a store to an Arg object that already contains an
    object of type Device.  The Device object is now correctly
    overwritten.  Previously, an error was returned.
    
    ACPICA 20050624:
    
    Modified the new OSL cache interfaces to use ACPI_CACHE_T
    as the type for the host-defined cache object.  This allows
    the OSL implementation to define and type this object in
    any manner desired, simplifying the OSL implementation.
    For example, ACPI_CACHE_T is defined as kmem_cache_t for
    Linux, and should be defined in the OS-specific header
    file for other operating systems as required.
    
    Changed the interface to AcpiOsAcquireObject to directly
    return the requested object as the function return (instead
    of ACPI_STATUS.) This change was made for performance
    reasons, since this is the purpose of the interface in the
    first place.  acpi_os_acquire_object is now similar to the
    acpi_os_allocate interface.  Thanks to Alexey Starikovskiy.
    
    Modified the initialization sequence in
    acpi_initialize_subsystem to call the OSL interface
    acpi_osl_initialize first, before any local initialization.
    This change was required because the global initialization
    now calls OSL interfaces.
    
    Restructured the code base to split some files because
    of size and/or because the code logically belonged in a
    separate file.  New files are listed below.
    
      utilities/utcache.c	/* Local cache interfaces */
      utilities/utmutex.c	/* Local mutex support */
      utilities/utstate.c	/* State object support */
      parser/psloop.c	/* Main AML parse loop */
    
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 88ac00f5a841dcfc5c682000f4a6add0add8caac
Author: Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Thu May 26 00:00:00 2005 -0400

    ACPICA 20050526 from Bob Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    
    Implemented support to execute Type 1 and Type 2 AML
    opcodes appearing at the module level (not within a control
    method.)  These opcodes are executed exactly once at the
    time the table is loaded. This type of code was legal up
    until the release of ACPI 2.0B (2002) and is now supported
    within ACPI CA in order to provide backwards compatibility
    with earlier BIOS implementations. This eliminates the
    "Encountered executable code at module level" warning that
    was previously generated upon detection of such code.
    
    Fixed a problem in the interpreter where an AE_NOT_FOUND
    exception could inadvertently be generated during the
    lookup of namespace objects in the second pass parse of
    ACPI tables and control methods. It appears that this
    problem could occur during the resolution of forward
    references to namespace objects.
    
    Added the ACPI_MUTEX_DEBUG #ifdef to the
    acpi_ut_release_mutex function, corresponding to the same
    the deadlock detection debug code to be compiled out in
    the normal case, improving mutex performance (and overall
    subsystem performance) considerably.  As suggested by
    Alexey Starikovskiy.
    
    Implemented a handful of miscellaneous fixes for possible
    memory leaks on error conditions and error handling
    control paths. These fixes were suggested by FreeBSD and
    the Coverity Prevent source code analysis tool.
    
    Added a check for a null RSDT pointer in
    acpi_get_firmware_table (tbxfroot.c) to prevent a fault
    in this error case.
    
    Signed-off-by Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 6f42ccf2fc50ecee8ea170040627f268430c1648
Author: Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Fri May 13 00:00:00 2005 -0400

    ACPICA from Bob Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    
    Implemented support for PCI Express root bridges
    -- added support for device PNP0A08 in the root
    bridge search within AcpiEvPciConfigRegionSetup.
    acpi_ev_pci_config_region_setup().
    
    The interpreter now automatically truncates incoming
    64-bit constants to 32 bits if currently executing out
    of a 32-bit ACPI table (Revision < 2). This also affects
    the iASL compiler constant folding. (Note: as per below,
    the iASL compiler no longer allows 64-bit constants within
    32-bit tables.)
    
    Fixed a problem where string and buffer objects with
    "static" pointers (pointers to initialization data within
    an ACPI table) were not handled consistently. The internal
    object copy operation now always copies the data to a newly
    allocated buffer, regardless of whether the source object
    is static or not.
    
    Fixed a problem with the FromBCD operator where an
    implicit result conversion was improperly performed while
    storing the result to the target operand. Since this is an
    "explicit conversion" operator, the implicit conversion
    should never be performed on the output.
    
    Fixed a problem with the CopyObject operator where a copy
    to an existing named object did not always completely
    overwrite the existing object stored at name. Specifically,
    a buffer-to-buffer copy did not delete the existing buffer.
    
    Replaced "interrupt_level" with "interrupt_number" in all
    GPE interfaces and structs for consistency.
    
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit d8683a0cb5d09cb7f19feefa708424a84577e68f
Author: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Sun Jul 3 16:42:23 2005 -0400

    [ACPI] increase MAX_IO_APICS to 64 on i386
    
    x86_64 was already 128
    
    http://bugzilla.kernel.org/show_bug.cgi?id=3754
    
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 02df8b9385c21fdba165bd380f60eca1d3b0578b
Author: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Fri Apr 15 15:07:10 2005 -0400

    [ACPI] enable C2 and C3 idle power states on SMP
    http://bugzilla.kernel.org/show_bug.cgi?id=4401
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 17e9c78a75ce9eacd61200f9e1f1924012e28846
Author: Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Fri Apr 22 23:07:10 2005 -0400

    [ACPI] EC GPE-disabled issue
    http://bugzilla.kernel.org/show_bug.cgi?id=3851
    
    Signed-off-by: Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit a27ac38efd6dc6dccebfc9bcc475ab4aa5fc4a56
Author: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Fri Apr 5 00:07:45 2019 -0500

    [ACPI] fix merge error that broke CONFIG_ACPI_DEBUG=y build
    
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 590275ce72c48fdbddea057bc9ee379c1fd851ef
Author: Jesse Barnes <jbarnes-sJ/iWh9BUns@public.gmane.org>
Date:   Mon Apr 18 23:52:17 2005 -0400

    [ACPI] cleanup: delete !IA64_SGI_SN from acpi/Kconfig
    
    Signed-off-by: Jesse Barnes <jbarnes-sJ/iWh9BUns@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 6c4fa56033c11ad5c5929bf3edd1505d3d8a8c0b
Author: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Mon Apr 18 23:06:47 2005 -0400

    [ACPI] fix C1 patch for IA64
    http://bugzilla.kernel.org/show_bug.cgi?id=4233
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit ef7b06cd905424aea7c31f27fef622e84e75e650
Author: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Mon Apr 18 22:59:23 2005 -0400

    [ACPI] quiet dmesg related to ACPI PM of PCI devices
    
    DBG("No ACPI bus support for %s\n", dev->bus_id);
    http://bugzilla.kernel.org/show_bug.cgi?id=4277
    
    Signed-off-by: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 44f6c01242da4e162f28d8e1216a8c7a91174605
Author: Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Mon Apr 18 22:49:35 2005 -0400

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

commit ebb6e1a6122fd6b7c96470cfd4ce0f04150e5084
Author: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Thu Apr 14 23:12:56 2005 -0400

    [ACPI] Deprecate /proc/acpi/sleep in favor of /sys/power/state
    
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 9d9437759eb6fdb68f7b82cbee20b0fb711d9f0d
Author: Nickolai Zeldovich <kolya-DPNOqEs/LNQ@public.gmane.org>
Date:   Fri Apr 8 23:37:34 2005 -0400

    [ACPI] S3 resume -- use lgdtl, not lgdt
    
    From: Nickolai Zeldovich <kolya-DPNOqEs/LNQ@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit c9c3e457de24cca2ca688fa397d93a241f472048
Author: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Fri Apr 1 00:07:31 2005 -0500

    [ACPI] PNPACPI vs sound IRQ
    
    http://bugme.osdl.org/show_bug.cgi?id=4016
    
    Written-by: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Acked-by: Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit acf05f4b7f558051ea0028e8e617144123650272
Author: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Thu Mar 31 23:23:15 2005 -0500

    [ACPI] update /proc/acpi/processor/*/power even if only C1 support
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 55e59c511cea3c6c721971467c707e9955922bc2
Author: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Thu Mar 31 22:51:10 2005 -0500

    [ACPI] Evaluate CPEI Processor Override flag
    
    ACPI 3.0 added a Correctable Platform Error Interrupt (CPEI)
    Processor Overide flag to MADT.Platform_Interrupt_Source.
    Record the processor that was provided as hint from ACPI.
    
    Signed-off-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 6940fabaa35b893163b7043d0d1dc5d715f9e1ca
Author: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Date:   Wed Mar 30 23:15:47 2005 -0500

    [ACPI] hotplug Processor consideration in acpi_bus_add()
    
    Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 8de7a63b69a263b7549599be882d7aa15397f8b3
Author: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Date:   Wed Mar 30 22:53:30 2005 -0500

    [ACPI] fix debug-mode build warning in acpi/hotkey.c
    
    drivers/acpi/hotkey.c: In function `create_polling_proc':
    drivers/acpi/hotkey.c:334: warning: ISO C90 forbids mixed declarations and code
    
    Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit d1dd0c23916bd781de27bc5ec1c295064e9ce9cc
Author: Paulo Marques <pmarques-TSnNRl9vlf1Wk0Htik3J/w@public.gmane.org>
Date:   Wed Mar 30 22:39:49 2005 -0500

    [ACPI] fix kmalloc size bug in acpi/video.c
    
    acpi_video_device_find_cap() used &p instead of *p
    when calculating storage size, thus allocating
    only 4 or 8 bytes instead of 12...
    
    Also, kfree(NULL) is legal, so remove some unneeded checks.
    
    From: Paulo Marques <pmarques-TSnNRl9vlf1Wk0Htik3J/w@public.gmane.org>
    Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 7334571f724df7a19f48cc974e991e00afde1e2f
Author: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
Date:   Wed Mar 30 22:31:35 2005 -0500

    [ACPI] fix potential NULL dereference in acpi/video.c
    
    Found-by: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit f4224153098c1103db592b28f304beeb9c02481b
Author: Panagiotis Issaris <takis-8nu/KwtRnEU@public.gmane.org>
Date:   Wed Mar 30 22:15:36 2005 -0500

    [ACPI] check for kmalloc failure in toshiba_acpi.c
    
    Signed-off-by: Panagiotis Issaris <takis-8nu/KwtRnEU@public.gmane.org>
    Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 83ea7445221651dc43cf8d22f81089e0cbccf22b
Author: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Date:   Wed Mar 30 22:12:13 2005 -0500

    [ACPI] fix build warning
    
    Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit f165b10f4a9aac7fee9b11a125de20a1712be128
Author: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
Date:   Wed Mar 30 21:23:19 2005 -0500

    cleanup: remove unnecessary initializer on static pointers
    
    Suggested-by: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit b008b8d7092053fc1f036cfc54dc11740cc424ed
Author: Matthieu Castet <castet.matthieu-GANU6spQydw@public.gmane.org>
Date:   Fri Mar 25 12:03:15 2005 -0500

    [ACPI] PNPACPI parse error
    
    http://bugzilla.kernel.org/show_bug.cgi?id=3912
    
    Written-by: matthieu castet <castet.matthieu-GANU6spQydw@public.gmane.org>
    Acked-by: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit a406d9e63e1d7088aad22565449de2e109300e5c
Author: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Wed Mar 23 16:16:03 2005 -0500

    [ACPI] gut acpi_pci_choose_state() to avoid conflict
    with pending pm_message_t re-definition.
    
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit fa9cd547e097df4966b8bd5c94aeed953e32b14d
Author: Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Sat Mar 19 01:54:47 2005 -0500

    [ACPI] fix EC access width
    http://bugzilla.kernel.org/show_bug.cgi?id=4346
    
    Written-by: David Shaohua Li and Luming Yu
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 451566f45a2e6cd10ba56e7220a9dd84ba3ef550
Author: Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>
Date:   Sat Mar 19 01:10:05 2005 -0500

    [ACPI] Enable EC Burst Mode
    
    Fixes several Embedded Controller issues, including
    button failure and battery status AE_TIME failure.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=3851
    
    Based on patch by: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
    Signed-off-by: Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>
    Signed-off-by: Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit b913100d7304ea9596d8d85ab5f3ae04bd2b0ddb
Author: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Sat Mar 19 00:16:18 2005 -0500

    [ACPI] pci_set_power_state() now calls
    	platform_pci_set_power_state()
    		and ACPI can answer
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4277
    
    Signed-off-by: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 0f64474b8f7f1f7f3af5b24ef997baa35f923509
Author: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Sat Mar 19 00:15:48 2005 -0500

    [ACPI] PCI can now get suspend state from firmware
    
    pci_choose_state() can now call
    	platform_pci_choose_state()
    		and ACPI can answer
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4277
    
    Signed-off-by: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 84df749f364209c9623304b7a94ddb954dc343bb
Author: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Fri Mar 18 18:53:36 2005 -0500

    [ACPI] Bind ACPI and PCI devices
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4277
    
    Signed-off-by: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 4e10d12a3d88c88fba3258809aa42d14fd8cf1d1
Author: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Fri Mar 18 18:45:35 2005 -0500

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

commit fb9802fa59b196d7f90bb3c2e33c555c6bdc4c54
Author: Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Fri Mar 18 18:03:45 2005 -0500

    [ACPI] generic Hot Key support
    
    See Documentation/acpi-hotkey.txt
    
    Use cmdline "acpi_specific_hotkey" to enable
    legacy platform specific drivers.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=3887
    
    Signed-off-by: Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit d58da590451cf6ae75379a2ebf96d3afb8d810d8
Author: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Fri Mar 18 16:43:54 2005 -0500

    [ACPI] S3 Suspend to RAM: fix driver suspend/resume methods
    
    Drivers should do this:
    
    .suspend()
    	pci_disable_device()
    
    .resume()
    	pci_enable_device()
    
    http://bugzilla.kernel.org/show_bug.cgi?id=3469
    
    Signed-off-by: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 362b06bb70b5a5779b2e852e0f2bdb437061106e
Author: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Fri Mar 18 16:30:29 2005 -0500

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

commit 5ae947ecc9c1c23834201e5321684a5cb68bdd3f
Author: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Fri Mar 18 16:27:13 2005 -0500

    [ACPI] Suspend to RAM fix
    
    Free some RAM before entering S3 so that upon
    resume we can be sure early allocations will succeed.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=3469
    
    Signed-off-by: David Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit e2a5b420f716cd1a46674b1a90389612eced916f
Author: Alexey Starikovskiy <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Fri Mar 18 16:20:46 2005 -0500

    [ACPI] ACPI poweroff fix
    
    Register an "acpi" system device to be notified of shutdown preparation.
    This depends on CONFIG_PM
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4041
    
    Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit be91492ca871e58f61b517cfba541095bb60001c
Author: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Fri Mar 18 16:00:29 2005 -0500

    [ACPI] CONFIG_ACPI now depends on CONFIG_PM
    
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit bd4698dad3023ae137b366c736e29ca6eaf3b9f7
Author: Alexey Starikovskiy <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Fri Mar 18 15:35:22 2005 -0500

    [ACPI] Allow simultaneous Fixed Feature and Control Method buttons
    delete /proc/acpi/button
    
    http://bugzilla.kernel.org/show_bug.cgi?id=1920
    
    Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 45b1b196677b8009ab6cdc4b656265f1d7015c1b
Author: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Date:   Wed Mar 2 00:00:00 2005 -0500

    [ACPI] update CONFIG_ACPI_CONTAINER Kconfig help
    
    Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
    Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
