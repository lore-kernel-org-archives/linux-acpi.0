From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] Repost: acpi_ibm_notify.patch
Date: Tue, 01 Aug 2006 15:26:11 +0200
Message-ID: <1154438772.4302.367.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-IJWfm0WUiLK3Nsp1MJsc"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:36575 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932544AbWHANWu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Aug 2006 09:22:50 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: "Brown, Len" <len.brown@intel.com>


--=-IJWfm0WUiLK3Nsp1MJsc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This one already got the OK of Borislav (ibm_acpi author)
See mail:
	Subject: Re: [PATCH] Fix Thinkpad A21m shutdown
	Date: Wed, 12 Apr 2006
on this list.

Fix Thinkpad A21m shutdown

The A21m Thinkpad (maybe also be others, T21,..) have an ACPI GDCK method
and an ACPI DOCK device.
It seems that on others machines the GDCK is the docking device.
Installing the notify handler for a GDCK fails if it is a method
an not a device.
When module is unloaded it is tried to remove the never installed
notify handler for the GDCK method which seems to freeze the machine.
Fix: Do not set notify_installed when installing the notify handler fails.

Reference: https://bugzilla.novell.org/show_bug.cgi?id=150851

Signed-off-by: Thomas Renninger <mail@renninger.de>

 drivers/acpi/ibm_acpi.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

Index: linux-2.6.18-rc2/drivers/acpi/ibm_acpi.c
===================================================================
--- linux-2.6.18-rc2.orig/drivers/acpi/ibm_acpi.c
+++ linux-2.6.18-rc2/drivers/acpi/ibm_acpi.c
@@ -1789,12 +1789,12 @@ static int __init setup_notify(struct ib
 	int ret;
 
 	if (!*ibm->handle)
-		return 0;
+		return 1;
 
 	ret = acpi_bus_get_device(*ibm->handle, &ibm->device);
 	if (ret < 0) {
 		printk(IBM_ERR "%s device not present\n", ibm->name);
-		return 0;
+		return 1;
 	}
 
 	acpi_driver_data(ibm->device) = ibm;
@@ -1884,6 +1884,8 @@ static int __init ibm_init(struct ibm_st
 		ret = setup_notify(ibm);
 		if (ret < 0)
 			return ret;
+		if (ret > 0)
+			return 0;
 		ibm->notify_installed = 1;
 	}
 


--=-IJWfm0WUiLK3Nsp1MJsc
Content-Disposition: attachment; filename=acpi_ibm_notify.patch
Content-Type: text/x-patch; name=acpi_ibm_notify.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Fix Thinkpad A21m shutdown

The A21m Thinkpad (maybe also be others, T21,..) have an ACPI GDCK method
and an ACPI DOCK device.
It seems that on others machines the GDCK is the docking device.
Installing the notify handler for a GDCK fails if it is a method
an not a device.
When module is unloaded it is tried to remove the never installed
notify handler for the GDCK method which seems to freeze the machine.
Fix: Do not set notify_installed when installing the notify handler fails.

Reference: https://bugzilla.novell.org/show_bug.cgi?id=150851

Signed-off-by: Thomas Renninger <mail@renninger.de>

 drivers/acpi/ibm_acpi.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

Index: linux-2.6.18-rc2/drivers/acpi/ibm_acpi.c
===================================================================
--- linux-2.6.18-rc2.orig/drivers/acpi/ibm_acpi.c
+++ linux-2.6.18-rc2/drivers/acpi/ibm_acpi.c
@@ -1789,12 +1789,12 @@ static int __init setup_notify(struct ib
 	int ret;
 
 	if (!*ibm->handle)
-		return 0;
+		return 1;
 
 	ret = acpi_bus_get_device(*ibm->handle, &ibm->device);
 	if (ret < 0) {
 		printk(IBM_ERR "%s device not present\n", ibm->name);
-		return 0;
+		return 1;
 	}
 
 	acpi_driver_data(ibm->device) = ibm;
@@ -1884,6 +1884,8 @@ static int __init ibm_init(struct ibm_st
 		ret = setup_notify(ibm);
 		if (ret < 0)
 			return ret;
+		if (ret > 0)
+			return 0;
 		ibm->notify_installed = 1;
 	}
 

--=-IJWfm0WUiLK3Nsp1MJsc--

