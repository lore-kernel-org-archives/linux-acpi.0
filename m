From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/22] cpuidle: ladder does not depend on ACPI
Date: Fri,  9 Mar 2007 23:00:47 -0500
Message-ID: <11734992693895-git-send-email-lenb@kernel.org>
References: <11734992592550-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:27693 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1945928AbXCJEBK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Mar 2007 23:01:10 -0500
In-Reply-To: <11734992592550-git-send-email-lenb@kernel.org>
Message-Id: <b51f201f9a9af932c723492551f9e688d34cc468.1173498654.git.len.brown@intel.com>
In-Reply-To: <941b1971a405f95537bc6f9a738e737eb2186e45.1173498647.git.len.brown@intel.com>
References: <941b1971a405f95537bc6f9a738e737eb2186e45.1173498647.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

=46rom: Len Brown <len.brown@intel.com>

build fix for CONFIG_ACPI=3Dn

In file included from drivers/cpuidle/governors/ladder.c:21:
include/acpi/processor.h:88: error: expected specifier-qualifier-list b=
efore =E2=80=98acpi_integer=E2=80=99
include/acpi/processor.h:106: error: expected specifier-qualifier-list =
before =E2=80=98acpi_integer=E2=80=99
include/acpi/processor.h:168: error: expected specifier-qualifier-list =
before =E2=80=98acpi_handle=E2=80=99

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/cpuidle/governors/ladder.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/gover=
nors/ladder.c
index 87d2e54..cf5a7a7 100644
--- a/drivers/cpuidle/governors/ladder.c
+++ b/drivers/cpuidle/governors/ladder.c
@@ -14,11 +14,9 @@
=20
 #include <linux/kernel.h>
 #include <linux/cpuidle.h>
-#include <linux/acpi.h>
 #include <linux/latency.h>
 #include <linux/moduleparam.h>
 #include <linux/jiffies.h>
-#include <acpi/processor.h>
=20
 #include <asm/io.h>
 #include <asm/uaccess.h>
--=20
1.5.0.3.310.g05ef5
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
