From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Re: [PATCH] Teach OSL to handle multiple interrupts [1/2]
Date: Sat, 13 Nov 2004 01:28:54 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC065@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Fu, Michael" <michael.fu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

My comments:

1. In acpi_gpe_block_add,=20

+	acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+			acpi_gpe_block_crs_add, &block);
+	if (block.register_count =3D=3D 0)
+		return 0;

1.1  Shouldn't it return AE_ERROR.
1.2  You assume there always have IRQ resource for the gpe blocks.

2. In acpi_gpe_block_remove,
+	acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+			acpi_gpe_block_crs_remove, &fadt);
+	if (fadt)
+		return AE_OK;

2.1 fadt seems always to be 0, So why you need it?
2.2 How to free IRQ resource? You just free them at acpi_os_terminate.

3. In acpi_gpe_block_crs_addr
+	data->address.register_bit_width =3D ACPI_GPE_REGISTER_WIDTH;
+	data->address.register_bit_offset =3D ACPI_GPE_REGISTER_WIDTH;
+	data->address.address =3D addr->min_address_range;
+	data->register_count =3D size / 2;

3.1 you should specify address.address_space_id
3.2  address.reserved must be 0. (You allocate it at stack)
3.3 Why you think register_bit_offset is ACPI_GPE_REGISTER_WIDTH.
3.3 Why you think register_count should be size/2 ?=20


