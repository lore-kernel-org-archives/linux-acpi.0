From: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Subject: NO_RETURN_VALUE w/ 20040715
Date: Fri, 20 Aug 2004 14:11:55 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1093032715.4993.60.camel@tdi>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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


   I've got one more new error going on with the new ACPI.  On bootup of
an hp rx8620 (sx1000 based ia64 system), I'm now getting a number of
these:

dswstate-0273 [18] ds_result_pop_from_bot: No result objects! State=e000072000095030
dsutils-0526 [18] ds_create_operand     : Missing or null operand, AE_AML_NO_RETURN_VALUE
psparse-1133: *** Error: Method execution failed [\_SB_.N000.S000.IOC0.L000.SSTA] (Node e0000703fef6d730), AE_AML_NO_RETURN_VALUE
psparse-1133: *** Error: Method execution failed [\_SB_.N000.S000.IOC0.L000.SBF0._STA] (Node e0000703fef6f130), AE_AML_NO_RETURN_VALUE
 uteval-0158: *** Error: Method execution failed [\_SB_.N000.S000.IOC0.L000.SBF0._STA] (Node e0000703fef6f130), AE_AML_NO_RETURN_VALUE

This did not happen w/ the previous ACPI code so I'd like to get a feel
for whether this looks like an interpreter bug or an AML bug.   The
disassembled DSDT for the _STA and SSTA methods is below.  Looks to me
like there's no way out of the SSTA method w/o a return, but then I
don't really know AML.  I can provide the entire DSDT if this isn't
sufficient.  Thanks,

	Alex

Method (SSTA, 0, NotSerialized)
{
    Acquire (MCTX, 0xFFFF)
    Store (0x0F, CSTS)
    If (LNot (LEqual (PRES (), Ones)))
    {
        Store (0x00, CSTS)
        Release (MCTX)
        Return (ToInteger (CSTS, Local0))
    }
    If (LNot (LEqual (PCHK (), Ones)))
    {
         Store (0x00, GOOD)
         Store (0x00, LIVE)
         Store (0x00, SEEN)
         Release (MCTX)
         Return (ToInteger (CSTS, Local0))
    }
    If (LEqual (RC, 0x00))
    {
        Store (BSTR, Local0)
    }
    Else
    {
        Store (0x00, Local0)
    }
    If (LEqual (Local0, 0x00))
    {
        Store (0x01, GOOD)
    }
    Release (MCTX)
    Return (ToInteger (CSTS, Local0))
}
...
Device (SBF0)
{
    ...
    Method (_STA, 0, NotSerialized)
    {
        Return (^^SSTA ())
    }
}

-- 
Alex Williamson                             HP Linux & Open Source Lab



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
