From: The Purple Flamingo <aquarichy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: ACPI on an Acer TravelMate C100
Date: Mon, 7 Mar 2005 15:27:33 -0500
Message-ID: <25ae429205030712276d63b68a@mail.gmail.com>
Reply-To: The Purple Flamingo <aquarichy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Hello.   I am fairly confident that ACPI is supported by my laptop,
because I have read several references to it working on it, and the
BIOS-provided physical RAM map mentions ACPI as well.

However, at boot, I get:
  ACPI: RSDP (v000 Acer                                  ) @ 0x000ec2d0
    >>> ERROR: Invalid checksum

and later on,

  ACPI: Subsystem revision 20050211
  ACPI: Interpreter disabled.

and APM loads instead.  If I compile a kernel sans APM, then I get no PM.
Trying pnpacpi=off, pci=routeirq, apm=off, and acpi=force have done nothing.  
There is not even a /proc/acpi !

This is problematic because my laptop thinks there are no batteries
now, and suspending freezes the machine on lid close (though running a
script for it succeeds . . . unless I try to close the lid!)

I am using Ubuntu Linux 5.04.
Vanilla kernels have no better luck then theres.

What can I do? 

Richard Schwarting


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
