From: Robert Woerle <robert-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org>
Subject: Re: Changing IRQ`s at DSDT
Date: Tue, 30 Sep 2003 10:15:04 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F793B88.60104@paceblade.com>
References: <3F780D1A.20908@paceblade.com> <200309291937.53825.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200309291937.53825.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



Andrew de Quincey schrieb:

>On Monday 29 September 2003 11:44, Robert Woerle wrote:
>  
>
>>Hi
>>
>>for the history : i am having a issue with ACPI and IRQ`s ( i believe )
>>i have a configuration where sound ( ali5451 ) , eth0( realtek 8139) and
>>usb ( usb-ohci) are using IRQ 5 .
>>Until now what happens is that when i used 2 out of these 3 devices at
>>the same time the unit locked hard .
>>
>>Now i am able to set eth0 to IRQ7 and a first stress test with 600MB
>>dowload and playing songs worked fine .
>>
>>I am using now 2.4.22 + acpi20030916  + the initrd patch to use my own
>>DSDT .
>>
>>I reached that now in sent the LNK1 in my DSDT to IRQ 7 .
>>
>>Unfortunatly the systems still uses IRQ 5 for the other 2 devices
>>although i also did change the LNK8 and LNKU  at the DSDT ( tryed 6  and
>>11 and 7 ) .
>>
>>find attached my data of the unit ..
>>
>>can somebody tell me why it ignores my changes to LNK8 and LNKU in my
>>DSDT and still uses IRQ5 ?
>>i am also curious why certain LNK`s are parsed twice ???
>>    
>>
>
>Aha, that diff doesn't include the other patch I released more recently, which makes ACPI not 
>reallocate an IRQ if the BIOS has already allocated one.. this sounds like the 
>problem you are encontering.
>
>Try this (against 2.4.23-pre3, so you may have to wiggle it into place). Lemme know if it helps.
>
>
>--- linux-2.4.23-pre3.null_crs/drivers/acpi/pci_link.c	2003-09-05 23:57:39.000000000 +0100
>+++ linux-2.4.23-pre3.nochangeirq/drivers/acpi/pci_link.c	2003-09-16 23:59:49.212387016 +0100
>@@ -507,15 +507,15 @@
> 		irq = link->irq.active;
> 	} else {
> 		irq = link->irq.possible[0];
>-	}
> 
>-	/* 
>-	 * Select the best IRQ.  This is done in reverse to promote 
>-	 * the use of IRQs 9, 10, 11, and >15.
>-	 */
>-	for (i=(link->irq.possible_count-1); i>0; i--) {
>-		if (acpi_irq_penalty[irq] > acpi_irq_penalty[link->irq.possible[i]])
>-			irq = link->irq.possible[i];
>+		/* 
>+		 * Select the best IRQ.  This is done in reverse to promote 
>+		 * the use of IRQs 9, 10, 11, and >15.
>+		 */
>+		for (i=(link->irq.possible_count-1); i>0; i--) {
>+			if (acpi_irq_penalty[irq] > acpi_irq_penalty[link->irq.possible[i]])
>+				irq = link->irq.possible[i];
>+		}
> 	}
> 
> 	/* Attempt to enable the link device at this IRQ. */
>  
>
hmm .. this patch doenst change too much ... .it only let run that code 
in the else {} ?? right ?

i used it but didnt found any difference ... all the IRQ`s which are 
active stay active and i cannot change them
with my DSDT ...

is there a way to not mark them as active and then be able to change 
them like i want ???

Cheers Rob

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
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
