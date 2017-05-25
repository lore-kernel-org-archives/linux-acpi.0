From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Subject: [PATCH v9 7/7] MANTAINERS: Add maintainer for HiSilicon LPC driver
Date: Thu, 25 May 2017 12:37:28 +0100
Message-ID: <1495712248-5232-8-git-send-email-gabriele.paoloni@huawei.com>
References: <1495712248-5232-1-git-send-email-gabriele.paoloni@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([45.249.212.188]:6829 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763903AbdEYLob (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 May 2017 07:44:31 -0400
In-Reply-To: <1495712248-5232-1-git-send-email-gabriele.paoloni@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org, frowand.list@gmail.com, bhelgaas@google.com, rafael@kernel.org, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com
Cc: gabriele.paoloni@huawei.com, mark.rutland@arm.com, brian.starkey@arm.com, olof@lixom.net, benh@kernel.crashing.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linuxarm@huawei.com, linux-pci@vger.kernel.org, minyard@acm.org, john.garry@huawei.com, xuwei5@hisilicon.com

Added maintainer for drivers/bus/hisi_lpc.c

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9e98464..8fb9006 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6061,6 +6061,14 @@ F:	include/uapi/linux/if_hippi.h
 F:	net/802/hippi.c
 F:	drivers/net/hippi/
 
+HISILICON LPC BUS DRIVER
+M:	Gabriele Paoloni <gabriele.paoloni@huawei.com>
+L:	linux-arm-kernel@lists.infradead.org
+W:	http://www.hisilicon.com
+S:	Maintained
+F:	drivers/bus/hisi_lpc.c
+F:	Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
+
 HISILICON NETWORK SUBSYSTEM DRIVER
 M:	Yisen Zhuang <yisen.zhuang@huawei.com>
 M:	Salil Mehta <salil.mehta@huawei.com>
-- 
2.7.4


