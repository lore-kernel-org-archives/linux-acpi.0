From: "Bishop Brock" <bcbrock-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: An embedded-Linux power-management framework
Date: Fri, 2 Aug 2002 21:29:04 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <OF4415334C.6C7486B8-ON86256C0A.00081BB4@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org
Cc: Linux Power Management Development <linux-pm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux ACPI Development <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux APMD <apmd-list-+wEybqfU8vgCzWx7n4ubxQ@public.gmane.org>, CPU Frequency <cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [ACPI] An embedded-Linux power-management framework
Date: 03 Aug 2002 00:31:10 +0100

On Fri, 2002-08-02 at 19:20, Hollis Blanchard wrote:
>> frequency transitions. The idle task is a great place to lower frequency
>> only, since you're not doing anything anyways (you're not extending the
>> running time of a meaningful task), but you may not want to incur the
>> overhead of a voltage transition every time you come in and out of it.
>>

> The idle task should almost never run on a properly power managed system
> because if we are getting voltage reductions we want to reduce the
> frequency so that we are not quite idle as that saves us more power than
> idling. This is also effectively true for clock only scaling because
> very few of them have a "stopped" mode so their is a ceiling of minimal
> power consumption we want to rest at as much as possible

I assume you're talking about systems with more-or-less continuous
workloads;
the examples most often used in academic research are media players.
You've asserted  the conventional wisdom about dynamic power management
which I challenge
as being 1) system and application dependent, and 2) unachievable.

On the first point, we're concerned with system-wide power management,
which includes the
memory subsystem.  Our processors are so power-efficient today that we burn
more power
in the memory than in the CPU core.  An idle system can greatly reduce
memory power by
reducing the memory clock frequency, and/or self-refreshing all or part of
the memory.  Depending
on the application and system design, it may be more power-efficient to
finish the application
quickly and power down the memory, rather than trying to extend the run
time of the application
to just meet a deadline, which requires continuously running the memory at
high frequencies.

On the second point, we all dream of finding just the right operating point
that allows our
media applications to finish just in time with minimum energy, but are
always disappointed.
Power states are quantized, first by the data sheet of the processor which
will list at most a few
fully characterized voltage operating points, and second by the clocking
subsystems which will
limit the range of allowable frequency scaling.  Due to normal variations
in media workloads,
a power management policy that tries to guarantee high fidelity in the
playback will naturally
need to include a provision for headroom in the selection of the operating
point.  These
three factors: workload variability, a fixed list of operating points and a
conservative
power management policy lead to slack, i.e., idle time.  Our proposal
allows the system to
capture the slack by aggressively idling the processor for short periods,
e.g., between video
frames, without any effect on the application, and with significant energy
reduction.

Bishop Brock

IBM Research, Austin Center for Low-Power Computing
11400 Burnet Road    MS/904-6F021
Austin, TX 78758
(512) 838-0149    IBM T/L 678-0149





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
