From: Brendan Burns <bburns-2RkbYZshK0Iw9SF6qBHgXg@public.gmane.org>
Subject: Re: Acpi-devel digest, Vol 1 #791 - 3 msgs
Date: Sat, 1 Feb 2003 16:09:16 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <6BD30F44-3629-11D7-814C-0003931E5EDC@wso.williams.edu>
References: <E18f4GI-0005dc-00@sc8-sf-list2.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v551)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <E18f4GI-0005dc-00-ek0oC1U1TqqnvZpeIfgr/KQD96bmaF075NbjCUgZEJk@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

unsubscribe qwerty bburns-bjBJFzlPIWP2fBVCVOL8/A@public.gmane.org
On Saturday, February 1, 2003, at 03:24 PM, 
acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org wrote:

> Send Acpi-devel mailing list submissions to
> 	acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
> 	https://lists.sourceforge.net/lists/listinfo/acpi-devel
> or, via email, send a message with subject or body 'help' to
> 	acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>
> You can reach the person managing the list at
> 	acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Acpi-devel digest..."
>
>
> Today's Topics:
>
>    1. How to add dsdt.hex to kernel ? (reeja.john-5C7GfCeVMHo@public.gmane.org)
>    2. [FAQ?][ACPI] How to add dsdt.hex to kernel ? (Stefan Behnel)
>    3. Re: [FAQ?][ACPI] How to add dsdt.hex to kernel ? 
> (=?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto)
>
> --__--__--
>
> Message: 1
> From: reeja.john-5C7GfCeVMHo@public.gmane.org
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Date: Fri, 31 Jan 2003 14:34:39 -0800
> Subject: [ACPI] How to add dsdt.hex to kernel ?
>
> Hi,
>
>    I created a custom dsdt.hex for my system for the kernel 2.5.55. 
> How am I able to add this new dsdt into the kernel?. I found some 
> instructions on the web for kernel 2.4.18 to copy this file as 
> drivers/acpt/tables/acpi_dsdt.c . But when I do that in linux-2.5.55, 
> it doesn't get compiled( no acpi_dsdt.o is made). Is there any 
> different procedure in linux-2.5.55 to add the dsdt to the kernel? Any 
> help  appreciated.
> Thanks,
>
> Reeja
>
> 		Reeja John
> 		Software Research and Development,AMD
> 		(408) 749 - 3289
>
>
>
>
> --__--__--
>
> Message: 2
> Date: Sat, 01 Feb 2003 13:08:03 +0100
> From: Stefan Behnel <behnel_ml-8NdywcgfOMlWMvVl7B+zuCEWGD4kr0XT@public.gmane.org>
> To: reeja.john-5C7GfCeVMHo@public.gmane.org
> CC: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [FAQ?][ACPI] How to add dsdt.hex to kernel ?
>
> Hi!
>
> reeja.john-5C7GfCeVMHo@public.gmane.org wrote:
>> I created a custom dsdt.hex for my system for the kernel 2.5.55. How
>> am I able to add this new dsdt into the kernel?
>
> That one should really go into a FAQ somewhere (or rather replace the
> outdated description in the existing FAQ).
>
> This simple patch allows you to include your DSDT.hex file. I called it
> "my-dsdt.hex" here, has to be in the directory [linux]/drivers/acpi/,
> where osl.c is located.
>
> BTW: As this seems to be a common problem, would there be a way to add
> it as a standard kernel config option?
>
> Have fun,
> Stefan Behnel
>
>
> --- linux-2.4.21/drivers/acpi/osl.c 2003-01-24 09:59:27.000000000 +0100
> +++ linux/drivers/acpi/osl.c	  2003-01-24 13:36:45.000000000 +0100
> @@ -201,6 +201,9 @@
>   	return AE_OK;
>   }
>
> +/**/static const
> +#include "my-dsdt.hex"
> +
>   acpi_status
>   acpi_os_table_override (struct acpi_table_header *existing_table,
>   			struct acpi_table_header **new_table)
> @@ -208,7 +211,11 @@
>   	if (!existing_table || !new_table)
>   		return AE_BAD_PARAMETER;
>
> -	*new_table = NULL;
> +	/**/if (strncmp(existing_table->signature,"DSDT",4))
> +	  *new_table = NULL;
> +	/**/else
> +	  *new_table = (struct acpi_table_header *)AmlCode;
> +
>   	return AE_OK;
>   }
>
>
>
>
> --__--__--
>
> Message: 3
> Subject: Re: [FAQ?][ACPI] How to add dsdt.hex to kernel ?
> From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
> To: Stefan Behnel <behnel_ml-8NdywcgfOMlWMvVl7B+zuCEWGD4kr0XT@public.gmane.org>
> Cc: reeja.john-5C7GfCeVMHo@public.gmane.org, acpi-devel <acpi-devel@lists.sourceforge.net>
> Date: 01 Feb 2003 17:13:08 +0000
>
> like i write before , you can read this two messages
>
> http://sourceforge.net/mailarchive/message.php?msg_id=2160477
>
>
> or
>
> http://sourceforge.net/mailarchive/message.php?msg_id=2062932
>
>
> On Sat, 2003-02-01 at 12:08, Stefan Behnel wrote:
>> Hi!
>>
>> reeja.john-5C7GfCeVMHo@public.gmane.org wrote:
>>> I created a custom dsdt.hex for my system for the kernel 2.5.55. How
>>> am I able to add this new dsdt into the kernel?
>>
>> That one should really go into a FAQ somewhere (or rather replace the
>> outdated description in the existing FAQ).
>>
>> This simple patch allows you to include your DSDT.hex file. I called 
>> it
>> "my-dsdt.hex" here, has to be in the directory [linux]/drivers/acpi/,
>> where osl.c is located.
>>
>> BTW: As this seems to be a common problem, would there be a way to add
>> it as a standard kernel config option?
>>
>> Have fun,
>> Stefan Behnel
>>
>>
>> --- linux-2.4.21/drivers/acpi/osl.c 2003-01-24 09:59:27.000000000 
>> +0100
>> +++ linux/drivers/acpi/osl.c	  2003-01-24 13:36:45.000000000 +0100
>> @@ -201,6 +201,9 @@
>>   	return AE_OK;
>>   }
>>
>> +/**/static const
>> +#include "my-dsdt.hex"
>> +
>>   acpi_status
>>   acpi_os_table_override (struct acpi_table_header *existing_table,
>>   			struct acpi_table_header **new_table)
>> @@ -208,7 +211,11 @@
>>   	if (!existing_table || !new_table)
>>   		return AE_BAD_PARAMETER;
>>
>> -	*new_table = NULL;
>> +	/**/if (strncmp(existing_table->signature,"DSDT",4))
>> +	  *new_table = NULL;
>> +	/**/else
>> +	  *new_table = (struct acpi_table_header *)AmlCode;
>> +
>>   	return AE_OK;
>>   }
>>
>>
>>
>>
>> -------------------------------------------------------
>> This SF.NET email is sponsored by:
>> SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
>> http://www.vasoftware.com
>> _______________________________________________
>> Acpi-devel mailing list
>> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>
>
>
>
>
> --__--__--
>
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>
>
> End of Acpi-devel Digest



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
