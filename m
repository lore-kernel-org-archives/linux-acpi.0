From: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Subject: Re: [PATCH] Teach OSL to handle multiple interrupts [1/2]
Date: Thu, 11 Nov 2004 15:08:29 +0000
Message-ID: <20041111150829.GA1108@parcelfarce.linux.theplanet.co.uk>
References: <20041106064442.GA21423@parcelfarce.linux.theplanet.co.uk> <20041106074900.GA29632@parcelfarce.linux.theplanet.co.uk> <20041107144315.GC23303@parcelfarce.linux.theplanet.co.uk> <20041107144754.GD23303@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041107144754.GD23303-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Patches sent after this one have been applied.  Is this patch still in review?

On Sun, Nov 07, 2004 at 02:47:54PM +0000, Matthew Wilcox wrote:
> 
> OSL assumed that there would only be one ACPI IRQ.  In the presence of
> GPE blocks, there are multiple ACPI IRQs.
> 
> Index: linux-2.6/drivers/acpi/osl.c
> ===================================================================
> RCS file: /var/cvs/linux-2.6/drivers/acpi/osl.c,v
> retrieving revision 1.13
> diff -u -p -r1.13 osl.c
> --- linux-2.6/drivers/acpi/osl.c	11 Oct 2004 21:41:01 -0000	1.13
> +++ linux-2.6/drivers/acpi/osl.c	7 Nov 2004 14:34:33 -0000
> @@ -66,9 +66,6 @@ int acpi_in_debugger;
>  extern char line_buf[80];
>  #endif /*ENABLE_DEBUGGER*/
>  
> -static unsigned int acpi_irq_irq;
> -static acpi_osd_handler acpi_irq_handler;
> -static void *acpi_irq_context;
>  static struct workqueue_struct *kacpid_wq;
>  
>  acpi_status
> @@ -96,13 +93,12 @@ acpi_os_initialize1(void)
>  	return AE_OK;
>  }
>  
> +static void acpi_os_remove_interrupt_handlers(void);
> +
>  acpi_status
>  acpi_os_terminate(void)
>  {
> -	if (acpi_irq_handler) {
> -		acpi_os_remove_interrupt_handler(acpi_irq_irq,
> -						 acpi_irq_handler);
> -	}
> +	acpi_os_remove_interrupt_handlers();
>  
>  	destroy_workqueue(kacpid_wq);
>  
> @@ -255,52 +251,129 @@ acpi_os_table_override (struct acpi_tabl
>  	return AE_OK;
>  }
>  
> +struct acpi_dev_id {
> +	acpi_osd_handler handler;
> +	void *context;
> +	int irq;
> +	struct acpi_dev_id *next;
> +};
> +
>  static irqreturn_t
>  acpi_irq(int irq, void *dev_id, struct pt_regs *regs)
>  {
> -	return (*acpi_irq_handler)(acpi_irq_context) ? IRQ_HANDLED : IRQ_NONE;
> +	struct acpi_dev_id *irq_ctx = dev_id;
> +	acpi_osd_handler handler = irq_ctx->handler;
> +	void *context = irq_ctx->context;
> +	return (*handler)(context) ? IRQ_HANDLED : IRQ_NONE;
> +}
> +
> +struct acpi_dev_id *dev_id_list;
> +
> +static void *alloc_dev_id(acpi_osd_handler handler, void *context, int irq)
> +{
> +	struct acpi_dev_id *irq_ctx = kmalloc(sizeof(*irq_ctx), GFP_KERNEL);
> +	irq_ctx->handler = handler;
> +	irq_ctx->context = context;
> +	irq_ctx->irq = irq;
> +	irq_ctx->next = dev_id_list;
> +	dev_id_list = irq_ctx;
> +	return irq_ctx;
> +}
> +
> +/*
> + * XXX: Ideally, we would match the context too, but that information
> + * isn't passed to the acpi_os_remove_interrupt_handler() function.
> + */
> +static void *find_dev_id(int irq, acpi_osd_handler handler)
> +{
> +	struct acpi_dev_id *irq_ctx = dev_id_list;
> +	for (irq_ctx = dev_id_list; irq_ctx; irq_ctx = irq_ctx->next) {
> +		if ((irq_ctx->handler == handler) && (irq_ctx->irq == irq))
> +			return irq_ctx;
> +	}
> +	printk("find_dev_id: handler %p for irq %d not found\n", handler, irq);
> +	return NULL;
> +}
> +
> +static void free_dev_id(struct acpi_dev_id *dev_id)
> +{
> +	struct acpi_dev_id **pprev = &dev_id_list;
> +	for (;;) {
> +		struct acpi_dev_id *irq_ctx = *pprev;
> +		if (!irq_ctx)
> +			break;
> +		if (irq_ctx != dev_id) {
> +			pprev = &irq_ctx->next;
> +			continue;
> +		}
> +
> +		*pprev = irq_ctx->next;
> +		kfree(irq_ctx);
> +		return;
> +	}
> +	printk("free_dev_id: dev_id %p not found\n", dev_id);
>  }
>  
>  acpi_status
>  acpi_os_install_interrupt_handler(u32 gsi, acpi_osd_handler handler, void *context)
>  {
>  	unsigned int irq;
> +	void *dev_id;
>  
>  	/*
> -	 * Ignore the GSI from the core, and use the value in our copy of the
> -	 * FADT. It may not be the same if an interrupt source override exists
> -	 * for the SCI.
> +	 * If this is the FADT interrupt, ignore the GSI from the core and
> +	 * use the value in our copy of the FADT instead.  It may not be the
> +	 * same if an interrupt source override exists for the SCI.
>  	 */
> -	gsi = acpi_fadt.sci_int;
> +	if (gsi == acpi_gbl_FADT->sci_int)
> +		gsi = acpi_fadt.sci_int;
> +
>  	if (acpi_gsi_to_irq(gsi, &irq) < 0) {
>  		printk(KERN_ERR PREFIX "SCI (ACPI GSI %d) not registered\n",
>  		       gsi);
>  		return AE_OK;
>  	}
>  
> -	acpi_irq_handler = handler;
> -	acpi_irq_context = context;
> -	if (request_irq(irq, acpi_irq, SA_SHIRQ, "acpi", acpi_irq)) {
> +	dev_id = alloc_dev_id(handler, context, irq);
> +	if (request_irq(irq, acpi_irq, SA_SHIRQ, "acpi", dev_id)) {
>  		printk(KERN_ERR PREFIX "SCI (IRQ%d) allocation failed\n", irq);
> +		free_dev_id(dev_id);
>  		return AE_NOT_ACQUIRED;
>  	}
> -	acpi_irq_irq = irq;
>  
>  	return AE_OK;
>  }
>  
>  acpi_status
> -acpi_os_remove_interrupt_handler(u32 irq, acpi_osd_handler handler)
> +acpi_os_remove_interrupt_handler(u32 gsi, acpi_osd_handler handler)
>  {
> -	if (irq) {
> -		free_irq(irq, acpi_irq);
> -		acpi_irq_handler = NULL;
> -		acpi_irq_irq = 0;
> +	int irq;
> +	void *dev_id;
> +
> +	if (gsi == acpi_gbl_FADT->sci_int)
> +		gsi = acpi_fadt.sci_int;
> +
> +	if (acpi_gsi_to_irq(gsi, &irq) < 0) {
> +		printk(KERN_ERR PREFIX "SCI (ACPI GSI %d) not registered\n",
> +		       gsi);
> +		return AE_OK;
>  	}
>  
> +	dev_id = find_dev_id(irq, handler);
> +	free_irq(irq, dev_id);
> +	free_dev_id(dev_id);
> +
>  	return AE_OK;
>  }
>  
> +static void acpi_os_remove_interrupt_handlers(void)
> +{
> +	while (dev_id_list) {
> +		acpi_os_remove_interrupt_handler(dev_id_list->irq,
> +				dev_id_list->handler);
> +	}
> +}
> +
>  /*
>   * Running in interpreter thread context, safe to sleep
>   */
> 
> -- 
> "Next the statesmen will invent cheap lies, putting the blame upon 
> the nation that is attacked, and every man will be glad of those
> conscience-soothing falsities, and will diligently study them, and refuse
> to examine any refutations of them; and thus he will by and by convince 
> himself that the war is just, and will thank God for the better sleep 
> he enjoys after this process of grotesque self-deception." -- Mark Twain

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
