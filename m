From: =?iso-8859-1?q?Ois=EDn_Mac_Fheara=ED?= <destynova-iUB+o6dfpG8i1yMB4YHZDQ@public.gmane.org>
Subject: Acer Aspire 1705SMi LNKx?
Date: Mon, 25 Oct 2004 09:09:41 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200410250909.41761.destynova@esatclear.ie>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
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

I finally got around to compiling in my custom DSDT for my Acer Aspire 1705SMi 
laptop, and have battery giving useful information now.

However, there's still some somewhat confusing messages at bootup; can anyone 
shed some light on this - is it bad/fixable?

PCI: Ignoring BAR0-3 of IDE controller 0000:00:02.5
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
  uteval-0205: *** Error: Return object type is incorrect 
[\_SB_.PCI0.LPCB.LNKA._CRS] (Node dfdeb7a8), AE_TYPE
ACPI: PCI Interrupt Link [LNKA] (IRQs 7 10) *0
ACPI: PCI Interrupt Link [LNKB] (IRQs 3) *0, disabled.
  uteval-0205: *** Error: Return object type is incorrect 
[\_SB_.PCI0.LPCB.LNKC._CRS] (Node dfde93a8), AE_TYPE
ACPI: PCI Interrupt Link [LNKC] (IRQs 5) *0
  uteval-0205: *** Error: Return object type is incorrect 
[\_SB_.PCI0.LPCB.LNKD._CRS] (Node dfde91a8), AE_TYPE
ACPI: PCI Interrupt Link [LNKD] (IRQs 7 10) *0
  uteval-0205: *** Error: Return object type is incorrect 
[\_SB_.PCI0.LPCB.LNKE._CRS] (Node dfdeaea8), AE_TYPE
ACPI: PCI Interrupt Link [LNKE] (IRQs 7 10) *0
  uteval-0205: *** Error: Return object type is incorrect 
[\_SB_.PCI0.LPCB.LNKF._CRS] (Node dfdeaca8), AE_TYPE
ACPI: PCI Interrupt Link [LNKF] (IRQs 7 10) *0
  uteval-0205: *** Error: Return object type is incorrect 
[\_SB_.PCI0.LPCB.LNKG._CRS] (Node dfdeaaa8), AE_TYPE
ACPI: PCI Interrupt Link [LNKG] (IRQs 7 10) *0
ACPI: PCI Interrupt Link [LNKH] (IRQs 7 10) *0, disabled.

The portions of the DSDT in question are like this (in this instance, in 
Device (LNKA)):

                    Method (_CRS, 0, NotSerialized)
                    {
                        Store (Z00B, Local0)
                        CreateWordField (Local0, 0x01, IRA0)
                        If (LEqual (And (\_SB.PCI0.LPCB.PIRA, 0x80), Zero))
                        {
                            And (\_SB.PCI0.LPCB.PIRA, 0x0F, Local0)
                            ShiftLeft (0x01, Local0, IRA0)
                        }
                        Else
                        {
                            Store (0x00, IRA0)
                        }

                        Return (Local0)
                    }


Oisín


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
