From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI global lock macros
Date: Thu, 11 Dec 2003 15:27:09 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720C22@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Paul Menage <menage-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I have filed a tracker http://bugme.osdl.org/show_bug.cgi?id=3D1669  , =
And a proposal patch based on Paul's proposal filed there.
--Luming

-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org =
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org]On Behalf Of Yu, Luming
Sent: 2003?12?11? 15:06
To: Paul Menage; agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; acpi-devel@lists.sourceforge.net
Subject: RE: [ACPI] ACPI global lock macros


>>#define ACPI_ACQUIRE_GLOBAL_LOCK(GLptr, Acq) \
>>     do { \
>>        asm volatile("1:movl   (%1),%%eax;" \
>>             "movl   %%eax,%%edx;" \
>>             "andl   %2,%%edx;" \
>>             "btsl   $0x1,%%edx;" \
>>             "adcl   $0x0,%%edx;" \
>>             "lock;  cmpxchgl %%edx,(%1);" \
>>             "jnz    1b;" \
>>             "cmpb   $0x3,%%dl;" \
>>             "sbbl   %0,%0" \
>>             :"=3Dr"(Acq):"r"(GLptr),"i"(~1L):"dx", "ax"); \
>>     } while(0)

Above code have a bug! Considering below code:

u8	acquired =3D FALSE;

ACPI_ACQUIRE_GLOBAL_LOC(acpi_gbl_common_fACS.global_lock, acquired);
if(acquired) {
....
}

Gcc will complain " ERROR: '%cl' not allowed with sbbl ". And I think =
any other compiler will
complain that  too !

How about  below changes to your proposal code.

<             "sbbl   %0,%0" \
<             :"=3Dr"(Acq):"r"(GLptr),"i"(~1L):"dx","ax"); \
---
>             "sbbl   %%eax,%%eax" \
>             :"=3Da"(Acq):"r"(GLptr),"i"(~1L):"dx"); \

PS. I'm very curious about how could you find this bug. =20

Thanks
Luming



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
