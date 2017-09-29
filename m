From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH v6 0/3] ACPI / EC: Tune the timing of EC events arrival during S3-exit
Date: Fri, 29 Sep 2017 10:50:06 +0800
Message-ID: <cover.1506653046.git.lv.zheng@intel.com>
References: <99f23db65bbe89ee856018629654584a96734c84.1501141963.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:28351 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750826AbdI2CuP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 28 Sep 2017 22:50:15 -0400
In-Reply-To: <99f23db65bbe89ee856018629654584a96734c84.1501141963.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

If EC events occurred during BIOS S3-exit and early OS S3-exit steps can
be detected by OS earlier, then there can be less driver order issues
between acpi_ec_resume() and some other drivers' .resume() hook (e.x.
acpi_button_resume()).

However there are known facts that EC FW does drop EC events during S3,
and it takes time for EC FW to initialize (maximum 1.4 observed) while
Windows acts normally, so detecting EC event earlier might just be a
workaround for other drivers (they should be aware of this order issue and
deal with it themselves). As such, this patchset is marked as an RFC.

If Linux EC driver started to detect events during early OS S3-exit, it
need to timely poll EC events during noirq stages as in this stage there is
no EC event triggering source.

This patchset implements earlier EC event handling for Linux.

Lv Zheng (3):
  ACPI / EC: Fix possible driver order issue by moving EC event handling
    earlier
  ACPI / EC: Add event detection support for noirq stages
  ACPI / EC: Enable noirq stage event detection

 drivers/acpi/ec.c       | 128 +++++++++++++++++++++++++++++++++++++++++++-----
 drivers/acpi/internal.h |   1 +
 2 files changed, 118 insertions(+), 11 deletions(-)

-- 
2.7.4

