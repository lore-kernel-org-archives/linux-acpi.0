From: David Rientjes <rientjes@google.com>
Subject: [patch] acpi: remove NID_INVAL
Date: Tue, 21 Jun 2011 17:56:55 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1106211756110.4454@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:11371 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757462Ab1FVA5D (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Jun 2011 20:57:03 -0400
Received: from kpbe16.cbf.corp.google.com (kpbe16.cbf.corp.google.com [172.25.105.80])
	by smtp-out.google.com with ESMTP id p5M0ux7w020231
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jun 2011 17:56:59 -0700
Received: from pvg13 (pvg13.prod.google.com [10.241.210.141])
	by kpbe16.cbf.corp.google.com with ESMTP id p5M0uvRx024691
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jun 2011 17:56:58 -0700
Received: by pvg13 with SMTP id 13so210126pvg.26
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jun 2011 17:56:57 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

b552a8c56db8 ("ACPI: remove NID_INVAL") removed the left over uses of
NID_INVAL, but didn't actually remove the definition.  Remove it.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 include/linux/acpi.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -238,7 +238,6 @@ extern int acpi_paddr_to_node(u64 start_addr, u64 size);
 extern int pnpacpi_disabled;
 
 #define PXM_INVAL	(-1)
-#define NID_INVAL	(-1)
 
 int acpi_check_resource_conflict(const struct resource *res);
 
