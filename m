From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 3/3] ACPI: remove unused acpi_bus_ops flags
Date: Tue, 24 Mar 2009 10:55:33 -0600
Message-ID: <20090324165532.25119.99553.stgit@bob.kio>
References: <20090324165420.25119.78955.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:18691 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757866AbZCXQzf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Mar 2009 12:55:35 -0400
In-Reply-To: <20090324165420.25119.78955.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Li Shaohua <shaohua.li@intel.com>, Rajesh Shah <rajesh.shah@intel.com>

In acpi_bus_ops, only the acpi_op_add and acpi_op_start flags are used,
so remove all the rest.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 include/acpi/acpi_bus.h |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index fb91bc2..08ec60c 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -98,17 +98,7 @@ typedef int (*acpi_op_unbind) (struct acpi_device * device);
 
 struct acpi_bus_ops {
 	u32 acpi_op_add:1;
-	u32 acpi_op_remove:1;
-	u32 acpi_op_lock:1;
 	u32 acpi_op_start:1;
-	u32 acpi_op_stop:1;
-	u32 acpi_op_suspend:1;
-	u32 acpi_op_resume:1;
-	u32 acpi_op_scan:1;
-	u32 acpi_op_bind:1;
-	u32 acpi_op_unbind:1;
-	u32 acpi_op_shutdown:1;
-	u32 reserved:21;
 };
 
 struct acpi_device_ops {

