From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 0/4] ACPI: pci_link cleanups
Date: Tue, 17 Feb 2009 14:00:35 -0700
Message-ID: <20090217205906.4506.95815.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:13692 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbZBQVAg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Feb 2009 16:00:36 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

These are minor cleanups to PCI interrupt link handling:
whitespace, removing unnecessary casts and null pointer
checks, and simplifying linked list management.

Comments welcome.

Bjorn
