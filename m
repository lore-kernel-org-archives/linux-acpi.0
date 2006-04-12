From: Borislav Deianov <borislav@users.sf.net>
Subject: Re: [PATCH] Fix Thinkpad A21m shutdown
Date: Wed, 12 Apr 2006 14:40:25 -0700
Message-ID: <20060412214025.GH26153@aero.ensim.com>
References: <200604121532.13392.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.ensim.com ([65.164.64.254]:12636 "EHLO aero.ensim.com")
	by vger.kernel.org with ESMTP id S932101AbWDLVkv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Apr 2006 17:40:51 -0400
Content-Disposition: inline
In-Reply-To: <200604121532.13392.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-thinkpad@linux-thinkpad.org, Raymund Will <rw@suse.de>

On Wed, Apr 12, 2006 at 03:32:12PM +0200, Thomas Renninger wrote:
> 
> The A21m Thinkpad (maybe also others) have a GDCK method and a DOCK device.
> It seems that on others machines the GDCK is the docking device.
> Installing the notify handler for a GDCK device fails.
> When module is unloaded it is tried to remove the never installed
> notify handler for the GDCK method which seems to freeze the machine.
> 
> Fix: Do not set notify_installed when installing the notify handler fails.

Thanks, Thomas - makes sense. Len, please apply.

Regards,
Borislav

Signed-off-by: Thomas Renninger <trenn@suse.de>

 drivers/acpi/ibm_acpi.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

Index: linux-2.6.16/drivers/acpi/ibm_acpi.c
===================================================================
--- linux-2.6.16.orig/drivers/acpi/ibm_acpi.c
+++ linux-2.6.16/drivers/acpi/ibm_acpi.c
@@ -1716,12 +1716,12 @@ static int __init setup_notify(struct ib
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
@@ -1811,6 +1811,8 @@ static int __init ibm_init(struct ibm_st
 		ret = setup_notify(ibm);
 		if (ret < 0)
 			return ret;
+		if (ret > 0)
+			return 0;
 		ibm->notify_installed = 1;
 	}
 
