From: Linus Torvalds <torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org>
Subject: RE: ACPI interrupts..
Date: Wed, 25 Sep 2002 10:25:09 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0209250959550.1817-100000@penguin.transmeta.com>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DEBC@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DEBC-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On Wed, 25 Sep 2002, Grover, Andrew wrote:
> > ie why does my dual P4-HT take ~18,000 interrupts per second on each 
> > virtual CPU?
> 
> A bug, apparently...
> 
> I take it this is a new phenomena?

The whole machine is reasonable new, and to be honest it's fast enough(*)
that it's not like I could claim I would have noticed it before. I took a 
look at the interrupt counts for totally unrelated reasons, and for all I 
know it might have done this for some time.

(*) Fast enough means that in practice the thing slowing it down are disk 
accesses, not CPU speed.

> I've seen this problem before on a system that had interrupt polarity wrong.
> The ACPI interrupt should always be active low, shareable, level triggered.

It's definitely level-triggered: note the "IO-APIC-level" in the 
/proc/interrupt output.

That also implies that it's not a completely spurious interrupt: if it was
spurious, the interrupt handler wouldn't know what to do with it, and it 
would scream constantly and the machine would make no progress. Obviously 
that isn't the case, since the machine works fine.

So I think the interrupt is doing fine, and there is just some event that 
really happens 18,000 times a second (well, it's actually 72,000 times a 
second, since it is nicely distributed on all 4 virtual CPU's).

Enabling some acpi debugging seems to show a lot of:

   evsci-0058 [0000] [127] Ev_sci_handler        : ----Entry
  hwregs-0249 [0000] [128] Acpi_get_register     : ----Entry
  hwregs-0465 [0000] [129] Hw_register_read      : ----Entry
  hwregs-0544 [0000] [129] Hw_register_read      : ----Exit- AE_OK
  hwregs-0281 [0000] [128] Acpi_get_register     : Read value 1
  hwregs-0284 [0000] [128] Acpi_get_register     : ----Exit- AE_OK
  hwregs-0465 [0000] [128] Hw_register_read      : ----Entry
  hwregs-0544 [0000] [128] Hw_register_read      : ----Exit- AE_OK
  hwregs-0465 [0000] [128] Hw_register_read      : ----Entry
  hwregs-0544 [0000] [128] Hw_register_read      : ----Exit- AE_OK
 evevent-0220 [0000] [127] Ev_fixed_event_detect : Fixed Acpi_event Block: Enable 00000120 Status 00000011
 evevent-0704 [0000] [127] Ev_gpe_detect         : GPE block at 000000000000042E - Values: Enable 80 Status 40
 evevent-0704 [0000] [127] Ev_gpe_detect         : GPE block at 000000000000042F - Values: Enable 00 Status 21
 evevent-0704 [0000] [127] Ev_gpe_detect         : GPE block at 000000000000042A - Values: Enable 38 Status 00
 evevent-0704 [0000] [127] Ev_gpe_detect         : GPE block at 000000000000042B - Values: Enable 09 Status 00
   evsci-0090 [0000] [127] Ev_sci_handler        : ----Exit- 0000000000000000

which (if I read this right) is kind of strange, since none of the status 
bits overlap with any of the enable bits. 

Over to you, Andrew,

		Linus



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
