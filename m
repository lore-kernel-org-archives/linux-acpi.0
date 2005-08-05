From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: latest ACPI patch based on 2.6.13
Date: Fri, 05 Aug 2005 01:35:25 -0400
Message-ID: <1123220125.13136.77.camel@toshiba>
References: <1123214969.13136.51.camel@toshiba>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1123214969.13136.51.camel@toshiba>
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
Cc: akpm-3NddpPZAyC0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The Latest ACPI patch based on 2.6.13 is available here:

http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.12/acpi-20050729-2.6.13-rc6.patch

These patches are exported to-akpm for inclusion in -mm
with the intent to integrate into 2.6.14.

http://ftp.kernel.org/pub/scm/linux/kernel/git/lenb/to-akpm.git/

Please give it a go and speak up and file bugs if you run into
any issues.

Yes, I've Lindented all the ACPI files.
No, there really is never a good time to do this,
but the "quite period" after 2.6.13 and before 2.6.14
seemed as good as any, and I'd rather have a program
handle style so that developers don't get sidetracked.
Afer this flag day, I ask you to Lindent the ACPI files
you touch before generating patches.  I'll probably
automatically Lindent files after patches are applied
to maintain the invarient that ACPI is Lindent clean.

Yes, this will disturb patches currently in flight,
and I'll help work through that.

Note that if you've sent me a patch in the past
and my travel, my vacation, or my hard drive crash ate it,
this would be a good time to nag me about it.

thanks,
-Len
------
commit c202ac9fbdb64145f034be266d6ee88c98b40aa8
Merge: 4be44fcd3bf648b782f4460fd06dfae6c42ded4b
c306895167c8384b88bc02945a0d226a04218fa5
Author: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Fri Aug 5 00:49:06 2005 -0400

    Merge ../to-linus

commit 4be44fcd3bf648b782f4460fd06dfae6c42ded4b
Author: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Fri Aug 5 00:44:28 2005 -0400

    [ACPI] Lindent all ACPI files
    
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit c65ade4dc8b486e8c8b9b0a6399789a5428e2039
Author: Pavel Machek <pavel-Y4LbUc7mvzI@public.gmane.org>
Date:   Fri Aug 5 00:37:45 2005 -0400

    [ACPI] whitespace
    
    Signed-off-by: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 1d492eb41371d9a5145651e8eb64bea1042a4057
Merge: 5d2a22079c825669d91a3a200332f1053b4b61b0
cbfc1bae55bbd053308ef0fa6b6448cd1ddf3e67
Author: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Fri Aug 5 00:31:42 2005 -0400

    [ACPI] Merge acpi-2.6.12 branch into 2.6.13-rc3
    
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit cbfc1bae55bbd053308ef0fa6b6448cd1ddf3e67
Author: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
Date:   Sat Jul 30 04:18:00 2005 -0400

    [ACPI] ACPI_HOTPLUG_CPU Kconfig dependency update
    
    prevent:
    
    HOTPLUG_CPU=y
    ACPI_PROCESSOR=y
    ACPI_HOTPLUG_CPU=n
    
    Signed-off-by: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
    Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 4fdcf0804598f44b0f48da9e5281af48a4db393f
Author: Andrew Morton <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Sat Jul 30 04:18:00 2005 -0400

    [ACPI] lint: irqrouter_suspend() takes a pm_message_t, not a u32
    
    Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 031ec77bf67e4bda994ef8ceba267be3295ffdb7
Author: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Date:   Sat Jul 30 04:18:00 2005 -0400

    [ACPI] acpi_remove_notify_handler() on video driver unload
    
    The video driver doesn't properly remove all the notify handlers
    on module unload.  This has a side effect of subdevices failing
    to register on module reload, but sudden death looms if the
    handlers trigger after the module is unloaded.
    
    Signed-off-by: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
    Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit e92310a930462c6e1611f35453f57357c42bde14
Author: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Date:   Sat Jul 30 04:18:00 2005 -0400

    [ACPI] fix IA64 build warning
    
    Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-z/GqZRLIEsXQT0dZR+AlfA@public.gmane.org>

commit 53de49f52e305e96143375d1741f15acff7bf34b
Author: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Date:   Sat Jul 30 04:18:00 2005 -0400

    [ACPI] CONFIG_ACPI=n build fix
    
    Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 14454a1b3ff8d1d15fbe7cc77f27373777184ddf
Author: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Date:   Thu Jul 28 14:42:00 2005 -0400

    [ACPI] iosapic_register_intr() now returns error instead of panic
    error condition is passed along by acpi_register_gsi().
    
    Signed-off-by: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
    Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 58e0276245f6c60119f0384e7eca576b08aa89e2
Author: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Date:   Thu Jul 28 14:42:00 2005 -0400

    [ACPI] 8250 driver now checks for acpi_register_gsi() errors
    
    Signed-off-by: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
    Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 71df30f8e3e97fde573c41df063c2d66c1ad01b0
