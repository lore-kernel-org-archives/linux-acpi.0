From: Len Brown <lenb@kernel.org>
Subject: [PATCH 5/9] PNP: don't check for conflicts with bridge windows
Date: Thu, 06 May 2010 03:03:17 -0400
Message-ID: <11439a6fd90b4861df64b4f983726e1c54977ab7.1273129319.git.len.brown@intel.com>
References: <1273129401-12704-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:56632 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529Ab0EFHDm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 May 2010 03:03:42 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L1Z0098QKXPY3E4@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 May 2010 02:03:31 -0500 (CDT)
In-reply-to: <1273129401-12704-1-git-send-email-lenb@kernel.org>
In-reply-to: <5cc4a0f6b72878ea4e96fdb392d5d24c892a988e.1273129319.git.len.brown@intel.com>
References: <5cc4a0f6b72878ea4e96fdb392d5d24c892a988e.1273129319.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

With fa35b4926, I broke a lot of PNP resource assignment.  That commit made
PNPACPI include bridge windows as PNP resources, and PNP resource assignment
treats any enabled overlapping PNP resources as conflicts.  Since PCI host
bridge windows typically include most of the I/O port space, this makes PNP
port assigments fail.

The PCI host bridge driver will eventually use those PNP window resources,
so we should make PNP ignore them when checking for conflicts.

This fixes https://bugzilla.kernel.org/show_bug.cgi?id=15903

Reported-and-tested-by: Pavel Kysilka <goldenfish@linuxsoft.cz>
Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/resource.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/pnp/resource.c b/drivers/pnp/resource.c
index 2e54e6a..e3446ab 100644
--- a/drivers/pnp/resource.c
+++ b/drivers/pnp/resource.c
@@ -211,6 +211,8 @@ int pnp_check_port(struct pnp_dev *dev, struct resource *res)
 			if (tres->flags & IORESOURCE_IO) {
 				if (cannot_compare(tres->flags))
 					continue;
+				if (tres->flags & IORESOURCE_WINDOW)
+					continue;
 				tport = &tres->start;
 				tend = &tres->end;
 				if (ranged_conflict(port, end, tport, tend))
@@ -271,6 +273,8 @@ int pnp_check_mem(struct pnp_dev *dev, struct resource *res)
 			if (tres->flags & IORESOURCE_MEM) {
 				if (cannot_compare(tres->flags))
 					continue;
+				if (tres->flags & IORESOURCE_WINDOW)
+					continue;
 				taddr = &tres->start;
 				tend = &tres->end;
 				if (ranged_conflict(addr, end, taddr, tend))
-- 
1.6.0.6

