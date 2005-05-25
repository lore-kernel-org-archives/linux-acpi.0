From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: RE: [PATCH 1/2] Allow multiple GPE interrupts
Date: Wed, 25 May 2005 13:35:24 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840836E7C7@pdsmsx403>
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
To: Matthew Wilcox <willy-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, matthew-Ztpu424NOJ8@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

 Hi,

Do you have updated patch for the comments below? I'm sorry I jump into =
a rather old thread.

Thanks,
Luming

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Brown, Len
>Sent: 2005=C4=EA4=D4=C214=C8=D5 10:23
>To: Matthew Wilcox
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; matthew-Ztpu424NOJ8@public.gmane.org
>Subject: [ACPI] RE: [PATCH 1/2] Allow multiple GPE interrupts
>
>=20
>
>>-----Original Message-----
>>From: Matthew Wilcox [mailto:willy-6jwH94ZQLHl74goWV3ctuw@public.gmane.org]=20
>>Sent: Tuesday, April 12, 2005 5:59 PM
>>To: Brown, Len
>>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; matthew-Ztpu424NOJ8@public.gmane.org
>>Subject: [PATCH 1/2] Allow multiple GPE interrupts
>>
>>Allow multiple GPE interrupts
>>
>>If we have multiple GPE blocks, they can (and do) have independent
>>interrupts.  Remove the assumptions in OSL that there is only one GPE
>>interrupt.
>>
>>Index: ./drivers/acpi/osl.c
>>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>RCS file: /var/cvs/linux-2.6/drivers/acpi/osl.c,v
>>retrieving revision 1.16
>>diff -u -p -r1.16 osl.c
>>--- ./drivers/acpi/osl.c	12 Jan 2005 20:16:09 -0000	1.16
>>+++ ./drivers/acpi/osl.c	26 Jan 2005 19:16:52 -0000
>>@@ -71,9 +71,6 @@ EXPORT_SYMBOL(acpi_in_debugger);
>> extern char line_buf[80];
>> #endif /*ENABLE_DEBUGGER*/
>>=20
>>-static unsigned int acpi_irq_irq;
>>-static acpi_osd_handler acpi_irq_handler;
>>-static void *acpi_irq_context;
>> static struct workqueue_struct *kacpid_wq;
>>=20
>> acpi_status
>>@@ -101,13 +98,12 @@ acpi_os_initialize1(void)
>> 	return AE_OK;
>> }
>>=20
>>+static void acpi_os_remove_interrupt_handlers(void);
>>+
>> acpi_status
>> acpi_os_terminate(void)
>> {
>>-	if (acpi_irq_handler) {
>>-		acpi_os_remove_interrupt_handler(acpi_irq_irq,
>>-						 acpi_irq_handler);
>>-	}
>>+	acpi_os_remove_interrupt_handlers();
>>=20
>> 	destroy_workqueue(kacpid_wq);
>>=20
>>@@ -264,50 +260,127 @@ acpi_os_table_override (struct acpi_tabl
>> 	return AE_OK;
>> }
>>=20
>>+struct acpi_dev_id {
>>+	acpi_osd_handler handler;
>>+	void *context;
>>+	int irq;
>>+	struct acpi_dev_id *next;
>>+};
>>+
>> static irqreturn_t
>> acpi_irq(int irq, void *dev_id, struct pt_regs *regs)
>> {
>>-	return (*acpi_irq_handler)(acpi_irq_context) ?=20
>>IRQ_HANDLED : IRQ_NONE;
>>+	struct acpi_dev_id *irq_ctx =3D dev_id;
>>+	acpi_osd_handler handler =3D irq_ctx->handler;
>>+	void *context =3D irq_ctx->context;
>>+	return (*handler)(context) ? IRQ_HANDLED : IRQ_NONE;
>>+}
>>+
>>+struct acpi_dev_id *dev_id_list;
>
>static?
>
>>+static void *alloc_dev_id(acpi_osd_handler handler, void=20
>>*context, int irq)
>>+{
>>+	struct acpi_dev_id *irq_ctx =3D kmalloc(sizeof(*irq_ctx),=20
>>GFP_KERNEL);
>
>
>Check for return value of kmalloc?
>
>
>>+	irq_ctx->handler =3D handler;
>>+	irq_ctx->context =3D context;
>>+	irq_ctx->irq =3D irq;
>>+	irq_ctx->next =3D dev_id_list;
>>+	dev_id_list =3D irq_ctx;
>>+	return irq_ctx;
>>+}
>>+
>>+/*
>>+ * XXX: Ideally, we would match the context too, but that information
>>+ * isn't passed to the acpi_os_remove_interrupt_handler() function.
>>+ */
>>+static void *find_dev_id(int irq, acpi_osd_handler handler)
>>+{
>>+	struct acpi_dev_id *irq_ctx =3D dev_id_list;
>>+	for (irq_ctx =3D dev_id_list; irq_ctx; irq_ctx =3D irq_ctx->next) {
>>+		if ((irq_ctx->handler =3D=3D handler) &&=20
>>(irq_ctx->irq =3D=3D irq))
>>+			return irq_ctx;
>>+	}
>>+	printk("find_dev_id: handler %p for irq %d not=20
>>found\n", handler, irq);
>>+	return NULL;
>>+}
>>+
>>+static void free_dev_id(struct acpi_dev_id *dev_id)
>>+{
>>+	struct acpi_dev_id **pprev =3D &dev_id_list;
>>+	for (;;) {
>>+		struct acpi_dev_id *irq_ctx =3D *pprev;
>>+		if (!irq_ctx)
>>+			break;
>>+		if (irq_ctx !=3D dev_id) {
>>+			pprev =3D &irq_ctx->next;
>>+			continue;
>>+		}
>>+
>>+		*pprev =3D irq_ctx->next;
>>+		kfree(irq_ctx);
>>+		return;
>>+	}
>>+	printk("free_dev_id: dev_id %p not found\n", dev_id);
>> }
>>=20
>> acpi_status
>> acpi_os_install_interrupt_handler(u32 gsi, acpi_osd_handler=20
>>handler, void *context)
>> {
>> 	unsigned int irq;
>>+	void *dev_id;
>>=20
>> 	/*
>>-	 * Ignore the GSI from the core, and use the value in=20
>>our copy of the
>>-	 * FADT. It may not be the same if an interrupt source=20
>>override exists
>>-	 * for the SCI.
>>+	 * If this is the FADT interrupt, ignore the GSI from=20
>>the core and
>>+	 * use the value in our copy of the FADT instead.  It=20
>>may not be the
>>+	 * same if an interrupt source override exists for the SCI.
>> 	 */
>>-	gsi =3D acpi_fadt.sci_int;
>>+	if (gsi =3D=3D acpi_gbl_FADT->sci_int)
>>+		gsi =3D acpi_fadt.sci_int;
>
>What's the deail with two copies of the FADT anyway?
>Is the assumption here that acpi_gbl_FADT has
>the original (PIC mode) sci_int value and that acpi_fadt
>has the possibly IOAPIC over-ridden value?
>And the assumption is that we're called always
>with the PIC-mode SCI value?
>
>I'm not really psyched to have two copied of the FADT,
>though that isn't the fault of this patch...
>
>> 	if (acpi_gsi_to_irq(gsi, &irq) < 0) {
>> 		printk(KERN_ERR PREFIX "SCI (ACPI GSI %d) not=20
>>registered\n",
>> 		       gsi);
>> 		return AE_OK;
>> 	}
>>=20
>>-	acpi_irq_handler =3D handler;
>>-	acpi_irq_context =3D context;
>>-	if (request_irq(irq, acpi_irq, SA_SHIRQ, "acpi", acpi_irq)) {
>>+	dev_id =3D alloc_dev_id(handler, context, irq);
>>+	if (request_irq(irq, acpi_irq, SA_SHIRQ, "acpi", dev_id)) {
>> 		printk(KERN_ERR PREFIX "SCI (IRQ%d) allocation=20
>>failed\n", irq);
>>+		free_dev_id(dev_id);
>> 		return AE_NOT_ACQUIRED;
>> 	}
>>-	acpi_irq_irq =3D irq;
>>=20
>> 	return AE_OK;
>> }
>>=20
>> acpi_status
>>-acpi_os_remove_interrupt_handler(u32 irq, acpi_osd_handler handler)
>>+acpi_os_remove_interrupt_handler(u32 gsi, acpi_osd_handler handler)
>> {
>>-	if (irq) {
>>-		free_irq(irq, acpi_irq);
>>-		acpi_irq_handler =3D NULL;
>>-		acpi_irq_irq =3D 0;
>>+	int irq;
>>+	void *dev_id;
>>+
>>+	if (gsi =3D=3D acpi_gbl_FADT->sci_int)
>>+		gsi =3D acpi_fadt.sci_int;
>>+
>>+	if (acpi_gsi_to_irq(gsi, &irq) < 0) {
>>+		printk(KERN_ERR PREFIX "SCI (ACPI GSI %d) not=20
>>registered\n",
>>+		       gsi);
>>+		return AE_OK;
>> 	}
>>=20
>>+	dev_id =3D find_dev_id(irq, handler);
>>+	free_irq(irq, dev_id);
>>+	free_dev_id(dev_id);
>>+
>> 	return AE_OK;
>>+}
>>+
>>+static void acpi_os_remove_interrupt_handlers(void)
>>+{
>>+	while (dev_id_list) {
>>+		acpi_os_remove_interrupt_handler(dev_id_list->irq,
>>+				dev_id_list->handler);
>>+	}
>> }
>>=20
>> /*
>>
>
>
>-------------------------------------------------------
>SF email is sponsored by - The IT Product Guide
>Read honest & candid reviews on hundreds of IT Products from=20
>real users.
>Discover which products truly live up to the hype. Start reading now.
>http://ads.osdn.com/?ad_ide95&alloc_id=14396&op=3Dick
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
