From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [BK PATCH] ACPI update
Date: Wed, 18 Sep 2002 23:09:35 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DE7E@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: 'Linus Torvalds' <torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Linus, please do a

	bk pull http://linux-acpi.bkbits.net/linux-acpi
<http://linux-acpi.bkbits.net/linux-acpi> 

A significant ACPI driver reorg by Pat, as well as a number of fixes by me.

Thanks -- Andy

This will update the following files:

 arch/i386/kernel/acpi.c            |   77 -
 arch/i386/kernel/io_apic.c         |    2 
 arch/i386/kernel/mpparse.c         |   26 
 arch/i386/kernel/suspend.c         |    1 
 arch/i386/pci/acpi.c               |    2 
 drivers/acpi/Config.help           |   17 
 drivers/acpi/Config.in             |    5 
 drivers/acpi/Makefile              |   13 
 drivers/acpi/ac.c                  |   14 
 drivers/acpi/acpi_bus.h            |   44 
 drivers/acpi/acpi_drivers.h        |  210 ----
 drivers/acpi/acpi_ksyms.c          |    2 
 drivers/acpi/battery.c             |   15 
 drivers/acpi/blacklist.c           |  145 ++
 drivers/acpi/bus.c                 | 1529 ------------------------------
 drivers/acpi/button.c              |   30 
 drivers/acpi/debug.c               |  130 ++
 drivers/acpi/dispatcher/dsfield.c  |    8 
 drivers/acpi/dispatcher/dsobject.c |    7 
 drivers/acpi/dispatcher/dswload.c  |   68 +
 drivers/acpi/driverfs.c            |   46 
 drivers/acpi/ec.c                  |   57 -
 drivers/acpi/event.c               |  140 ++
 drivers/acpi/executer/exconvrt.c   |   30 
 drivers/acpi/executer/exmisc.c     |    3 
 drivers/acpi/executer/exoparg1.c   |  132 --
 drivers/acpi/executer/exresnte.c   |    3 
 drivers/acpi/executer/exresolv.c   |  169 +++
 drivers/acpi/executer/exresop.c    |    9 
 drivers/acpi/executer/exstore.c    |   10 
 drivers/acpi/executer/exstoren.c   |   11 
 drivers/acpi/fan.c                 |   11 
 drivers/acpi/include/acconfig.h    |    4 
 drivers/acpi/include/acdebug.h     |    6 
 drivers/acpi/include/acexcep.h     |   14 
 drivers/acpi/include/acinterp.h    |    9 
 drivers/acpi/include/acpiosxf.h    |   20 
 drivers/acpi/include/actypes.h     |    2 
 drivers/acpi/include/acutils.h     |   16 
 drivers/acpi/namespace/nsdump.c    |   14 
 drivers/acpi/namespace/nsdumpdv.c  |    3 
 drivers/acpi/namespace/nsload.c    |    3 
 drivers/acpi/numa.c                |    2 
 drivers/acpi/parser/psxface.c      |    3 
 drivers/acpi/pci_bind.c            |    3 
 drivers/acpi/pci_irq.c             |    2 
 drivers/acpi/pci_link.c            |   18 
 drivers/acpi/pci_root.c            |   23 
 drivers/acpi/power.c               |   35 
 drivers/acpi/processor.c           |   14 
 drivers/acpi/resources/rsdump.c    |   35 
 drivers/acpi/scan.c                | 1866
+++++++++++++++++++++++++++----------
 drivers/acpi/sleep.c               |  718 ++++++++++++++
 drivers/acpi/system.c              | 1213 +-----------------------
 drivers/acpi/tables.c              |   67 +
 drivers/acpi/tables/tbget.c        |   14 
 drivers/acpi/thermal.c             |   21 
 drivers/acpi/utilities/utcopy.c    |    3 
 drivers/acpi/utilities/utdebug.c   |    6 
 drivers/acpi/utilities/utglobal.c  |    3 
 drivers/acpi/utilities/utinit.c    |    4 
 drivers/acpi/utilities/utmisc.c    |    4 
 include/asm-i386/mpspec.h          |    1 
 include/linux/acpi.h               |   15 
 64 files changed, 3461 insertions(+), 3666 deletions(-)

