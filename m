From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: acpi_ec_space_handler flooding logs
Date: Fri, 12 Aug 2005 10:21:33 +0200
Message-ID: <42FC5C0D.4010907@suse.de>
References: <1123000573.12447.15.camel@x10>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1123000573.12447.15.camel@x10>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Florian Schricker <fschricker-S0/GAf8tV78@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Florian Schricker wrote:
> Hello everybody!
> 
...
> Intel ACPI Component Architecture
> ASL Optimizing Compiler / AML Disassembler version 20030918 [Sep 18
> 2003]
> Copyright (C) 2000 - 2003 Intel Corporation
> Supports ACPI Specification Revision 2.0b
> 
> dsdt-samsung.dsl   312:     Method (_WAK, 1, NotSerialized)
> Warning  2026 -                        ^ Reserved method must return a
> value (_WAK)
> 
don't care about.

> dsdt-samsung.dsl  2577:                     Field (ECR, DWordAcc, Lock,
> Preserve)
> Error    1048 -                                      ^ Host Operation
> Region requires ByteAcc access
Replace DWordAcc with ByteAcc :)
> 
> dsdt-samsung.dsl  2623:                     Method (_GLK, 1,
> NotSerialized)
> Warning  2024 - Reserved method has too many arguments ^  ( _GLK
> requires 0)
You could replace 1 with 0 to avoid the compile warning.
> 
> ASL Input:  dsdt-samsung.dsl - 3748 lines, 125559 bytes, 1798 keywords
> Compilation complete. 1 Errors, 2 Warnings, 0 Remarks, 410 Optimizations
> -------
> 
> This broken DSDT is currently active, fails with battery as mentioned -
> and: floods dmesg / /var/log/messages with
> 
>   ACPI: acpi_ec_space_handler: bit_width should be 8

Could you try whether the above suggestions fix your battery?
I thought this one is workarounded?
At least it is tried: ACPI: acpi_ec_space_handler: bit_width should be 8
but maybe it does not work as expected?
> 
> Is this something known?
Yes.
> What would I need to fix the DSDT? Anything I can provide?
See above.
> thank you - and hopefully this the correct list
It is.

You do use the latest kernel?
If not please try your unfixed DSDT with the latest kernel, this
should be workarounded correctly since (about 2.6.11?), better use
the latest.

    Thomas


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
