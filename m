From: "Bishop Brock" <bcbrock-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: An embedded-Linux power-management framework
Date: Fri, 2 Aug 2002 20:28:07 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <OF94EF243F.A49E95B4-ON86256C09.00716EF4@pok.ibm.com>
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

>From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
>Subject: Re: [ACPI] An embedded-Linux power-management framework
>Date: 02 Aug 2002 20:11:17 +0100

> Take a look at cpufreq. The processor speed/voltage side is a solved
> problem with working code for x86 and ARM processors including the
> framework to adjust other devices. For example on ARM you have to frob
> with the RAM clocks. Cpufreq deals with it nicely both from user and
> kernel sides

Processor speed and voltage setting are only two dimensions of the problem
for current and future generations of embedded processors.  The PowerPC
405LP supports 6 somewhat independent parameters that affect the power
consumption of the system: Core voltage, CPU frequency, Memory Bus
Frequency,
On-board peripheral bus frequency, External peripheral bus frequency, and
LCD
pixel clock frequency. The next generation of processors will take this
even
further: They will support multiple internal voltage planes, asymmetric
multiprocessing (cf. TI OMAP architecture) with independent voltage control
and clocking, and advanced clocking schemes to maximize the potential for
dynamic power management.  We will be able to do amazing things with
minuscule amounts of energy, but only if the OS supports the flexibility
inherent in the underlying hardware architectures.

We are proposing a scalable solution that naturally extends the
capabilities of cpufreq. We encapsulate all of the mutually constrained
physical and abstract parameters of a power management policy into
a system-dependent object called an "operating point", and propose
standard ways to manipulate operating points and sets of operating points.
This mechanism will be integrated with the device model in such a way
that as devices come on and off line, the optimum operating point is always
available.

We also add another dimension not present in the current solution, i.e.,
kernel control of dynamic power management at critical points in the
OS, particularly the entry and exit of the idle (halt) state, consistent
with policies defined in advance.  As we noted in the original posting,
significant system-wide energy savings are possible by rapidly scaling
frequencies during even short idle periods, and only the OS has the
visibility required to actively manage these events.

> In terms of per process settings please read US patent 6,298,448.

> Suggstions on how t work around it are welcomed

The following comments must not be construed as a legal position of
the IBM Corporation, or the legal opinion of any IBM attorney.

We have discussed this patent with our IP attorneys.  Those of
us developing this proposal are operating under the working
assumption that this patent does not preclude us from publishing
our code, and will not preclude anyone from executing our code
on any IBM processors.  However, prior to any release of
code to Open Source, we will go through a legal review process where
these issues will be closed to the satisfaction of IBM and our
Linux Distribution partners.

As an aside, my colleagues and I have doubts about the enforceability
of the patent in any case, due to extensive prior art before the
filing date.


Bishop Brock

IBM Research, Austin Center for Low-Power Computing
11400 Burnet Road    MS/904-6F021
Austin, TX 78758
(512) 838-0149    IBM T/L 678-0149





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
