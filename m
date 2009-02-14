From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 1/4] acer-wmi: double free in acer_rfkill_exit()
Date: Sat, 14 Feb 2009 09:53:48 +0000
Message-ID: <20090214095348.18550.46246.stgit@localhost>
References: <20090214095342.18550.24339.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:33145 "EHLO
	pegasus." rhost-flags-OK-OK-FAIL-FAIL) by vger.kernel.org with ESMTP
	id S1751342AbZBNKNU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Feb 2009 05:13:20 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pegasus. (8.14.3/8.13.8) with ESMTP id n1E9rmsv018594
	for <linux-acpi@vger.kernel.org>; Sat, 14 Feb 2009 09:53:48 GMT
In-Reply-To: <20090214095342.18550.24339.stgit@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

From: Dan Carpenter <error27@gmail.com>

This is acer_rfkill_exit() from drivers/platform/x86/acer-wmi.c.

The code frees wireless_rfkill->data again instead of
bluetooth_rfkill->data.

This was found using a code checker (http://repo.or.cz/w/smatch.git/).
Compile tested only, sorry.

regards,
dan carpenter

Signed-off-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>

--- orig/drivers/platform/x86/acer-wmi.c	2009-02-03 08:06:54.000000000 +0300
+++ devel/drivers/platform/x86/acer-wmi.c	2009-02-03 08:07:16.000000000 +0300
@@ -1026,7 +1026,7 @@
  	kfree(wireless_rfkill->data);
  	rfkill_unregister(wireless_rfkill);
  	if (has_cap(ACER_CAP_BLUETOOTH)) {
-		kfree(wireless_rfkill->data);
+		kfree(bluetooth_rfkill->data);
  		rfkill_unregister(bluetooth_rfkill);
  	}
  	return;
---

 0 files changed, 0 insertions(+), 0 deletions(-)



