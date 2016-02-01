From: Joshua Hunt <johunt@akamai.com>
Subject: [PATCH 2/2] ACPI, APEI, ERST: Fixed leaked resources in erst_init
Date: Mon,  1 Feb 2016 13:47:48 -0500
Message-ID: <1454352468-14371-3-git-send-email-johunt@akamai.com>
References: <1454352468-14371-1-git-send-email-johunt@akamai.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from prod-mail-xrelay07.akamai.com ([23.79.238.175]:9841 "EHLO
	prod-mail-xrelay07.akamai.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752875AbcBASzC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2016 13:55:02 -0500
In-Reply-To: <1454352468-14371-1-git-send-email-johunt@akamai.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>, linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Joshua Hunt <johunt@akamai.com>

erst_init currently leaks resources allocated from its call to
apei_resources_request(). The data allocated there gets copied
into apei_resources_all and can be freed when we're done with it.

Signed-off-by: Josh Hunt <johunt@akamai.com>

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 6e6bc10..b86d8ea 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -1207,6 +1207,8 @@ static int __init erst_init(void)
 		"Failed to allocate %lld bytes for persistent store error log.\n",
 		erst_erange.size);
 
+	/* Cleanup ERST Resources */
+	apei_resources_fini(&erst_resources);
 	return 0;
 
 err_release_erange:
-- 
1.7.9.5

