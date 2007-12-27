From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 0/5] WMI
Date: Thu, 27 Dec 2007 15:38:04 +0000
Message-ID: <20071227153803.4974.97907.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:39518 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751874AbXL0Pif (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Dec 2007 10:38:35 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Alexey Starikovskiy <aystarik@gmail.com>

ACSWR - A Christmas Sale WMI release

Patch #1: (WMI - driver and in kernel interface)

Added per GUID event handling callbacks, as per Matthew's suggestion.

Len:
For review, and to go upstream.

(Bar the EC stuff, this code has also been inflic^^^^tested by acer_acpi users
with my 0.10 releases, so I'm confident on Acer hardware at least that it won't
break horribly).

Patch #2: (acer-wmi)

Add device detection for bluetooth and maximum brightness (removes more hard
coded EC quirks). Also simplified some of the code.

Len:
For review, and to go upstream.

Patch #3: (tc1100-wmi) - No Change

RFC only, needs actual testing on the hardware, and probably very broken.
Waiting on Matthew Garrett to get some free time to test this.

Patch #4: (WMI sysfs interface) - No Change

RFC only (see patch #5 for reason). Adds interface under
/sys/devices/virtual/wmi

Matthew - Do you want me to fold patch #5 into this?

Patch #5: (WMI sysfs workaround) - No change

Temporary hack, needed to get patch #4 working, due to a limitation on bus_id
length (Kay Sievers is apparently working on this, ref Greg KH[1]).

-Carlos

[1] http://lkml.org/lkml/2007/12/4/30
