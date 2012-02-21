From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 3/3] xen/processor-passthru: Remove the print_hex_dump - as it is difficult to decipher it
Date: Mon, 20 Feb 2012 19:07:48 -0500
Message-ID: <1329782868-1696-4-git-send-email-konrad.wilk@oracle.com>
References: <20120214183006.GJ12984@reaktio.net>
 <1329782868-1696-1-git-send-email-konrad.wilk@oracle.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:24241 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754757Ab2BUALc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Feb 2012 19:11:32 -0500
In-Reply-To: <1329782868-1696-1-git-send-email-konrad.wilk@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pasik@iki.fi
Cc: xen-devel@lists.xensource.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, JBeulich@novell.com, kevin.tian@intel.com, ke.yu@intel.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

It is much easier to just look in the hypervisor output and figure
out what went wrong. For that use, cpufreq=verbose on Xen command line.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 drivers/xen/processor-passthru.c |   25 ++++++++-----------------
 1 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/xen/processor-passthru.c b/drivers/xen/processor-passthru.c
index 9ca2965..d731f55 100644
--- a/drivers/xen/processor-passthru.c
+++ b/drivers/xen/processor-passthru.c
@@ -119,14 +119,10 @@ static int xen_push_cxx_to_hypervisor(struct acpi_processor *_pr)
 	if (!no_hypercall && xen_initial_domain())
 		ret = HYPERVISOR_dom0_op(&op);
 
-	if (ret) {
-		pr_err(DRV_NAME ": Failed to send to hypervisor (rc:%d)\n", ret);
-		print_hex_dump_bytes("OP: ", DUMP_PREFIX_NONE, &op,
-				     sizeof(struct xen_platform_op));
-		print_hex_dump_bytes("Cx: ", DUMP_PREFIX_NONE, xen_cx_states,
-				     _pr->power.count *
-				     sizeof(struct xen_processor_cx));
-	}
+	if (ret)
+		pr_err(DRV_NAME "(CX): Hypervisor returned (%d) for ACPI ID: %d\n",
+		       ret, _pr->acpi_id);
+
 	kfree(xen_cx_states);
 
 	return ret;
@@ -229,15 +225,10 @@ static int xen_push_pxx_to_hypervisor(struct acpi_processor *_pr)
 	if (!no_hypercall && xen_initial_domain())
 		ret = HYPERVISOR_dom0_op(&op);
 
-	if (ret) {
-		pr_err(DRV_NAME ": Failed to send to hypervisor (rc:%d)\n", ret);
-		print_hex_dump_bytes("OP: ", DUMP_PREFIX_NONE, &op,
-				     sizeof(struct xen_platform_op));
-		if (!IS_ERR_OR_NULL(xen_states))
-			print_hex_dump_bytes("Pxx:", DUMP_PREFIX_NONE, xen_states,
-				     _pr->performance->state_count *
-				     sizeof(struct xen_processor_px));
-	}
+	if (ret)
+		pr_err(DRV_NAME "(_PXX): Hypervisor returned (%d) for ACPI ID %d\n",
+		       ret, _pr->acpi_id);
+
 	if (!IS_ERR_OR_NULL(xen_states))
 		kfree(xen_states);
 
-- 
1.7.7.5

