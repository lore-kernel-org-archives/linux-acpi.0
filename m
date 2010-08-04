From: Colin King <colin.king@canonical.com>
Subject: [PATCH 0/1] acpi: clear PCIEXP_WAKE_STS on resume
Date: Wed,  4 Aug 2010 11:06:35 +0100
Message-ID: <1280916396-6512-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:37071 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932120Ab0HDKGi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Aug 2010 06:06:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Discovered that clearing the PCIEXP_WAKE_STS bit in PM1 on
resume fixes a S3 resume hang in a BIOS. I beleive the on
board PCI Express ethernet is sometimes causing a PCI wakeup
event which requires clearing the PCIEXP_WAKE_STS bit before
we go into the next resume or it will hang in the BIOS.

The ACPI spec 4.0 does indicate that this bit should be
cleared before suspending (see section 4.7.3.1.1, table 4-11
in the PCIEXP_WAKE_STS entry) otherwise "the system will
not automatically wake."

Colin Ian King (1):
  acpi: clear PCIEXP_WAKE_STS on resume

 drivers/acpi/acpica/aclocal.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

