From: Greg Alexander <gre-VobwYXd2LmVM656bX5wj8A@public.gmane.org>
Subject: IASL bug with big constants?
Date: Sat, 2 Oct 2004 12:12:32 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041002171232.GA11585@goonies.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hi -

I hope this hasn't already been addressed.  I skimmed the logs and the
buggy version appears to still be on Intel's site...

I see the trouble in constants in OperationRegions generally getting
cut to one-byte.  i.e.:

---
DefinitionBlock ("DSDT.aml", "DSDT", 1, "VIA", "VIA_K7", 4096)
{
    ....
    OperationRegion (M4D0, SystemMemory, 0x04D0, 0x0B)
    Field (M4D0, ByteAcc, NoLock, Preserve)
    {
        ....
    }
}
---

when I assembled then disassembled that with the 20040715 version of
iasl, I got:

---
DefinitionBlock ("DSDT.aml", "DSDT", 1, "VIA", "VIA_K7", 4096)
{
    ....
    OperationRegion (M4D0, SystemMemory, 0xD0, 0x0B)	/* should be 0x04D0 */
    Field (M4D0, ByteAcc, NoLock, Preserve)
    {
        ....
    }
}
---

Note the 0xD0 where 0x04D0 is expected!  My laptop manufacturer put
NVRAM at 0x4D0.  They did not put it at 0xD0.

I tracked it down to the following code in
acpica/compiler/aslopcodes.c line 209 in OpcSetOptimalIntegerSize(),
at the very beginning:

---
    if (Op->Asl.Parent &&
        Op->Asl.Parent->Asl.Parent &&
        (Op->Asl.Parent->Asl.Parent->Asl.ParseOpcode == PARSEOP_DEFINITIONBLOCK))
    {
        return 0;
    }
---

The parent is the OperationRegion, the parent's parent is the
DefinitionBlock, so it doesn't generate a size for the opcode.  
So it gets the default from aslmap.c line 520:

   /* INTEGER */ OP_TABLE_ENTRY (AML_BYTE_OP, 0, 0, ACPI_BTYPE_INTEGER),

It defaults to a byte!  I looked in the changelog and I suspect this
corresponds to the following entry:

   Eliminated optimization messages for "_T_x" objects and small
   constants within the DefinitionBlock operator.

Why don't you want to optimize small constants within the
DefinitionBlock operator?  Why only when it's nested?  Why not test a
change at least once before sending it to customers?  Since the
change is both broken and meaningless to me, I simply removed the
offending piece of code and now OpcSetOptimalIntegerSize() does its
job appropriately and my DSDT works.  If we really don't want to
optimize them, perhaps we should set a better default, like
AML_DWORD_OP?

This is a MOST frustrating bug to track down -- I had so little faith
in my BIOS vendor that I thought they had enough non-standard crap
jammed in there that recompiling my DSDT was expected to fail.

Sure takes the joy out of bashing the Microsoft compiler.

Nonetheless, thanks for the tools.  I never could have fixed my laptop
without iasl.


Cheers,
- Greg


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
