From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: device model?
Date: Thu, 12 Jun 2003 08:51:30 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0306120834020.11379-100000@cherise>
References: <20030612153024.GJ30843@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030612153024.GJ30843-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> But I have some devices which _only_ have a firmware representation.
> For example, there's a couple of serial ports on this workstation which
> can't be found any other way.  Then there's the SBA and LBA devices I
> mention below.  These devices have basically nothing in common except
> that they only have an acpi_device to represent them.

Hm, we have a name for that - motivation :) 

> hmm.  so you want a serial_object, an lba_object and an sba_object?
> then we can tie them together through the namespaces?  I feel lost in
> a maze of pointers, all subtly different.

Heh. Basically yes, we do want those objects. At least for serial, ACPI is
used only for discovery and resource management, not for actually
communicating with the device. There should also already be a
serial_object of some sort, though there may not be a method for the
system, or firmware driver, to tell the serial core to add the device.

Something like this:

	acpi_device * acpidev;


	/* Scan ACPI devices */ 

	if (is_serial_device(acpidev)) {
		struct serial_device * serdev;
		serdev = kmalloc(sizeof(struct serial_device),GFP_KERNEL);

		/* Initialize with resource information, etc */

		if (!(error = serial_add_device(serdev))) {
			sysfs_create_link(&acpidev->kobj,
                                          &serdev->dev.kobj,
                                          "device");
			sysfs_create_link(&serdev->dev.kobj,
                                          &acpidev->kobj,
                                          "ACPI");
		}
	}

should suffice, as well as add symlinks to bridge the representations. 

As for the other objects, you want something similar, though the format 
of representing the device and notifying the drivers is up to you..


	-pat



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
