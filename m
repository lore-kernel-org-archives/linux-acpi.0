From: Yasunori Goto <y-goto@jp.fujitsu.com>
Subject: [PATCH](memory hotplug) Fix acpi_get_node() when _PXM is not defined.
Date: Tue, 01 Aug 2006 22:34:41 +0900
Message-ID: <20060801222852.156A.Y-GOTO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:55478 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932677AbWHANfa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Aug 2006 09:35:30 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: ACPI-ML <linux-acpi@vger.kernel.org>, Linux Hotplug Memory Support <lhms-devel@lists.sourceforge.net>, keith mannthey <kmannth@us.ibm.com>, Andi Kleen <ak@suse.de>


Hello.

This patch is to avoid returning negative value for node id if _PXM is not
defined in ACPI's DSDT. There are 2 possible cases.

  1) The hot-add code is executed with NUMA kernel on NON-NUMA box.
  2) Firmware expects only SRAT table's information to find pxm,
     and it doesn't expect DSDT.

If -1 is returned for node id, kernel will touch no-pgdat address
when hot-add is executed.

To fix case 2) exactly, kernel should search memory block information
which cames from SRAT at boottime. But, it will be arch dependent code
and it is not written for i386 and ia64 yet. And it will be post later.
So, at least, kernel panic should be avoided on 2.6.18 by this patch.

This patch is for 2.6.18-rc3. And I tested this patch on my Tiger4 with
hot-add emulation.

Please apply.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

 drivers/acpi/numa.c |    4 ++++
 1 files changed, 4 insertions(+)

Index: hotmemtest1/drivers/acpi/numa.c
===================================================================
--- hotmemtest1.orig/drivers/acpi/numa.c	2006-08-01 20:13:24.000000000 +0900
+++ hotmemtest1/drivers/acpi/numa.c	2006-08-01 20:14:27.000000000 +0900
@@ -263,6 +263,10 @@ int acpi_get_node(acpi_handle *handle)
 	if (pxm >= 0)
 		node = acpi_map_pxm_to_node(pxm);
 
+	/* _PXM might not be defined by firmware. */
+	if (node < 0)
+		node = first_online_node;
+
 	return node;
 }
 EXPORT_SYMBOL(acpi_get_node);

-- 
Yasunori Goto 


