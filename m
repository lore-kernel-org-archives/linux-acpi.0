From: Len Brown <len.brown@intel.com>
Subject: [PATCH 07/20] sony-laptop: fix uninitialised variable
Date: Fri,  9 Mar 2007 22:49:25 -0500
Message-ID: <11734985842575-git-send-email-len.brown@intel.com>
References: <11734985781377-git-send-email-len.brown@intel.com> <11734985791126-git-send-email-len.brown@intel.com> <1173498580364-git-send-email-len.brown@intel.com> <11734985813852-git-send-email-len.brown@intel.com> <11734985822692-git-send-email-len.brown@intel.com> <11734985822425-git-send-email-len.brown@intel.com> <11734985831806-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48279 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752814AbXCJDtp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Mar 2007 22:49:45 -0500
In-Reply-To: <11734985831806-git-send-email-len.brown@intel.com>
Message-Id: <8607c673bdd593d4ce439a36412a213a8efb282b.1173498420.git.len.brown@intel.com>
In-Reply-To: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
References: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Andrew Morton <akpm@linux-foundation.org>

drivers/misc/sony-laptop.c: In function 'sony_acpi_add':
drivers/misc/sony-laptop.c:456: warning: 'result' may be used uninitialized in this function

The compiler seems to actually be telling the truth this time.

Cc: Mattia Dongili <malattia@linux.it>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/sony-laptop.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 2ebe240..ac708bc 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -453,7 +453,7 @@ static int sony_acpi_resume(struct acpi_device *device)
 static int sony_acpi_add(struct acpi_device *device)
 {
 	acpi_status status;
-	int result;
+	int result = 0;
 	acpi_handle handle;
 
 	sony_acpi_acpi_device = device;
-- 
1.5.0.3.310.g05ef5
