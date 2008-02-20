From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Re: 2.6.25-rc2 System no longer powers off after suspend-to-disk.
 Screen becomes green.
Date: Thu, 21 Feb 2008 01:17:15 +0800 (SGT)
Message-ID: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:5636 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754228AbYBTRRi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Feb 2008 12:17:38 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1986872rvb.1
        for <linux-acpi@vger.kernel.org>; Wed, 20 Feb 2008 09:17:35 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jesse.barnes@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, suspend-devel List <suspend-devel@lists.sourceforge.net>, Greg KH <gregkh@suse.de>



On Feb 20, 2008 2:19 PM, Jeff Chua
> I'll try the "idle=poll" to see if that works and will try some printk

I don't know what exactly the i915_suspend() and i915_resume() are 
supposed to do because it works better without them.

After inserting "return 0;" right at the top of those two functions, 
suspend (and power-off properly), and resume (without green screen) works 
just fine.

I would like to know what they're for.

Tested suspend-to-ram, and suspend-to-disk, both console and X on notebook 
internal LCD display, all works without these two functions.

But, anyway, got down to just one line in i915_drv.c causing the hang 
during suspend. "pci_set_power_state(dev->pdev, PCI_D3hot);".

And green screen problem during resume is caused by i915_restore_vga(dev);

So, let me where to go from here.


Thanks,
Jeff.




--- linux/drivers/char/drm/i915_drv.c.bad	2008-02-20 
11:29:14 +0800
+++ linux/drivers/char/drm/i915_drv.c	2008-02-21 00:58:37 +0800
@@ -369,7 +369,7 @@
  	if (state.event == PM_EVENT_SUSPEND) {
  		/* Shut down the device */
  		pci_disable_device(dev->pdev);
-		pci_set_power_state(dev->pdev, PCI_D3hot);
+		//pci_set_power_state(dev->pdev, PCI_D3hot);
  	}

  	return 0;
@@ -521,7 +521,7 @@
  	for (i = 0; i < 3; i++)
  		I915_WRITE(SWF30 + (i << 2), dev_priv->saveSWF2[i]);

-	i915_restore_vga(dev);
+	//i915_restore_vga(dev);

  	return 0;
  }
