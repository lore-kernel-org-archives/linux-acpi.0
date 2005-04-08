From: Sebastian <sebastian_ml-hi6Y0CQ0nG0@public.gmane.org>
Subject: DSDT properly fixed?
Date: Fri, 08 Apr 2005 18:31:52 +0200
Message-ID: <4256B1F8.6010300@gmx.net>
Reply-To: sebastian_ml-hi6Y0CQ0nG0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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

Dear list,

I'd like to know if I properly fixed my motherboards dsdt before I
upload it. It's from a Shuttle AN35N NForce2 board.

Original DSDT:

./iasl -tc dsdt.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20050309 [Apr  8 2005]
Copyright (C) 2000 - 2005 Intel Corporation
Supports ACPI Specification Revision 3.0

dsdt.dsl   357:     Method (\_WAK, 1, NotSerialized)
Warning  2026 -                 ^ Reserved method must return a value (_WAK)

dsdt.dsl  4402:                     Store (Local0, Local0)
Error    1013 -                                 ^ Method local variable
is not initialized (Local0)

ASL Input:  dsdt.dsl - 5049 lines, 145160 bytes, 1988 keywords
Compilation complete. 1 Errors, 1 Warnings, 0 Remarks, 483 Optimizations

Offending line 357:

Method (\_WAK, 1, NotSerialized)
    {
        Store (0xFF, DBG1)
        Store (0x00, SFLG)
        And (GP36, 0xF0, GP36)
        Or (GP36, 0x05, GP36)
        Store (0x14, SIDX)
        Store (SDTA, Local0)
        Or (Local0, 0x02, Local0)
        Store (Local0, SDTA)
        Store (0xFF, ACPX)
        If (LEqual (RTCW, 0x00))
        {
            Notify (\_SB.PWRB, 0x02)
        }

        Notify (\_SB.PCI0.USB0, 0x00)
        Notify (\_SB.PCI0.USB1, 0x00)
        Store (\_SB.PCI0.CTL0, Local0)
        And (Local0, 0xFBFFFFFF, Local0)
        Store (Local0, \_SB.PCI0.CTL0)
        If (LNot (LLess (OSFL, 0x01)))
        {
            Store (0x00, \_SB.PCI0.SMB0.SMPM)
            Store (0x5000, \_SB.PCI0.SMB0.SB1)
            Store (0x5100, \_SB.PCI0.SMB0.SB2)
        }
    }

I added the line

Return(Package(0x02){0x00, 0x00})

before the last '}'

Offending line 4402:

Method (_DIS, 0, NotSerialized)
                {
                    If (LEqual (DISE, 0x01))
                    {
                        ENFG ()
                        Store (0x02, LDN)
                        Store (Zero, ACTR)
                        EXFG ()
                        DISD (0x01)
                    }

                    Store (Local0, Local0)
                }

I changed the second line from the bottom to

Store (0x00, Local0)

Recompiling dsdt.dsl now doesn't give any warnings/errors:

./iasl -tc dsdt.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20050309 [Apr  8 2005]
Copyright (C) 2000 - 2005 Intel Corporation
Supports ACPI Specification Revision 3.0

ASL Input:  dsdt.dsl - 5055 lines, 144252 bytes, 1989 keywords
AML Output: DSDT.aml - 16995 bytes 803 named objects 1186 executable opcodes

Compilation complete. 0 Errors, 0 Warnings, 0 Remarks, 0 Optimizations


But is this the proper way to fix this? I'd like to know before I upload
to acpi.sf.net. Could you please check?

Also in case you want to have a look at the complete dsdt please say so
and I will mail it bzipped (~10kb).

Greetings

Sebastian


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
