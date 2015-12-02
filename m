From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [RFC PATCH 0/4] add ACPI support for syscon
Date: Wed, 2 Dec 2015 17:09:24 +0800
Message-ID: <1449047368-5768-1-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:12208 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756789AbbLBJMV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2015 04:12:21 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kefeng Wang <wangkefeng.wang@huawei.com>

Lots of drivers begin to support both OF and ACPI now, but some drivers depend on syscon,
so syscon need to support ACPI firstly.

Add ACPI support for syscon, and introduce syscon_regmap_lookup_by_dev_property()
helper when the driver need to get a regmap handle from syscon, it can used in
both OF and ACPI.

Kefeng Wang (4):
  acpi: property: Introduce helper acpi_dev_get_reference_device()
  device property: Introduce helper device_get_reference_node()
  ACPI/platform: Introduce helper acpi_dev_find_plat_dev()
  mfd: syscon: add ACPI support

 drivers/acpi/acpi_platform.c | 25 ++++++++++++++++++++++
 drivers/acpi/property.c      | 23 ++++++++++++++++++++
 drivers/base/property.c      | 40 +++++++++++++++++++++++++++++++++++
 drivers/mfd/syscon.c         | 50 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h         | 13 ++++++++++++
 include/linux/mfd/syscon.h   |  8 +++++++
 include/linux/property.h     |  6 ++++++
 7 files changed, 165 insertions(+)

-- 
1.7.12.4


