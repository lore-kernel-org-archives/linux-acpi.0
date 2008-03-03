From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: [PATCH] ACPI: Unneccessary to scan the PCI bus already scanned.
Date: Mon, 3 Mar 2008 00:30:02 -0800
Message-ID: <86802c440803030030p4ff9cec5tdb25d1cdc131d377@mail.gmail.com>
References: <1204525186.4080.11.camel@yakui_zhao.sh.intel.com>
	 <20080303073214.GA5934@elte.hu>
	 <86802c440803030006m1879838awc238f07bc98ed43e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.182]:60453 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbYCCIaG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Mar 2008 03:30:06 -0500
Received: by el-out-1112.google.com with SMTP id v27so1751419ele.17
        for <linux-acpi@vger.kernel.org>; Mon, 03 Mar 2008 00:30:03 -0800 (PST)
In-Reply-To: <86802c440803030006m1879838awc238f07bc98ed43e@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Zhao Yakui <yakui.zhao@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org

that regression is caused by:

commit 08f1c192c3c32797068bfe97738babb3295bbf42
Author: Muli Ben-Yehuda <muli@il.ibm.com>
Date:   Sun Jul 22 00:23:39 2007 +0300

    x86-64: introduce struct pci_sysdata to facilitate sharing of ->sysdata

    This patch introduces struct pci_sysdata to x86 and x86-64, and
    converts the existing two users (NUMA, Calgary) to use it.

    This lays the groundwork for having other users of sysdata, such as
    the PCI domains work.

    The Calgary bits are tested, the NUMA bits just look ok.

    Signed-off-by: Jeff Garzik <jeff@garzik.org>
    Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

that replace pcibios_scan_root by pci_scan_bus_parented...
-       bus = pcibios_scan_root(busnum);
+       sd->node = -1;
+
+       pxm = acpi_get_pxm(device->handle);
+#ifdef CONFIG_ACPI_NUMA
+       if (pxm >= 0)
+               sd->node = pxm_to_node(pxm);
+#endif
+
+       bus = pci_scan_bus_parented(NULL, busnum, &pci_root_ops, sd);

and in pcibios_scan_root we have

        struct pci_bus *bus = NULL;
        struct pci_sysdata *sd;

        dmi_check_system(pciprobe_dmi_table);

        while ((bus = pci_find_next_bus(bus)) != NULL) {
                if (bus->number == busnum) {
                        /* Already scanned */
                        return bus;
                }
        }

YH
