From: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [ACPI][PATCH 0/4] (take 2) Software coordination of frequency across CPUs sharing common P-state
Date: Tue, 13 Sep 2005 16:57:52 -0700
Message-ID: <20050913165752.A5968@unix-os.sc.intel.com>
References: <20050901193154.GD24910@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050901193154.GD24910-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>; from davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org on Thu, Sep 01, 2005 at 12:31:55PM -0700
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
Cc: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Shah, Rajesh" <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org



Take 2 of patchset posted earlier (Sub -
"Software coordination of frequency across CPUs sharing common P-state")

Changes since last post:
- Small changes to make things work with CPU_HOTPLUG
- Minor changes and cleanups

Outstanding issue:
- "affected_cpus" unaware userlevel policies can change CPU frequencies wrongly.
If the userlevel policy is unaware that CPU freqs can be shared across CPUs,
and assumes each CPU has independent control, then it can change the frequencies
wrongly. 

Say CPU 0 and CPU 1 share a P-state. That information is exposed 
by kernel. But, if userspace daemon doesn't know about it (legacy daemon),
then it thinks each CPU is independent, and whenever one CPu (say CPU 1) is
idle it lowers CPU 1's frequency. And even when CPU 0 is busy, CPU 0's frequency
will get reduced in such a circumstance. And all this can happen silently,
letting the user to wonder why performance has gone down.

I don't know of any clean way of providing backward compatibility to those
(legacy) userlevel policy. Keeping this patch in mm for a while (until 2.6.14)
should provide a chance to identify such userlevel policies and fix them.

(Rest of this mail is same as in original thread)

Details:

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
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
