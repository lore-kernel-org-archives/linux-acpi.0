From: Jurgen Kramer <gtm.kramer-c1aixF9oqgPk1uMJSBkQmQ@public.gmane.org>
Subject: Fixing my DSDT
Date: Thu, 17 Feb 2005 19:32:57 +0100
Message-ID: <1108665177.10385.2.camel@paragon.slim>
Mime-Version: 1.0
Content-Type: text/plain
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
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

When I compile a new DSDT for my HP TC1100 a get the following errors
and warnings:

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20041203 [Feb 17
2005]
Copyright (C) 2000 - 2004 Intel Corporation
Supports ACPI Specification Revision 2.0c

dsdt.dsl   209:     Method (_WAK, 1, NotSerialized)
Warning  2026 -                ^ Reserved method must return a value
(_WAK)

dsdt.dsl  2640:                     Name (_HID, "Compaq TabletPC
Buttons")
Error    1068 -                    String must be entirely alphanumeric
^  (Compaq TabletPC Buttons)

dsdt.dsl  3457:             Name (_WDG, Buffer (0x28)
Warning  2033 -                      ^ Unknown reserved name (_WDG)

dsdt.dsl  3565:             Method (_WED, 1, NotSerialized)
Warning  2033 -  Unknown reserved name ^  (_WED)

ASL Input:  dsdt.dsl - 3579 lines, 117282 bytes, 1781 keywords
Compilation complete. 1 Errors, 3 Warnings, 0 Remarks, 377 Optimizations

Is it worth trying to get these fixed?

I also trying to get brightness control working on this machine, which
is probably operated through ACPI. What should I be looking for?

Thanks

Jurgen

-- 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
