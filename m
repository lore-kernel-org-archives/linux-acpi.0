From: Len Brown <lenb@kernel.org>
Subject: [PATCH 122/122] ACPI: fix ia64 build warning
Date: Thu, 23 Oct 2008 02:39:36 -0400
Message-ID: <3262a8f2bf686ced3a6ce8dee013ddf85511fbb6.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:58094 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755482AbYJWGkj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:39 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9600KQ5IJARZ72@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:23 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

=46rom: Len Brown <len.brown@intel.com>

arch/ia64/sn/kernel/io_acpi_init.c:361: warning: format =E2=80=98%lx=E2=
=80=99 expects type =E2=80=98long unsigned int=E2=80=99, but argument 3=
 has type =E2=80=98long long unsigned int=E2=80=99

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/ia64/sn/kernel/io_acpi_init.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/ia64/sn/kernel/io_acpi_init.c b/arch/ia64/sn/kernel/i=
o_acpi_init.c
index a15baac..bc610a6 100644
--- a/arch/ia64/sn/kernel/io_acpi_init.c
+++ b/arch/ia64/sn/kernel/io_acpi_init.c
@@ -357,7 +357,7 @@ sn_acpi_get_pcidev_info(struct pci_dev *dev, struct=
 pcidev_info **pcidev_info,
         if (ACPI_SUCCESS(status)) {
 		if (segment !=3D pci_domain_nr(dev)) {
 			printk(KERN_ERR
-			       "%s: Segment number mismatch, 0x%lx vs 0x%x for: ",
+			       "%s: Segment number mismatch, 0x%llx vs 0x%x for: ",
 			       __func__, segment, pci_domain_nr(dev));
 			acpi_ns_print_node_pathname(rootbus_handle, NULL);
 			printk("\n");
--=20
1.5.5.1

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
