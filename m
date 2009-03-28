From: Len Brown <lenb@kernel.org>
Subject: [PATCH 69/98] ACPI: skip DMI power state check when ACPI disabled
Date: Sat, 28 Mar 2009 00:31:44 -0400
Message-ID: <81d0273df20edff275e2eefe6b50436af3bdf9e8.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:34985 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224AbZC1Ede (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:34 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700KJZ8NUYMU6@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:31 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch makes acpi_init() exit early when ACPI is disabled.
This skips a DMI check that affects ACPI power management.   The
DMI check prints a notice that is misleading when ACPI is disabled.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 2e90410..bdeed39 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -869,6 +869,10 @@ static int __init acpi_init(void)
 		}
 	} else
 		disable_acpi();
+
+	if (acpi_disabled)
+		return result;
+
 	/*
 	 * If the laptop falls into the DMI check table, the power state check
 	 * will be disabled in the course of device power transistion.
-- 
1.6.0.6

