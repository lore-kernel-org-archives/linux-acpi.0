From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/3] ACPI / EC: Add quirk modes for boot EC support
Date: Tue, 16 May 2017 17:46:43 +0800
Message-ID: <cover.1494927504.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:24647 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750795AbdEPJqv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 16 May 2017 05:46:51 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Daniel Drake <drake@endlessm.com>

It's reported that Asus laptop X550VXK/FX502VD/FX502VE have a BIOS bug
where the ECDT correctly states that EC events trigger GPE 0x23, but the
DSDT _GPE method incorrectly returns GPE 0x33.

This patchset prepares required code for adding quirks for such platforms,
however it doesn't finally add the quirks due to lack of platform
information.

Link: https://www.spinics.net/lists/linux-acpi/msg73763.html
      https://bugzilla.kernel.org/show_bug.cgi?id=195651

Lv Zheng (3):
  ACPI / EC: Enhance boot EC sanity check
  ACPI / EC: Add support to skip boot stage DSDT probe
  ACPI / EC: Add EC setting preference support

 drivers/acpi/ec.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 5 deletions(-)

-- 
2.7.4

