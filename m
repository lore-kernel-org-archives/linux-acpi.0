From: Stefan Assmann <sassmann@redhat.com>
Subject: [PATCH 0/4] x86: boot interrupt reroute fix
Date: Thu, 18 Nov 2010 08:51:58 -0500
Message-ID: <20101118135207.2269.2593.sendpatchset@localhost6.localdomain6>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35144 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757866Ab0KRNxO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Nov 2010 08:53:14 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: JBeulich@novell.com, linux-acpi@vger.kernel.org, Olaf.Dabrunz@gmx.net, Stefan Assmann <sassmann@redhat.com>, mingo@elte.hu, bjorn.helgaas@hp.com, tglx@linutronix.de, lenb@kernel.org

During the 2.6.29 merge parts of e1d3a90846b40ad3160bf4b648d36c6badad39ac got
lost because of other ACPI changes. This patchset gets the reroute code working
again with the current ACPI code. As suggested by Ingo Molnar, the boot interrupt
reroute code has been split into its own file.
Therefore some smaller changes to the ACPI and PCI code are necessary to allow
the boot interrupt reroute code to access required structures and functionality.
In detail, the reroute code requires access to:
- struct acpi_prt_entry
- pci_find_upstream_pcie_bridge()

Additionally to not change any information in the global acpi_prt_list it is
desirable to have acpi_pci_irq_find_prt_entry() return a pointer to a copy of
a struct acpi_prt_entry instead of pointer into the global acpi_prt_list. The
callers of acpi_pci_irq_find_prt_entry() have been updated to free the
allocated structure as well.

By request of Bjorn Helgaas I've created a bugzilla entry at
https://bugzilla.kernel.org/show_bug.cgi?id=21882
to gather information about the boot interrupt reroute problem.
