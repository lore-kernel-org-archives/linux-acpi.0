From: David Howells <dhowells@redhat.com>
Subject: [PATCH] Fix acpi_pm_device_sleep_wake()
Date: Tue, 08 Jul 2008 15:00:54 +0100
Message-ID: <20080708140053.4835.96139.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:48381 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754062AbYGHOBs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Jul 2008 10:01:48 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, jbarnes@virtuousgeek.org, akpm@linux-foundation.org
Cc: dhowells@redhat.com, linux-acpi@vger.kernel.org

Fix acpi_pm_device_sleep_wake() by providing a stub for CONFIG_PM_SLEEP=n.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/acpi/acpi_bus.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)


diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 7ab5a61..a5ac0bc 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -388,6 +388,10 @@ static inline int acpi_pm_device_sleep_state(struct device *d, int *p)
 		*p = ACPI_STATE_D0;
 	return ACPI_STATE_D3;
 }
+static inline int acpi_pm_device_sleep_wake(struct device *dev, bool enable)
+{
+	return -ENODEV;
+}
 #endif /* !CONFIG_PM_SLEEP */
 
 #endif				/* CONFIG_ACPI */

