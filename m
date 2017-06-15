From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 0/4] ACPI / EC: Add quirk modes for boot EC support
Date: Thu, 15 Jun 2017 09:41:27 +0800
Message-ID: <cover.1497490457.git.lv.zheng@intel.com>
References: <cover.1494927504.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:48058 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750768AbdFOBlc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Jun 2017 21:41:32 -0400
In-Reply-To: <cover.1494927504.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

It's reported that Asus laptop X580VD/X550VXK/GL720VMK/FX502VD/FX502VE have
a BIOS bug where the ECDT correctly states that EC events trigger GPE 0x23,
but the DSDT _GPE method incorrectly returns GPE 0x33.

This patchset fixes this issue.

Link: https://www.spinics.net/lists/linux-acpi/msg73763.html
      https://bugzilla.kernel.org/show_bug.cgi?id=195651

v2: Stops doing craps related to EC_ID (it's already too complicated), and
    reduces one unnecessary boot parameter. For the final bug fix, prefers
    the fix from endlessm.com developers.
v3: Removes improper statments related to _STA as acpi_get_devices() has
    executed _STA before invoking ec_parse_device() adds detailed
    explanation for why acpi_ec_dsdt_probe() is a wrong approach.
    Carlo Caione helps to add a new quirk for GL720VMK.

Carlo Caione (1):
  ACPI / EC: Add quirk for GL720VMK

Chris Chiu (1):
  ACPI / EC: Fix media keys not working problem on some Asus laptops

Lv Zheng (2):
  ACPI / EC: Enhance boot EC sanity check
  ACPI / EC: Add support to skip boot stage DSDT probe

 drivers/acpi/ec.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 71 insertions(+), 6 deletions(-)

-- 
2.7.4

