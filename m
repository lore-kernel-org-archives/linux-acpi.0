From: Danny Baumann <dannybaumann@web.de>
Subject: [PATCH 0/3] ACPI video: Fix brightness control initialization sequence
Date: Thu, 14 Mar 2013 11:34:21 +0100
Message-ID: <1363257264-15984-1-git-send-email-dannybaumann@web.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Danny Baumann <dannybaumann@web.de>
List-Id: linux-acpi@vger.kernel.org

This patch set fixes a some logic mistakes in the brightness control
initialization sequence of the ACPI video driver. This should make
the initialization (and as a consequence in-kernel brightness control)
work for a number of laptops. One example that was broken before is the
Dell Inspiron 15R SE (7520).

Regards,

Danny

Danny Baumann (3):
  ACPI video: Fix brightness control initialization for some laptops.
  ACPI video: Make logic a little easier to understand.
  ACPI video: Fix applying indexed initial brightness value.

 drivers/acpi/video.c | 59 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 23 deletions(-)

-- 
1.8.1.4
