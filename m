From: Malte Doersam <malte.d-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: acpi_pci_link_check's attempt to find the _best_ irq prevents system from using ACPI irq routing
Date: Sat, 26 Apr 2003 19:47:36 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200304261944.35901.malte.d@gmx.net>
References: <F760B14C9561B941B89469F59BA3A847E96E08@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E96E08-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Content-Disposition: inline
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

Hi Andy, Hi everbody

It took me severel hours to track down this to this point. As you stated, the 
acpi_pci_link_check doesn't block the booting.  I observed the loop with some 
printks in acpi_pci_link_check:

FYI my links: 
ACPI: PCI Interrupt Link [PILA] (IRQs 3 4 5 6 7 9 *11 12 14 15)
ACPI: PCI Interrupt Link [PILB] (IRQs 3 4 5 6 7 9 *11 12 14 15)
ACPI: PCI Interrupt Link [PILC] (IRQs 3 4 5 6 7 9 *11 12 14 15)
ACPI: PCI Interrupt Link [PILD] (IRQs 3 4 5 6 7 9 *11 12 14 15)
ACPI: PCI Interrupt Link [PILE] (IRQs 3 4 5 6 7 9 *11 12 14 15)
ACPI: PCI Interrupt Link [PILF] (IRQs 3 4 5 6 7 9 *11 12 14 15)
ACPI: PCI Interrupt Link [PILG] (IRQs 3 4 5 6 7 9 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [PILh] (IRQs 3 4 5 6 7 9 11 12 14 15, disabled)

and here are my printks, the numbers in {{x}} represent the content of the 
variable before...

acpi_pci_link_check entered
link->irq.active --> IRQ: 11 Penalty: 100
link->irq.active --> IRQ: 11 Penalty: 200
link->irq.active --> IRQ: 11 Penalty: 300
link->irq.active --> IRQ: 11 Penalty: 400
link->irq.active --> IRQ: 11 Penalty: 500
link->irq.active --> IRQ: 11 Penalty: 600
!link->irq.active
!link->irq.active
first list_for_each completed

!link->irq.active
irq=link->irq.possible[0] {{3}}
for (i=( link->irq.possible_count {{10}} -1; i>0;i--) {
if (acpi_irq_penalty[irq] {{10020}} > acpi_irq_penalty[link->irq.possible[i]] 
{{10020} ) { 	// 15
if (acpi_irq_penalty[irq] {{10020}} > acpi_irq_penalty[link->irq.possible[i]] 
{{10020} ) {	// 14
if (acpi_irq_penalty[irq] {{10020}} > acpi_irq_penalty[link->irq.possible[i]] 
{{10020} ) {	// 12
if (acpi_irq_penalty[irq] {{10020}} > acpi_irq_penalty[link->irq.possible[i]] 
{{620} ) {	// 11
irq = link->irq.possible[i] {{11}} ;
if (acpi_irq_penalty[irq] {{620}} > acpi_irq_penalty[link->irq.possible[i]] 
{{20} ) {		//  9
irq = link->irq.possible[i] {{9}} ;
if (acpi_irq_penalty[irq] {{20}} > acpi_irq_penalty[link->irq.possible[i]] 
{{10020} ) {		//  7
if (acpi_irq_penalty[irq] {{20}} > acpi_irq_penalty[link->irq.possible[i]] 
{{10020} ) {		//  6
if (acpi_irq_penalty[irq] {{20}} > acpi_irq_penalty[link->irq.possible[i]] 
{{20} ) {		//  5
if (acpi_irq_penalty[irq] {{20}} > acpi_irq_penalty[link->irq.possible[i]] 
{{10020} ) {		//  4
second list_for_each complete

acpi_pci_link_set(link,irq);

Ok, as you can see, it is trying to do the acpi_pci_link_set with IRQ 9, which 
doesn't work. Commenting out this check-loop made the disabled links to use 
the first IRQ (3) which worked.

Now to the interesting part, why IRQ doesn't work:

I followed the acpi_pci_link_set through zillions of lines of code ;) to this 
function ( drivers/acpi/parser/psparse.c)

acpi_status acpi_ps_parse_loop ( struct acpi_walk_state * walk_state)

The "offending part" is this:

/* This op complete, notify the dispatcher */

if (walk_state->ascending_callback != NULL ) {
  walk_state->op    = op;
  walk_state->opcode = op->common.aml_opcode;
  printk("Malte DEBUG: last seen line\n");
  status = walk_state->ascending_callback (walk_state);
  printk("Malte DEBUG: never got to this point with IRQ9\n");
  status = acpi_ps_next_parse_state (walk_state, op, status);
  if (status == AE_CTRL_PENDING) {
    status = AE_OK;
    goto close_this_op;
  }
}

Maybe you can send me some appropriate printk-instruction which print some 
usefull information for you about this 'blocker'? :-)
I'm not sure whether this might be an AML-Bug, but my dsdt.asl does compile 
fine with iasl. In the mean time I'm just using IRQ 3 for these links :-)

http://home.fhtw-berlin.de/~s0502837/linux.kernel/2.5.66.dsdt
http://home.fhtw-berlin.de/~s0502837/linux.kernel/dsdt.asl

cheers Malte




Am Mittwoch, 23. April 2003 20:19 schrieben Sie:
> Looks OK to me. You guys need to tell me *why* commenting it out fixes
> things - with it left in, what irq is it picking, and why isn't that irq
> working OK?
>
> Thanks -- Regards -- Andy



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
