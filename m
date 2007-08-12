From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/2] sony-laptop: old Vaio models contain 2 IO port entries
Date: Sat, 11 Aug 2007 23:27:44 -0400
Message-ID: <200708112327.44755.lenb@kernel.org>
References: <1186796587433-git-send-email-malattia@linux.it> <11867965871757-git-send-email-malattia@linux.it> <11867965873858-git-send-email-malattia@linux.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53289 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866AbXHLD2M (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 11 Aug 2007 23:28:12 -0400
In-Reply-To: <11867965873858-git-send-email-malattia@linux.it>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>

On Friday 10 August 2007 21:43, Mattia Dongili wrote:
> Make the driver aware of this case and manage the existence of a
> second separate IO port.
> Fixes http://bugzilla.kernel.org/show_bug.cgi?id=8803

Why is this marked as a regression vs 2.6.21?
Is the problem that sonypi supported this this type of box
and sony-laptop did not, and that is when the submitter
started using sony-laptop?

They can still build and use sonypi in 2.6.22, 3 if they want, yes?

I don't see a huge risk in applying this patch, because it
seems that it (should) only have an effect on the boxes
that were not properly supported before.

But, it is pretty big for a post-rc2 type thing,
particularly if they can still use sonypi per above.
Probably appropriate to test it till 2.6.24.

-Len

> 
> Signed-off-by: Mattia Dongili <malattia@linux.it>
> ---
>  drivers/misc/sony-laptop.c |  204 ++++++++++++++++++++++++++++++++------------
>  1 files changed, 148 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
> index 1fd84a5..8f7c9ee 100644
> --- a/drivers/misc/sony-laptop.c
> +++ b/drivers/misc/sony-laptop.c
> @@ -1156,7 +1156,8 @@ static struct acpi_driver sony_nc_driver = {
>  #define SONYPI_TYPE3_OFFSET	0x12
>  
>  struct sony_pic_ioport {
> -	struct acpi_resource_io	io;
> +	struct acpi_resource_io	io1;
> +	struct acpi_resource_io	io2;
>  	struct list_head	list;
>  };
>  
> @@ -1426,11 +1427,11 @@ static u8 sony_pic_call1(u8 dev)
>  {
>  	u8 v1, v2;
>  
> -	wait_on_command(inb_p(spic_dev.cur_ioport->io.minimum + 4) & 2,
> +	wait_on_command(inb_p(spic_dev.cur_ioport->io1.minimum + 4) & 2,
>  			ITERATIONS_LONG);
> -	outb(dev, spic_dev.cur_ioport->io.minimum + 4);
> -	v1 = inb_p(spic_dev.cur_ioport->io.minimum + 4);
> -	v2 = inb_p(spic_dev.cur_ioport->io.minimum);
> +	outb(dev, spic_dev.cur_ioport->io1.minimum + 4);
> +	v1 = inb_p(spic_dev.cur_ioport->io1.minimum + 4);
> +	v2 = inb_p(spic_dev.cur_ioport->io1.minimum);
>  	dprintk("sony_pic_call1: 0x%.4x\n", (v2 << 8) | v1);
>  	return v2;
>  }
> @@ -1439,13 +1440,13 @@ static u8 sony_pic_call2(u8 dev, u8 fn)
>  {
>  	u8 v1;
>  
> -	wait_on_command(inb_p(spic_dev.cur_ioport->io.minimum + 4) & 2,
> +	wait_on_command(inb_p(spic_dev.cur_ioport->io1.minimum + 4) & 2,
>  			ITERATIONS_LONG);
> -	outb(dev, spic_dev.cur_ioport->io.minimum + 4);
> -	wait_on_command(inb_p(spic_dev.cur_ioport->io.minimum + 4) & 2,
> +	outb(dev, spic_dev.cur_ioport->io1.minimum + 4);
> +	wait_on_command(inb_p(spic_dev.cur_ioport->io1.minimum + 4) & 2,
>  			ITERATIONS_LONG);
> -	outb(fn, spic_dev.cur_ioport->io.minimum);
> -	v1 = inb_p(spic_dev.cur_ioport->io.minimum);
> +	outb(fn, spic_dev.cur_ioport->io1.minimum);
> +	v1 = inb_p(spic_dev.cur_ioport->io1.minimum);
>  	dprintk("sony_pic_call2: 0x%.4x\n", v1);
>  	return v1;
>  }
> @@ -1454,13 +1455,13 @@ static u8 sony_pic_call3(u8 dev, u8 fn, u8 v)
>  {
>  	u8 v1;
>  
> -	wait_on_command(inb_p(spic_dev.cur_ioport->io.minimum + 4) & 2, ITERATIONS_LONG);
> -	outb(dev, spic_dev.cur_ioport->io.minimum + 4);
> -	wait_on_command(inb_p(spic_dev.cur_ioport->io.minimum + 4) & 2, ITERATIONS_LONG);
> -	outb(fn, spic_dev.cur_ioport->io.minimum);
> -	wait_on_command(inb_p(spic_dev.cur_ioport->io.minimum + 4) & 2, ITERATIONS_LONG);
> -	outb(v, spic_dev.cur_ioport->io.minimum);
> -	v1 = inb_p(spic_dev.cur_ioport->io.minimum);
> +	wait_on_command(inb_p(spic_dev.cur_ioport->io1.minimum + 4) & 2, ITERATIONS_LONG);
> +	outb(dev, spic_dev.cur_ioport->io1.minimum + 4);
> +	wait_on_command(inb_p(spic_dev.cur_ioport->io1.minimum + 4) & 2, ITERATIONS_LONG);
> +	outb(fn, spic_dev.cur_ioport->io1.minimum);
> +	wait_on_command(inb_p(spic_dev.cur_ioport->io1.minimum + 4) & 2, ITERATIONS_LONG);
> +	outb(v, spic_dev.cur_ioport->io1.minimum);
> +	v1 = inb_p(spic_dev.cur_ioport->io1.minimum);
>  	dprintk("sony_pic_call3: 0x%.4x\n", v1);
>  	return v1;
>  }
> @@ -2057,7 +2058,18 @@ sony_pic_read_possible_resource(struct acpi_resource *resource, void *context)
>  
>  	switch (resource->type) {
>  	case ACPI_RESOURCE_TYPE_START_DEPENDENT:
> +		{
> +			/* start IO enumeration */
> +			struct sony_pic_ioport *ioport = kzalloc(sizeof(*ioport), GFP_KERNEL);
> +			if (!ioport)
> +				return AE_ERROR;
> +
> +			list_add(&ioport->list, &dev->ioports);
> +			return AE_OK;
> +		}
> +
>  	case ACPI_RESOURCE_TYPE_END_DEPENDENT:
> +		/* end IO enumeration */
>  		return AE_OK;
>  
>  	case ACPI_RESOURCE_TYPE_IRQ:
> @@ -2084,7 +2096,7 @@ sony_pic_read_possible_resource(struct acpi_resource *resource, void *context)
>  				if (!interrupt)
>  					return AE_ERROR;
>  
> -				list_add_tail(&interrupt->list, &dev->interrupts);
> +				list_add(&interrupt->list, &dev->interrupts);
>  				interrupt->irq.triggering = p->triggering;
>  				interrupt->irq.polarity = p->polarity;
>  				interrupt->irq.sharable = p->sharable;
> @@ -2096,18 +2108,27 @@ sony_pic_read_possible_resource(struct acpi_resource *resource, void *context)
>  	case ACPI_RESOURCE_TYPE_IO:
>  		{
>  			struct acpi_resource_io *io = &resource->data.io;
> -			struct sony_pic_ioport *ioport = NULL;
> +			struct sony_pic_ioport *ioport =
> +				list_first_entry(&dev->ioports, struct sony_pic_ioport, list);
>  			if (!io) {
>  				dprintk("Blank IO resource\n");
>  				return AE_OK;
>  			}
>  
> -			ioport = kzalloc(sizeof(*ioport), GFP_KERNEL);
> -			if (!ioport)
> +			if (!ioport->io1.minimum) {
> +				memcpy(&ioport->io1, io, sizeof(*io));
> +				dprintk("IO1 at 0x%.4x (0x%.2x)\n", ioport->io1.minimum,
> +						ioport->io1.address_length);
> +			}
> +			else if (!ioport->io2.minimum) {
> +				memcpy(&ioport->io2, io, sizeof(*io));
> +				dprintk("IO2 at 0x%.4x (0x%.2x)\n", ioport->io2.minimum,
> +						ioport->io2.address_length);
> +			}
> +			else {
> +				printk(KERN_ERR DRV_PFX "Unknown SPIC Type, more than 2 IO Ports\n");
>  				return AE_ERROR;
> -
> -			list_add_tail(&ioport->list, &dev->ioports);
> -			memcpy(&ioport->io, io, sizeof(*io));
> +			}
>  			return AE_OK;
>  		}
>  	default:
> @@ -2182,10 +2203,22 @@ static int sony_pic_enable(struct acpi_device *device,
>  {
>  	acpi_status status;
>  	int result = 0;
> +	/* Type 1 resource layout is:
> +	 *    IO
> +	 *    IO
> +	 *    IRQNoFlags
> +	 *    End
> +	 *
> +	 * Type 2 and 3 resource layout is:
> +	 *    IO
> +	 *    IRQNoFlags
> +	 *    End
> +	 */
>  	struct {
> -		struct acpi_resource io_res;
> -		struct acpi_resource irq_res;
> -		struct acpi_resource end;
> +		struct acpi_resource res1;
> +		struct acpi_resource res2;
> +		struct acpi_resource res3;
> +		struct acpi_resource res4;
>  	} *resource;
>  	struct acpi_buffer buffer = { 0, NULL };
>  
> @@ -2200,21 +2233,49 @@ static int sony_pic_enable(struct acpi_device *device,
>  	buffer.length = sizeof(*resource) + 1;
>  	buffer.pointer = resource;
>  
> -	/* setup io resource */
> -	resource->io_res.type = ACPI_RESOURCE_TYPE_IO;
> -	resource->io_res.length = sizeof(struct acpi_resource);
> -	memcpy(&resource->io_res.data.io, &ioport->io,
> -			sizeof(struct acpi_resource_io));
> +	/* setup Type 1 resources */
> +	if (spic_dev.model == SONYPI_DEVICE_TYPE1) {
>  
> -	/* setup irq resource */
> -	resource->irq_res.type = ACPI_RESOURCE_TYPE_IRQ;
> -	resource->irq_res.length = sizeof(struct acpi_resource);
> -	memcpy(&resource->irq_res.data.irq, &irq->irq,
> -			sizeof(struct acpi_resource_irq));
> -	/* we requested a shared irq */
> -	resource->irq_res.data.irq.sharable = ACPI_SHARED;
> +		/* setup io resources */
> +		resource->res1.type = ACPI_RESOURCE_TYPE_IO;
> +		resource->res1.length = sizeof(struct acpi_resource);
> +		memcpy(&resource->res1.data.io, &ioport->io1,
> +				sizeof(struct acpi_resource_io));
>  
> -	resource->end.type = ACPI_RESOURCE_TYPE_END_TAG;
> +		resource->res2.type = ACPI_RESOURCE_TYPE_IO;
> +		resource->res2.length = sizeof(struct acpi_resource);
> +		memcpy(&resource->res2.data.io, &ioport->io2,
> +				sizeof(struct acpi_resource_io));
> +
> +		/* setup irq resource */
> +		resource->res3.type = ACPI_RESOURCE_TYPE_IRQ;
> +		resource->res3.length = sizeof(struct acpi_resource);
> +		memcpy(&resource->res3.data.irq, &irq->irq,
> +				sizeof(struct acpi_resource_irq));
> +		/* we requested a shared irq */
> +		resource->res3.data.irq.sharable = ACPI_SHARED;
> +
> +		resource->res4.type = ACPI_RESOURCE_TYPE_END_TAG;
> +
> +	}
> +	/* setup Type 2/3 resources */
> +	else {
> +		/* setup io resource */
> +		resource->res1.type = ACPI_RESOURCE_TYPE_IO;
> +		resource->res1.length = sizeof(struct acpi_resource);
> +		memcpy(&resource->res1.data.io, &ioport->io1,
> +				sizeof(struct acpi_resource_io));
> +
> +		/* setup irq resource */
> +		resource->res2.type = ACPI_RESOURCE_TYPE_IRQ;
> +		resource->res2.length = sizeof(struct acpi_resource);
> +		memcpy(&resource->res2.data.irq, &irq->irq,
> +				sizeof(struct acpi_resource_irq));
> +		/* we requested a shared irq */
> +		resource->res2.data.irq.sharable = ACPI_SHARED;
> +
> +		resource->res3.type = ACPI_RESOURCE_TYPE_END_TAG;
> +	}
>  
>  	/* Attempt to set the resource */
>  	dprintk("Evaluating _SRS\n");
> @@ -2222,7 +2283,7 @@ static int sony_pic_enable(struct acpi_device *device,
>  
>  	/* check for total failure */
>  	if (ACPI_FAILURE(status)) {
> -		printk(KERN_ERR DRV_PFX "Error evaluating _SRS");
> +		printk(KERN_ERR DRV_PFX "Error evaluating _SRS\n");
>  		result = -ENODEV;
>  		goto end;
>  	}
> @@ -2251,11 +2312,14 @@ static irqreturn_t sony_pic_irq(int irq, void *dev_id)
>  
>  	struct sony_pic_dev *dev = (struct sony_pic_dev *) dev_id;
>  
> -	ev = inb_p(dev->cur_ioport->io.minimum);
> -	data_mask = inb_p(dev->cur_ioport->io.minimum + dev->evport_offset);
> +	ev = inb_p(dev->cur_ioport->io1.minimum);
> +	if (dev->cur_ioport->io2.minimum)
> +		data_mask = inb_p(dev->cur_ioport->io2.minimum);
> +	else
> +		data_mask = inb_p(dev->cur_ioport->io1.minimum + dev->evport_offset);
>  
>  	dprintk("event ([%.2x] [%.2x]) at port 0x%.4x(+0x%.2x)\n",
> -			ev, data_mask, dev->cur_ioport->io.minimum, dev->evport_offset);
> +			ev, data_mask, dev->cur_ioport->io1.minimum, dev->evport_offset);
>  
>  	if (ev == 0x00 || ev == 0xff)
>  		return IRQ_HANDLED;
> @@ -2308,8 +2372,11 @@ static int sony_pic_remove(struct acpi_device *device, int type)
>  	}
>  
>  	free_irq(spic_dev.cur_irq->irq.interrupts[0], &spic_dev);
> -	release_region(spic_dev.cur_ioport->io.minimum,
> -			spic_dev.cur_ioport->io.address_length);
> +	release_region(spic_dev.cur_ioport->io1.minimum,
> +			spic_dev.cur_ioport->io1.address_length);
> +	if (spic_dev.cur_ioport->io2.minimum)
> +		release_region(spic_dev.cur_ioport->io2.minimum,
> +				spic_dev.cur_ioport->io2.address_length);
>  
>  	sony_laptop_remove_input();
>  
> @@ -2377,14 +2444,36 @@ static int sony_pic_add(struct acpi_device *device)
>  	}
>  
>  	/* request io port */
> -	list_for_each_entry(io, &spic_dev.ioports, list) {
> -		if (request_region(io->io.minimum, io->io.address_length,
> +	list_for_each_entry_reverse(io, &spic_dev.ioports, list) {
> +		if (request_region(io->io1.minimum, io->io1.address_length,
>  					"Sony Programable I/O Device")) {
> -			dprintk("I/O port: 0x%.4x (0x%.4x) + 0x%.2x\n",
> -					io->io.minimum, io->io.maximum,
> -					io->io.address_length);
> -			spic_dev.cur_ioport = io;
> -			break;
> +			dprintk("I/O port1: 0x%.4x (0x%.4x) + 0x%.2x\n",
> +					io->io1.minimum, io->io1.maximum,
> +					io->io1.address_length);
> +			/* Type 1 have 2 ioports */
> +			if (io->io2.minimum) {
> +				if (request_region(io->io2.minimum,
> +						io->io2.address_length,
> +						"Sony Programable I/O Device")) {
> +					dprintk("I/O port2: 0x%.4x (0x%.4x) + 0x%.2x\n",
> +							io->io2.minimum, io->io2.maximum,
> +							io->io2.address_length);
> +					spic_dev.cur_ioport = io;
> +					break;
> +				}
> +				else {
> +					dprintk("Unable to get I/O port2: "
> +							"0x%.4x (0x%.4x) + 0x%.2x\n",
> +							io->io2.minimum, io->io2.maximum,
> +							io->io2.address_length);
> +					release_region(io->io1.minimum,
> +							io->io1.address_length);
> +				}
> +			}
> +			else {
> +				spic_dev.cur_ioport = io;
> +				break;
> +			}
>  		}
>  	}
>  	if (!spic_dev.cur_ioport) {
> @@ -2394,7 +2483,7 @@ static int sony_pic_add(struct acpi_device *device)
>  	}
>  
>  	/* request IRQ */
> -	list_for_each_entry(irq, &spic_dev.interrupts, list) {
> +	list_for_each_entry_reverse(irq, &spic_dev.interrupts, list) {
>  		if (!request_irq(irq->irq.interrupts[0], sony_pic_irq,
>  					IRQF_SHARED, "sony-laptop", &spic_dev)) {
>  			dprintk("IRQ: %d - triggering: %d - "
> @@ -2445,8 +2534,11 @@ err_free_irq:
>  	free_irq(spic_dev.cur_irq->irq.interrupts[0], &spic_dev);
>  
>  err_release_region:
> -	release_region(spic_dev.cur_ioport->io.minimum,
> -			spic_dev.cur_ioport->io.address_length);
> +	release_region(spic_dev.cur_ioport->io1.minimum,
> +			spic_dev.cur_ioport->io1.address_length);
> +	if (spic_dev.cur_ioport->io2.minimum)
> +		release_region(spic_dev.cur_ioport->io2.minimum,
> +				spic_dev.cur_ioport->io2.address_length);
>  
>  err_remove_input:
>  	sony_laptop_remove_input();
