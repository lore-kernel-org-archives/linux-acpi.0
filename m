From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Shutting down PCI devices on suspend
Date: Mon, 13 Dec 2004 09:59:56 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD30575C12271@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>Yes, layering has small losses in flexability, but the advantage of
>ensuring
>uniform behavior and capabilities is very important.  With layering,
code
>repitition is minimal and everything in the kernel is all around more
>simplistic and easy to maintain.  I think we can have a higher average
>quality
>of functionality and stability with this approach.  Also less work will
be
>required when developing new drivers or adding new functionality.  For
>example, a developer could update class level code without breaking or
>needing
>to change driver and bus level code.
>
>Basically each component in the stack should not know or care about
what
>the
>components above or below it are going to do.  Each should be
autonomous
>and
>only concerned with completing its own well defined goal along the
chain of
>the process.  This can apply to most problems, including power
management.
I like the layering device model very much. We really need a unified
model to link the physical devices with ACPI devices. I have some
attempts before (see
http://www.gossamer-threads.com/lists/linux/kernel/490570?#490570), but
it isn't clear. Pat suggested me using some helpers for this issue, but
it would be better if the device model can unified handle it.

>Firmware like ACPI will tell us what wake-on-lan capabilities we have.
The
>bus layer also handles much of the physical aspects.  The user will say
>that
>he or she wants the logical device "eth1", as an example, to wake up
the
>computer if any traffic is incoming.  So really all of the layers play
some
>role in wake-on-lan, right?  Is a device useful for wake-on-lan without
a
>corresponding logical ethernet device?
>
>Furthermore, it can be more complicated than just keeping it powered
on.  A
>device might need a seperate power domain to be used for wake-on-lan
than
>normal operation.  ACPI could help with this.
ACPI could help more. Many ACPI devices have specific methods, such as
Floppy, SATA, USB. We just ignored them now. It's more important for
ACPI 3.0. In ACPI 3.0, every device could have a _OSC method, and the
drivers must indicate their capability.=20

Thanks,
Shaohua


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
