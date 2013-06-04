From: liguang <lig.fnst@cn.fujitsu.com>
Subject: [PATCH 2/2] xen: remove bm_rld_set of xen_processor_flags
Date: Tue, 4 Jun 2013 16:05:28 +0800
Message-ID: <1370333128-11412-2-git-send-email-lig.fnst@cn.fujitsu.com>
References: <1370333128-11412-1-git-send-email-lig.fnst@cn.fujitsu.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:54771 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751168Ab3FDIGe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 4 Jun 2013 04:06:34 -0400
In-Reply-To: <1370333128-11412-1-git-send-email-lig.fnst@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Liu Jinsong <jinsong.liu@intel.com>, Jan Beulich <JBeulich@suse.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, liguang <lig.fnst@cn.fujitsu.com>

bm_rld_set seems obsolete now

Signed-off-by: liguang <lig.fnst@cn.fujitsu.com>
---
 include/xen/interface/platform.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/xen/interface/platform.h b/include/xen/interface/platform.h
index c57d5f6..7ffff33 100644
--- a/include/xen/interface/platform.h
+++ b/include/xen/interface/platform.h
@@ -240,7 +240,6 @@ struct xen_processor_flags {
 	uint32_t bm_check:1;
 	uint32_t has_cst:1;
 	uint32_t power_setup_done:1;
-	uint32_t bm_rld_set:1;
 };
 
 struct xen_processor_power {
-- 
1.7.2.5

