From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] #if 0 acpi/bay.c:eject_removable_drive()
Date: Mon, 14 Apr 2008 21:40:47 +0300
Message-ID: <20080414184047.GF6695@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp4.pp.htv.fi ([213.243.153.38]:51066 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764014AbYDNSlx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Apr 2008 14:41:53 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

This patch #if 0's the unused eject_removable_drive().

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

This patch has been sent on:
- 31 Mar 2008
- 1 Mar 2008

 drivers/acpi/bay.c |    2 ++
 1 file changed, 2 insertions(+)

de6f6fda54c9a51719c8e5a5b8d303fb958cfe36 foobar
diff --git a/drivers/acpi/bay.c b/drivers/acpi/bay.c
index 1fa8681..d2fc941 100644
--- a/drivers/acpi/bay.c
+++ b/drivers/acpi/bay.c
@@ -201,6 +201,7 @@ static int is_ejectable_bay(acpi_handle handle)
 	return 0;
 }
 
+#if 0
 /**
  * eject_removable_drive - try to eject this drive
  * @dev : the device structure of the drive
@@ -225,6 +226,7 @@ int eject_removable_drive(struct device *dev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(eject_removable_drive);
+#endif  /*  0  */
 
 static int acpi_bay_add_fs(struct bay *bay)
 {



