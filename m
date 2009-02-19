From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 0/2] ACPI: Kconfig cleanup
Date: Thu, 19 Feb 2009 12:56:11 -0700
Message-ID: <20090219195548.20757.53184.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:41485 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708AbZBST4N (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Feb 2009 14:56:13 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

These patches remove CONFIG_ACPI_SYSTEM (which is unnecessary)
and clean up the Kconfig help texts.

Comments welcome.

Bjorn
---

Bjorn Helgaas (2):
      ACPI: update Kconfig help texts (no functional changes)
      ACPI: remove CONFIG_ACPI_SYSTEM


 drivers/acpi/Kconfig  |  153 +++++++++++++++++++++++++++----------------------
 drivers/acpi/Makefile |    2 -
 2 files changed, 86 insertions(+), 69 deletions(-)

-- 
Signature
