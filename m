From: Jon TURNEY <jon-GrJqePx9RPPAJUdA+FbntA@public.gmane.org>
Subject: Re: ACPI 2.4.25/20040211 on Acer TravelMate C100
Date: Sun, 14 Mar 2004 13:20:59 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40545C3B.6000508@dronecode.org.uk>
References: <20040229140517.GV5481@shell.blacknet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040229140517.GV5481-fwwGEH0YM/9GlUdvxZb+J7NAH6kLmebB@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Goetz Bock <public-bock-zjrZfhH+lcMb1SvskN2V4Q@ciao.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Goetz Bock wrote:

> Dear list,
> 
> unfortunately with Linux 2.4.25 (even with the most up to date patches
> to 20040211) ACPI stopped working on my Acer TravelMate C100.
> 
> It worked fine with 2.4.23 with 20031002, but now all i get is:
> 
> ---=== cut here ===---
>  BIOS-e820: ............... - ................ (ACPI data)
>  BIOS-e820: ............... - ................ (ACPI NVS)
> .
> .
> .
> ACPI: have wakeup address 0xc9991999
> .
> .
> .
> ACPI: RSDP (v000 Acer                     ) @ 0x000ec2d0
>   >>> ERROR: Invalid checksum
> .

This looks like the same problem as:

http://sourceforge.net/mailarchive/forum.php?thread_id=3854113&forum_id=6102

I don't know if the patch I did against 2.6.3 will be any use...




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