through these ChangeSets:

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/09/18 1.549)
   Use ACPI fix map region instead of IOAPIC region, since it is undefined
   in non-SMP.

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/09/18 1.548)
   ACPI: Ensure that the SCI has the proper polarity and trigger, even
   on systems that do not have an interrupt override entry in the MADT.

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/09/18 1.547)
   ACPI: Interpreter update to 20020918

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/09/17 1.545)
   ACPI: Add missing include to sleep.c

<mochel-3NddpPZAyC0@public.gmane.org> (02/09/17 1.542)
   ACPI: don't match every device to every driver.
   
   acpi_bus_match() wasn't returning an error if the device's hid didn't
match
   and it didn't have a _CID.
   
   Also, don't let gcc complain about unused variables when debugging isn't 
   enabled.

<mochel-3NddpPZAyC0@public.gmane.org> (02/09/16 1.536.11.2)
   ACPI: lots of minor cleanups in drivers/acpi/scan.c
   
   These should clean up the code a bit by doing:
   
   - removing unncessary checks.
   - removing the commented-out code
   - remove some function tracing from the small, benign functions
   - streamline the code in acpi_bus_match
   - invert a few instances of if (!true) err else do_something; to if
(true) do_something else err;
   - break acpi_bus_add into 5 more distinct helper functions

<mochel-3NddpPZAyC0@public.gmane.org> (02/09/13 1.497.91.13)
   ACPI: greatly simplify acpi device and acpi driver binding.
   
   First, introduce a global acpi device list, and insert devices into it
when they're discovered. Now,
   instead of having to recurse through our own device tree, we simply walk
the list of devices. Access
   is protected using a new spinlock. This completely obviates the need for
the complicated acpi_bus_walk(). 
   
   acpi_bus_attach() and acpi_bus_unattach() become acpi_driver_attach() and
acpi_driver_detach() to better
   identify what they're doing. They do the walking of the device list
themselves.
   
   acpi_bus_find_driver() is converted to list_for_each_safe() and use the
same new spinlock.
   
   struct acpi_driver::references is changed from an int to an atomic_t. No
lock is needed anymore for 
   incrementing/decrementing the refcount. 

<mochel-3NddpPZAyC0@public.gmane.org> (02/09/13 1.497.91.12)
   ACPI: move sleep file defines to drivers/acpi/sleep.c (where they're
used)

<mochel-3NddpPZAyC0@public.gmane.org> (02/09/13 1.497.91.11)
   ACPI: Don't use driver model for struct acpi_device; use driverfs
directly.
   
   Instead of initializing and registering a struct device for each
acpi_device, just
   initialize and create a driverfs directory for each one. ACPI devices
aren't devices,
   and shouldn't be treated as such. They are firmware objects that describe
devices.
   They should still have representation in driverfs (and symlinks to the
devices they
   describe), but none of the other driver model overhead. 
   
   In order to do this, we also add some ACPI bindings for driverfs. It gets
its own top-
   level directory now (though it will soon be under a more generic
'platform' directory).

<mochel-3NddpPZAyC0@public.gmane.org> (02/09/13 1.497.91.10)
   ACPI: Add call to acpi_ec_ecdt_probe() from acpi_bus_init() again and fix
the comment to 
   explicitly say that it must be called before acpi_initialize_objects().

<mochel-3NddpPZAyC0@public.gmane.org> (02/09/13 1.497.91.9)
   ACPI: Move per-componet defines into component files. Only share in
headers what is needed by 
   multiple users.

<mochel-3NddpPZAyC0@public.gmane.org> (02/09/13 1.497.91.8)
   ACPI: Treat acpi_root_dir as acpi_root_dir when initializing (not
acpi_device_dir(acpi_root))
   (and fix OOPS on boot because acpi_root is NULL).
   

<mochel-3NddpPZAyC0@public.gmane.org> (02/09/13 1.497.91.7)
   ACPI: Remove call to acpi_ec_ecdt_probe() in acpi_bus_init() and make it
a part 
   of acpi_ec_init().

<mochel-3NddpPZAyC0@public.gmane.org> (02/09/12 1.497.91.6)
   ACPI: remove the rest of the explicit init function calls and move them 
   into the various files and make them initcalls.
   

