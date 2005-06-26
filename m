From: Damian <res0d26i-H+0wwilmMs3R7s880joybQ@public.gmane.org>
Subject: acer aspire dsdt error
Date: Sat, 25 Jun 2005 20:47:16 -0700
Message-ID: <1119757636.7402.4.camel@localhost.localdomain>
Reply-To: res0d26i-H+0wwilmMs3R7s880joybQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I own an Acer Aspire 3000 which I'm trying to compile a correct dsdt but
am getting the following errors from the supposed corrected dsdt. I have
tried fixing the error by adding External (\_OSI) but it created yet
another error that wasn't documented on the guide. So here is the file
untouched by me so I can't mess things up even more. This is what
happens when I try to compile it...Please I don't know what more to do.
Thanks for your time, any info is highly appreciated.

Damian

damian@opstand:~/ACER$ ./iasl -tc
ACER-Aspire_3002LCI_or_3000-Phoenix_3A16-original.asl

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20050513 [Jun 25
2005]
Copyright (C) 2000 - 2005 Intel Corporation
Supports ACPI Specification Revision 3.0

ACER-Aspire_3002LCI_or_3000-Phoenix_3A16-original.asl  2506:          If
(LNot (LEqual (\_PR.CPU0._PPC, Zero)))
Error    1022 -                   Object does not exist ^
(\_PR.CPU0._PPC)

ACER-Aspire_3002LCI_or_3000-Phoenix_3A16-original.asl  2508:
Store (Zero, \_PR.CPU0._PPC)
Error    1022 -                  Object does not exist ^
(\_PR.CPU0._PPC)

ACER-Aspire_3002LCI_or_3000-Phoenix_3A16-original.asl  2516:          If
(LLess (\_PR.CPU0._PPC, Local1))
Error    1022 -            Object does not exist ^  (\_PR.CPU0._PPC)

ACER-Aspire_3002LCI_or_3000-Phoenix_3A16-original.asl  2518:
Store (Local1, \_PR.CPU0._PPC)
Error    1022 -                    Object does not exist ^
(\_PR.CPU0._PPC)

ACER-Aspire_3002LCI_or_3000-Phoenix_3A16-original.asl  2528:      If
(LNot (LEqual (\_PR.CPU0._PPC, Zero)))
Error    1022 -               Object does not exist ^  (\_PR.CPU0._PPC)

ACER-Aspire_3002LCI_or_3000-Phoenix_3A16-original.asl  2530:
Store (Zero, \_PR.CPU0._PPC)
Error    1022 -              Object does not exist ^  (\_PR.CPU0._PPC)

ASL Input:  ACER-Aspire_3002LCI_or_3000-Phoenix_3A16-original.asl - 3466
lines, 119524 bytes, 1556 keywords
Compilation complete. 6 Errors, 0 Warnings, 0 Remarks, 3 Optimizations




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
