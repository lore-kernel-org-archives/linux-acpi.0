From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: [PATCHES 2.6] ACPI processor driver updates [idle, throttling,
	cpufreq, thermal]
Date: Mon, 6 Oct 2003 21:54:06 +0200
Sender: cpufreq-bounces-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
Message-ID: <20031006195406.GA22956@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-bounces-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm38Ik5SeuEX72+df2TVCvIA@public.gmane.org>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
List-Help: <mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm4xOcYYyLxz0@public.gmane.org>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMmEuNEP1Y2mCuZIoH1IeqzKA@public.gmane.org>
Errors-To: cpufreq-bounces-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The following patches which
- a) replace the broken ACPI CPUfreq driver with a better, flexible variant,
- b) modularize the processor.c code: instead of one large file there are
     many small files.
- c) improve passive cooling support
- d) allow for easy adding of proper locking and ref-counting in processor.c
have been re-diffed against linux-2.6.0-test6-bk-current and are available
on my website. 
Len, I'll send them to you in private e-mail for easier merging later.

Please apply.

	Dominik

http://www.brodo.de/patches/2003-10-06/acpi-2.6.0-test6-2-remove_previous_pstates_implementation
	The previous arch/i386/kernel/cpu/cpufreq/acpi.c CPUfreq
	driver was broken, of bad design, and needs to replaced 
	by something better. But, as a first step, remove all 
	parts related to P-States from ACPI code.

http://www.brodo.de/patches/2003-10-06/acpi-2.6.0-test6-2-processor_submodules
	Add a "submodule interface" to drivers/acpi/processor.c

	It allows to create other "modules" which access the acpi_handle 
	for the processor, and which get notified if the event value 
	maches the value passed in acpi_processor_register_notify.

http://www.brodo.de/patches/2003-10-06/acpi-2.6.0-test6-2-processor_perflib
	This patch adds a new "P-States library" to drivers/acpi/

	CPUfreq drivers can now easly access the contents of the 
	_PCT and the _PSS. For example, the speedstep-centrino 
	driver could be appended so that it passes the appropriate 
	value to the P-States library which then evaluates _PDC, 
	and then returns the updated _PCT and _PSS.

	Also, the platform limit is now handled as a cpufreq notifier and
	as a call to cpufreq_policy_update.

http://www.brodo.de/patches/2003-10-06/acpi-2.6.0-test6-2-new_acpi_io_driver
	This re-adds the acpi P-States I/O driver. It is much smaller,
	leaner and cleaner.

http://www.brodo.de/patches/2003-10-06/acpi-2.6.0-test6-2-idle_submodule
	This moves the idle handler out of drivers/acpi/processor and into
	an own module.

	Even if only C1 is available, it is now used. If the user prefers the 
	default pm_idle, he can unload processor_idle, and still have the other
	functionality available.

http://www.brodo.de/patches/2003-10-06/acpi-2.6.0-test6-2-thermal_submodule
	This adds a new mechanism to manage passive cooling. Instead of
	hardcoded -and partly wrong- access to CPUfreq and ACPI 
	throttling-, add a generic mechanism which other modules can 
	register with.

http://www.brodo.de/patches/2003-10-06/acpi-2.6.0-test6-2-thermal_cpufreq
	Use _any_ CPUfreq driver for passive cooling. Implemented by an
	cpufreq policy notifier and cpufreq_update_policy.
 
http://www.brodo.de/patches/2003-10-06/acpi-2.6.0-test6-2-thermal_throttling
	Move throttling into its own submodule, and register it with the new
	passive cooling module. Also, the now-useless "limit" interface is
	removed.
