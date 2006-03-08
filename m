From: Thomas Renninger <trenn@suse.de>
Subject: SCSI behind PCIE bridge only detected using pci=noacpi
Date: Wed, 8 Mar 2006 19:54:43 +0100
Message-ID: <200603081954.44195.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58277 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751109AbWCHSyq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Mar 2006 13:54:46 -0500
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 0562C1D757
	for <linux-acpi@vger.kernel.org>; Wed,  8 Mar 2006 19:54:45 +0100 (CET)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Should this work or is this really not supported via ACPI?

I expect this is the relevant output:

ACPI: PCI Root Bridge [PCI1] (0001:40)
PCI: Multiple domains not supported
ACPI Error (pci_root-0279): Bus 0001:40 not present in PCI namespace<7>Losing some ticks... checking if CPU frequency changed.
 [20060127]
ACPI Exception (pci_bind-0156): AE_NOT_FOUND, Invalid ACPI-PCI context for parent device PCI1 [20060127]
ACPI Exception (pci_bind-0156): AE_NOT_FOUND, Invalid ACPI-PCI context for parent device PCI1 [20060127]
ACPI: PCI Root Bridge [PCI2] (0002:80)
PCI: Multiple domains not supported
ACPI Error (pci_root-0279): Bus 0002:80 not present in PCI namespace [20060127]
ACPI Exception (pci_bind-0156): AE_NOT_FOUND, Invalid ACPI-PCI context for parent device PCI2 [20060127]
ACPI Exception (pci_bind-0156): AE_NOT_FOUND, Invalid ACPI-PCI context for parent device PCI2 [20060127]

With pci=noacpi the SCSI disk/controller works fine.
Without even the controller is not recognised.

Thanks,

         Thomas