Author: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Date:   Thu Jul 28 14:42:00 2005 -0400

    [ACPI] PNPACPI driver now checks for acpi_register_gsi() errors
    
    Signed-off-by: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
    Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit a9bd53bc49ee8984633e57c1d9d45111c58e9457
Author: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Date:   Thu Jul 28 14:42:00 2005 -0400

    [ACPI] HPET driver now checks for acpi_register_gsi() errors
    
    Signed-off-by: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
    Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 349f0d5640c18db09a646f9da51a97f1da908660
Author: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Date:   Thu Jul 28 14:42:00 2005 -0400

    [ACPI] acpi_pci_enable_irq() now checks for acpi_register_gsi()
errors
    
    Signed-off-by: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
    Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 1f3a6a15771ed70d3b2581663dcc6b9bc134baa5
Author: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Date:   Thu Jul 28 14:42:00 2005 -0400

    [ACPI] acpi_register_gsi() can return error
    
    Current acpi_register_gsi() function has no way to indicate errors
to its
    callers even though acpi_register_gsi() can fail to register gsi
because of
    some reasons (out of memory, lack of interrupt vectors, incorrect
BIOS, and so
    on).  As a result, caller of acpi_register_gsi() cannot handle the
case that
    acpi_register_gsi() fails.  I think failure of acpi_register_gsi()
should be
    handled properly.
    
    This series of patches changes acpi_register_gsi() to return
negative value on
    error, and also changes callers of acpi_register_gsi() to handle
failure of
    acpi_register_gsi().
    
    This patch changes the type of return value of acpi_register_gsi()
from
    "unsigned int" to "int" to indicate an error.  If
acpi_register_gsi() fails to
    register gsi, it returns negative value.
    
    Signed-off-by: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
    Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit 5d2a22079c825669d91a3a200332f1053b4b61b0
Merge: 1c5ad84516ae7ea4ec868436a910a6bd8d20215a
bd6dbdf3c7b9784fbf5d8500e427a954e27a976a
Author: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Thu Aug 4 18:09:09 2005 -0400

    /home/lenb/src/to-akpm branch 'acpi-2.6.12'

commit bd6dbdf3c7b9784fbf5d8500e427a954e27a976a
Merge: aefdcfa6c243702f1d35d23515d0e5eeca225c97
d4ab025b73a2d10548e17765eb76f3b7351dc611
Author: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Thu Aug 4 00:17:42 2005 -0400

    When a merge does not work automatically, git prevents
    commit from running until a change has been made in
    the destination.  In this instance the desired result
    was to choose the destination version of the file
    and ignore the source version, but git would not
    allow that.
    
    Here I added a blank line to let git commit think
    I resolved a merge conflict.

commit aefdcfa6c243702f1d35d23515d0e5eeca225c97
Merge: 0c9938cc75057c0fca1af55a55dcfc2842436695
79cda7d0e1c8629996242c036d6fe0466038d8ba
Author: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Wed Aug 3 18:12:57 2005 -0400

    Merge ../to-linus

commit 0c9938cc75057c0fca1af55a55dcfc2842436695
Author: Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Fri Jul 29 15:15:00 2005 -0700

    [ACPI] ACPICA 20050729 from Bob Moore
    
    Implemented support to ignore an attempt to install/load
    a particular ACPI table more than once. Apparently there
    exists BIOS code that repeatedly attempts to load the same
    SSDT upon certain events. Thanks to Venkatesh Pallipadi.
    
    Restructured the main interface to the AML parser in
    order to correctly handle all exceptional conditions. This
    will prevent leakage of the OwnerId resource and should
    eliminate the AE_OWNER_ID_LIMIT exceptions seen on some
    machines. Thanks to Alexey Starikovskiy.
    
    Support for "module level code" has been disabled in this
    version due to a number of issues that have appeared
    on various machines. The support can be enabled by
    defining ACPI_ENABLE_MODULE_LEVEL_CODE during subsystem
    compilation. When the issues are fully resolved, the code
    will be enabled by default again.
    
    Modified the internal functions for debug print support
    to define the FunctionName parameter as a (const char *)
    for compatibility with compiler built-in macros such as
    __FUNCTION__, etc.
    
    Linted the entire ACPICA source tree for both 32-bit
    and 64-bit.
    
    Signed-off-by: Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit dd8f39bbf5154cdbfd698fc70c66faba33eafa44
Merge: c2c2e03409f5f5405e79d9d9156202b75cb5b35b
87bec66b9691522414862dd8d41e430b063735ef
Author: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Fri Jul 29 23:11:11 2005 -0400

    Merge ../to-linus

commit c2c2e03409f5f5405e79d9d9156202b75cb5b35b
Author: Iacopo Spalletti <avvisi-m0DhsibC5ZROhR2lhbcafA@public.gmane.org>
Date:   Sun Jul 17 02:06:00 2005 -0400

    [ACPI] update hotkey documentation
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4903
    
    Signed-off-by: Iacopo Spalletti <avvisi-m0DhsibC5ZROhR2lhbcafA@public.gmane.org>
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





-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
