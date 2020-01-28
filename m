Return-Path: <SRS0=v6CU=3R=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D069C2D0DB
	for <linux-acpi@archiver.kernel.org>; Tue, 28 Jan 2020 15:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6739024683
	for <linux-acpi@archiver.kernel.org>; Tue, 28 Jan 2020 15:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgA1PQp (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 28 Jan 2020 10:16:45 -0500
Received: from mga17.intel.com ([192.55.52.151]:26964 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbgA1PQo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Jan 2020 10:16:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2020 07:16:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,374,1574150400"; 
   d="scan'208";a="401684281"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 28 Jan 2020 07:16:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C2E8313F; Tue, 28 Jan 2020 17:16:41 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] MAINTAINERS: Sort entries in database for ACPI
Date:   Tue, 28 Jan 2020 17:16:41 +0200
Message-Id: <20200128151641.37132-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Run parse-maintainers.pl and choose ACPI records. Fix them accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f04b1c6508fe..ddfbddd95744 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -317,30 +317,30 @@ ACPI
 M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
 M:	Len Brown <lenb@kernel.org>
 L:	linux-acpi@vger.kernel.org
+S:	Supported
 W:	https://01.org/linux-acpi
-Q:	https://patchwork.kernel.org/project/linux-acpi/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
+Q:	https://patchwork.kernel.org/project/linux-acpi/list/
 B:	https://bugzilla.kernel.org
-S:	Supported
+F:	Documentation/ABI/testing/configfs-acpi
+F:	Documentation/ABI/testing/sysfs-bus-acpi
+F:	Documentation/firmware-guide/acpi/
 F:	drivers/acpi/
+F:	drivers/pci/*/*acpi*
+F:	drivers/pci/*acpi*
 F:	drivers/pnp/pnpacpi/
+F:	include/acpi/
 F:	include/linux/acpi.h
 F:	include/linux/fwnode.h
-F:	include/acpi/
-F:	Documentation/firmware-guide/acpi/
-F:	Documentation/ABI/testing/sysfs-bus-acpi
-F:	Documentation/ABI/testing/configfs-acpi
-F:	drivers/pci/*acpi*
-F:	drivers/pci/*/*acpi*
 F:	tools/power/acpi/
 
 ACPI APEI
 M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
 M:	Len Brown <lenb@kernel.org>
-L:	linux-acpi@vger.kernel.org
 R:	James Morse <james.morse@arm.com>
 R:	Tony Luck <tony.luck@intel.com>
 R:	Borislav Petkov <bp@alien8.de>
+L:	linux-acpi@vger.kernel.org
 F:	drivers/acpi/apei/
 
 ACPI COMPONENT ARCHITECTURE (ACPICA)
@@ -363,9 +363,9 @@ F:	tools/power/acpi/
 ACPI FAN DRIVER
 M:	Zhang Rui <rui.zhang@intel.com>
 L:	linux-acpi@vger.kernel.org
+S:	Supported
 W:	https://01.org/linux-acpi
 B:	https://bugzilla.kernel.org
-S:	Supported
 F:	drivers/acpi/fan.c
 
 ACPI FOR ARM64 (ACPI/arm64)
@@ -389,26 +389,26 @@ M:	Len Brown <lenb@kernel.org>
 R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 R:	Mika Westerberg <mika.westerberg@linux.intel.com>
 L:	linux-acpi@vger.kernel.org
-Q:	https://patchwork.kernel.org/project/linux-acpi/list/
+S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
+Q:	https://patchwork.kernel.org/project/linux-acpi/list/
 B:	https://bugzilla.kernel.org
-S:	Supported
 F:	drivers/acpi/pmic/
 
 ACPI THERMAL DRIVER
 M:	Zhang Rui <rui.zhang@intel.com>
 L:	linux-acpi@vger.kernel.org
+S:	Supported
 W:	https://01.org/linux-acpi
 B:	https://bugzilla.kernel.org
-S:	Supported
 F:	drivers/acpi/*thermal*
 
 ACPI VIDEO DRIVER
 M:	Zhang Rui <rui.zhang@intel.com>
 L:	linux-acpi@vger.kernel.org
+S:	Supported
 W:	https://01.org/linux-acpi
 B:	https://bugzilla.kernel.org
-S:	Supported
 F:	drivers/acpi/acpi_video.c
 
 ACPI WMI DRIVER
@@ -13353,11 +13353,6 @@ T:	git git://github.com/intel/pm-graph
 S:	Supported
 F:	tools/power/pm-graph
 
-PNP SUPPORT
-M:	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
-S:	Maintained
-F:	drivers/pnp/
-
 PNI RM3100 IIO DRIVER
 M:	Song Qiang <songqiang1304521@gmail.com>
 L:	linux-iio@vger.kernel.org
@@ -13365,6 +13360,11 @@ S:	Maintained
 F:	drivers/iio/magnetometer/rm3100*
 F:	Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
 
+PNP SUPPORT
+M:	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
+S:	Maintained
+F:	drivers/pnp/
+
 POSIX CLOCKS and TIMERS
 M:	Thomas Gleixner <tglx@linutronix.de>
 L:	linux-kernel@vger.kernel.org
-- 
2.24.1

