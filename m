From: "Pedro I. Sanchez" <pedro.sanchez-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>
Subject: Help with the DSDT for an Acer Ferrari 3400 laptop
Date: Tue, 28 Dec 2004 00:38:37 -0500
Message-ID: <41D0F15D.8000201@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

I'm new to this ACPI world and I'd like your help to fix the dsdt.dsl 
file that I got with this laptop. I followed the steps in the ACPI FAQ 
to disassemble the bin file and ended up with a source file that 
compiles with 8 errors and 1 warning using the Intel ASL compiler.

For your reference the problem I want to fix is that I have no control 
over the fan which is always on, quite annoying. Even though my Linux 
kernel has compiled ACPI fan support the directory /proc/acpi/fan is 
empty. I'm running vanilla kernel 2.6.10 with Debian-AMD64.

The good news is that the 8 errors are actually the same one spread all 
over the source file. So fixing it once will fix the whole file. The bad 
news is that I don't know how to fix it :|

The Error
---------
dsdt.dsl  4480:           If (LLess (\_PR.CPU0._PPC, Local1))
Error    1022 -             Object does not exist ^  (\_PR.CPU0._PPC)

The error is repeated every time the object \_PR.CPU0._PPC appears in 
the code. I read in the FAQ that one possible solution is to use the 
statement

	External(\_PR.CPU0._PPC)

to tell the compiler that this is an external object. However I don't 
understand where this External statement should go. I've tried putting 
it at the beginning of the file and inside the Scope(\_PR) section which 
simply reads

	Scope (\_PR)
	{
	   Processor (CPU0, 0x00, 0x00004010, 0x06) {}
	}

In both cases the compiler complains. So, where shall this External 
statement go?

The Warning
-----------
dsdt.dsl  4287: Method (SMSL, 0, NotSerialized)
Warning  2019 -            ^ Not all control paths return a value (SMSL)

I added a Return (0x00) statement at the very end of the method and the 
warning disappeared. But, is this right? Following my signature you will 
find the code of the offending method including my extra line.


Thanks in advance for any advice you can give me.

-- 
Pedro



                     Name (ACFL, 0x00)
                     Method (SMSL, 0, NotSerialized)
                     {
                         Store ("CMBatt - SMSL", Debug)
                         If (LEqual (\_SB.ECOK, 0x00))
                         {
                             Return (0xFF)
                         }

                         Acquire (\_SB.PCI0.PIB.EC0.MUT1, 0xFFFF)
                         If (LNot (\_SB.PCI0.PIB.EC0.SMRD (0x09, 0x14, 
0x01, RefOf (Local0))))
                         {
                             Store (Local0, SEL0)
                             Store (SEL0, Debug)
                             If (LEqual (ALRT, 0x01))
                             {
                                 \_SB.BAT1.IVBI ()
                                 \_SB.BAT1.IVBS ()
                                 Store (0x00, ALRT)
                             }

                             Store (\_SB.ACAD.CHAC (SEL0), Local1)
                             Store (\_SB.BAT1.CHBP (SEL0), Local2)
                             Or (SEL0, 0x0FFF, Local0)
                             SMWR (0x08, 0x14, 0x01, Local0)
                             If (LAnd (Local1, \_SB.ACAD.ACP))
                             {
                                 Store ("CMBatt - Notify(ACAD,0x80): 
AC_Inserted", Debug)
                                 Notify (\_SB.ACAD, 0x80)
                                 Store (0x02, ACFL)
                             }

                             If (And (0x04, Local2))
                             {
                                 \_SB.BAT1.B1CK ()
                             }

                             If (And (0x02, Local2))
                             {
                                 \_SB.BAT1.B1ST ()
                             }

                             If (And (0x01, Local2))
                             {
                                 \_SB.BAT1.B1IF ()
                             }

                             If (LAnd (Local1, LNot (\_SB.ACAD.ACP)))
                             {
                                 Store ("CMBatt - Notify(ACAD, 0x80): 
AC_Removed", Debug)
                                 Notify (\_SB.ACAD, 0x80)
                                 Store (0x01, ACFL)
                             }
                         }

                         Store (0x3C, Local4)
                         If (\_SB.BAT1.REPT)
                         {
                             Store (0x02, Local4)
                         }

                         If (BFLG)
                         {
                             Store (0x01, Local5)
                             While (LNot (And (BFLG, 0x01)))
                             {
                                 Increment (Local5)
                                 ShiftRight (BFLG, 0x01, BFLG)
                             }

                             ShiftRight (BFLG, 0x01, BFLG)
                             If (LGreater (Local4, Local5))
                             {
                                 Store (Local5, Local4)
                             }
                         }

                         Store (Local4, BPD)
                         BPOL ()
                         Release (\_SB.PCI0.PIB.EC0.MUT1)
                         If (ACFL)
                         {
                             Decrement (ACFL)
                             Store (0x00, ACFL)
                         }
                         Return (0x00)
                     }



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
