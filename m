From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: Error in dsdt from asus a3527nuh
Date: Tue, 09 Nov 2004 12:49:44 -0800
Message-ID: <41912D68.8040609@root.org>
References: <200411092131.27258.valerio@bgweb.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200411092131.27258.valerio-3NZjWNnCfY8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Valerio Felici <valerio-3NZjWNnCfY8@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Valerio Felici wrote:
> Sorry in advance if this is the wrong ml for my question, or if this one is 
> bad formed.
> 
> I've a new asus a3527nuh. I've decompiled my dsdt and trying to compile it 
> with iasl I can observe there is an error, it seems a stupid error, but I'm 
> not able to solve it.
> 
> So I've decide to post it here in attachment (tar-gzipped) so someone can, 
> perhaps, debug it better than me.
> 
> Notebook is ASUS A3N family
> Bios is 0205 version
> 
> Iasl Report:
> -----
> # iasl -tc dsdt.dsl
> 
> Intel ACPI Component Architecture
> ASL Optimizing Compiler / AML Disassembler version 20040527 [May 27 2004]
> Copyright (C) 2000 - 2004 Intel Corporation
> Supports ACPI Specification Revision 2.0c
> 
> dsdt.dsl  7818:     If (SS1)
> Error    1037 -      ^ parse error
> 
> ASL Input:  dsdt.dsl - 7924 lines, 271634 bytes, 3603 keywords
> Compilation complete. 1 Errors, 0 Warnings, 0 Remarks, 0 Optimizations

I don't know if this is the same problem but I've noticed a lot of 
systems with AML opcodes outside any method.  This is technically 
illegal but iasl should still be able to handle it.

-- 
Nate


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