<mochel-3NddpPZAyC0@public.gmane.org> (02/09/12 1.497.91.5)
   ACPI: Move all namespace scanning functions from drivers/acpi/bus.c to
drivers/acpi/scan.c
   
   Also, trigger bus scanning in acpi_scan_init(), which is made into an
initcall.

<mochel-3NddpPZAyC0@public.gmane.org> (02/09/12 1.497.91.4)
   ACPI: set acpi_disabled = 1 if acpi_bus_init() fails, and check this in
the
   init functions for the other components.
   

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/09/12 1.497.75.56)
   ACPI: Print the DSDT stats on boot, just like the other ACPI tables.

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/09/12 1.497.77.15)
   ACPI: Fix Config.in to allow CONFIG_ACPI_SLEEP to be set properly

<mochel-3NddpPZAyC0@public.gmane.org> (02/09/12 1.497.91.3)
   ACPI: Remove acpi_exit() and friends, since it's never called. 
   
   Also, make sure acpi_init() is declared static and not prototyped
anywhere.

<mochel-3NddpPZAyC0@public.gmane.org> (02/09/12 1.497.91.2)
   ACPI: Remove dead code from drivers/acpi/bus.c
   
   CONFIG_LDM is useless; you're stuck with it now :)
   
   Also, the struct device_driver callbacks have never been used. The
objects that are being
   called 'devices' aren't really devices anyway; they're merely firmware
representations of them...
   
   Remove the unused (wrapped in #ifdef 0) functions acpi_platform_add() and
acpi_platform_remove().
   
   Remove the unused (commented out) functions acpi_add_device_fs() and
acpi_remove_device_fs().

<mochel-3NddpPZAyC0@public.gmane.org> (02/09/12 1.497.91.1)
   ACPI: make CONFIG_ACPI_SLEEP _not_ dependent on CONFIG_SOFTWARE_SUSPEND
   and add help text.

<mochel-3NddpPZAyC0@public.gmane.org> (02/09/12 1.497.77.12)
   ACPI: break procfs handlers for acpi events and debug levels out of
drivers/acpi/system.c and into their own files.

<mochel-3NddpPZAyC0@public.gmane.org> (02/09/12 1.497.77.11)
   ACPI: Remove unnecessary objects and code from drivers/acpi/system.c
   
   First, we remove acpi_system_driver, since it's not really a driver, and
making it its own 
   object is just silly. This allows us to not have to register it, and we
can hence remove
   the add and remove callbacks. 
   
   For initialization, acpi_system_add_fs() has been inlined in
acpi_system_init(). The proc file
   creation was cleaned up to use create_proc_read_entry() where possible.
Any failures now
   result in a goto Error, which prints the error message previously
replicated after each
   failure. We also remove all the files that were created if that happens.
acpi_system_init()
   was made a subsys_initcall and declared static. 
   
   The acpi_system_exit() code and friends was removed, since it's never,
ever called. 

<mochel-3NddpPZAyC0@public.gmane.org> (02/09/12 1.497.77.9)
   ACPI: Move sleep code from system.c to sleep.c
   
   struct acpi_system was removed, because it was an unncessary abstraction
(a single array suffices).
   All functions have been updated to reference the array. 
   
   Unnecessary headers were removed, including ones implicitly included.
   
   procfs files controlling sleep support were moved. 
   
   sysrq handler and registration were removed. 
   
   acpi_sleep_init() made an implicit subsys_initcall.

<mochel-3NddpPZAyC0@public.gmane.org> (02/09/12 1.497.77.8)
   ACPI: move PREFIX to a common header

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/09/11 1.497.77.7)
   ACPI: Include proper header for acpi_enter_sleep_state() in suspend.c

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/09/11 1.497.77.5)
   ACPI:
   - Use early table mapping code from acpitable.c (Andi Kleen)
   - Make a warning a little more verbose

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/09/11 1.497.77.4)
   ACPI: New blacklist entries (Andi Kleen)

<agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (02/09/10 1.497.77.3)
   ACPI: Blacklist improvements
   1) Split blacklist code out into a separate file.
   2) Move checking the blacklist to very early. Previously, we would use
ACPI
   tables, and then halfway through init, check the blacklist -- too late.
   Now, it's early enough to completely fall-back to non-ACPI.
   3) Some FACP -> FADT cleanups, too.




-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
