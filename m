From: Toni Erdmann <toni.erdmann-S0/GAf8tV78@public.gmane.org>
Subject: mobo A7V600-F and problems with sound
Date: Sun, 22 Feb 2004 20:07:07 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4038FDDB.8090807@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hello,

Sound is not working with my SuSE Linux 9.0 with 2.4.21-166-athlon
on an ASUS A7V600-F (FSB333).

I found the following messages in 'dmesg'

ACPI: Unable to set IRQ for PCI Interrupt Link [LNKH] (likely buggy
      ACPI BIOS, please report to acpi-devel!)
...
IRQ routing conflict for 00:10.0, have irq 5, want irq 3
...
ALSA via82xx.c:520: codec_valid: codec 0 is not valid [0xfe0000]

Last one probably means that the kernel can't contact sound chip

I packed all Information into a tar ball as supposed for a
bugzilla entry, but want to avoind sending 22K to the list.

I didn't find an entry in bugzilla related to this here.

What shall I do? Shall I post a report?

Toni




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
