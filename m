From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: ACPI processor module enhancements
Date: Wed, 15 Sep 2004 10:47:14 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040915084714.GA2282@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

This is meant as sort of a "TODO list" for the ACPI processor module. There
are several areas which are in need of improvement -- and coordination. To
keep in Linux tradition, I've tried to split them up so that small
incremental patches are possible:


1.) utilize pstate_cnt to notify the BIOS that a P-State driver is present
This has already been brought up on this list, last in this thread:
http://marc.theaimsgroup.com/?l=acpi4linux&m=109428989121089&w=2


2.) support for _CST [more, dynamically configurable CPU power states] on UP
Patch is at http://bugme.osdl.org/show_bug.cgi?id=1958 -- Bruno's
"non-dynamic" patch instead of mine is the way to go...


3.) improved CPU power state selection algorithm
Some ideas are in my patch http://bugme.osdl.org/show_bug.cgi?id=1958 , it
needs adaption to TODO#2 and further evaluation, though.


4.) _OSC / _PDC framework
The _PDC / _OSC methods added in ACPI v. 3.0 are a bit tricky to handle
because of the modularization in Linux. Basically we need a 

unsigned int acpi_processor_osc_update()

which only adds something to a saved buffer. If the driver requests some
"control" by calling acpi_processor_osc_update(), the latter should lock the
driver by "try_module_get()".


5.) _{P,T,C}SD groundwork
some 

acpi_status acpi_processor_get_domain(..., cpumask_t *cpus, u8 *type);

is needed which a) determines the domain of the CPU passed as argument,
b) walks through all detected processor objects and looks for the other CPUs
in this domain [this asserts that all CPUs are initialized as required by
ACPI spec v.3.0 p.273], c) converts the ACPI CPU numbers to Linux kernel CPU
numbers, and d) converts this to a cpumask_t


6.) Utilizing _PSD in the ACPI perflib

The cpufreq core is (almost) ready for handling domains, so it'll be only a
question of cpufreq driver support for domain ahndling. A helper like

acpi_for_domain_do_fn(cpumask_t domain; (int) (*fn) (unsigned int cpu, cpumask_t allowed_maskm void *), void *data, int type) {
	int ret = -EINVAL;
	/* we encourage type ANY as it is faster */
	if (likely(type == ANY)) { 
		ret = fn(find_first_bit(domain), domain, data)
	} else {
		for_each_cpu_mask(cpu, domain) {
			ret = fn(cpu, cpu_mask_of_cpu(cpu), data)
			if (ret)
				return (ret);
		}
	}
	return (ret);
}

or something like that may be of assistance here.


7.) Support for C2-type sleep on multiprocessor systems.

Already previous versions of the ACPI specification can support that in
theory, though SMT awareness requires _CSD handling.


8.) Support for WBINVD-based C3

Only enabled on UP if users explicitely requests it, but always available
on multiprocessor systems.


9.) throttling support using _PTC/_TSS/_TPC on UP
Currently only the P_CNT method is available.


10.) Make throttling multiprocessor-aware utilizing _TSD


11.) [or maybe much much earlier?] split up drivers/acpi/processor.c in
     individual files and modules:
	- core
	- C-States handling
	- T-States handling
	- ACPI perflib


	Dominik


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
