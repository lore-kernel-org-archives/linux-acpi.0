From: roychris-GANU6spQydw@public.gmane.org
Subject: Re: custom dsdt with 2.5
Date: Fri, 09 May 2003 19:35:08 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1052501708.3ebbe6ccf3454@imp.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Bruno, your patch is rejected by the 2.5.69. But thanks to your help, it's
working now. I can use my custom dsdt.
But my problem is not solve. When I try the 3 sleep state, all my peripherics
are shutted down (but I don't have the sleep LED on), but when I want to resume,
only the cdrom wakes up ! And when I try the 4 state, after the driver frees the
memory, I have a very fast (too fast to read it) message that is indefinitively
repeated. I think that it's a dump mem (something like kernel panic maybe).

How can I have this message ?
Does anyone have the same troubles ?

Ducrot Bruno wrote:

>On Fri, May 09, 2003 at 05:09:12PM +0200, roychris wrote:
>
>>I changed by hand the osl.c of the kernel 2.5. I can send you a diff if 
>>you want. This is the few lines I changed :
>>
>>#include "/my/home/dsdt.hex"
>>
>>and
>>
>>*new_table = (struct acpi_table_header *) AmlCode;
>>
>
>*ALL* acpi tables will be passed to acpi_table_override().  Therefore,
>the RSDT table have been replaced by the table that you have provided.
>Since that is not what you want (RSDT is not DSDT), the ACPI subsystem
>can not work properly.
>
>Do something like this:
>
>	*new_table = NULL;
>
>	if (!strncmp((strncmp(existing_table->signature, DSDT_SIG, 4))))
>		*new_table = (struct acpi_table_header *) AmlCode;
>
>
>BTW, I don't see any reason why you have to patch by hand osl.c and you don't
>use acpi-custom-DSDT.patch instead.
>Really, it look good for me.  What say
>
>$ patch -p1 -i /path/to/acpi-custom-DSDT.patch
>in the linux-2.5.69 directory ?
>
>
>Cheers,
>


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
