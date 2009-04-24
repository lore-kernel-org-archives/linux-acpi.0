From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH]: ACPI: Add the module param check for processor.max_cstate
Date: Thu, 23 Apr 2009 23:24:23 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904232323410.15843@localhost.localdomain>
References: <1240539912.3651.68.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:62918 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722AbZDXDY1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 23:24:27 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIL001XX5GOY7WM@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Apr 2009 22:24:25 -0500 (CDT)
In-reply-to: <1240539912.3651.68.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org

From: Len Brown <len.brown@intel.com>
Subject: [PATCH] ACPI: prevent processor.max_cstate=0 boot crash

As processor.max_cstate is an init-time-only modparam,
sanity checking it at init-time is sufficient.

http://bugzilla.kernel.org/show_bug.cgi?id=13142

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 6fe1214..436127e 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1037,6 +1037,9 @@ static int acpi_processor_setup_cpuidle(struct acpi_processor *pr)
 		dev->states[i].desc[0] = '\0';
 	}
 
+	if (max_cstate == 0)
+		max_cstate = 1;
+
 	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER && i <= max_cstate; i++) {
 		cx = &pr->power.states[i];
 		state = &dev->states[count];
-- 
1.6.3.rc1.34.g0be9b

