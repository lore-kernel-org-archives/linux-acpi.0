From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 13/26] ACPI: print wakeup device list on same line as label
Date: Mon, 3 Apr 2006 16:05:02 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB616C058@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:2381 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S964868AbWDCUF2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Apr 2006 16:05:28 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: akpm@osdl.org, linux-acpi@vger.kernel.org

applied.

thanks,
-Len
 

>-----Original Message-----
>From: Bjorn Helgaas [mailto:bjorn.helgaas@hp.com] 
>Sent: Monday, April 03, 2006 1:14 PM
>To: Brown, Len
>Cc: akpm@osdl.org; linux-acpi@vger.kernel.org
>Subject: Re: [patch 13/26] ACPI: print wakeup device list on 
>same line as label
>
>On Saturday 01 April 2006 19:55, Brown, Len wrote:
>> >From: Bjorn Helgaas <bjorn.helgaas@hp.com>
>> >
>> >Print the ACPI wakeup device list on the same line as the 
>label to make
>> >"dmesg | grep ACPI" output more useful.
>> 
>> It is a temporary hack that we expose these devices via the 
>internal BIOS names.
>> They should really be properties of devices in the device tree.
>
>That's true.  Is it an issue that this property is not yet exported
>in the device tree?  Probably not, because any current consumers of
>this information would have to be scanning dmesg for ugly names like
>these from my HP nw8240:
>
>    ACPI wakeup devices: C069 C0CE C1D1 C0DE C1D4 
>
>> Instead of updating this message, can we delete it altogether?
>
>Sure.  Andrew, can you replace
>acpi-print-wakeup-device-list-on-same-line-as-label
>with the following?
>
>
>[ACPI] Don't print internal BIOS names of wakeup devices
>
>The "wakeup" property of a device should be exported via the
>device tree, not by a printk of an internal BIOS name.
>
>Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>
>Index: linux-2.6/drivers/acpi/sleep/wakeup.c
>===================================================================
>--- linux-2.6.orig/drivers/acpi/sleep/wakeup.c	2006-02-13 
>15:44:33.000000000 -0700
>+++ linux-2.6/drivers/acpi/sleep/wakeup.c	2006-04-03 
>11:00:41.000000000 -0600
>@@ -155,7 +155,6 @@
> 
> 	if (acpi_disabled)
> 		return 0;
>-	printk("ACPI wakeup devices: \n");
> 
> 	spin_lock(&acpi_device_lock);
> 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
>@@ -174,10 +173,8 @@
> 			dev->wakeup.state.enabled = 1;
> 			spin_lock(&acpi_device_lock);
> 		}
>-		printk("%4s ", dev->pnp.bus_id);
> 	}
> 	spin_unlock(&acpi_device_lock);
>-	printk("\n");
> 
> 	return 0;
> }
>
