From: Norbert Preining <preining@logic.at>
Subject: Re: discrete nvidia switch on/off for Asus UL30Vt, Asus UL50V and
 Asus UL80V laptops
Date: Wed, 30 Dec 2009 13:50:15 +0900
Message-ID: <20091230045015.GA16075@gandalf.dynalias.org>
References: <358f4d650912291411t687d0398y4ebc80fb254a2ba3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:36597 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbZL3FJs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2009 00:09:48 -0500
Content-Disposition: inline
In-Reply-To: <358f4d650912291411t687d0398y4ebc80fb254a2ba3@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Albert Vilella <avilella@gmail.com>
Cc: linux-acpi@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, 29 Dec 2009, Albert Vilella wrote:
> One of the Asus UL30Vt laptop Linux users has found a solution to
> switch on/off the discrete nvidia card

There is also a quick module written by Matthew Garrett to turn off
the nvidia on sony laptops. I attach it here for completeness.

I think it would be a very good idea (in fact some days ago I was
discussing with Mattia from sony-laptop about this) to have some module
that allows switching on/off graphics cards... Currently that means
mostly ATI or nVidia.

Best wishes

Norbert

----------------------------------------------------------------------------
Norbert Preining                preining@{jaist.ac.jp, logic.at, debian.org}
JAIST, Japan               TU Wien, Austria            Debian TeX Task Force
gpg DSA: 0x09C5B094   fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
----------------------------------------------------------------------------
WORMELOW TUMP (n.)
Any seventeen-year-old who doesn't know about anything at all in the
world other than bicycle gears.
			--- Douglas Adams, The Meaning of Liff

--x+6KMIRAuhnl3hBn
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="nvidia-control.c"

#include <linux/acpi.h>
#include <acpi/acpi_drivers.h>
#include <acpi/acpi_bus.h>
#include <linux/pci.h>

static int nvidia_dsm(struct pci_dev *dev, int func, int arg, int *result)
{
	static char muid[] = {
		0xA0, 0xA0, 0x95, 0x9D, 0x60, 0x00, 0x48, 0x4D,
		0xB3, 0x4D, 0x7E, 0x5F, 0xEA, 0x12, 0x9F, 0xD4,
	};

	struct acpi_handle *handle;
	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
	struct acpi_object_list input;
	union acpi_object params[4];
	union acpi_object *obj;
	int err;

	handle = DEVICE_ACPI_HANDLE(&dev->dev);

	if (!handle)
		return -ENODEV;

	input.count = 4;
	input.pointer = params;
	params[0].type = ACPI_TYPE_BUFFER;
	params[0].buffer.length = sizeof(muid);
	params[0].buffer.pointer = (char *)muid;
	params[1].type = ACPI_TYPE_INTEGER;
	params[1].integer.value = 0x00000102;
	params[2].type = ACPI_TYPE_INTEGER;
	params[2].integer.value = func;
	params[3].type = ACPI_TYPE_INTEGER;
	params[3].integer.value = arg;

	err = acpi_evaluate_object(handle, "_DSM", &input, &output);
	if (err) {
		printk(KERN_ERR "nvidia-control: failed to evaluate _DSM: %d\n",
		       err);
		return err;
	}

	obj = (union acpi_object *)output.pointer;

	if (obj->type == ACPI_TYPE_INTEGER)
		if (obj->integer.value == 0x80000002)
			return -ENODEV;

	if (obj->type == ACPI_TYPE_BUFFER) {
		if (obj->buffer.length == 4 && result) {
			*result = 0;
			*result |= obj->buffer.pointer[0];
			*result |= (obj->buffer.pointer[1] << 8);
			*result |= (obj->buffer.pointer[2] << 16);
			*result |= (obj->buffer.pointer[3] << 24);
		}
	}

	kfree(output.pointer);
	return 0;
}

int nvidia_control_setup(struct pci_dev *dev)
{
	int result;

	if (nvidia_dsm(dev, 1, 0, &result))
		return -ENODEV;

	printk(KERN_INFO "nvidia-control: hardware status gave 0x%x\n", result);

	if (result &= 0x1) {	/* Stamina mode - disable the external GPU */
		nvidia_dsm(dev, 0x2, 0x11, NULL);
		nvidia_dsm(dev, 0x3, 0x02, NULL);
	} else {		/* Ensure that the external GPU is enabled */
		nvidia_dsm(dev, 0x2, 0x12, NULL);
		nvidia_dsm(dev, 0x3, 0x01, NULL);
	}

	return 0;
}

int nvidia_control_probe(struct pci_dev *dev)
{
	int support = 0;
	
	if (nvidia_dsm(dev, 0, 0, &support))
		 return -ENODEV;

	if (!support)
		return -ENODEV;

	return 0;
}

static int __init nvidia_control_init(void)
{
	struct pci_dev *dev = NULL;
	while ((dev = pci_get_device(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID, dev))) {
		if (dev->class == 0x30000)
			if (!nvidia_control_probe(dev))
				nvidia_control_setup(dev);
	}
	return 0;
}

static void __exit nvidia_control_exit(void)
{
	return;
}

static const struct pci_device_id pci_ids [] = {
	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
	  (PCI_CLASS_DISPLAY_VGA << 8), 0xffff00},
	{ },
};

MODULE_DEVICE_TABLE(pci, pci_ids);

module_init(nvidia_control_init);
module_exit(nvidia_control_exit);

MODULE_LICENSE("GPL");

--x+6KMIRAuhnl3hBn--
