From: akpm@linux-foundation.org
Subject: [patch 26/26] eeepc-laptop: fix hotplug_disabled module_param permissions
Date: Tue, 20 Jul 2010 15:19:55 -0700
Message-ID: <201007202219.o6KMJtEB021101@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37114 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932954Ab0GTWkb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jul 2010 18:40:31 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, axel.lin@gmail.com, alan-jenkins@tuffmail.co.uk, corentincj@iksaif.net, mjg@redhat.com

From: Axel Lin <axel.lin@gmail.com>

The hotplug_disabled module parameter is determinated at the module load
time.  Change the value after the module is loaded does not make sense and
has no effect at all, thus set the permissions to 0444 instead of 0644.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Cc: Corentin Chary <corentincj@iksaif.net>
Cc: Matthew Garrett <mjg@redhat.com>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/eeepc-laptop.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/platform/x86/eeepc-laptop.c~eeepc-laptop-fix-hotplug_disabled-module_param-permissions drivers/platform/x86/eeepc-laptop.c
--- a/drivers/platform/x86/eeepc-laptop.c~eeepc-laptop-fix-hotplug_disabled-module_param-permissions
+++ a/drivers/platform/x86/eeepc-laptop.c
@@ -53,7 +53,7 @@ MODULE_LICENSE("GPL");
 
 static bool hotplug_disabled;
 
-module_param(hotplug_disabled, bool, 0644);
+module_param(hotplug_disabled, bool, 0444);
 MODULE_PARM_DESC(hotplug_disabled,
 		 "Disable hotplug for wireless device. "
 		 "If your laptop need that, please report to "
_
