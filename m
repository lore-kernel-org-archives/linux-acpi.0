From: Stephen L Johnson <sjohnson-WpdXj7kV/NVg9hUCZPvPmw@public.gmane.org>
Subject: Interrupt Routing
Date: 10 Jan 2003 14:59:12 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1042232352.2868.31.camel@rodan.monsters.org>
Mime-Version: 1.0
Content-Type: text/plain
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
To: ACPI Dev Mailing List <acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Somewhere along the way, the interrupt routing on my laptopn has gone
back to cramming everything onto the same interrupt. Here is my
/proc/interrupts output:

sjohnson@rodan:~> cat /proc/interrupts 
           CPU0       
  0:     565260          XT-PIC  timer
  1:       6943          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  9:      72990          XT-PIC  acpi, ohci1394, usb-uhci, usb-uhci,
usb-uhci, Ricoh Co Ltd RL5c475, Texas Instruments PCI1410 PC card
Cardbus Controller, Intel 82801CA-ICH3, eth0
 11:        484          XT-PIC  sonypi
 12:      76803          XT-PIC  PS/2 Mouse
 14:      29615          XT-PIC  ide0
NMI:          0 
LOC:     565211 
ERR:          0
MIS:          0

This is on a Sony Vaio R505-ES running 2.4.20 with acpi-20021212.


-- 
Stephen L Johnson <sjohnson-WpdXj7kV/NVg9hUCZPvPmw@public.gmane.org>



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
