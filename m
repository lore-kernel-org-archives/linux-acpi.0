From: Jaswinder Singh Rajput <jaswinder@kernel.org>
Subject: [PATCH 35/44] includecheck fix: include/acpi, acpi_bus.h
Date: Wed, 08 Jul 2009 21:17:38 +0530
Message-ID: <1247068058.4382.96.camel@ht.satnam>
References: <1247063308.4382.12.camel@ht.satnam>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53251 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759196AbZGHQFk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Jul 2009 12:05:40 -0400
In-Reply-To: <1247063308.4382.12.camel@ht.satnam>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>


fix the following 'make includecheck' warning:

  include/acpi/acpi_bus.h: linux/device.h is included more than once.

Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
---
 include/acpi/acpi_bus.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index c65e4ce..2d8f6ef 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -356,7 +356,6 @@ void acpi_remove_dir(struct acpi_device *);
 /*
  * Bind physical devices with ACPI devices
  */
-#include <linux/device.h>
 struct acpi_bus_type {
 	struct list_head list;
 	struct bus_type *bus;
-- 
1.6.0.6



