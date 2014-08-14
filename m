From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [RFC 0/3] Experimental patchset for CPPC
Date: Thu, 14 Aug 2014 15:57:07 -0400
Message-ID: <1408046230-16439-1-git-send-email-ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com, mike.turquette@linaro.org, morten.rasmussen@arm.com, arjan@linux.intel.com, mingo@kernel.org, peterz@infradead.org, len.brown@intel.com, rjw@rjwysocki.ne, linaro-acpi@lists.linaro.org, arnd@arndb.de, linux-acpi@vger.kernel.org, cpufreq@vger.kernel.org, patches@linaro.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>
List-Id: linux-acpi@vger.kernel.org


Hello,

Apologies in advance for a lengthy cover letter. Hopefully it has all t=
he
required information so you dont need to read the ACPI spec. ;)

This patchset introduces the ideas behind CPPC (Collaborative Processor
Performance Control) and implements support for controlling CPU perform=
ance
using the existing PID (Proportional-Integral-Derivative) controller (f=
rom
intel_pstate.c) and some CPPC semantics.

The patchwork is not a final proposal of the CPPC implementation. I've =
had
to hack some sections due to lack of hardware, details of which are in =
the
Testing section.

There are several bits of information which are needed in order to make=
 CPPC
work great on Linux based platforms and I'm hoping to start a wider dis=
cussion on
how to address the missing bits. The following sections briefly introdu=
ce CPPC
and later highlight the information which is missing.

More importantly, I'm also looking for ideas on how to support CPPC in =
the short
term, given that we will soon be seeing products based on ARM64 and X86=
 which
support CPPC.[1] Although we may not have all the information, we could=
 make it
work with existing governors in a way this patchset demonstrates. Hopef=
ully,
this approach is acceptable for mainline inclusion in the short term.

=46iner details about the CPPC spec are available in the latest ACPI 5.=
1
specification.[2]

If these issues are being discussed on some other thread or elsewhere, =
or if
someone is already working on it, please let me know. Also, please corr=
ect me if
I have misunderstood anything.

What is CPPC:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

CPPC is the new interface for CPU performance control between the OS an=
d the
platform defined in ACPI 5.0+. The interface is built on an abstract
representation of CPU performance rather than raw frequency.  Basic ope=
ration
consists of:

* Platform enumerates supported performance range to OS

* OS requests desired performance level over some time window along
with min and max instantaneous limits

* Platform is free to optimize power/performance within bounds provided=
 by OS

* Platform provides telemetry back to OS on delivered performance

Communication with the OS is abstracted via another ACPI construct call=
ed
Platform Communication Channel (PCC) which is essentially a generic sha=
red
memory channel with doorbell interrupts going back and forth. This abst=
raction
allows the =E2=80=9Cplatform=E2=80=9D for CPPC to be a variety of diffe=
rent entities =E2=80=93 driver,
firmware, BMC, etc.

CPPC describes the following registers:

* HighestPerformance: (read from platform)

Indicates the highest level of performance the processor is theoretical=
ly
capable of achieving, given ideal operating conditions.

* Nominal Performance: (read from platform)

Indicates the highest sustained performance level of the processor.  Th=
is is the
highest operating performance level the CPU is expected to deliver cont=
inuously.

* LowestNonlinearPerformance: (read from platform)

Indicates the lowest performance level of the processor with non- linea=
r power
savings.

* LowestPerformance: (read from platform)

Indicates the lowest performance level of the processor.

* GuaranteedPerformanceRegister: (read from platform)

Optional. If supported, contains register to read the current guarantee=
d
performance from. This is current max sustained performance of the CPU =
taking
into account all budgeting constraints. This can change at runtime and =
is
notified to the OS via ACPI notification mechanisms.

* DesiredPerformanceRegister: (write to platform)

Register to write desired performance level from the OS.

* MinimumPerformanceRegister: (write to platform)

