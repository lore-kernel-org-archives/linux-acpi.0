From: Paul Menage <menage-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: ACPI global lock macros
Date: Thu, 11 Dec 2003 00:20:14 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FD828BE.7020906@google.com>
References: <3ACA40606221794F80A5670F0AF15F8401720C21@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720C21-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Yu, Luming wrote:
> 
> 
> Above code have a bug! Considering below code:
> 
> u8	acquired = FALSE;
> 
> ACPI_ACQUIRE_GLOBAL_LOC(acpi_gbl_common_fACS.global_lock, acquired);
> if(acquired) {
> ....
> }
> 
> Gcc will complain " ERROR: '%cl' not allowed with sbbl ". And I think any other compiler will
> complain that  too !

Oops - the version I posted differed in one character from the version 
that I'd compiled - I'd just used "sbb" in the working version and let 
the compiler figure out which version to use.

> 
> How about  below changes to your proposal code.
> 
> <             "sbbl   %0,%0" \
> <             :"=r"(Acq):"r"(GLptr),"i"(~1L):"dx","ax"); \
> ---
> 
>>            "sbbl   %%eax,%%eax" \
>>            :"=a"(Acq):"r"(GLptr),"i"(~1L):"dx"); \

Yes, that would work too, but I don't like forcing the asm to use 
particular registers when there's no good reason to do so.

> 
> 
> PS. I'm very curious about how could you find this bug.  

It was mainly down to the differences between the i386 and x86_64 
versions, and trying to understand the reasons for those differences, 
and indeed how the entire set of macros worked at all.

Paul



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
