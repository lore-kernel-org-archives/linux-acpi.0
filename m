From: Stephen Early <steve-vKhv4Q37w8utmTQ+vhA3Yw@public.gmane.org>
Subject: Re: CALL FOR TESTING
Date: Sun, 22 Sep 2002 15:11:30 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3D8DCF92.1050903@greenend.org.uk>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE80@orsmsx119.jf.intel.com>
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
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Tested 2.4.19 with this patch on three machines: a Supermicro SMP board, 
a HP Pavilion N5472 laptop, and an Asus P2B board.

All three boot, assign interrupts properly (which is an improvement over 
stock 2.4.19 on the Supermicro board) and all features like buttons, 
battery info on the laptop, etc. work correctly (an improvement over the 
ACPI code in 2.4.19).

ACPI: RSDP (v000 AMI                        ) @ 0x000fb2d0
ACPI: RSDT (v001 SUPERM SUPERTBL 00000.00009) @ 0x17ff0000
ACPI: FADT (v001 SUPERM SUPERTBL 00000.00009) @ 0x17ff1000
ACPI: MADT (v001 SUPERM SUPERTBL 00000.00009) @ 0x17ff2000
ACPI: DSDT (v001 SUPERM SUPERMTB 00000.00001) @ 0x00000000

ACPI: RSDP (v000 HP-MCD                     ) @ 0x000f61b0
ACPI: RSDT (v001 HP-MCD   RSDT   01540.00000) @ 0x0f6fa497
ACPI: FADT (v001 HP-MCD GF DSDT  01540.00000) @ 0x0f6fef8c
ACPI: DSDT (v001 HP-MCD GF DSDT  01540.00000) @ 0x00000000

ACPI: RSDP (v000 ASUS                       ) @ 0x000f7f30
ACPI: RSDT (v001 ASUS   P2B      22616.11825) @ 0x07ffd000
ACPI: FADT (v001 ASUS   P2B      22616.11825) @ 0x07ffd080
ACPI: BOOT (v001 ASUS   P2B      22616.11825) @ 0x07ffd040
ACPI: DSDT (v001   ASUS P2B      00000.04096) @ 0x00000000

Stephen Early



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
