From: =?ISO-8859-1?Q?Luis_Miguel_Garc=EDa?= <ktech-39ZsbGIQGT7e5aOfsHch1g@public.gmane.org>
Subject: Re: acpi problem with nforce motherboards and ethernet
Date: Sat, 07 Feb 2004 07:29:20 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <402485C0.905@wanadoo.es>
References: <402298C7.5050405@wanadoo.es> <40229D2C.20701@blue-labs.org> <4022B55B.1090309@wanadoo.es> <20040205154059.6649dd74.akpm@osdl.org> <Pine.LNX.4.55.0402070021210.12260@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.55.0402070021210.12260-rsPqkUlH4Vdx0R2ya2r/wqsMm+1xrEX8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Maciej W. Rozycki" <macro-8Y0ljV8xnLVscumT1wHf3A@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, david+challenge-response-qokYbnrgTHEgsBAKwltoeQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, a.verweij-oe7qfRrRQfeEZXFvZSAUrfP6llvjuJOh@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Maciej W. Rozycki wrote:

>On Thu, 5 Feb 2004, Andrew Morton wrote:
>
>  
>
>>>By the way, is anyone involved in solving the IO-APIC thing in nforce 
>>>motherboards? Anyone trying a different approach? Anyone contacting 
>>>nvidia about this problem?
>>>      
>>>
>>As far as I know, we're dead in the water on these problems.
>>    
>>
>
> Not necessarily. :-)
>
>  
>
>>Here's one:
>>
>>
>>[x86] do not wrongly override mp_ExtINT IRQ
>>
>>From: Mathieu <cheuche+lkml-GANU6spQydw@public.gmane.org>.
>>
>>With this patch timer IRQ0 is correctly set to IO-APIC-edge
>>(not XT-PIC) on nForce2 boards when using APIC and ACPI.
>>
>> arch/i386/kernel/mpparse.c |    3 ++-
>> 1 files changed, 2 insertions(+), 1 deletion(-)
>>
>>diff -puN arch/i386/kernel/mpparse.c~nforce2-apic arch/i386/kernel/mpparse.c
>>--- linux-2.6.0-test11/arch/i386/kernel/mpparse.c~nforce2-apic	2003-12-08 00:12:25.782597272 +0100
>>+++ linux-2.6.0-test11-root/arch/i386/kernel/mpparse.c	2003-12-08 00:12:25.786596664 +0100
>>@@ -962,7 +962,8 @@ void __init mp_override_legacy_irq (
>> 	 */
>> 	for (i = 0; i < mp_irq_entries; i++) {
>> 		if ((mp_irqs[i].mpc_dstapic == intsrc.mpc_dstapic) 
>>-			&& (mp_irqs[i].mpc_srcbusirq == intsrc.mpc_srcbusirq)) {
>>+			&& (mp_irqs[i].mpc_srcbusirq == intsrc.mpc_srcbusirq)
>>+			&& (mp_irqs[i].mpc_irqtype == intsrc.mpc_irqtype)) {
>> 			mp_irqs[i] = intsrc;
>> 			found = 1;
>> 			break;
>>    
>>
>
> That's not the right fix.  There's a bug in Linux's ACPI IRQ setup as
>I've discovered by comparing the code to the spec.  Here's a patch I sent
>in December both to the LKML and the ACPI maintainer.  The feedback from
>the list was positive, but the maintainer didn't bother to comment.
>
> I haven't pushed the patch more firmly, because the MIPS port is my
>priority and I don't even have any ACPI-aware equipment.
>
> Maciej
>
>  
>
Can you send us the specific patch or at least telling us if you're 
going to push it?

Thanks a lot for the fix ;)

LuisMi Garcia


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
