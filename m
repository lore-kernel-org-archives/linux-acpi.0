From: Herman Sheremetyev <hsheremetyev-yhWOWVs/RhdYAqn04ObX1A@public.gmane.org>
Subject: executing aliased methods
Date: Wed, 24 Mar 2004 10:33:47 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1080142427.1770.84.camel@cheez>
References: <1080126326.2271.25.camel@eva.ecr.navy.mil>
Reply-To: herman-yhWOWVs/RhdYAqn04ObX1A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1080126326.2271.25.camel-w5mZ+H5JyiYmhCb6mdbn6A@public.gmane.org>
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

Hi All,

I'm using an Asus M6N notebook running kernel 2.6.3 with the ecdt patch
and a custom DSDT.  The main reason I need this custom DSDT at the
moment is that the one shipped in the BIOS has method calls which are
being called through an alias and therefore fail to be resolved on linux
(and freebsd).  Here's the relevant code from the iasl disassembly:

 Alias (PCI0.SBRG.EC0.ECAV, ECAV)
 Alias (PCI0.SBRG.EC0.ACS, ACS)
 Alias (PCI0.SBRG.EC0.BATS, BATS)

Then later on you see method calls like this:

 If (BATS ())
 {
    Return (PAK0)
 }

Calls like this fail during ACPI startup, here is a section of the
dmesg:
-----------------------------------------------------------------------------------------------
Executing all Device _STA and_INI
methods:..............................................  psargs-0352: ***
Error: Looking up [ECFL] in namespace, AE_NOT_FOUND
search_node c15663a8 start_node c15663a8 return_node 00000000
 psparse-1120: *** Error: Method execution failed [\_SB_.ECAV] (Node c15663a8), AE_NOT_FOUND
 psparse-1120: *** Error: Method execution failed [\_SB_.ACS_] (Node c1566328), AE_NOT_FOUND
 psparse-1120: *** Error: Method execution failed [\_SB_.AC__._INI] (Node c15655a8), AE_NOT_FOUND
..  psargs-0352: *** Error: Looking up [ECFL] in namespace, AE_NOT_FOUND
search_node c15663a8 start_node c15663a8 return_node 00000000
 psparse-1120: *** Error: Method execution failed [\_SB_.ECAV] (Node c15663a8), AE_NOT_FOUND
 psparse-1120: *** Error: Method execution failed [\_SB_.BATS] (Node c15662a8), AE_NOT_FOUND
 psparse-1120: *** Error: Method execution failed [\_SB_.BAT0._STA] (Node c155c4a8), AE_NOT_FOUND
------------------------------------------------------------------------------------------------

If I comment off the Alias statements and change the method calls
to use the full method name then the errors in dmesg go away and 
things work much better as a result (battery status specifically).  

I have links to the full DSDT and dmesg output here:

http://mrhammy2.ath.cx:81/dsdt.M6N0206A
http://mrhammy2.ath.cx:81/dmesg.M6N0206A

The way to fix the DSDT by replacing the Alias methods was actually 
brought to my attention by Andreas Dieling so I don't want to take 
credit for it.  I haven't looked at ACPI code too much myself but I'm 
curious if there is a way this can be resolved?  I'm willing to 
beta-test and maybe even write a bit of code if somebody points me in
the right direction.

Thanks,

-Herman



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
