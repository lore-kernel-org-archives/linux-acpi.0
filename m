From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 0/3] ACPI / EC: Add quirk modes for boot EC support
Date: Fri, 19 May 2017 15:07:27 +0800
Message-ID: <cover.1495176440.git.lv.zheng@intel.com>
References: <cover.1494927504.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1494927504.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

It's reported that Asus laptop X580VD/X550VXK/FX502VD/FX502VE have a BIOS
bug where the ECDT correctly states that EC events trigger GPE 0x23, but
the DSDT _GPE method incorrectly returns GPE 0x33.

This patchset fixes this issue.

Link: https://www.spinics.net/lists/linux-acpi/msg73763.html
      https://bugzilla.kernel.org/show_bug.cgi?id=195651

v2: Stops doing craps related to EC_ID (it's already too complicated), and
    reduces one unnecessary boot parameter. For the final bug fix, prefers
    the fix from endlessm.com developers.

Chris Chiu (1):
  ACPI / EC: Fix media keys not working problem on some Asus laptops

Lv Zheng (2):
  ACPI / EC: Enhance boot EC sanity check
  ACPI / EC: Add support to skip boot stage DSDT probe

 drivers/acpi/ec.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 60 insertions(+), 6 deletions(-)

-- 
2.7.4
