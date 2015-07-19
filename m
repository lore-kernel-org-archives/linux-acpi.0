From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH 0/2] ACPI: __refdata cleanups
Date: Sun, 19 Jul 2015 18:50:37 +0200
Message-ID: <1437324639-18118-1-git-send-email-minipli@googlemail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37640 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbbGSQur (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 19 Jul 2015 12:50:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Mathias Krause <minipli@googlemail.com>, Paul Gortmaker <paul.gortmaker@windriver.com>

This series is a respin of patch "03/12"[1] with slightly more coverage.

[1] http://marc.info/?l=linux-acpi&m=143419843716724&w=4

The __refdata annotations used to be needed in __cpuinit times but those
are long gone (since v3.11). Now those annotations may serve as an
additional error source, hiding legitimate section mismatches.

This series drops the unneeded annotations and adds a comment to the
last legitimate remaining one below drivers/acpi/.

Please apply.


Mathias Krause (2):
  ACPI / processor: remove bogus __refdata annotations
  ACPI / OSL: add comment for the __ref annotation of
    acpi_os_unmap_iomem()

 drivers/acpi/acpi_processor.c   |    2 +-
 drivers/acpi/osl.c              |    3 +++
 drivers/acpi/processor_driver.c |    2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

-- 
1.7.10.4

