From: Christopher Allen Wing <wingc-fnGUqWb9lFPPwG6xszlCvg@public.gmane.org>
Subject: suggestions for debugging ACPI IRQ routing in 2.6.11.6? (timer
 interrupt received twice)
Date: Mon, 4 Apr 2005 17:51:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0504041743340.32159@hammer.engin.umich.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

With ACPI enabled and APIC enabled on my x86_64 system (Athlon64 with ATI
RS200 chipset), the timer interrupt gets received twice for every tick.
This causes the clock to run twice as fast as normal.

I entered a bugzilla report with the kernel bug tracker:

	http://bugme.osdl.org/show_bug.cgi?id=4442



Anyway, the problem goes away if I disable APIC interrupts using the
'noapic' kernel boot option. I am guessing the problem is that somehow the
timer interrupt gets routed twice when in APIC mode. I would be interested
in suggestions for how to debug this. I note the kernel boot options:

	acpi_dbg_layer=
	acpi_dbg_level=

Would these provide any useful information in this case?


I tried to disassemble the ACPI tables via:

	acpidmp >acpidmp.out
	acpixtract DSDT acpidmp.out >dsdt.dat
	iasl -d dsdt.dat


but 'iasl' crashes with a segfault in AcpiTbChecksum(). I tried the same
procedure on two different systems (one of them is my x86_64 system with
the bad clock, another is an older pentium III system). iasl crashed on
both. Does iasl work properly, are my ACPI tables corrupted, or am I doing
something else wrong?


Thanks,

Chris Wing
wingc-fnGUqWb9lFPPwG6xszlCvg@public.gmane.org


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
