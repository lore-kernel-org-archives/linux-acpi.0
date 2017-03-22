From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/3] ACPI Fixes for Hotplug
Date: Wed, 22 Mar 2017 18:33:22 +0100
Message-ID: <1490204005-2733-1-git-send-email-joro@8bytes.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:40665 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935429AbdCVRdh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 22 Mar 2017 13:33:37 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>

Hi,

here are fixes for three issues I found in ACPI code during
hotplug testing. Patches 2 and 3 fix the same issue, but I
think both make sense on their own.

Please review.

Thanks,

	Joerg

Joerg Roedel (3):
  ACPI, ioapic: Clear on-stack resource before using it
  ACPI: Remove platform devices from a bus on removal
  ACPI: Don't create a platform_device for IOAPIC/IOxAPIC

 drivers/acpi/acpi_platform.c |  8 +++++---
 drivers/acpi/ioapic.c        |  6 ++++++
 drivers/acpi/scan.c          | 26 ++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 3 deletions(-)

-- 
1.9.1

