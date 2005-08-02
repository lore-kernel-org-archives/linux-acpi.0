From: Florian Schricker <fschricker-S0/GAf8tV78@public.gmane.org>
Subject: acpi_ec_space_handler flooding logs
Date: Tue, 02 Aug 2005 18:36:13 +0200
Message-ID: <1123000573.12447.15.camel@x10>
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

Hello everybody!


I have quite some trouble with ACPI / DSDT and with my hddisk - and
quite frankly I'm a bit lost. :-(

Well, looong story short: I had previously a self-repaired DSDT in my
initrd which I suspect of being the cause of quite some trouble. I am
unsure if this can be possible, but I thought it'd be best to at least
fall back to the "integrated" one.

Although all ACPI modules load fine (I'm on a 2.6.12 kernel), I have
trouble with my battery - I had this before, and to be honest, I'd very
much appreciate any professional help on fixing it (I suspect _me_ being
the cause of troubles first)!

For that I extracted my DSDT, disassembled it using iasl and, for
testing purposes, I recompiled it.

Both files are accessible:
 - raw data from /proc/acpi/dsdt
     http://www.uni-koblenz.de/~eyerq/dsdt-samsung.dat
 - dissambled DSDT source
     http://www.uni-koblenz.de/~eyerq/dsdt-samsung.dsl

Recompiling gives:

-------
# ./iasl dsdt-samsung.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20030918 [Sep 18
2003]
Copyright (C) 2000 - 2003 Intel Corporation
Supports ACPI Specification Revision 2.0b

dsdt-samsung.dsl   312:     Method (_WAK, 1, NotSerialized)
Warning  2026 -                        ^ Reserved method must return a
value (_WAK)

dsdt-samsung.dsl  2577:                     Field (ECR, DWordAcc, Lock,
Preserve)
Error    1048 -                                      ^ Host Operation
Region requires ByteAcc access

dsdt-samsung.dsl  2623:                     Method (_GLK, 1,
NotSerialized)
Warning  2024 - Reserved method has too many arguments ^  ( _GLK
requires 0)

ASL Input:  dsdt-samsung.dsl - 3748 lines, 125559 bytes, 1798 keywords
Compilation complete. 1 Errors, 2 Warnings, 0 Remarks, 410 Optimizations
-------

This broken DSDT is currently active, fails with battery as mentioned -
and: floods dmesg / /var/log/messages with

  ACPI: acpi_ec_space_handler: bit_width should be 8

Is this something known?
What would I need to fix the DSDT? Anything I can provide?


thank you - and hopefully this the correct list
Florian Schricker



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
