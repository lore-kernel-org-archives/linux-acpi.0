From: Robert Woerle Paceblade/Support <robert-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org>
Subject: could not map ACPI
Date: Tue, 21 Jan 2003 12:52:17 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E2D3471.1070307@paceblade.com>
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

Hi

When i use mem=XXXM ACPI works fine , BUT i get cruel crashes when using 
  Sound and Ethernet or/and usb togethere ( they all have IRQ 5 ) one 
device alone is fine .
When i dont use mem=XXXM i get an error at /drivers/acpi/tables/tb_get.c
BUT all the devices work fine , even together !!!
i tried also mem=XXXM + acpi=nopci  which gives the same result : ACPI 
works and the devices crash together ....
the machine is a Transmeta driving machine ...

So when i look at tb_get.c at the specific functions...
i see that it maps the pointers there according to a 
switch(adress->pointer) call !
Is possible that it normally uses the
case ACPI_LOGMODE_PHYSPTR:
stuff but when i use mem=XXX
it might use the other case statement:
case ACPI_LOGMODE_LOGPTR:

can i make a cruel hack around that that it always uses the working one ???

The aim is of course to get both variants together : ACPI working + 
DEvices not crashing !!
Please advice !!!




---tb_get.c---- where it bails out--------

		status = acpi_os_map_memory (address->pointer.physical, sizeof 
(acpi_table_header),
				  (void **) &header);
		if (ACPI_FAILURE (status)) {
			ACPI_REPORT_ERROR (("Could not map memory at %8.8X%8.8X for length %X\n",
				ACPI_HIDWORD (address->pointer.physical),
				ACPI_LODWORD (address->pointer.physical),
				sizeof (acpi_table_header)));
			return_ACPI_STATUS (status);
		}



-

_____________________________________
*Robert Woerle
**Technical Support | Linux
PaceBlade Technology Europe SA*
phone: +49 89 552 99935
fax: +49 89 552 99910
mobile: +49 179 474 45 27
email: robert-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org <mailto:robert@paceblade.com>
web: http://www.paceblade.com
_____________________________________







-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
