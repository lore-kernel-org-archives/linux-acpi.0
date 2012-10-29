From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pnpacpi: incorrect test
Date: Mon, 29 Oct 2012 16:05:09 +0000
Message-ID: <20121029160455.14886.37788.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:58202 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759899Ab2J2QDs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Oct 2012 12:03:48 -0400
Received: from localhost.localdomain (earthlight.etchedpixels.co.uk [81.2.110.250])
	by lxorguk.ukuu.org.uk (8.14.5/8.14.1) with ESMTP id q9TGZi44003568
	for <linux-acpi@vger.kernel.org>; Mon, 29 Oct 2012 16:35:49 GMT
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

TEST_ALPHA() is broken and always returns 0

Resolves-bug:  https://bugzilla.kernel.org/show_bug.cgi?id=45171
---

 drivers/pnp/pnpacpi/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 26b5d4b..107b6b6 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -58,7 +58,7 @@ static inline int __init is_exclusive_device(struct acpi_device *dev)
 	if (!(('0' <= (c) && (c) <= '9') || ('A' <= (c) && (c) <= 'F'))) \
 		return 0
 #define TEST_ALPHA(c) \
-	if (!('@' <= (c) || (c) <= 'Z')) \
+	if (!('@' <= (c) && (c) <= 'Z')) \
 		return 0
 static int __init ispnpidacpi(const char *id)
 {

