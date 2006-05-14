From: Len Brown <len.brown@intel.com>
Subject: Re: latest ACPI patch vs 2.6.17-rc4
Date: Sun, 14 May 2006 00:48:47 -0400
Message-ID: <200605140048.47994.len.brown@intel.com>
References: <200605120518.38033.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13960 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932370AbWENEr0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 14 May 2006 00:47:26 -0400
In-Reply-To: <200605120518.38033.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Friday 12 May 2006 05:18, Len Brown wrote:
> Folks,
> The latest ACPI patch is against 2.6.17-rc4 and is available here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git test
> ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6.17/
>acpi-test-20060310-2.6.17-rc4.diff.gz
>
> Note that I removed the acpi_in_resume workaround, so you'll get some oops'
>  during resume, until we replace it with something else.
>
> Note that the kmalloc patches allow CONFIG_DEBUG_SLAB_LEAKS to put more
> useful entries in /proc/slab_allocators for acpi.


Same location, updated contents with some patches that were in -mm:

Latest ACPI patch is available here

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git test
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6.17/acpi-test-20060310-2.6.17-rc4.diff.gz

and contains this:

Adrian Bunk:
      [ACPI] drivers/acpi/video.c: fix error path NULL pointer dereference
      ACPI: Kconfig: ACPI should depend on, not select PCI

Andi Kleen:
      [ACPI] fix "nolapic" flag in ACPI mode

Andreas Mohr:
      ACPI: apply "__read_mostly" to processor_idle.c loop module parameters 
and friends

Andrew Morton:
      ACPI: UP build fix for bugzilla-5737

Arjan van de Ven:
      sem2mutex: drivers/acpi/processor_perflib.c

Arnaud Patard:
      ACPI: suppress power button event on S3 resume

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
      ACPI: acpi_bus_unregister_driver() returns void
      ACPI: acpi_os_wait_semaphore(): silence complaint

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

Ingo Molnar:
      sem2mutex: acpi, acpi_link_lock

Irwan Djajadi:
      [ACPI] drivers/acpi/hotkey.c: check kmalloc return value

Jiri Slaby:
      ACPI: EC acpi-ecdt-uid-hack

KAMEZAWA Hiroyuki:
      ACPI: use for_each_possible_cpu() instead of for_each_cpu()

Len Brown:
      ACPI: enable BIOS warning
      [ACPI] document cmdline acpi_os_name=
      Revert "ACPI: fix vendor resource length computation"
      ACPI: inline trivial acpi_os_get_thread_id()
      ACPI: ia64 buildfix
      ACPI: ia64 buildfix
      ACPI: delete remaining function tracing macros from drivers/acpi/*.c
      ACPI: delete newly added debugging macros in processor_perflib.c
      ACPI: disable ACPI_DBG_TRACK_ALLOCATIONS on debug kernel
      ACPI: use kfree(), delete acpi_os_free()
      ACPI: delete acpi_in_resume workaround
      ACPI: use kmalloc() and kzalloc(), delete acpi_os_allocate()
      ACPI: repair damage from overzealous bus.c cleanup patch
      ACPI: use kfree() on ia64 instead of acpi_os_free()
      ACPI: silence ia64 build warning
      ACPI: delete unused acpi_bus_drivers_lock

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

Vasily Averin:
      ACPI: fix potential memory leak in acpi_evaluate_integer() error path
      ACPI: fix memory leak in acpi_thermal_add() error path

Venkatesh Pallipadi:
      P-state software coordination for ACPI core
      P-state software coordination for acpi-cpufreq
      P-state software coordination for speedstep-centrino
      Enable P-state software coordination via _PDC
