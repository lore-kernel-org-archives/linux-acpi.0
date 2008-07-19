From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [PATCH 2/3] acpi: Avoid dropping rapid GPEs on Asus EeePC and others
Date: Sat, 19 Jul 2008 12:39:05 +0100
Message-ID: <4881D259.3040202@tuffmail.co.uk>
References: <487D23C3.5070301@student.cs.york.ac.uk> <487F31D7.30803@suse.de> <20080717121309.GF31732@khazad-dum.debian.net> <487F3B6D.3090507@suse.de> <20080717162628.GB18457@khazad-dum.debian.net> <487F7724.5080905@tuffmail.co.uk> <20080717185032.GD18457@khazad-dum.debian.net> <487F986A.3070504@tuffmail.co.uk> <4881CE72.1090401@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:7234 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937AbYGSLis (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Jul 2008 07:38:48 -0400
Received: by nf-out-0910.google.com with SMTP id d3so237784nfc.21
        for <linux-acpi@vger.kernel.org>; Sat, 19 Jul 2008 04:38:46 -0700 (PDT)
In-Reply-To: <4881CE72.1090401@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

Fix regression "Asus Eee PC hotkeys stop working if pressed quickly",
<http://bugzilla.kernel.org/show_bug.cgi?id=11089>.  More important 
notifications e.g. battery level may also be affected.

It looks like this EC clears the SCI_EVT bit after every query, but there may
be more events buffered.  Therefore we should repeatedly query the EC until it
reports that no events remain.

The regression was caused by a recently added check for GPE interrupt storms.
The Eee PC triggers this check and switches to polling GPEs.  When multiple 
events arrive between polling intervals, only one was fetched from the EC.
This caused erroneous behaviour; ultimately events stop being delivered 
altogether when the EC buffer overflows.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Tested-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 9ca71df..e764011 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -457,14 +457,10 @@ void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit)
 
 EXPORT_SYMBOL_GPL(acpi_ec_remove_query_handler);
 
-static void acpi_ec_gpe_query(void *ec_cxt)
+static void acpi_ec_gpe_run_handler(struct acpi_ec *ec, u8 value)
 {
-	struct acpi_ec *ec = ec_cxt;
-	u8 value = 0;
 	struct acpi_ec_query_handler *handler, copy;
 
-	if (!ec || acpi_ec_query(ec, &value))
-		return;
 	mutex_lock(&ec->lock);
 	list_for_each_entry(handler, &ec->list, node) {
 		if (value == handler->query_bit) {
@@ -482,6 +478,18 @@ static void acpi_ec_gpe_query(void *ec_cxt)
 	mutex_unlock(&ec->lock);
 }
 
+static void acpi_ec_gpe_query(void *ec_cxt)
+{
+	struct acpi_ec *ec = ec_cxt;
+	u8 value = 0;
+
+	if (!ec)
+		return;
+
+	while (acpi_ec_query(ec, &value) == 0)
+		acpi_ec_gpe_run_handler(ec, value);
+}
+
 static u32 acpi_ec_gpe_handler(void *data)
 {
 	acpi_status status = AE_OK;


