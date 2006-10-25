From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [patch 0/2] acpi: driverregistration again can report ENODEV
Date: Wed, 25 Oct 2006 18:40:31 +0800
Message-ID: <1161772831.14917.36.camel@localhost.localdomain>
References: <20061020092547.519734000@neutrino.suse.de>
	 <1161338381.32262.114.camel@queen.suse.de>
	 <200610201055.33931.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43315 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1423213AbWJYKiU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Oct 2006 06:38:20 -0400
In-Reply-To: <200610201055.33931.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: trenn@suse.de, fseidel@suse.de, linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>, shaohua.li@intel.com

We won't have such issues if we make ACPI use driver model.
I've sent out a patch series which throw the legacy ACPI driver model
away. The patches will be added to -mm tree.

On Sat, 2006-10-21 at 00:55 +0800, Bjorn Helgaas wrote:
> > acpi_bus_register_driver must return -ENODEV when no device with
> > matching HID was found. E.g. battery also should currently get
> always
> > loaded even a system never has one.
> 
> If the driver wants to unload if it doesn't find any devices,
> it can easily do so by counting calls to its add() method, as
> asus_acpi.c currently does.  I don't think that's a good long-
> term solution, though.  I think it would be better to have a
> hotplug scheme that loads the driver when the hardware is
> found, like we do for PCI.
> 
that's true. With this patch series, .uevent method of ACPI bus will be
called when an ACPI device is found. Then udev script loads the right
driver by checking hid/cid offered by .uevent method. 

thanks,
Rui