Optional. This is the min allowable performance as requested by the OS.

* MaximumPerformanceRegister: (write to platform)

Optional. This is the max allowable performance as requested by the OS.

* PerformanceReductionToleranceRegister (write to platform)

Optional. This is the deviation below the desired perf value as request=
ed by the
OS. If the Time window register(below) is supported, then this value is=
 the min
performance on average over the time window that the OS desires.

* TimeWindowRegister: (write to platform)
Optional. The OS requests desired performance over this time window.

* CounterWraparoundTime: (read from platform)
Optional. Min time before the performance counters wrap around.

* ReferencePerformanceCounterRegister: (read from platform)

A counter that increments proportionally to the reference performance o=
f the
processor.

* DeliveredPerformanceCounterRegister: (read from platform)

Delivered perf =3D reference perf * delta(delivered perf ctr)/delta(ref=
 perf ctr)

* PerformanceLimitedRegister: (read from platform)

This is set by the platform in the event that it has to limit available
performance due to thermal or budgeting constraints.

* CPPCEnableRegister: (read/write from platform)

Enable/disable CPPC

* AutonomousSelectionEnable:

Platform decides CPU performance level w/o OS assist.

* AutonomousActivityWindowRegister:

This influences the increase or decrease in cpu performance of the plat=
forms
autonomous selection policy.

* EnergyPerformancePreferenceRegister:

Provides a energy or perf bias hint to the platform when in autonomous =
mode.

* Reference Performance: (read from platform)

Indicates the rate at which the reference counter increments.


Whats missing in CPPC:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Currently CPPC makes no mention of power. However, this could be added =
in future
versions of the spec.
e.g. although CPPC works off of a continuous range of CPU perf levels, =
we could
discretize the scale such that we only extract points where the power l=
evel changes
substantially between CPU perf levels and export this information to th=
e
scheduler.

Whats missing in the kernel:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

We may have some of this information in the scheduler, but I couldn't s=
ee a good way
to extract it for CPPC yet.

(1) An intelligent way to provide a min/max bound and a desired value f=
or CPU
performance.

(2) A timing window for the platform to deliver requested performance w=
ithin
bounds. This could be a kind of sampling interval between consecutive r=
eads of
delivered cpu performance.

(3) Centralized decision making by any CPU in a freq domain for all its
siblings.

The last point needs some elaboration:

I see that the CPUfreq layer allows defining "related CPUs" and that we=
 can have
