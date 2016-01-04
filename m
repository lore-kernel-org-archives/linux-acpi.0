From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v2 0/2] memory-hotplug: cleanup register_memory_resource()
Date: Mon,  4 Jan 2016 17:17:29 +0100
Message-ID: <1451924251-4189-1-git-send-email-vkuznets@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50249 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751740AbcADQRi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Jan 2016 11:17:38 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, Tang Chen <tangchen@cn.fujitsu.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Xishi Qiu <qiuxishi@huawei.com>, Sheng Yong <shengyong1@huawei.com>, Zhu Guihua <zhugh.fnst@cn.fujitsu.com>, Dan Williams <dan.j.williams@intel.com>, David Vrabel <david.vrabel@citrix.com>, Igor Mammedov <imammedo@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

This series is a successor for the previously sent "[PATCH] memory-hotplug:
 don't BUG() in register_memory_resource()". Changes since it are:
- Use ERR_PTR/PTR_ERR/IS_ERR() [David Rientjes]
- Add "memory-hotplug: keep the request_resource() error code" patch
  [Andrew Morton]

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Tang Chen <tangchen@cn.fujitsu.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Xishi Qiu <qiuxishi@huawei.com>
Cc: Sheng Yong <shengyong1@huawei.com>
Cc: Zhu Guihua <zhugh.fnst@cn.fujitsu.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Vrabel <david.vrabel@citrix.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>

Vitaly Kuznetsov (2):
  memory-hotplug: don't BUG() in register_memory_resource()
  memory-hotplug: keep the request_resource() error code

 drivers/acpi/acpi_memhotplug.c |  4 ++--
 mm/memory_hotplug.c            | 13 ++++++++-----
 2 files changed, 10 insertions(+), 7 deletions(-)

-- 
2.4.3

