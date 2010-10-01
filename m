From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] /drivers/acpi/acpica/nsrepair.c (2.6.35.7) - Fixed useless
 compile warning
Date: Fri, 01 Oct 2010 02:14:02 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010010213051.7033@localhost.localdomain>
References: <593258.59408.qm@web45801.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1543916911-1285913644=:7033"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:41513 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706Ab0JAGOI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Oct 2010 02:14:08 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9L00GUULBJ50J8@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 01 Oct 2010 01:14:08 -0500 (CDT)
In-reply-to: <593258.59408.qm@web45801.mail.sp1.yahoo.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Poyo VL <poyo_vl@yahoo.com>
Cc: linux-acpi@vger.kernel.org, robert.moore@intel.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1543916911-1285913644=:7033
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT



thanks,
Len Brown, Intel Open Source Technology Center

On Sun, 19 Sep 2010, Poyo VL wrote:

> This is not a problem, it is a simple fix for an ugly compiler warning. When I 
> tried to cimpile, I got the following warning:
> drivers/acpi/acpica/nsrepair.c: In function ‘acpi_ns_repair_object’:
> drivers/acpi/acpica/nsrepair.c:125:29: warning: ‘new_object’ may be used 
> uninitialized in this function
> new_object is declared without being initialized. It is initialized in a 
> conditional expression like if (expected_btypes & ACPI_RTYPE_INTEGER) so the 
> compiler can't be sure that it will be used initialized, and it throws that 
> warning.
> Just have to initialize new_object which is a pointer with NULL.

I don't see this warning.
What version of the compiler are you using?

thanks,
-Len

> Patch:
> 
> Signed-off-by: Ionut Gabriel Popescu <poyo_vl@yahoo.com>
> ---
> 
> --- a/drivers/acpi/acpica/nsrepair.c    2010-09-20 08:35:56.568006487 +0300
> +++ b/drivers/acpi/acpica/nsrepair.c    2010-09-20 08:00:40.000000000 +0300
> @@ -122,7 +122,7 @@ acpi_ns_repair_object(struct acpi_predef
>                union acpi_operand_object **return_object_ptr)
>  {
>      union acpi_operand_object *return_object = *return_object_ptr;
> -    union acpi_operand_object *new_object;
> +    union acpi_operand_object *new_object = NULL;
>      acpi_status status;
>  
>      ACPI_FUNCTION_NAME(ns_repair_object);
> 

--8323328-1543916911-1285913644=:7033--
