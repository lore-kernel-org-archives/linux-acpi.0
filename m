From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 0/2] [RESEND] Split out custom method AML override into own compile option
Date: Thu, 26 May 2011 12:26:22 +0200
Message-ID: <1306405584-34581-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57858 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757114Ab1EZK0m (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 May 2011 06:26:42 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, rui.zhang@intel.com, rjw@sisk.pl, Thomas Renninger <trenn@suse.de>

This is a resend of:
[PATCH 2/3] acpi: Cleanup custom_method debug stuff
[PATCH 3/3] acpi: Split out custom_method functionality into an own driver
03/31/11 - linux-acpi@vger.kernel.org

Len stated that the patches were applied, but it looks
like the fell through...

Patches based on latest ACPI test branch, would be great
if they can get queued for 2.6.40.

Thanks,

    Thomas

Thomas Renninger (2):
  ACPI: Cleanup custom_method debug stuff
  ACPI: Split out custom_method functionality into an own driver

 Documentation/acpi/method-customizing.txt |    5 ++
 drivers/acpi/Kconfig                      |   15 ++++
 drivers/acpi/Makefile                     |    1 +
 drivers/acpi/custom_method.c              |  100 +++++++++++++++++++++++++++++
 drivers/acpi/debugfs.c                    |   92 +-------------------------
 drivers/acpi/internal.h                   |    3 +-
 drivers/acpi/sysfs.c                      |    8 ++
 7 files changed, 135 insertions(+), 89 deletions(-)
 create mode 100644 drivers/acpi/custom_method.c

-- 
1.7.3.4

