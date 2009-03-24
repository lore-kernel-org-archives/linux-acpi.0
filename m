From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 01/10] ACPI: skip DMI power state check when ACPI disabled
Date: Tue, 24 Mar 2009 16:49:38 -0600
Message-ID: <20090324224938.1262.97300.stgit@bob.kio>
References: <20090324224834.1262.65260.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:35546 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753541AbZCXWtk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Mar 2009 18:49:40 -0400
In-Reply-To: <20090324224834.1262.65260.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Li Shaohua <shaohua.li@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>Li Shaohua <shaohua.li@intel.com>, Zhao Yakui <yakui.zhao@intel.com>

This patch makes acpi_init() exit early when ACPI is disabled.
This skips a DMI check that affects ACPI power management.   The
DMI check prints a notice that is misleading when ACPI is disabled.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
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

