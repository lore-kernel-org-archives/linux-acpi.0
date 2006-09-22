From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
Subject: Re: [12/12] acpi: set fake hid
Date: Fri, 22 Sep 2006 14:59:38 +0300
Message-ID: <4513D02A.8020106@kolumbus.fi>
References: <1158918880.11985.88.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gw1.turkuamk.fi ([195.148.208.125]:15040 "EHLO
	mail-gw1.turkuamk.fi") by vger.kernel.org with ESMTP
	id S932319AbWIVL5u (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Sep 2006 07:57:50 -0400
In-Reply-To: <1158918880.11985.88.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com

+static int acpi_pci_bridge_match(struct acpi_device *device)
+{
+       acpi_status status;
+       acpi_handle handle;
+
+       /* pci bridge has _PRT but isn't PNP0A03 */
+       status = acpi_get_handle(device->handle, METHOD_NAME__PRT, &handle);
+       if (ACPI_FAILURE(status))
+               return -ENODEV;
+       if (!acpi_match_ids(device, "PNP0A03"))
+               return -ENODEV;
+       return 0;
+}
+


You seem to handle pci-pci bridge here incorrectly (returns -ENODEV from match to PNP0A03)

--Mika


