From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/13] ACPI: EC: "DEBUG" needs to be defined earlier
Date: Thu, 24 Jan 2008 00:06:54 -0500
Message-ID: <d772b3b323a15588a757f5af28e51a57d0d2f622.1201150939.git.len.brown@intel.com>
References: <1201151215-11203-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:61214 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751573AbYAXFHB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Jan 2008 00:07:01 -0500
In-Reply-To: <1201151215-11203-1-git-send-email-lenb@kernel.org>
In-Reply-To: <d1154be3004e9db2d61533e16bb2cf85dd27a8cb.1201150939.git.len.brown@intel.com>
References: <d1154be3004e9db2d61533e16bb2cf85dd27a8cb.1201150939.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: =?utf-8?q?M=C3=A1rton=20N=C3=A9meth?= <nm127@freemail.hu>, Len Brown <len.brown@intel.com>

=46rom: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>

The "DEBUG" symbol needs to be defined before #including <linux/kernel.=
h> to
get the pr_debug() working.

Signed-off-by: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 06c9f35..987b967 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -26,6 +26,9 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~
  */
=20
+/* Uncomment next line to get verbose print outs*/
+/* #define DEBUG */
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -47,9 +50,6 @@
 #undef PREFIX
 #define PREFIX				"ACPI: EC: "
=20
-/* Uncomment next line to get verbose print outs*/
-/* #define DEBUG */
-
 /* EC status register */
 #define ACPI_EC_FLAG_OBF	0x01	/* Output buffer full */
 #define ACPI_EC_FLAG_IBF	0x02	/* Input buffer full */
--=20
1.5.4.rc4.14.g6fc74

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
