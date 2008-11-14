From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 0/4] ACPI: improve modularity and remove initcalls
Date: Fri, 14 Nov 2008 16:02:43 -0700
Message-ID: <20081114230117.18623.8172.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:22909 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885AbYKNXCq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Nov 2008 18:02:46 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

I'm on a quest to improve modularity and remove initcalls.

When possible, we should avoid initcalls because the order they
happen depends on the module link order, so innocuous makefile
changes can break things.

Yakui, I think I addressed your comments about sysfs duplicate
filenames (I think the link order dependency was removed by
commit 9b473de87209fa86eb421b23386693b461612f30).  But if not,
let me know.

Len, instead of making drivers/acpi/acpi.h, I made a
drivers/acpi/acpi_core.h.  The things in there shouldn't be
visible outside of drivers/acpi, so I don't really want to
put them in include/acpi/acpi_drivers.h.

I also added new pci.h and processor.h header files in drivers/acpi
for those drivers.  You mentioned Bob's ongoing header clean-up,
but I assume he's concentrating on the ACPI CA, whereas the ones
I added are for Linux drivers.

Comments welcome.

Bjorn