Thanks
Luming=20

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Matthew Wilcox
>Sent: 2004=C4=EA11=D4=C211=C8=D5 23:08
>To: Brown, Len
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] Re: [PATCH] Teach OSL to handle multiple=20
>interrupts [1/2]
>
>
>Patches sent after this one have been applied.  Is this patch=20
>still in review?
>
>On Sun, Nov 07, 2004 at 02:47:54PM +0000, Matthew Wilcox wrote:
>>=20
>> OSL assumed that there would only be one ACPI IRQ.  In the=20
>presence of
>> GPE blocks, there are multiple ACPI IRQs.
>>=20
>> Index: linux-2.6/drivers/acpi/osl.c
>> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> RCS file: /var/cvs/linux-2.6/drivers/acpi/osl.c,v
>> retrieving revision 1.13
>> diff -u -p -r1.13 osl.c
>> --- linux-2.6/drivers/acpi/osl.c	11 Oct 2004 21:41:01=20
>-0000	1.13
>> +++ linux-2.6/drivers/acpi/osl.c	7 Nov 2004 14:34:33 -0000
>> @@ -66,9 +66,6 @@ int acpi_in_debugger;
>>  extern char line_buf[80];
>>  #endif /*ENABLE_DEBUGGER*/
>> =20
>> -static unsigned int acpi_irq_irq;
>> -static acpi_osd_handler acpi_irq_handler;
>> -static void *acpi_irq_context;
>>  static struct workqueue_struct *kacpid_wq;
>> =20
>>  acpi_status
>> @@ -96,13 +93,12 @@ acpi_os_initialize1(void)
>>  	return AE_OK;
>>  }
>> =20
>> +static void acpi_os_remove_interrupt_handlers(void);
>> +
>>  acpi_status
>>  acpi_os_terminate(void)
>>  {
>> -	if (acpi_irq_handler) {
>> -		acpi_os_remove_interrupt_handler(acpi_irq_irq,
>> -						 acpi_irq_handler);
>> -	}
>> +	acpi_os_remove_interrupt_handlers();
>> =20
>>  	destroy_workqueue(kacpid_wq);
>> =20
>> @@ -255,52 +251,129 @@ acpi_os_table_override (struct acpi_tabl
>>  	return AE_OK;
>>  }
>> =20
>> +struct acpi_dev_id {
>> +	acpi_osd_handler handler;
>> +	void *context;
>> +	int irq;
>> +	struct acpi_dev_id *next;
>> +};
>> +
>>  static irqreturn_t
>>  acpi_irq(int irq, void *dev_id, struct pt_regs *regs)
>>  {
>> -	return (*acpi_irq_handler)(acpi_irq_context) ?=20
>IRQ_HANDLED : IRQ_NONE;
>> +	struct acpi_dev_id *irq_ctx =3D dev_id;
>> +	acpi_osd_handler handler =3D irq_ctx->handler;
>> +	void *context =3D irq_ctx->context;
>> +	return (*handler)(context) ? IRQ_HANDLED : IRQ_NONE;
>> +}
>> +
>> +struct acpi_dev_id *dev_id_list;
>> +
>> +static void *alloc_dev_id(acpi_osd_handler handler, void=20
>*context, int irq)
>> +{
>> +	struct acpi_dev_id *irq_ctx =3D kmalloc(sizeof(*irq_ctx),=20
>GFP_KERNEL);
>> +	irq_ctx->handler =3D handler;
>> +	irq_ctx->context =3D context;
>> +	irq_ctx->irq =3D irq;
>> +	irq_ctx->next =3D dev_id_list;
>> +	dev_id_list =3D irq_ctx;
>> +	return irq_ctx;
>> +}
>> +
>> +/*
>> + * XXX: Ideally, we would match the context too, but that=20
>information
>> + * isn't passed to the acpi_os_remove_interrupt_handler() function.
>> + */
>> +static void *find_dev_id(int irq, acpi_osd_handler handler)
>> +{
>> +	struct acpi_dev_id *irq_ctx =3D dev_id_list;
>> +	for (irq_ctx =3D dev_id_list; irq_ctx; irq_ctx =3D irq_ctx->next) {
>> +		if ((irq_ctx->handler =3D=3D handler) &&=20
>(irq_ctx->irq =3D=3D irq))
>> +			return irq_ctx;
>> +	}
>> +	printk("find_dev_id: handler %p for irq %d not=20
>found\n", handler, irq);
>> +	return NULL;
>> +}
>> +
>> +static void free_dev_id(struct acpi_dev_id *dev_id)
>> +{
>> +	struct acpi_dev_id **pprev =3D &dev_id_list;
>> +	for (;;) {
>> +		struct acpi_dev_id *irq_ctx =3D *pprev;
>> +		if (!irq_ctx)
>> +			break;
>> +		if (irq_ctx !=3D dev_id) {
>> +			pprev =3D &irq_ctx->next;
>> +			continue;
>> +		}
>> +
>> +		*pprev =3D irq_ctx->next;
>> +		kfree(irq_ctx);
>> +		return;
>> +	}
>> +	printk("free_dev_id: dev_id %p not found\n", dev_id);
>>  }
>> =20
>>  acpi_status
>>  acpi_os_install_interrupt_handler(u32 gsi, acpi_osd_handler=20
>handler, void *context)
>>  {
>>  	unsigned int irq;
>> +	void *dev_id;
>> =20
>>  	/*
>> -	 * Ignore the GSI from the core, and use the value in=20
>our copy of the
>> -	 * FADT. It may not be the same if an interrupt source=20
>override exists
>> -	 * for the SCI.
>> +	 * If this is the FADT interrupt, ignore the GSI from=20
>the core and
>> +	 * use the value in our copy of the FADT instead.  It=20
>may not be the
>> +	 * same if an interrupt source override exists for the SCI.
>>  	 */
>> -	gsi =3D acpi_fadt.sci_int;
>> +	if (gsi =3D=3D acpi_gbl_FADT->sci_int)
>> +		gsi =3D acpi_fadt.sci_int;
>> +
>>  	if (acpi_gsi_to_irq(gsi, &irq) < 0) {
>>  		printk(KERN_ERR PREFIX "SCI (ACPI GSI %d) not=20
>registered\n",
>>  		       gsi);
>>  		return AE_OK;
>>  	}
>> =20
>> -	acpi_irq_handler =3D handler;
>> -	acpi_irq_context =3D context;
>> -	if (request_irq(irq, acpi_irq, SA_SHIRQ, "acpi", acpi_irq)) {
>> +	dev_id =3D alloc_dev_id(handler, context, irq);
>> +	if (request_irq(irq, acpi_irq, SA_SHIRQ, "acpi", dev_id)) {
>>  		printk(KERN_ERR PREFIX "SCI (IRQ%d) allocation=20
>failed\n", irq);
>> +		free_dev_id(dev_id);
>>  		return AE_NOT_ACQUIRED;
>>  	}
>> -	acpi_irq_irq =3D irq;
>> =20
>>  	return AE_OK;
>>  }
>> =20
>>  acpi_status
>> -acpi_os_remove_interrupt_handler(u32 irq, acpi_osd_handler handler)
>> +acpi_os_remove_interrupt_handler(u32 gsi, acpi_osd_handler handler)
>>  {
>> -	if (irq) {
>> -		free_irq(irq, acpi_irq);
>> -		acpi_irq_handler =3D NULL;
>> -		acpi_irq_irq =3D 0;
>> +	int irq;
>> +	void *dev_id;
>> +
>> +	if (gsi =3D=3D acpi_gbl_FADT->sci_int)
>> +		gsi =3D acpi_fadt.sci_int;
>> +
>> +	if (acpi_gsi_to_irq(gsi, &irq) < 0) {
>> +		printk(KERN_ERR PREFIX "SCI (ACPI GSI %d) not=20
>registered\n",
>> +		       gsi);
>> +		return AE_OK;
>>  	}
>> =20
>> +	dev_id =3D find_dev_id(irq, handler);
>> +	free_irq(irq, dev_id);
>> +	free_dev_id(dev_id);
>> +
>>  	return AE_OK;
>>  }
>> =20
>> +static void acpi_os_remove_interrupt_handlers(void)
>> +{
>> +	while (dev_id_list) {
>> +		acpi_os_remove_interrupt_handler(dev_id_list->irq,
>> +				dev_id_list->handler);
>> +	}
>> +}
>> +
>>  /*
>>   * Running in interpreter thread context, safe to sleep
>>   */
>>=20
>> --=20
>> "Next the statesmen will invent cheap lies, putting the blame upon=20
>> the nation that is attacked, and every man will be glad of those
>> conscience-soothing falsities, and will diligently study=20
>them, and refuse
>> to examine any refutations of them; and thus he will by and=20
>by convince=20
>> himself that the war is just, and will thank God for the=20
>better sleep=20
>> he enjoys after this process of grotesque self-deception."=20
>-- Mark Twain
>
>--=20
>"Next the statesmen will invent cheap lies, putting the blame upon=20
>the nation that is attacked, and every man will be glad of those
>conscience-soothing falsities, and will diligently study them,=20
>and refuse
>to examine any refutations of them; and thus he will by and by=20
>convince=20
>himself that the war is just, and will thank God for the better sleep=20
>he enjoys after this process of grotesque self-deception." --=20
>Mark Twain
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by:
>Sybase ASE Linux Express Edition - download now for FREE
>LinuxWorld Reader's Choice Award Winner for best database on Linux.
>http://ads.osdn.com/?ad_id=3D5588&alloc_id=3D12065&op=3Dclick
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
