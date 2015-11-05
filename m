From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ACPICA: Delete unnecessary checks before the function call
 "acpi_ut_strupr"
Date: Thu, 5 Nov 2015 16:22:32 +0100
Message-ID: <563B7438.6010002@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:57767 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754933AbbKEPWw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 Nov 2015 10:22:52 -0500
In-Reply-To: <5317A59D.4@users.sourceforge.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, devel@acpica.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 5 Nov 2015 16:12:32 +0100

The acpi_ut_strupr() function tests whether its argument is NULL
and then returns immediately. Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/acpica/dbcmds.c  | 9 ++-------
 drivers/acpi/acpica/dbinput.c | 5 +----
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/acpica/dbcmds.c b/drivers/acpi/acpica/dbcmds.c
index 30414b3..7dcc95a 100644
--- a/drivers/acpi/acpica/dbcmds.c
+++ b/drivers/acpi/acpica/dbcmds.c
@@ -1131,13 +1131,8 @@ void acpi_db_trace(char *enable_arg, char *method_arg, char *once_arg)
 	u32 debug_layer = 0;
 	u32 flags = 0;
 
-	if (enable_arg) {
-		acpi_ut_strupr(enable_arg);
-	}
-
-	if (once_arg) {
-		acpi_ut_strupr(once_arg);
-	}
+	acpi_ut_strupr(enable_arg);
+	acpi_ut_strupr(once_arg);
 
 	if (method_arg) {
 		if (acpi_db_trace_method_name) {
diff --git a/drivers/acpi/acpica/dbinput.c b/drivers/acpi/acpica/dbinput.c
index 0480254..aa1dcee 100644
--- a/drivers/acpi/acpica/dbinput.c
+++ b/drivers/acpi/acpica/dbinput.c
@@ -622,10 +622,7 @@ static u32 acpi_db_get_line(char *input_buffer)
 	}
 
 	/* Uppercase the actual command */
-
-	if (acpi_gbl_db_args[0]) {
-		acpi_ut_strupr(acpi_gbl_db_args[0]);
-	}
+	acpi_ut_strupr(acpi_gbl_db_args[0]);
 
 	count = i;
 	if (count) {
-- 
2.6.2

