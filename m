From: Hrvoje Habjanic <hrvoje.habjanic-wUpq2f5uKgb0NTdHYsHBKg@public.gmane.org>
Subject: Method execution failed, AE_AML_BUFFER_LIMIT
Date: Mon, 23 Jun 2003 14:00:25 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200306231400.25347.hrvoje.habjanic@zg.hinet.hr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
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


Hi!

My Compaq Armada M700 with acpi-20030522 didn't had those errors:

[snip]
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4bios S4 S5)
dsopcode-0515 [20] ds_init_buffer_field  : Field size 1184 exceeds Buffer size 1088 (bits)
 psparse-1121: *** Error: Method execution failed [\_SB_.C005.C00B] (Node c12d3f88), AE_AML_BUFFER_LIMIT
 psparse-1121: *** Error: Method execution failed [\_SB_.C005.C00F] (Node c12d2148), AE_AML_BUFFER_LIMIT
 psparse-1121: *** Error: Method execution failed [\_SB_.C005._CRS] (Node c12d2248), AE_AML_BUFFER_LIMIT
  uteval-0098: *** Error: Method execution failed [\_SB_.C005._CRS] (Node c12d2248), AE_AML_BUFFER_LIMIT
ACPI: PCI Root Bridge [C005] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Power Resource [C13C] (on)
[snip]

Full info on http://free-zg.htnet.hr/HrvojeHabjanic/acpi .


Hrvoje



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
