From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Subject: dsdt and more
Date: 27 Oct 2002 00:57:22 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1035676644.1476.18.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-oogNxUB+MexsSwBSsGdD"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-oogNxUB+MexsSwBSsGdD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I will report all strange things acpi related in my Compaq pressario
706EA. 


./iasl -tc -i acpi_dsdt.dsl 
give me this strange error, the others error have fixes. 
acpi_dsdt.dsl   549:                     Zero 
Error    1037 -                 parse error ^ 


if I override bios with this dsdt fixed deleting or not deleting this
Zeros, my BAT is not recognized. 
without override I can read BATTERY information. 

"Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions" 


" acpi_processor-0897 [21] acpi_processor_get_per: Unsupported address
space [127] (control_register) 
ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)" 

with this new verion this mesg disappears ;), know I don't have
/proc/processor. 

acpidmp > dmp.bin 
acpidmp DSDT > DSDT.bin 
acpidmp FACP > FACP.bin 
acpidmp FACS > FACS.bin 
acpidmp FADT > FADT.bin 
acpidmp RSDP > RSDP.bin 
acpidmp RSDT > RSDT.bin 
acpidmp SSDT > SSDT.bin 
cat /proc/acpi/fadt > fadt.bin 

from dmesg: 
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f6dd0 
ACPI: RSDT (v001 PTLTD    RSDT   01540.00000) @ 0x0defb63b 
ACPI: FADT (v001 COMPAQ  EAGLES  01540.00000) @ 0x0defeeb6 
ACPI: SSDT (v001 PTLTD  POWERNOW 01540.00000) @ 0x0defef2a 
ACPI: DSDT (v001 COMAPQ   EAGLES 01540.00000) @ 0x00000000 
ACPI: Vendor "COMAPQ" System "  EAGLES" Revision 0x6040000 has a known
ACPI BIOS problem. 
ACPI: Reason: SCI issues (C2 disabled). This is a recoverable error 
ACPI: BIOS passes blacklist 


and finally 
Oct 21 03:42:57 darkstar kernel: [ACPI Debug] String: USB runtime event 
Oct 21 03:42:57 darkstar kernel: acpi_bus-0263 [15]
acpi_bus_get_device   : Error getting context for object [cde28ee8] 
Oct 21 03:42:57 darkstar kernel: hub.c: USB new device connect on
bus1/1, assigned device number 3 
Oct 21 03:42:57 darkstar kernel: usb.c: USB device 3 (vend/prod
0x5ab/0x200) is not claimed by any active driver. 


--=-oogNxUB+MexsSwBSsGdD
Content-Disposition: attachment; filename=bins.tar.gz
Content-Type: application/x-gzip; name=bins.tar.gz
Content-Transfer-Encoding: base64

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
YDAYDAaDcZrxN2WwHLwAeAAA

--=-oogNxUB+MexsSwBSsGdD--



-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
