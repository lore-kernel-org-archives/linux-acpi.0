From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: ACPI / hotplug / PCI: Rework the handling of eject requests
Date: Tue, 8 Jul 2014 16:37:45 +0300
Message-ID: <20140708133745.GA20496@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:46610 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861AbaGHNhw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jul 2014 09:37:52 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rafael.j.wysocki@intel.com
Cc: linux-acpi@vger.kernel.org

Hello Rafael J. Wysocki,

The patch dd2151be28b9: "ACPI / hotplug / PCI: Rework the handling of
eject requests" from Feb 4, 2014, leads to the following static
checker warning:

	drivers/acpi/scan.c:479 acpi_generic_hotplug_event()
	error: we previously assumed 'adev->handler' could be null (see line 473)

drivers/acpi/scan.c
   464  static int acpi_generic_hotplug_event(struct acpi_device *adev, u32 type)
   465  {
   466          switch (type) {
   467          case ACPI_NOTIFY_BUS_CHECK:
   468                  return acpi_scan_bus_check(adev);
   469          case ACPI_NOTIFY_DEVICE_CHECK:
   470                  return acpi_scan_device_check(adev);
   471          case ACPI_NOTIFY_EJECT_REQUEST:
   472          case ACPI_OST_EC_OSPM_EJECT:
   473                  if (adev->handler && !adev->handler->hotplug.enabled) {
                            ^^^^^^^^^^^^^
Patch adds new check.

   474                          dev_info(&adev->dev, "Eject disabled\n");
   475                          return -EPERM;
   476                  }
   477                  acpi_evaluate_ost(adev->handle, ACPI_NOTIFY_EJECT_REQUEST,
   478                                    ACPI_OST_SC_EJECT_IN_PROGRESS, NULL);
   479                  return acpi_scan_hot_remove(adev);

"adev->handler" is dereferenced without checking inside the call to
acpi_scan_hot_remove().

   480          }
   481          return -EINVAL;
   482  }

regards,
dan carpenter
