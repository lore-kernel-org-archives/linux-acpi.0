From: roychris <roychris-GANU6spQydw@public.gmane.org>
Subject: Re: custom dsdt with 2.5
Date: Fri, 09 May 2003 17:09:12 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3EBBC498.7030704@free.fr>
References: <3EBB6B55.5000700@free.fr> <3EBB9E65.6000108@gkec.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3EBB9E65.6000108-8NdywcgfOMlWMvVl7B+zuCEWGD4kr0XT@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan Behnel <behnel-8NdywcgfOMlWMvVl7B+zuCEWGD4kr0XT@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I changed by hand the osl.c of the kernel 2.5. I can send you a diff if 
you want. This is the few lines I changed :

#include "/my/home/dsdt.hex"

and

*new_table = (struct acpi_table_header *) AmlCode;

Now I have this error at boot time :

ACPI: Subsystem revision 20030418
    ACPI-0291: *** Info: Table [DSDT] replaced by host OS
    ACPI-0227: *** Error: Invalid signature where RSDP indicates 
RSDT/XSDT should be located
    ACPI-0103: *** Error: acpi_load_tables: Could not load RSDT: 
AE_BAD_SIGNATURE
    ACPI-0133: *** Error: acpi_load_tables: Could not load tables: 
AE_BAD_SIGNATURE
ACPI: Unable to load the System Description Tables


Could you help me ?


Stefan Behnel wrote:

> Hi!
>
> roychris wrote:
>
>> I've just fixed my dsdt. How can I load it with the 2.5.69 kernel ?
>
>
> Try
> http://www.behnel.de/acpi/acpi-custom-DSDT.patch
> resp.
> http://www.behnel.de/acpi/samsung-acpi.html
>
> At least, it works for 2.4, but I don't see why it shouldn't work for 
> ACPI in 2.5.
>
> BTW: There were patches recently that allow loading the DSDT from an 
> initrd. Search the archives for that.
>
> Stefan
>




-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
