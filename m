From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [Resend PATCH V2 2/7] usb: Bind devices to ACPI devices when
 possible
Date: Sat, 5 May 2012 16:00:47 +0100
Message-ID: <20120505150046.GA6743@srcf.ucam.org>
References: <1336100803-28353-1-git-send-email-tianyu.lan@intel.com>
 <1336100803-28353-3-git-send-email-tianyu.lan@intel.com>
 <20120505002155.GA12282@kroah.com>
 <20120505052624.GA574@srcf.ucam.org>
 <20120505144743.GA27434@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:55601 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755637Ab2EEPA4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 May 2012 11:00:56 -0400
Content-Disposition: inline
In-Reply-To: <20120505144743.GA27434@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Lan Tianyu <tianyu.lan@intel.com>, lenb@kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, mfm@muteddisk.com

On Sat, May 05, 2012 at 07:47:43AM -0700, Greg KH wrote:

> I think the problem is that these functions aren't exported to modules,
> not that they aren't there for non-ACPI systems (although that too is
> probably a problem...)

Bleah. Of course.

commit 050f1fd505db7969efc0ca245d2c17f279f42fa2
Author: Matthew Garrett <mjg@redhat.com>
Date:   Sat May 5 01:21:45 2012 -0400

    ACPI: Add stubs for (un)register_acpi_bus_type
    
    It's unreasonable to have CONFIG_ACPI for these in drivers, so add some
    stub functions.
    
    Signed-off-by: Matthew Garrett <mjg@redhat.com>

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 29a4a5c..243ee85 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -39,6 +39,7 @@ int register_acpi_bus_type(struct acpi_bus_type *type)
 	}
 	return -ENODEV;
 }
+EXPORT_SYMBOL_GPL(register_acpi_bus_type);
 
 int unregister_acpi_bus_type(struct acpi_bus_type *type)
 {
@@ -54,6 +55,7 @@ int unregister_acpi_bus_type(struct acpi_bus_type *type)
 	}
 	return -ENODEV;
 }
+EXPORT_SYMBOL_GPL(unregister_acpi_bus_type);
 
 static struct acpi_bus_type *acpi_get_bus_type(struct bus_type *type)
 {
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 30a9250..714b7d7 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -431,6 +431,11 @@ static inline int acpi_pm_device_sleep_wake(struct device *dev, bool enable)
 }
 #endif
 
+#else	/* CONFIG_ACPI */
+
+static int register_acpi_bus_type(struct acpi_bus_type *bus) { return 0; }
+static int unregister_acpi_bus_type(struct acpi_bus_type *bus) { return 0; }
+
 #endif				/* CONFIG_ACPI */
 
 #endif /*__ACPI_BUS_H__*/

-- 
Matthew Garrett | mjg59@srcf.ucam.org
