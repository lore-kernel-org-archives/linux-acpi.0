From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [Resend PATCH V2 2/7] usb: Bind devices to ACPI devices when
 possible
Date: Sat, 5 May 2012 06:26:24 +0100
Message-ID: <20120505052624.GA574@srcf.ucam.org>
References: <1336100803-28353-1-git-send-email-tianyu.lan@intel.com>
 <1336100803-28353-3-git-send-email-tianyu.lan@intel.com>
 <20120505002155.GA12282@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:55398 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab2EEF0f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 May 2012 01:26:35 -0400
Content-Disposition: inline
In-Reply-To: <20120505002155.GA12282@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Lan Tianyu <tianyu.lan@intel.com>, lenb@kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, mfm@muteddisk.com

On Fri, May 04, 2012 at 05:21:55PM -0700, Greg KH wrote:

> This patch breaks the build with:
> 	ERROR: "unregister_acpi_bus_type" [drivers/usb/core/usbcore.ko] undefined!
> 	ERROR: "register_acpi_bus_type" [drivers/usb/core/usbcore.ko] undefined!
> 
> {sigh}
> 
> Care to resend them after fixing this?

Does this fix it?

commit f5c5fea66ab7db94cea5a51c474ff5111ec55800
Author: Matthew Garrett <mjg@redhat.com>
Date:   Sat May 5 01:21:45 2012 -0400

    ACPI: Add stubs for (un)register_acpi_bus_type
    
    It's unreasonable to have CONFIG_ACPI for these in drivers, so add some
    stub functions.
    
    Signed-off-by: Matthew Garrett <mjg@redhat.com>

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 30a9250..19f9483 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -431,6 +431,11 @@ static inline int acpi_pm_device_sleep_wake(struct device *dev, bool enable)
 }
 #endif
 
+#else	/* CONFIG_ACPI */
+
+static int register_acpi_bus_type (struct acpi_bus_type *bus) { return 0; }
+static int unregister_acpi_bus_type (struct acpi_bus_type *bus) { return 0; }
+
 #endif				/* CONFIG_ACPI */
 
 #endif /*__ACPI_BUS_H__*/

-- 
Matthew Garrett | mjg59@srcf.ucam.org
