From: root <chp802-8tGg7S+viayFxr2TtlUqVg@public.gmane.org>
Subject: Sleep button events on Compaq Evo.
Date: Wed, 30 Jul 2003 16:45:58 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F27E836.3080305@bangor.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I was just trying to get my sleep button to work, not that swsusp has
gone gold. I've got three buttons, which are controlled by acpi; Sleep,
Soft power and Lid. Kernel gives @ bootup;

ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (FF) [SLPF]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
ACPI: Thermal Zone [THRM] (59 C)

Which seems to indicate fixed-featue buttons. I've set up acpid like this;

------
event=button/lid LID.*
action=logger ACPI lid %e
------
event=button/power PWRF.*
action=logger ACPI power %e
------
event=button/sleep SLPF.*
action=logger ACPI sleep %e
------

Which makes Lid and Soft Power worky, but, alas, Sleep is noworky. I get
no events whatsoever:(. Note, though, I've yet to see any docs of how to 
setup acpid, so I'm just assuming this is right.

DSDT gives this;

Scope (_SB)
    {
        Device (SLPB)
        {
            Name (_HID, EisaId ("PNP0C0E"))
            Name (_PRW, Package (0x02)
            {
                0x01,
                0x03
            })
        }

        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C"))
            Name (_PRW, Package (0x02)
            {
                0x01,
                0x04
            })
        }

        Device (LID)
        {
            Name (_HID, EisaId ("PNP0C0D"))
            Name (_PRW, Package (0x02)
            {
                0x01,
                0x03
            })
            Method (_LID, 0, NotSerialized)
            {
                If (\_SB.PCI0.ISA.EC.ECOK)
                {
                    If (\_SB.PCI0.ISA.EC.LIDS)
                    {
                        Return (0x00)
                    }
                    Else
                    {
                        Return (0x01)
                    }
                }
                Else
                {
                    Return (0x00)
                }
            }
        }


I'm not sure where I go from here. Is this a bug, perhaps? I've
tried to see if the buttons generate and scancodes, but they don't. So I
assume they're indeed controlled by acpi directly. Cheers,

/Chris




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
