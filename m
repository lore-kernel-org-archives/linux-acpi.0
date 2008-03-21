From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH  9/16] PCI slot: Remove unused slot member from pci_dev (Not
 for mainline!)
Date: Fri, 21 Mar 2008 13:16:19 +0900
Message-ID: <47E33693.7080102@jp.fujitsu.com>
References: <20080318210539.GA30421@ldl.fc.hp.com> <47E33472.1000602@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:35639 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbYCUESj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Mar 2008 00:18:39 -0400
In-Reply-To: <47E33472.1000602@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>, Greg KH <gregkh@suse.de>
Cc: Gary Hade <garyhade@us.ibm.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Matthew Wilcox <matthew@wil.cx>, warthog19@eaglescrag.net, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org

The 'slot' member in struct pci_dev is not used. Remove this unused
member.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 include/linux/pci.h |    1 -
 1 file changed, 1 deletion(-)

Index: linux-2.6.25-rc6/include/linux/pci.h
===================================================================
--- linux-2.6.25-rc6.orig/include/linux/pci.h
+++ linux-2.6.25-rc6/include/linux/pci.h
@@ -149,7 +149,6 @@ struct pci_dev {
 
 	void		*sysdata;	/* hook for sys-specific extension */
 	struct proc_dir_entry *procent;	/* device entry in /proc/bus/pci */
-	struct pci_slot	*slot;		/* Physical slot this device is in */
 
 	unsigned int	devfn;		/* encoded device & function index */
 	unsigned short	vendor;


