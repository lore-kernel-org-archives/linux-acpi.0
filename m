From: Colin King <colin.king@canonical.com>
Subject: [RESEND][PATCH 0/1] acpi: clear PCIEXP_WAKE_STS on resume
Date: Tue, 28 Sep 2010 12:00:23 +0100
Message-ID: <1285671624-7826-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:45817 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab0I1LA0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Sep 2010 07:00:26 -0400
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

