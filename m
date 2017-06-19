From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] ACPI / scan: Fix enumeration for special SPI and I2C
 devices
Date: Mon, 19 Jun 2017 23:12:24 +0300
Message-ID: <20170619201224.GP629@lahna.fi.intel.com>
References: <20170619125301.7016-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:46065 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750947AbdFSUQt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Jun 2017 16:16:49 -0400
Content-Disposition: inline
In-Reply-To: <20170619125301.7016-1-jarkko.nikula@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>

On Mon, Jun 19, 2017 at 03:53:01PM +0300, Jarkko Nikula wrote:
> Commit f406270bf73d ("ACPI / scan: Set the visited flag for all
> enumerated devices") caused that two group of special SPI or I2C
> devices do not enumerate. SPI and I2C devices are expected to be
> enumerated by the SPI and I2C subsystems but change caused that
> acpi_bus_attach() marks those devices with acpi_device_set_enumerated().
> 
> First group of devices are matched using Device Tree compatible property
> with special _HID "PRP0001". Those devices have matched scan handler,
> acpi_scan_attach_handler() retuns 1 and acpi_bus_attach() marks them
> with acpi_device_set_enumerated().
> 
> Second group of devices without valid _HID such as "LNXVIDEO" have
> device->pnp.type.platform_id set to zero and change again marks them
> with acpi_device_set_enumerated().
> 
> Fix this by flagging the SPI and I2C devices during struct acpi_device
> object initialization time and let the code in acpi_bus_attach() to go
> through the device_attach() and acpi_default_enumeration() path for all
> SPI and I2C devices.
> 
> Fixes: f406270bf73d ("ACPI / scan: Set the visited flag for all enumerated devices")
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
