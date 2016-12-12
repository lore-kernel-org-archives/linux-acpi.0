From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH] x86/acpi: Use proper macro for invalid node
Date: Mon, 12 Dec 2016 14:29:52 -0500
Message-ID: <1481570993-13941-1-git-send-email-boris.ostrovsky@oracle.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:21809 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751792AbcLLTd6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Dec 2016 14:33:58 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>

Use NUMA_NO_NODE instead of -1.

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 arch/x86/kernel/acpi/boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 931ced8..db5bcd1 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -713,7 +713,7 @@ int acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
 	int nid;
 
 	nid = acpi_get_node(handle);
-	if (nid != -1) {
+	if (nid != NUMA_NO_NODE) {
 		set_apicid_to_node(physid, nid);
 		numa_set_node(cpu, nid);
 	}
-- 
1.8.3.1

