From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 0/6] PNP: minor code cleanups, use dev_printk()
Date: Fri, 28 Sep 2007 10:39:11 -0600
Message-ID: <20070928163911.697537922@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:45570 "EHLO atlrel7.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752072AbXI1Qo1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Sep 2007 12:44:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

These patches remove a few more null pointer checks, simplify a
couple code paths (without functional change), and make PNP use
dev_printk() when the device structure is available.

--
