From: "Tommy Ch." <tommy-c-hi6Y0CQ0nG0@public.gmane.org>
Subject: Req: debug dsdt of Toshiba M30
Date: Sat, 26 Feb 2005 20:41:03 +0100
Message-ID: <4220D0CF.3090705@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi!

I'm new to the list and I would like to request your help. I'm glad that 
some time ago I got setting the brightness working with the help of .. 
erm, I think it was Bruno Ducrot. I send him my DSDT or something. Since 
this time I learned a lot about that stuff and now need some help in 
debugging the DSDT of my Toshiba M30 Laptop. Trying to compile it with 
the intel compiler I get the following errors:

./iasl -tc dsdt.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20050211 [Feb 25 2005]
Copyright (C) 2000 - 2005 Intel Corporation
Supports ACPI Specification Revision 3.0

dsdt.dsl  1579:                                 Notify (\_PR.CPU0, 0x80)
Error    1022 -                           Object does not exist ^ 
(\_PR.CPU0)

dsdt.dsl  1684:                                 Notify (\_PR.CPU0, 0x80)
Error    1022 -                           Object does not exist ^ 
(\_PR.CPU0)

dsdt.dsl  3928:                     Notify (\_PR.CPU0, Local0)
Error    1022 -               Object does not exist ^  (\_PR.CPU0)

dsdt.dsl  4053:                 \_PR.CPU0
Error    1022 -   Object does not exist ^  (\_PR.CPU0)

dsdt.dsl  4079:                     Notify (\_PR.CPU0, 0x80)
Error    1022 -               Object does not exist ^  (\_PR.CPU0)

dsdt.dsl  4250:     Method (_WAK, 1, NotSerialized)
Warning  2026 -                ^ Reserved method must return a value (_WAK)

dsdt.dsl  4275:                 Notify (\_PR.CPU0, 0x80)
Error    1022 -           Object does not exist ^  (\_PR.CPU0)

ASL Input:  dsdt.dsl - 4509 lines, 154290 bytes, 2025 keywords
Compilation complete. 6 Errors, 1 Warnings, 0 Remarks, 690 Optimizations

-------------

I already searched the internet to find common solutions for problems 
like this, but I couldn't find anything but a solution for the warning.
Looking in the disassembly I found this concerning the errors:

  Name (_PSL, Package (0x01)
             {
                 \_PR.CPU0
             })

There were no other occurencies of PR.CPU0 than this and in the error lines.

Do you have any ideas? Is it worth correcting these errors? Can you tell 
if it will have any advantages? This is the context of one of the error 
lines:

Method (_PS0, 0, Serialized)
  {
    Store (0x00, \_SB.MEM.CRTS)
    If (LEqual (\_SB.MEM.RPPC, 0x01))
      {
       Notify (\_PR.CPU0, 0x80)
       Store (0x00, \_SB.MEM.RPPC)
      }
}


And perhaps: can anybody tell me why it isn't possible to switch CRT or 
S-VIDEO on with the toshiba acpi driver? Is it possible to see this from 
the disassembly?

The file http://www.uni-koblenz.de/~tenshi/toshm30dsdt.tar.gz includes 
all the necessary files: dsdt.hex, dsdt.dsl, errors.txt


Thank you very much for any help!

Greetings,
   Thomas Ch.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
