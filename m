From: Stephan Berberig <s.berberig@arcor.de>
Subject: ACPI: bay: send envp with uevent - fix
Date: Sat, 09 Jun 2007 11:23:43 +0200
Message-ID: <466A719F.3010509@arcor.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010502080101080402060701"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:41246 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751733AbXFIKPL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 9 Jun 2007 06:15:11 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HwxyI-0004P1-9I
	for linux-acpi@vger.kernel.org; Sat, 09 Jun 2007 12:15:02 +0200
Received: from pd9e000e2.dip0.t-ipconnect.de ([217.224.0.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 09 Jun 2007 12:15:02 +0200
Received: from s.berberig by pd9e000e2.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 09 Jun 2007 12:15:02 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------010502080101080402060701
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,
attached a patch to fix the bay uevent so that udev doesn't get confused.

Kristen, could I get your Acked-by?

Best regards,
Stephan

--------------010502080101080402060701
Content-Type: text/x-patch;
 name="bay-send-envp-with-uevent-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bay-send-envp-with-uevent-fix.patch"

There must not be a new-line character in the uevent. Otherwise, udev gets confused.
Thanks to Kay Sievers for pointing it out.

Signed-off-by: Stephan Berberig <s.berberig@arcor.de>
CC: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

--- a/drivers/acpi/bay.c	2007-06-08 12:01:11.000000000 +0200
+++ b/drivers/acpi/bay.c	2007-06-08 12:02:49.000000000 +0200
@@ -337,7 +337,7 @@
 	char *envp[] = { event_string, NULL };
 
 	bay_dprintk(handle, "Bay event");
-	sprintf(event_string, "BAY_EVENT=%d\n", event);
+	sprintf(event_string, "BAY_EVENT=%d", event);
 	kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, envp);
 }
 

--------------010502080101080402060701--

