From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: DSDT problem with Acer Aspire 3002NLC
Date: Mon, 06 Jun 2005 17:12:08 +0200
Message-ID: <42A467C8.503@suse.de>
References: <9a9bfc170506060740547d2bd6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <9a9bfc170506060740547d2bd6-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ramkumar R <andyetitmoves-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Ramkumar R wrote:
> Hi!
> 
> I have a Acer Aspire 3002NLC and the battery was not getting reported.
> The syslog too was flooded. I checked up the DSDT database and found a
> fixed table for Aspire 3000 (It reportedly fixed this error, see
> http://acpi.sourceforge.net/dsdt/view.php?id=377). I merged the
> changes with the decompiled file I had. I had decompiled with iasl,
> and on recompilation with the patch 6 errors remained. (Originally 37
> errors were present). I am using iasl version 20050513.
> 
> The compilation cmdline: iasl -oi -of -on -tc dcust.dsl 2>&1 > /tmp/error.log
> 
> Error log:
> 
> Intel ACPI Component Architecture
> ASL Optimizing Compiler / AML Disassembler version 20050513 [Jun  4 2005]
> Copyright (C) 2000 - 2005 Intel Corporation
> Supports ACPI Specification Revision 3.0
> 
> dcust.dsl  2506:                             If (LNot (LEqual
> (\_PR.CPU0._PPC, 0x00)))
> Error    1022 -                                       Object does not
> exist ^  (\_PR.CPU0._PPC)
> 
> dcust.dsl  2508:                                 Store (0x00, \_PR.CPU0._PPC)
> Error    1022 -                                      Object does not
> exist ^  (\_PR.CPU0._PPC)
> 
> dcust.dsl  2516:                             If (LLess (\_PR.CPU0._PPC, Local1))
> Error    1022 -                                Object does not exist ^
>  (\_PR.CPU0._PPC)
> 
> dcust.dsl  2518:                                 Store (Local1, \_PR.CPU0._PPC)
> Error    1022 -                                        Object does not
> exist ^  (\_PR.CPU0._PPC)
> 
> dcust.dsl  2528:                         If (LNot (LEqual
> (\_PR.CPU0._PPC, 0x00)))
> Error    1022 -                                   Object does not
> exist ^  (\_PR.CPU0._PPC)
> 
> dcust.dsl  2530:                             Store (0x00, \_PR.CPU0._PPC)
> Error    1022 -                                  Object does not exist
> ^  (\_PR.CPU0._PPC)
> 
> ASL Input:  dcust.dsl - 3466 lines, 120769 bytes, 1560 keywords
> Compilation complete. 6 Errors, 0 Warnings, 0 Remarks, 0 Optimizations
> 
The object is defined in your SSDT.
Try adding:
External (\_PR.CPU0._PPC)
in global scope
or
External (_PPC)
in the \_PR.CPU0 scope.
One of these should work getting your dsdt compiled.
The kernel interpreter will find the object when the SSDT table is loaded.

       Thomas



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
