From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH -next] acpi: fix acpi_bus.h warnings when ACPI is not enabled
Date: Wed, 23 May 2012 09:14:21 -0700
Message-ID: <4FBD0CDD.6010003@xenotime.net>
References: <20120523170740.ae058d8d5468d471eb948c39@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from oproxy5-pub.bluehost.com ([67.222.38.55]:39916 "HELO
	oproxy5-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751145Ab2EWQOV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 May 2012 12:14:21 -0400
In-Reply-To: <20120523170740.ae058d8d5468d471eb948c39@canb.auug.org.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

From: Randy Dunlap <rdunlap@xenotime.net>

Fix header file warnings when CONFIG_ACPI is not enabled:

include/acpi/acpi_bus.h:443:42: warning: 'struct acpi_bus_type' declared inside parameter list
include/acpi/acpi_bus.h:443:42: warning: its scope is only this definition or declaration, which is probably not what you want
include/acpi/acpi_bus.h:444:44: warning: 'struct acpi_bus_type' declared inside parameter list

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 include/acpi/acpi_bus.h |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20120523.orig/include/acpi/acpi_bus.h
+++ linux-next-20120523/include/acpi/acpi_bus.h
@@ -440,6 +440,8 @@ static inline int acpi_pm_device_sleep_w
 
 #else	/* CONFIG_ACPI */
 
+struct acpi_bus_type;
+
 static int register_acpi_bus_type(struct acpi_bus_type *bus) { return 0; }
 static int unregister_acpi_bus_type(struct acpi_bus_type *bus) { return 0; }
 
