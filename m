From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Error starting acpi with 2.4.19
Date: Wed, 4 Sep 2002 14:43:32 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19B756@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: 'John M Trostel' <john.trostel-+vhbC7un7QRBDgjK7y7TUQ@public.gmane.org>, ACPI-list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


This sounds like your machine has bad ASL of the form:

Name (DEB, 4)
Scope (DEB)
{
}

DEB can't be both an Integer and a Scope.

What type of machine is this?
Bob


-----Original Message-----
From: John M Trostel [mailto:john.trostel-+vhbC7un7QRBDgjK7y7TUQ@public.gmane.org] 
Sent: Wednesday, September 04, 2002 1:26 PM
To: ACPI-list
Subject: [ACPI] Error starting acpi with 2.4.19

I am having problems getting ACPI started using the latest SGI XFS
kernel (2.4.19) with patches sergiomb added. 

I get the following output on bootup: 


ACPI: Subsystem revision 20020829 
PCI: PCI BIOS revision 2.10 entry at 0xfdb31, last bus=1 
PCI: Using configuration type 1 
tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully
loaded 
dswload-0210: *** Error: Invalid type (Integer) for target of Scope
operator [DEB_] 
psparse-0570 [10] Ps_parse_loop         : During name lookup/catalog,
AE_AML_OPERAND_TYPE 
tbxface-0107: *** Error: Acpi_load_tables: Could not load namespace:
AE_AML_OPERAND_TYPE 
tbxface-0116: *** Error: Acpi_load_tables: Could not load tables:
AE_AML_OPERAND_TYPE 
ACPI: Unable to load the System Description Tables 
PCI: Probing PCI hardware 
PCI: ACPI tables contain no PCI IRQ routing entries 
PCI: Probing PCI hardware (bus 00) 
PCI: Discovered primary peer bus 01 [IRQ] 
Linux NET4.0 for Linux 2.4 

later in the boot process I see: 

Starting acpid: acpid: can't open /proc/acpi/event: No such file or
directory 
[FAILED] 

Which is unfortunate, as I would like to use acpid ;-> 

I see no acpi(d) process running and there is no /proc/acpi subdirectory
created... What do I need to do to debug this situation 

-- 
John M. Trostel
Senior Software Engineer
Quantum Corp.
john.trostel-+vhbC7un7QRBDgjK7y7TUQ@public.gmane.org
-- 
John M. Trostel
Senior Software Engineer
Quantum Corp.
john.trostel-+vhbC7un7QRBDgjK7y7TUQ@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
