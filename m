From: "Maciej W. Rozycki" <macro-8Y0ljV8xnLVscumT1wHf3A@public.gmane.org>
Subject: Re: acpi problem with nforce motherboards and ethernet
Date: Sat, 7 Feb 2004 00:33:04 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.55.0402070021210.12260@jurand.ds.pg.gda.pl>
References: <402298C7.5050405@wanadoo.es> <40229D2C.20701@blue-labs.org>
 <4022B55B.1090309@wanadoo.es> <20040205154059.6649dd74.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040205154059.6649dd74.akpm-3NddpPZAyC0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: Luis Miguel =?ISO-8859-1?Q?Garc=EDa?= <ktech-39ZsbGIQGT7e5aOfsHch1g@public.gmane.org>, david+challenge-response-qokYbnrgTHEgsBAKwltoeQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, a.verweij-oe7qfRrRQfeEZXFvZSAUrfP6llvjuJOh@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 5 Feb 2004, Andrew Morton wrote:

> > By the way, is anyone involved in solving the IO-APIC thing in nforce 
> > motherboards? Anyone trying a different approach? Anyone contacting 
> > nvidia about this problem?
> 
> As far as I know, we're dead in the water on these problems.

 Not necessarily. :-)

> Here's one:
> 
> 
> [x86] do not wrongly override mp_ExtINT IRQ
> 
> From: Mathieu <cheuche+lkml-GANU6spQydw@public.gmane.org>.
> 
> With this patch timer IRQ0 is correctly set to IO-APIC-edge
> (not XT-PIC) on nForce2 boards when using APIC and ACPI.
> 
>  arch/i386/kernel/mpparse.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff -puN arch/i386/kernel/mpparse.c~nforce2-apic arch/i386/kernel/mpparse.c
> --- linux-2.6.0-test11/arch/i386/kernel/mpparse.c~nforce2-apic	2003-12-08 00:12:25.782597272 +0100
> +++ linux-2.6.0-test11-root/arch/i386/kernel/mpparse.c	2003-12-08 00:12:25.786596664 +0100
> @@ -962,7 +962,8 @@ void __init mp_override_legacy_irq (
>  	 */
>  	for (i = 0; i < mp_irq_entries; i++) {
>  		if ((mp_irqs[i].mpc_dstapic == intsrc.mpc_dstapic) 
> -			&& (mp_irqs[i].mpc_srcbusirq == intsrc.mpc_srcbusirq)) {
> +			&& (mp_irqs[i].mpc_srcbusirq == intsrc.mpc_srcbusirq)
> +			&& (mp_irqs[i].mpc_irqtype == intsrc.mpc_irqtype)) {
>  			mp_irqs[i] = intsrc;
>  			found = 1;
>  			break;

 That's not the right fix.  There's a bug in Linux's ACPI IRQ setup as
I've discovered by comparing the code to the spec.  Here's a patch I sent
in December both to the LKML and the ACPI maintainer.  The feedback from
the list was positive, but the maintainer didn't bother to comment.

 I haven't pushed the patch more firmly, because the MIPS port is my
priority and I don't even have any ACPI-aware equipment.

 Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro-8Y0ljV8xnLVscumT1wHf3A@public.gmane.org, PGP key available        +

patch-mips-2.6.0-test11-20031209-acpi-irq0-1
diff -up --recursive --new-file linux-mips-2.6.0-test11-20031209.macro/arch/i386/kernel/mpparse.c linux-mips-2.6.0-test11-20031209/arch/i386/kernel/mpparse.c
--- linux-mips-2.6.0-test11-20031209.macro/arch/i386/kernel/mpparse.c	2003-11-25 04:57:01.000000000 +0000
+++ linux-mips-2.6.0-test11-20031209/arch/i386/kernel/mpparse.c	2003-12-11 09:43:26.000000000 +0000
@@ -940,7 +940,7 @@ void __init mp_override_legacy_irq (
 	 *      erroneously sets the trigger to level, resulting in a HUGE 
 	 *      increase of timer interrupts!
 	 */
-	if ((bus_irq == 0) && (global_irq == 2) && (trigger == 3))
+	if ((bus_irq == 0) && (trigger == 3))
 		trigger = 1;
 
 	intsrc.mpc_type = MP_INTSRC;
@@ -961,7 +961,7 @@ void __init mp_override_legacy_irq (
 	 * Otherwise create a new entry (e.g. global_irq == 2).
 	 */
 	for (i = 0; i < mp_irq_entries; i++) {
-		if ((mp_irqs[i].mpc_dstapic == intsrc.mpc_dstapic) 
+		if ((mp_irqs[i].mpc_srcbus == intsrc.mpc_srcbus) 
 			&& (mp_irqs[i].mpc_srcbusirq == intsrc.mpc_srcbusirq)) {
 			mp_irqs[i] = intsrc;
 			found = 1;
@@ -1008,9 +1008,10 @@ void __init mp_config_acpi_legacy_irqs (
 	 */
 	for (i = 0; i < 16; i++) {
 
-		if (i == 2) continue;			/* Don't connect IRQ2 */
+		if (i == 2)
+			continue;			/* Don't connect IRQ2 */
 
-		intsrc.mpc_irqtype = i ? mp_INT : mp_ExtINT;   /* 8259A to #0 */
+		intsrc.mpc_irqtype = mp_INT;
 		intsrc.mpc_srcbusirq = i;		   /* Identity mapped */
 		intsrc.mpc_dstirq = i;
 


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
