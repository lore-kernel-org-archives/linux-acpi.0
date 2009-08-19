From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH 0/5] wakeup event detect support
Date: Wed, 19 Aug 2009 15:24:08 +0800
Message-ID: <1250666648.23178.115.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22714 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751199AbZHSHYM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Aug 2009 03:24:12 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, mjg59 <mjg59@srcf.ucam.org>

These are a refresh of my previous wakeup event detect support patches.
Recently Matthem is adding pci runtime power management, so making the
wakeup event detection work is essential.
The patches add support for both acpi-based and pcie native pme based
wakeup event detection. The patches are just for wakeup event detection,
so what we should do after get the event (the patch just print some
info) and how to enable wakeup event (which should be done in driver)
are not in these patches' scope. please take a look.

Thanks,
Shaohua

