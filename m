From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: ACPI errors on ECS G220 laptop
Date: Thu, 06 Oct 2005 18:44:35 +0200
Message-ID: <43455473.6040209@suse.de>
References: <1128480553.11538.9.camel@tuxprototype.deadeyedata.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1128480553.11538.9.camel-HeUoCuMXkaHnRTjf+tVgBKY7qTmLiVr45NbjCUgZEJk@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: bulk-wOwPqRMbTBJeoWH0uzbU5w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Junk Mail Recipient wrote:
> I recently purchased an ECS G220 laptop with the hopes of running Suse
> 9.3 on it.  I am pretty well outta luck as far as acpi goes though.  The
> battery monitor doesn't work at all.  It perpetually shows a 1% charge.
> It also doesn't seem to be getting any thermal information.  CPU scaling
> can be done manually, but is not happening automatically.  
> 
> I followed the how-to on broken dsdt and from iasl I get 1 error and no
> warnings.  Unfortunately this seems to be a pretty generic syntax error
> and I am at a loss on how to track it down or where to go from here.  
> 
> Intel ACPI Component Architecture
> ASL Optimizing Compiler / AML Disassembler version 20050309 [Mar 19
> 2005]
> Copyright (C) 2000 - 2005 Intel Corporation
> Supports ACPI Specification Revision 3.0
> 
> dsdt.dsl  1901:     If (SS1)
> Error    1037 -      ^ syntax error, unexpected PARSEOP_IF

Create an _INI function in \_SB scope (if there is not already one) and place 
the If(SSX){...} code there.


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
