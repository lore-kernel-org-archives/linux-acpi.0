From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 0/5] WMI
Date: Tue, 18 Dec 2007 23:51:38 +0000
Message-ID: <20071218235137.12838.75397.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:42099 "EHLO
	pacifica." rhost-flags-OK-OK-FAIL-FAIL) by vger.kernel.org with ESMTP
	id S1753829AbXLRXwJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Dec 2007 18:52:09 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Alexey Starikovskiy <aystarik@gmail.com>

YAWR - Yet Another WMI release

Patch #1: (WMI - driver and in kernel interface)

Updated EC region handling as per Alexey's comments

Len:
For review, and hopefully to go up to 2.6.25

(Bar the EC stuff, this code has also been inflic^^^^tested by acer_acpi users
with the 0.10 RCs and 0.10 releases, so I'm confident on Acer hardware at least
that it won't break horribly).

Patch #2: (acer-wmi) - No Change

For review, and (rather tentatively here) 2.6.25 material?

Patch #3: (tc1100-wmi) - No Change

RFC only, needs actual testing on the hardware, and probably very broken.
Waiting on Matthew Garrett to get some free time to test this.

Patch #4: (WMI sysfs interface) - No Change

RFC only (see patch #5 for reason). Adds interface under
/sys/devices/virtual/wmi

Patch #5: (WMI sysfs workaround) - No change

Temporary hack, needed to get patch #4 working, due to a limitation on bus_id
length (Kay Sievers is apparently working on this, ref Greg KH[1]). This
should _NOT_ be applied to any upstream kernel.

-Carlos

[1] http://lkml.org/lkml/2007/12/4/30
