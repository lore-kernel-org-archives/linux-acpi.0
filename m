From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 0/3] ACPI processor _HID cleanups
Date: Mon, 27 Apr 2009 16:33:30 -0600
Message-ID: <20090427223244.16549.99553.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:19975 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757344AbZD0Wdb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Apr 2009 18:33:31 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

---

Bjorn Helgaas (3):
      ACPI: processor: move device _HID into driver
      ACPI: processor: check for synthetic _HID, default to "Device" declaration
      ACPI: use LNXCPU, not ACPI_CPU, for Linux-specific processor _HID


 drivers/acpi/processor_core.c |   32 ++++++++++++++++----------------
 include/acpi/acpi_drivers.h   |    3 +--
 2 files changed, 17 insertions(+), 18 deletions(-)
