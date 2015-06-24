From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: ACPI-APEI: Make exception handling a bit more efficient in __einj_error_trigger()
Date: Wed, 24 Jun 2015 12:32:35 +0200
Message-ID: <558A8743.5040105@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net> <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6> <530A086E.8010901@users.sourceforge.net> <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6> <530A72AA.3000601@users.sourceforge.net> <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6> <530B5FB6.6010207@users.sourceforge.net> <alpine.DEB.2.10.1402241710370.2074@hadrien> <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.so
 urceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:53370 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014AbbFXKcs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Jun 2015 06:32:48 -0400
In-Reply-To: <5317A59D.4@users.sourceforge.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 24 Jun 2015 11:41:46 +0200

Return from the __einj_error_trigger() function directly after a failed
call for the request_mem_region() function according to the current Linux
coding style convention.

Drop an unnecessary initialisation for the variable "trigger_tab" then.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/apei/einj.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index a095d4f..c3a2c06 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -299,7 +299,7 @@ static struct acpi_generic_address *einj_get_trigger_parameter_region(
 static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 				u64 param1, u64 param2)
 {
-	struct acpi_einj_trigger *trigger_tab = NULL;
+	struct acpi_einj_trigger *trigger_tab;
 	struct apei_exec_context trigger_ctx;
 	struct apei_resources trigger_resources;
 	struct acpi_whea_header *trigger_entry;
@@ -316,7 +316,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 		       (unsigned long long)trigger_paddr,
 		       (unsigned long long)trigger_paddr +
 			    sizeof(*trigger_tab) - 1);
-		goto out;
+		return rc;
 	}
 	trigger_tab = ioremap_cache(trigger_paddr, sizeof(*trigger_tab));
 	if (!trigger_tab) {
@@ -407,7 +407,7 @@ out_rel_entry:
 			   table_size - sizeof(*trigger_tab));
 out_rel_header:
 	release_mem_region(trigger_paddr, sizeof(*trigger_tab));
-out:
+
 	if (trigger_tab)
 		iounmap(trigger_tab);
 
-- 
2.4.4