the same policy for CPUs in the same freq domain and one governor per p=
olicy.
However, from what I could tell, there are at least 2 baked in assumpti=
ons in
this layer which break things at least for platforms like ARM (Please c=
orrect me
if I'm wrong!)

(a) All CPUs run at the exact same max, min and cur freq.

(b) Any CPU always gets exactly the freq it asked for.

So, although the CPUFreq layer is capable of making somewhat centralize=
d cpufreq
decisions for CPUs under the same policy, it seems to be deciding thing=
s under
the wrong/inapplicable assumptions.  Moreover only one CPU is in charge=
 of
policy handling at a time and the policy handling is shifted to another=
 CPU in the
domain, only if the former CPU is hotplugged out.

Not having a proper centralized decision maker adversely affects power =
saving
possibilities in platforms that can't distinguish when a CPU requests a=
 specific
freq and then goes to sleep.  This potentially has the effect of keepin=
g other
CPUs in the domain running at a much higher frequency than required, wh=
ile the
initial requester is deep asleep.

So, for point (3), I'm not sure which path we should take among the fol=
lowing:

(I) Fix cpufreq layer and add CPPC support as a cpufreq_driver.  (a) Ch=
ange
every call to get freq to make it read h/w registers and then snap valu=
e back to
freq table. This way, cpufreq can keep its idea of freq current. Howeve=
r, this
may end up waking CPUs to read counters, unless they are mem mapped.  (=
b) Allow
any CPU in the "related_cpus" mask to make policy decisions on behalf o=
f
siblings. So the policy maker switching is not tied to hotplug.

(II) Not touch CPUfreq and use the PID algorithm instead, but change th=
e busyness
calculation to accumulate busyness values from all CPUs in common domai=
n.
Requires implementation of domain awareness.

(III) Address these issues in the upcoming CPUfreq/CPUidle integration =
layer(?)

(IV) Handle it in the platform or lose out. I understand this has some =
potential
for adding latency to cpu freq requests so it may not be possible for a=
ll
platforms.

(V) ..?

=46or points (1) and (2), the long term solution IMHO is to work it out=
 along with the
scheduler CPUFreq/CPUidle integration. But its not clear to me what wou=
ld be
the best short term approach. I'd greatly appreciate any suggestions/co=
mments.
If anyone is already working on these issues, please CC me as well.

Test setup:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46or the sake of experiments, I used the Thinkpad x240 laptop, which a=
dvertises
CPPC tables in its ACPI firmware. The PCC and CPPC drivers included in =
this
patchset are able to parse the tables and get all the required addresse=
s.
However, it seems that this laptop doesn't implement PCC doorbell and t=
he
firmware side of CPPC. The PCC doorbell calls would just wait forever. =
Not sure
whats going on there. So, I had to hack it and emulate what the platfor=
m
would've done to some extent.

I extracted the PID algo from intel_pstate.c and modified it with CPPC =
function
wrappers. It shouldn't be hard to replace PID with anything else we thi=
nk is
suitable. In the long term, I hope we can make CPPC calls directly from=
 the
scheduler.

There are two versions of the low level CPPC accessors. The one include=
d in the
patchset is how I'd imagine it would work with platforms that completel=
y
implement CPPC in firmware.

The other version is here [5]. This should help with DT or platforms wi=
th broken
firmware, enablement purposes etc.

I ran a simple kernel compilation with intel_pstate.c and the CPPC modi=
fied
version as the governors and saw no real difference in compile times. S=
o no new
overheads added.
I verified that CPU freq requests were taken by reading out the PERF_ST=
ATUS register.

[1] - See the HWP section 14.4 http://www.intel.com/content/dam/www/pub=
lic/us/en/documents/manuals/64-ia-32-architectures-software-developer-v=
ol-3b-part-2-manual.pdf
[2] - http://www.uefi.org/sites/default/files/resources/ACPI_5_1release=
=2Epdf
[3] - https://plus.google.com/+TheodoreTso/posts/2vEekAsG2QT
[4] - https://plus.google.com/+ArjanvandeVen/posts/dLn9T4ehywL
[5] - http://git.linaro.org/people/ashwin.chaugule/leg-kernel.git/blob/=
236d901d31fb06fda798880c9ca09d65123c5dd9:/drivers/cpufreq/cppc_x86.c

Ashwin Chaugule (3):
  ACPI: Add support for Platform Communication Channel
  CPPC: Add support for Collaborative Processor Performance Control
  CPPC: Add ACPI accessors to CPC registers

 drivers/acpi/Kconfig        |  10 +
 drivers/acpi/Makefile       |   1 +
 drivers/acpi/pcc.c          | 301 +++++++++++++++
 drivers/cpufreq/Kconfig     |  19 +
 drivers/cpufreq/Makefile    |   2 +
 drivers/cpufreq/cppc.c      | 874 ++++++++++++++++++++++++++++++++++++=
++++++++
 drivers/cpufreq/cppc.h      | 181 +++++++++
 drivers/cpufreq/cppc_acpi.c |  80 ++++
 8 files changed, 1468 insertions(+)
 create mode 100644 drivers/acpi/pcc.c
 create mode 100644 drivers/cpufreq/cppc.c
 create mode 100644 drivers/cpufreq/cppc.h
 create mode 100644 drivers/cpufreq/cppc_acpi.c

--=20
1.9.1

