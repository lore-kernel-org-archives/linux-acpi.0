From: Luca <kronos-0Y2hHv2PMqFeoWH0uzbU5w@public.gmane.org>
Subject: Questions about DSDT
Date: Fri, 6 Feb 2004 21:55:00 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040206205500.GA16431@dreamland.darkstar.lan>
Reply-To: kronos-0Y2hHv2PMqFeoWH0uzbU5w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
I have some questions about DSDT:

1) My notebook [1] has a broken DSDT:

ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Fan [FAN0] (on)
acpi_processor-1626 [38] acpi_processor_get_inf: Invalid PBLK length [5]
ACPI: Processor [CPU0] (supports C1)
ACPI: Thermal Zone [THRM] (56 C)
Asus Laptop ACPI Extras version 0.26
  L3D model detected, supported

C2 is not recognized. Fixing it is quite simple. This is from the
original DSDT:

DefinitionBlock ("DSDT.aml", "DSDT", 1, "ASUS", "L3000D  ", 4096)
{
[cut]
    Scope (_PR)
    {
        Processor (CPU0, 0x01, 0x0000E410, 0x05)
        {
            Name (PSBT, Package (0x20)
            {
[cut]
            })
            Name (_PCT, Package (0x02)
            {
[cut]
            })
            Method (_PSS, 0, NotSerialized)
            {
[cut]
            }

            Method (_PPC, 0, NotSerialized)
            {
[cut]
            }

            Method (TCTR, 2, NotSerialized)
            {
[cut]
            }

            Method (TSTA, 2, NotSerialized)
            {
[cut]
            }
        }
    }


I patched it in this way:

--- dsdt-0113.dsl	Fri Feb  6 21:45:41 2004
+++ dsdt-hack-0113.dsl	Fri Feb  6 21:44:22 2004
@@ -43,7 +43,7 @@
     })
     Scope (_PR)
     {
-        Processor (CPU0, 0x01, 0x0000E410, 0x05)
+        Processor (CPU0, 0x01, 0x0000E410, 0x06)
         {
             Name (PSBT, Package (0x20)
             {


looks good? It seems to work:

ACPI: Subsystem revision 20040116
   tbget-0291: *** Info: Table [DSDT] replaced by host OS
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
[...]
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Fan [FAN0] (on)
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Thermal Zone [THRM] (32 C)
Asus Laptop ACPI Extras version 0.26
  L3D model detected, supported

2) In the DSDTs repository I see a custom DSDT for my laptop, but for an
older version of  the BIOS (I does work though). The  only difference is
that it adds Linux to the list  of know OS. What are the effects of this
change?

3) Should I upload original and hacked DSDT to acpi.sf.net?

4) How do I send the patch to ASUS? I just send an email to the support
explaining the problem or...?

[1] Notebook is an ASUS L3350D (L3D serie), BIOS 0113.

TIA,
Luca
-- 
Reply-To: kronos-OwEdLhkac/ZLIFpYAn0waQ@public.gmane.org
Home: http://kronoz.cjb.net
The trouble with computers is that they do what you tell them, 
not what you want.
D. Cohen


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
