From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch 1/1] acpi: better encapsulate eisa_set_level_irq()
Date: 25 Oct 2004 23:47:02 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1098762422.27399.188.camel@d845pe>
References: <200410251939.i9PJdH910553@mail.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200410251939.i9PJdH910553-VSHRlsF1veSXDw4h08c5KA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Applied,
thanks,

-Len

On Mon, 2004-10-25 at 15:37, akpm-3NddpPZAyC0@public.gmane.org wrote:
> From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
> 
> Move the "only do this once" stuff from acpi_register_gsi() into
> eisa_set_level().
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
> Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
> ---
> 
>  25-akpm/arch/i386/kernel/acpi/boot.c |    8 +-------
>  25-akpm/arch/i386/pci/irq.c          |    9 ++++++++-
>  2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff -puN
> arch/i386/kernel/acpi/boot.c~acpi-better-encapsulate-eisa_set_level_irq arch/i386/kernel/acpi/boot.c
> ---
> 25/arch/i386/kernel/acpi/boot.c~acpi-better-encapsulate-eisa_set_level_irq  Thu Sep 30 16:39:46 2004
> +++ 25-akpm/arch/i386/kernel/acpi/boot.c        Thu Sep 30 16:39:46
> 2004
> @@ -457,16 +457,10 @@ unsigned int acpi_register_gsi(u32 gsi,
>          * Make sure all (legacy) PCI IRQs are set as level-triggered.
>          */
>         if (acpi_irq_model == ACPI_IRQ_MODEL_PIC) {
> -               static u16 irq_mask;
>                 extern void eisa_set_level_irq(unsigned int irq);
> 
> -               if (edge_level == ACPI_LEVEL_SENSITIVE) {
> -                       if ((gsi < 16) && !((1 << gsi) & irq_mask)) {
> -                               Dprintk(KERN_DEBUG PREFIX "Setting GSI
> %u as level-triggered\n", gsi);
> -                               irq_mask |= (1 << gsi);
> +               if (edge_level == ACPI_LEVEL_SENSITIVE)
>                                 eisa_set_level_irq(gsi);
> -                       }
> -               }
>         }
>  #endif
> 
> diff -puN
> arch/i386/pci/irq.c~acpi-better-encapsulate-eisa_set_level_irq
> arch/i386/pci/irq.c
> ---
> 25/arch/i386/pci/irq.c~acpi-better-encapsulate-eisa_set_level_irq  
> Thu Sep 30 16:39:46 2004
> +++ 25-akpm/arch/i386/pci/irq.c Thu Sep 30 16:39:46 2004
> @@ -127,8 +127,15 @@ void eisa_set_level_irq(unsigned int irq
>  {
>         unsigned char mask = 1 << (irq & 7);
>         unsigned int port = 0x4d0 + (irq >> 3);
> -       unsigned char val = inb(port);
> +       unsigned char val;
> +       static u16 eisa_irq_mask;
> 
> +       if (irq >= 16 || (1 << irq) & eisa_irq_mask)
> +               return;
> +
> +       eisa_irq_mask |= (1 << irq);
> +       printk("PCI: setting IRQ %u as level-triggered\n", irq);
> +       val = inb(port);
>         if (!(val & mask)) {
>                 DBG(" -> edge");
>                 outb(val | mask, port);
> _
> 
> 



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
