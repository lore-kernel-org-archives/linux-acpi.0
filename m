From: Mark Stocker <mark-pX1FbxK42pU@public.gmane.org>
Subject: DSDT problems
Date: Fri, 16 May 2003 06:21:25 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200305160621.25645.mark@ale8.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hi!  i've been working for a while now on getting acpi functioning completly 
on my toshiba satellite 1625CDT.  I was having problems with the fan and 
thermal zone, both of which i've fixed in the DSDT by removing these if 
statements from the fan control methods and _TMP method in the TZ.

 If (LAnd (\_SB.PCI0.ISA.ECOK (), LEqual (ECDY, 0x00))) {}

i dont know what these statements are for, the best i can guess is ECOK 
meaning if the EC is ready to be accessed?

the ECOK method is:

                Method (ECOK, 0, NotSerialized)
                {
                    If (LAnd (And (\_SB.PCI0.ISA.EC0.OPRG, 0x08), And (MFLG, 
0x01)))
                    {
                        Return (0x01)
                    }
                    Else
                    {
                        Return (0x00)
                    }
                }

It seems anything that checks ECOK will not work properly.  is it dangerous to 
remove the if statements like i have done?  I've tried editing the ECOK 
method but nothing seems to help.
The only problem im still having is battery info.  Battery shows as present no 
matter what.  Removing the ECOK statements from the BAT0 device compiles DSDT 
with no errors but i get this at boot:

Executing all Device _STA and_INI methods:...evregion-0251 [23] 
ev_address_space
_dispa: no handler for region(cbfce7c8) [EmbeddedControl]
 exfldio-0235 [22] ex_access_region      : Region EmbeddedControl(3) has no 
hand
ler
 psparse-1121: *** Error: Method execution failed [\_SB_.BAT0._STA] (Node 
cbfe39
68), AE_NOT_EXIST
  uteval-0098: *** Error: Method execution failed [\_SB_.BAT0._STA] (Node 
cbfe39
68), AE_NOT_EXIST

battery info no longer shows up under /proc/acpi when i get the errors above.
i cant think of anything else to try for now, any help or suggestions would be 
greatly appreciated!

oringal DSDT.dsl: 
http://www.cykotix.com/~mark/toshiba_satellite_162CDT_dsdt_original.dsl

my modified version:
http://www.cykotix.com/~mark/toshiba_satellite_1625CDT_custom.dsl

Thanks!



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
