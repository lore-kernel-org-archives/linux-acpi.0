From: Robert Woerle <robert-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org>
Subject: Re: hacking DSDT [-WAS: freeze with 1.0.2]
Date: Wed, 23 Jul 2003 11:06:35 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F1E501B.70603@paceblade.com>
References: <3F1CEAD9.8020103@paceblade.com> <200307222132.56267.mflt1@micrologica.com.hk> <3F1D53E6.5030806@paceblade.com> <200307230048.35698.mflt1@micrologica.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200307230048.35698.mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Michael Frank <mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org>
Cc: swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



Michael Frank schrieb:

>On Tuesday 22 July 2003 23:10, Robert Woerle wrote:
>  
>
>>Michael Frank schrieb:
>>    
>>
>>>On Tuesday 22 July 2003 18:43, Robert Woerle wrote:
>>>      
>>>
>>>>Michael Frank schrieb:
>>>>        
>>>>
>
>Had a lock at your dmesg's, this link setup is a much more beautiful example 
>(a bigger mess) than my setup. 
>
>The remaining problem is that multiple links are BIOS pre-assigned to IRQ5 
>(one even invalidly). 
>
>The patch sent to you does not modify pre-assigned links, so what we have 
>to do is to scan all links and re-assign or disable the redundant ones, and
>possibly modify the DSDT as there seems to be no choice other than IRQ5.
>
>Please send your bzip2'd DSDT (/proc/acpi/dsdt), and give me a bit of time...
>  
>
ok , i do now dig myself in the dsdt and try to figure something out ...

i found the IRQ settings and wanted to change some irq`s so that the IRQ 
5 gets used by one device alone ...
but when i want to compile my dsdt with iasl it get the error

dsdt.dsl  904:   FIELD(PUIC,DWordAcc, Lock, Preserve)
   Error 1047 -                        ^ Access width is greater than 
region size


do you know something ...  it happens also on my plain unchanged 
original dsdt !!!


>
>Regards
>Michael
>
>  
>

-- 
_____________________________________
*Robert Woerle
Linux & Customer Support*
*PaceBlade Technology Europe SA*
phone: 	+49 89 552 99935
fax: 	+49 89 552 99910
mobile: 	+49 179 474 45 27
email: 	robert-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org <mailto:robert@paceblade.com>
web: 	http://www.paceblade.com
_____________________________________






-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
