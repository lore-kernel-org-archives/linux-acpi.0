From: Mattia Dongili <malattia@linux.it>
Subject: [HELP] sonypi going acpi-only
Date: Sun, 25 Feb 2007 20:02:46 +0100
Message-ID: <20070225190246.GA29882@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-jp
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa012msr.fastwebnet.it ([85.18.95.72]:54636 "EHLO
	aa012msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965099AbXBYTCx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 25 Feb 2007 14:02:53 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Stelian Pop <stelian@popies.net>

Hello,

I'm currently rewriting sonypi to use acpi-only functions for its
initialization. It seems I'm successful in this except that I don't get
IRQs on button or jogdial events. Actually 2 irqs are reported on device
enabling and disabling (_SRS and _DIS).
No irq is even reported in /proc/interrupts except the two mentioned.

This is sonypi v/s sony-pic (my driver) log, the 'event' is the irq
handling:

sonypi: Sony Programmable I/O Controller Driver v1.26.
sonypi: detected type3 model, verbose = 2, fnkeyinit = off, camera = off, compat = off, mask = 0xffffffff, useinput = on, acpi = on
sonypi: enabled at irq=11, port1=0x1080, port2=0x1084
sonypi: device allocated minor is 63
input: Sony Vaio Jogdial as /class/input/input25
input: Sony Vaio Keys as /class/input/input26
sonypi: event port1=0x00,port2=0xff
sonypi: event port1=0x00,port2=0xff
sonypi: unknown event port1=0x0e,port2=0xff	<== end module loading
sonypi: event port1=0x5c,port2=0xff		<== button press
sonypi: event port1=0x5c,port2=0xff
sonypi: event port1=0x00,port2=0xff		<== module unload
sonypi: unknown event port1=0xff,port2=0xff
sonypi: removed.

sony-pic: Sony Programmable I/O Controller Driver v0.1.
sony-pic: Device disabled
sony-pic: I/O port: 0x1080 + 0x20
sony-pic: IRQ: 11 - triggering: 1
sony-pic: event (0xffffffff) at port 1080	<== irq after _SRS
sony-pic: Device enabled
sony-pic: Current IO port: 1080 + 0020
sony-pic: Current IRQ 11			<== end module loading
sony-pic: event (0xffffffff) at port 1080	<== module unload (_DIS)
sony-pic: removed.

sony-pic.c follows anyway something that is easily noticeable is that it
reads a different value when reading the ioport... I guess it's telling
me that the device has not been enabled correctly (??).

Can you see anything obvious I'm missing, especially in sony_pic_enable
or sony_pic_add?

Some useful info:
- a DSDT of a (formerly in sonypi) Type3 SPIC:
  http://www.linux.it/~malattia/sony-pic/DSDT.sz72b.dsl
- a DSDT of a (formerly in sonypi) Type2 SPIC: 
  http://www.linux.it/~malattia/sony-pic/DSDT.gr7k.dsl
(Look for Device(SPIC) or SNY6001)
- a nice makefile to build the driver:
  http://www.linux.it/~malattia/sony-pic/Makefile
- the driver itself (also included at the end of this mail):
  http://www.linux.it/~malattia/sony-pic/sony-pic.c
- the driver didn't burn my HW on a Type2 and Type3 devices :)

Thanks for any suggestion/hint.
-- 
mattia
:wq!

/*
 * Sony Programmable I/O Control Device driver for VAIO
 *
 * Copyright (C) 2007 Mattia Dongili <malattia@linux.it>
 *
 * This driver is based on previous work which includes material from:
 *
 * Copyright (C) 2001-2005 Stelian Pop <stelian@popies.net>
 *
 * Copyright (C) 2005 Narayanan R S <nars@kadamba.org>
 *
 * Copyright (C) 2001-2002 Alc?ve <www.alcove.com>
 *
 * Copyright (C) 2001 Michael Ashley <m.ashley@unsw.edu.au>
 *
 * Copyright (C) 2001 Junichi Morita <jun1m@mars.dti.ne.jp>
 *
 * Copyright (C) 2000 Takaya Kinjo <t-kinjo@tc4.so-net.ne.jp>
 *
 * Copyright (C) 2000 Andrew Tridgell <tridge@valinux.com>
 *
 * Earlier work by Werner Almesberger, Paul `Rusty' Russell and Paul Mackerras.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 */

#include <linux/module.h>
#include <linux/dmi.h>
#include <linux/acpi.h>
#include <linux/pci.h>
#include <linux/interrupt.h>

#define SONY_PIC_DEBUG 1

#define SONYPIC_DRIVER_VERSION	"0.1"
#define SONY_PIC_PREFIX		"sony-pic: "

#ifdef SONY_PIC_DEBUG
#define dprintk(msg...)		printk(KERN_WARNING SONY_PIC_PREFIX  msg)
#else
#define dprintk(msg...)
#endif

#define ACPI_PIC_DRIVER_NAME	"sony-pic"
#define ACPI_PIC_CLASS		"sony"
#define ACPI_PIC_HID		"SNY6001"

MODULE_AUTHOR("Mattia Dongili <malattia@linux.it>");
MODULE_DESCRIPTION("Sony Programmable I/O Control Device driver (ACPI based)");
MODULE_LICENSE("GPL");
MODULE_VERSION(SONYPIC_DRIVER_VERSION);

struct sony_pic_ioport {
	struct acpi_resource_io	io;
	struct list_head	list;
};

struct sony_pic_irq {
	struct acpi_resource_irq	irq;
	struct list_head		list;
};

struct sony_pic_dev {
	acpi_handle		*handle;
	struct sony_pic_irq	*cur_irq;
	struct sony_pic_ioport	*cur_ioport;
	struct list_head	interrupts;
	struct list_head	ioports;
};

static struct sony_pic_dev spic_dev = {
	.interrupts	= LIST_HEAD_INIT(spic_dev.interrupts),
	.ioports	= LIST_HEAD_INIT(spic_dev.ioports),
};

#ifdef SONY_PIC_DEBUG
static acpi_status
sony_pic_read_current_resource(struct acpi_resource *resource, void *context)
{
	switch (resource->type) {
	case ACPI_RESOURCE_TYPE_IRQ:
		{
			struct acpi_resource_irq *p = &resource->data.irq;
			if (!p || !p->interrupt_count) {
				/*
				 * IRQ descriptors may have no IRQ# bits set,
				 * particularly those those w/ _STA disabled
				 */
				dprintk("Blank IRQ resource\n");
				return AE_OK;
			}
			dprintk("Current IRQ %d\n", p->interrupts[0]);
			return AE_OK;
		}
	case ACPI_RESOURCE_TYPE_IO:
		{
			struct acpi_resource_io *io = &resource->data.io;
			if (!io) {
				dprintk("Blank IO resource\n");
				return AE_OK;
			}

			dprintk("Current IO port: 0x%.4x + 0x%.2x\n",
					io->minimum, io->address_length);
			return AE_OK;
		}
	default:
		dprintk("Resource %d isn't an IRQ nor an IO port\n",
				resource->type);

	case ACPI_RESOURCE_TYPE_END_TAG:
		return AE_OK;
	}
	return AE_CTRL_TERMINATE;
}
#define sony_pic_current_resources(device) \
		sony_pic_resources(device, METHOD_NAME__CRS, \
				sony_pic_read_current_resource);
#endif /* SONY_PIC_DEBUG */

static acpi_status
sony_pic_read_possible_resource(struct acpi_resource *resource, void *context)
{
	u32 i;
	struct sony_pic_dev *dev = (struct sony_pic_dev *)context;

	switch (resource->type) {
	case ACPI_RESOURCE_TYPE_START_DEPENDENT:
	case ACPI_RESOURCE_TYPE_END_DEPENDENT:
		return AE_OK;

	case ACPI_RESOURCE_TYPE_IRQ:
		{
			struct acpi_resource_irq *p = &resource->data.irq;
			struct sony_pic_irq *interrupt = NULL;
			if (!p || !p->interrupt_count) {
				/*
				 * IRQ descriptors may have no IRQ# bits set,
				 * particularly those those w/ _STA disabled
				 */
				dprintk("Blank IRQ resource\n");
				return AE_OK;
			}
			for (i = 0; i < p->interrupt_count; i++) {
				if (!p->interrupts[i]) {
					printk(KERN_WARNING SONY_PIC_PREFIX
							"Invalid IRQ %d\n",
							p->interrupts[i]);
					continue;
				}
				interrupt = kzalloc(sizeof(*interrupt),
						GFP_KERNEL);
				if (!interrupt)
					return AE_ERROR;

				list_add(&interrupt->list, &dev->interrupts);
				interrupt->irq.triggering = p->triggering;
				interrupt->irq.polarity = p->polarity;
				interrupt->irq.sharable = p->sharable;
				interrupt->irq.interrupt_count = 1;
				interrupt->irq.interrupts[0] = p->interrupts[i];
			}
			return AE_OK;
		}
	case ACPI_RESOURCE_TYPE_IO:
		{
			struct acpi_resource_io *io = &resource->data.io;
			struct sony_pic_ioport *ioport = NULL;
			if (!io) {
				dprintk("Blank IO resource\n");
				return AE_OK;
			}

			ioport = kzalloc(sizeof(*ioport), GFP_KERNEL);
			if (!ioport)
				return AE_ERROR;

			list_add(&ioport->list, &dev->ioports);
			memcpy(&ioport->io, io, sizeof(*io));
			return AE_OK;
		}
	default:
		dprintk("Resource %d isn't an IRQ nor an IO port\n",
				resource->type);

	case ACPI_RESOURCE_TYPE_END_TAG:
		return AE_OK;
	}
	return AE_CTRL_TERMINATE;
}
#define sony_pic_possible_resources(device) \
		sony_pic_resources(device, METHOD_NAME__PRS, \
				sony_pic_read_possible_resource);

static int sony_pic_resources(struct acpi_device *device, char *method,
		acpi_status (*callback) (struct acpi_resource *resource,
			void *context))
{
	int result = 0;
	acpi_status status = AE_OK;

	if (!device)
		return -EINVAL;

	dprintk("Evaluating %s\n", method);

	/* get device status */
	/* see acpi_pci_link_get_current acpi_pci_link_get_possible */
	result = acpi_bus_get_status(device);
	if (result) {
		printk(KERN_WARNING SONY_PIC_PREFIX "Unable to read status\n");
		goto end;
	}

	if (!device->status.enabled)
		dprintk("Device disabled\n");
	else
		dprintk("Device enabled\n");

	/*
	 * Query and parse 'method'
	 */
	status = acpi_walk_resources(device->handle, method, callback,
			&spic_dev);
	if (ACPI_FAILURE(status)) {
		printk(KERN_WARNING SONY_PIC_PREFIX
				"Failure evaluating %s\n", method);
		result = -ENODEV;
	}
end:
	return result;
}

/*
 *  Disable the spic device by calling its _DIS method
 */
static int sony_pic_disable(struct acpi_device *device)
{
#ifdef SONY_PIC_DEBUG
	/* debug: query _CRS and print current settings */
	sony_pic_current_resources(device);
#endif
	if (ACPI_FAILURE(acpi_evaluate_object(device->handle, "_DIS", 0, NULL)))
		return -ENXIO;

	dprintk("Device disabled\n");
	return 0;
}


/*
 *  Based on drivers/acpi/pci_link.c:acpi_pci_link_set
 *
 *  Call _SRS to set current resources
 */
static int sony_pic_enable(struct acpi_device *device,
		struct sony_pic_ioport *ioport, struct sony_pic_irq *irq)
{
	acpi_status status;
	int result = 0;
	struct {
		struct acpi_resource io_res;
		struct acpi_resource irq_res;
		struct acpi_resource end;
	} *resource;
	struct acpi_buffer buffer = { 0, NULL };

	if (!ioport || !irq)
		return -EINVAL;

	/* init acpi_buffer */
	resource = kzalloc(sizeof(*resource) + 1, GFP_KERNEL);
	if (!resource)
		return -ENOMEM;

	buffer.length = sizeof(*resource) + 1;
	buffer.pointer = resource;

	/* setup io resource */
	resource->io_res.type = ACPI_RESOURCE_TYPE_IO;
	resource->io_res.length = sizeof(struct acpi_resource);
	memcpy(&resource->io_res.data.io, &ioport->io,
			sizeof(struct acpi_resource_io));

	/* setup irq resource */
	resource->irq_res.type = ACPI_RESOURCE_TYPE_IRQ;
	resource->irq_res.length = sizeof(struct acpi_resource);
	memcpy(&resource->irq_res.data.irq, &irq->irq,
			sizeof(struct acpi_resource_irq));
	/* we requested a shared irq */
	resource->irq_res.data.irq.sharable = ACPI_SHARED;

	resource->end.type = ACPI_RESOURCE_TYPE_END_TAG;

	/* Attempt to set the resource */
	status = acpi_set_current_resources(device->handle, &buffer);

	/* check for total failure */
	if (ACPI_FAILURE(status)) {
		printk(KERN_ERR SONY_PIC_PREFIX "Error evaluating _SRS");
		result = -ENODEV;
		goto end;
	}

#ifdef SONY_PIC_DEBUG
	/* debug: query _CRS and print current settings */
	sony_pic_current_resources(device);
#endif

end:
	kfree(resource);
	return result;
}


/* Interrupt handler: some event is available */
static irqreturn_t sony_pic_irq(int irq, void *dev_id)
{
	unsigned int v = 0;
	struct sony_pic_dev *dev = (struct sony_pic_dev *) dev_id;

	switch (dev->cur_ioport->io.address_length) {
		case 8:
			v = inb_p(dev->cur_ioport->io.minimum);
			break;
		case 16:
			v = inw_p(dev->cur_ioport->io.minimum);
			break;
		case 32:
			v = inl_p(dev->cur_ioport->io.minimum);
			break;
		default:
			printk(KERN_WARNING SONY_PIC_PREFIX "unknown addr length "
					"(0x%.2x)\n",
					dev->cur_ioport->io.address_length);
			return IRQ_HANDLED;
	}
	/* from SONYPI */
	/*
	u8 v1, v2, event = 0;

	v1 = inb_p(sonypi_device.ioport1);
	v2 = inb_p(sonypi_device.ioport1 + sonypi_device.evtype_offset);

	printk(KERN_INFO "sonypi: event port1=0x%02x,port2=0x%02x\n", v1, v2);
	*/

	printk(KERN_INFO SONY_PIC_PREFIX "event (0x%.8x) at port %.4x\n", v,
			dev->cur_ioport->io.minimum);
	return IRQ_HANDLED;
}

/*****************
 *
 *  ACPI driver
 *
 *****************/
static int sony_pic_remove(struct acpi_device *device, int type)
{
	struct sony_pic_ioport *io, *tmp_io;
	struct sony_pic_irq *irq, *tmp_irq;

	if (sony_pic_disable(device)) {
		printk(KERN_ERR SONY_PIC_PREFIX "Couldn't disable device.\n");
		return -ENXIO;
	}

	free_irq(spic_dev.cur_irq->irq.interrupts[0], &spic_dev);
	release_region(spic_dev.cur_ioport->io.minimum,
			spic_dev.cur_ioport->io.address_length);

	list_for_each_entry_safe(io, tmp_io, &spic_dev.ioports, list) {
		list_del(&io->list);
		kfree(io);
	}
	list_for_each_entry_safe(irq, tmp_irq, &spic_dev.interrupts, list) {
		list_del(&irq->list);
		kfree(irq);
	}
	spic_dev.cur_ioport = NULL;
	spic_dev.cur_irq = NULL;

	dprintk("removed.\n");
	return 0;
}

static int sony_pic_add(struct acpi_device *device)
{
	int result;
	struct sony_pic_ioport *io, *tmp_io;
	struct sony_pic_irq *irq, *tmp_irq;

	printk(KERN_INFO
		"sony-pic: Sony Programmable I/O Controller Driver v%s.\n",
		SONYPIC_DRIVER_VERSION);

	spic_dev.handle = device->handle;

	/* read _PRS resources */
	result = sony_pic_possible_resources(device);
	if (result) {
		printk(KERN_ERR SONY_PIC_PREFIX
				"Unabe to read possible resources.\n");
		goto err_free_resources;
	}

	/* request io port */
	list_for_each_entry_reverse(io, &spic_dev.ioports, list) {
		if (request_region(io->io.minimum, io->io.address_length,
					"Sony Programable I/O Device")) {
			dprintk("I/O port: 0x%.4x + 0x%.2x\n",
					io->io.minimum, io->io.address_length);
			spic_dev.cur_ioport = io;
			break;
		}
	}
	if (!spic_dev.cur_ioport) {
		printk(KERN_ERR SONY_PIC_PREFIX "Failed to request_region.\n");
		result = -ENODEV;
		goto err_free_resources;
	}

	/* request IRQ */
	list_for_each_entry(irq, &spic_dev.interrupts, list) {
		if (!request_irq(irq->irq.interrupts[0], sony_pic_irq,
					IRQF_SHARED, "sony-pic", &spic_dev)) {
			dprintk("IRQ: %d - triggering: %d\n",
					irq->irq.interrupts[0],
					irq->irq.triggering);
			spic_dev.cur_irq = irq;
			break;
		}
	}
	if (!spic_dev.cur_irq) {
		printk(KERN_ERR SONY_PIC_PREFIX "Failed to request_irq.\n");
		result = -ENODEV;
		goto err_release_region;
	}

	/* set resource status _SRS */
	result = sony_pic_enable(device, spic_dev.cur_ioport, spic_dev.cur_irq);
	if (result) {
		printk(KERN_ERR SONY_PIC_PREFIX "Couldn't enable device.\n");
		goto err_free_irq;
	}

	return 0;

err_free_irq:
	free_irq(spic_dev.cur_irq->irq.interrupts[0], &spic_dev);

err_release_region:
	release_region(spic_dev.cur_ioport->io.minimum, spic_dev.cur_ioport->io.address_length);

err_free_resources:
	list_for_each_entry_safe(io, tmp_io, &spic_dev.ioports, list) {
		list_del(&io->list);
		kfree(io);
	}
	list_for_each_entry_safe(irq, tmp_irq, &spic_dev.interrupts, list) {
		list_del(&irq->list);
		kfree(irq);
	}
	spic_dev.cur_ioport = NULL;
	spic_dev.cur_irq = NULL;

	return result;
}

static int sony_pic_suspend(struct acpi_device *device, pm_message_t state)
{
	if (sony_pic_disable(device))
		return -ENXIO;
	return 0;
}

static int sony_pic_resume(struct acpi_device *device)
{
	sony_pic_enable(device, spic_dev.cur_ioport, spic_dev.cur_irq);
	return 0;
}

static struct acpi_driver sony_pic_driver = {
	.name = ACPI_PIC_DRIVER_NAME,
	.class = ACPI_PIC_CLASS,
	.ids = ACPI_PIC_HID,
	.ops = {
		.add = sony_pic_add,
		.remove = sony_pic_remove,
		.suspend = sony_pic_suspend,
		.resume = sony_pic_resume,
		},
};

static struct dmi_system_id __initdata sonypi_dmi_table[] = {
	{
		.ident = "Sony Vaio",
		.matches = {
			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
			DMI_MATCH(DMI_PRODUCT_NAME, "PCG-"),
		},
	},
	{
		.ident = "Sony Vaio",
		.matches = {
			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-"),
		},
	},
	{ }
};

static int __init sony_pic_init(void)
{
	if (!dmi_check_system(sonypi_dmi_table))
		return -ENODEV;

	return acpi_bus_register_driver(&sony_pic_driver);
}

static void __exit sony_pic_exit(void)
{
	acpi_bus_unregister_driver(&sony_pic_driver);
}

module_init(sony_pic_init);
module_exit(sony_pic_exit);
