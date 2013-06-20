From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 0/3] ACPI video driver document update
Date: Thu, 20 Jun 2013 15:08:54 +0800
Message-ID: <1371712137-4019-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:42935 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751921Ab3FTHId (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Jun 2013 03:08:33 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Micael Dias <kam1kaz3@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

ACPI video driver's document is pretty outdated and needs updating.
Patch 1 adds description for brightness_switch_enabled kernel command
line option;
Patch 2 moves the document for ACPI video driver from Documentation/power
to Documentation/ACPI, since it is a document for the ACPI video driver;
Patch 3 updates the video driver's document by focusing on how backlight
is controlled by it.

Aaron Lu (3):
  ACPI / video: add description for brightness_switch_enabled
  ACPI / video: move video_extension.txt to Documentation/acpi
  ACPI / video: update video_extension.txt for backlight control

 Documentation/acpi/video_extension.txt  | 106 ++++++++++++++++++++++++++++++++
 Documentation/kernel-parameters.txt     |   9 +++
 Documentation/power/video_extension.txt |  37 -----------
 3 files changed, 115 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/acpi/video_extension.txt
 delete mode 100644 Documentation/power/video_extension.txt

-- 
1.8.3.3.gfada522

