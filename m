From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 0/2] PCI/ACPI: improve _CRS debug, validate host bridge windows
Date: Wed, 04 Nov 2009 10:39:08 -0700
Message-ID: <20091104173601.17517.71697.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0184.atlanta.hp.com ([15.193.32.61]:46110 "EHLO
	g6t0184.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932415AbZKDRjH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Nov 2009 12:39:07 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org

The first patch only adds some debug output; the second is a workaround
for BIOS bugs in _CRS descriptions (currently only used when booting with
"pci=use_crs").

---

Bjorn Helgaas (2):
      x86/PCI: for debuggability, show host bridge windows even when ignoring _CRS
      x86/PCI: fix bogus host bridge window start/end alignment from _CRS


 arch/x86/pci/acpi.c |   51 +++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 43 insertions(+), 8 deletions(-)

-- 
Bjorn
