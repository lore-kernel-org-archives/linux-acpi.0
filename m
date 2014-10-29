From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 0/2] ACPI/EC: Fix regressions on Samsung hardware.
Date: Wed, 29 Oct 2014 11:33:33 +0800
Message-ID: <cover.1414553399.git.lv.zheng@intel.com>
References: <544CE637.7000406@odi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11619 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751680AbaJ2Ddn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Oct 2014 23:33:43 -0400
In-Reply-To: <544CE637.7000406@odi.ch>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

It is reported that the Samsung EC firmware behaves differently than Acer
EC firmware. And then previous 2 commits that fix Acer issues have broken
Samsung hardware.

This patchset fixes the regressions.

Lv Zheng (2):
  Revert "ACPI / EC: Add support to disallow QR_EC to be issued before
    completing previous QR_EC"
  ACPI/EC: Fix a regression caused by conflict firmware behavior
    between Samsung and Acer.

 drivers/acpi/ec.c |   31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

-- 
1.7.10

