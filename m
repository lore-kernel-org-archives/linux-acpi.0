From: Josh Green <josh-momsFTegVwnNLxjTenLetw@public.gmane.org>
Subject: Extreme latency issues when fan kicks in on a Z71V laptop
Date: Tue, 21 Jun 2005 03:33:06 -0700
Message-ID: <1119349986.16343.26.camel@SillyPuddy.localdomain>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,
I recently bought an ASUS Z71V based laptop.  I've been having problems
when running 3D intensive applications.  When playing a 3D game, the
cooling fan will sometimes kick into high gear.  When this happens the
machine can stall for sometimes several seconds, during which time it is
completely unresponsive.  The fan will then slow down again and things
will once again be fine, then kick in again, stall.. stall.. etc.

Details of my system:
Pentium M 1.86GHz CPU
NVidia GeForce Go 6600 PCI-E card
Linux kernel 2.6.11-gentoo-r9
gcc 3.3.4
glibc 2.3.4.20040808

I'm using the acpi_cpufreq module for CPU frequency control.

I've verified that the CPU is at a constant temperature of 59C, so I 
don't believe the CPU is being throttled (active state does not change
in /proc/acpi/processor/CPU1/throttling).  The correlation does not
appear to be related to CPU usage either, since I can do heavy compiles
without the fan kicking in, its only with heavy 3D apps.

I ran oprofile to try and get an idea of what could be hanging the
system.  I ran it for a brief amount of time during the occurrence of
the problem.  The report showed that the kernel consumed ~45%,
libGLcore.so ~40%, ~9% for the game binary, ~2% nvidia module, etc.

Excerpt of vmlinux kernel symbol profile:

CPU: PIII, speed 1955.68 MHz (estimated)
Counted CPU_CLK_UNHALTED events (clocks processor is not halted) with a
unit mask of 0x00 (No unit mask) count 100000
samples  %        symbol name
31698    13.4055  acpi_ut_callocate
24138    10.2082  kfree
24133    10.2061  __kmalloc
13162     5.5664  acpi_ns_search_node
10561     4.4664  delay_pmtmr
9678      4.0929  acpi_ps_parse_loop
6840      2.8927  acpi_os_read_port
6036      2.5527  acpi_ps_get_opcode_info
4690      1.9835  acpi_ut_update_object_reference
4249      1.7970  schedule
3831      1.6202  acpi_ns_get_parent_node
3778      1.5978  sysenter_past_esp
3551      1.5018  acpi_ds_method_data_init
3521      1.4891  acpi_ut_acquire_from_cache
3380      1.4294  acpi_ns_delete_namespace_by_owner
3160      1.3364  acpi_ns_get_next_node
2731      1.1550  acpi_ds_exec_end_op
2717      1.1491  acpi_os_allocate
2614      1.1055  acpi_ds_exec_begin_op
2597      1.0983  mask_and_ack_8259A
...

If you would like to see the complete output, I've put it here:
http://resonance.org/~josh/acpi_oprofile.txt

So it appears that ACPI related code is consuming quite a lot of CPU
when the problem is occurring.  My guess is that an event of some sort
is being generated rather rapidly and causing system CPU starvation.
Any ideas?  Thanks in advance for help on resolving this issue.  I'm a
semi-competent programmer with some kernel experience, so I can do some
additional probing/tests with a little guidance.
Best regards,
	Josh Green




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
