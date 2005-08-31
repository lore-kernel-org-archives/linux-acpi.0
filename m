From: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC][PATCH 0/4] Software coordination of frequency across CPUs sharing common P-state
Date: Wed, 31 Aug 2005 14:09:33 -0700
Message-ID: <20050831140933.A12497@unix-os.sc.intel.com>
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
To: cpufreq <cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


ACPI 3.0 (http://www.acpi.info) adds new methods with which BIOS can communicate
P-state dependency domains (List of CPUs that share a common P-state) to
the OS. This can be used in conjunction with the existing "cpu group awareness"
in cpufreq infrastructure, to manage the group of CPUs sharing the common 
P-state, in a better way.

The patchset that follows adds this "software-coordination" feature in 
acpi-perflib, and also changes acpi-cpufreq and speedstep-centrino drivers to
use this feature. 

With this feature, current and future platforms (with more than one
logical processor) with Enhanced Speedstep Technology, can use 
software-coordination in place of BIOS(or Hardware)-coordination of P-states. 
The advantages:
1) With software coordination, we can use MSRs to change the frequency, 
instead of using IO ports (as in BIOS coordination). This has a huge advantage
in terms of P-state transition latency. MSR based P-states transition latency 
is around 10uS where as IO port based (which goes through SMM for BIOS 
coordination) latency is around 100uS.
2) Kernel will know about the exact frequency at which each CPU is running. 
With BIOS coordination, actual frequency of a particular CPU may be different
from what kernel thinks it is. As, BIOS changes the frequency of a particular 
CPU depending on last request from the kernel and also the frequency request 
from all the other CPUs in the same domain.

Caveat: BIOSes have to change to to support these new ACPI 3.0 based interfaces.
Not many BIOSes support it today. But, are likely to do it in future, as with 
dual-cores, more number of logical processors share the common P-states.

The patchset also allows "hardware coordination" of P-states among the
CPUs belonging to same P-state dependency domain. Kernel will use either
software or hardware coordination, depending on what BIOS supports on the
particular platform. With hardware coordination among the CPUs of a dependency
domain, we will still have the advantage (2) above, but will not have the 
advantage (1).

Below is more info about each patch in the patchset.

Comments most welcome.
Thanks,
Venki

[PATCH 1/4] Software coordination of freq across CPUs sharing common P-state

Changes to acpi/processor_perflib.c to invoke new (ACPI 3.0) _PSD methods. 
This method has to be called early on all CPUs and P-state dependency domains 
determined before the actual performance_register of P-states.

Also, a new field (shared_type) is added to cpufreq_policy. This is required to support two kinds of CPU groups. One, where one logical CPU can change the 
frequency of all the CPUs by writing into an MSR or IO port. Other, where all 
CPUs in the dependency domain need to write to an MSR or IO port.


[PATCH 2/4] Software coordination of freq across CPUs sharing common P-state

Changes to speedstep-centrino required for supporting cpu groups sharing
common P-state.

acpi_processor_preregister_performance is called initially to determine the
CPU group membership.
centrino_target is chaneg to handle acpu group shared_type of SHARED_TYPE_ANY
and SHARED_TYPE_ALL.


[PATCH 3/4] Software coordination of freq across CPUs sharing common P-state

Changes to acpi-cpufreq required for supporting cpu groups sharing
common P-state

acpi_processor_preregister_performance is called initially to determine the
CPU group membership.
centrino_target is chaneg to handle acpu group shared_type of SHARED_TYPE_ANY
and SHARED_TYPE_ALL.


[PATCH 4/4] Software coordination of freq across CPUs sharing common P-state

Final knob to turn on the P-state cpu groups in acpi-cpufreq and
speedstep-centrino. Add the software coordination bit for _PDC calls.




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
