From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 0/5] WMI
Date: Mon, 17 Dec 2007 00:23:17 +0000
Message-ID: <20071217002317.4980.71135.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:34852 "EHLO
	pacifica." rhost-flags-OK-OK-FAIL-FAIL) by vger.kernel.org with ESMTP
	id S1757905AbXLQAWx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 16 Dec 2007 19:22:53 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Alexey Starikovskiy <aystarik@gmail.com>

Another WMI release.

Patch #1: (WMI - initial driver and in kernel interface)

Big change here is putting in a basic EC region handler - which is
mostly a shameless rip off of the EC driver's acpi_ec_space_handler,
with the exception that WMI doesn't need to care about the EC device,
and just calls ec_{read,write} instead.

Therefore, CC'ing Alexey for the EC bit.

For review, and hopefully to go up to 2.6.25

Patch #2: (acer-wmi) - No Change

For review, and (rather tentatively here) 2.6.25 material?

Patch #3: (tc1100-wmi)

RFC only, needs actual testing on the hardware, and probably very broken. 
Waiting on Matthew Garrett to get some free time to test this.

Bluetooth renamed to jogdial, as per comments from Joshua Wise.

Patch #4: (WMI sysfs interface) - No Change

RFC only (see patch #5 for reason). Adds interface 
under /sys/devices/virtual/wmi

Changes: Added 'string' file to each GUID, which reports whether the GUID has 
the 'string' flag set (userspace needs to know for converting from its' 
format to ASCII and back).

Patch #5: (WMI sysfs workaround) - No change

Temporary hack, needed to get patch #4 working, due to a limitation on bus_id 
length (Kay Sievers is apparently working on this, ref Greg KH[1]). This 
should _NOT_ be applied to any upstream kernel.

-Carlos

[1] http://lkml.org/lkml/2007/12/4/30
