From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI / PCI: Make _SxD/_SxW check follow ACPI 4.0a spec
Date: Fri, 25 May 2012 22:00:24 +0200
Message-ID: <201205252200.24331.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1205251511170.1907-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:37710 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933230Ab2EYU1K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 May 2012 16:27:10 -0400
In-Reply-To: <Pine.LNX.4.44L0.1205251511170.1907-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Oleksij Rempel (fishor)" <bug-track@fisher-privat.net>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Friday, May 25, 2012, Alan Stern wrote:
> Oleksij:
> 
> Please take a look at this bug report:
> 
> 	https://bugzilla.kernel.org/show_bug.cgi?id=43278
> 
> Apparently your patch breaks wakeup on this machine by preventing the 
> USB host controllers from being put into D3.

I think the patch is incorrect, actually.

First, if you look at the first hunk:

-       if (acpi_target_sleep_state > ACPI_STATE_S0)
+       if (acpi_target_sleep_state > ACPI_STATE_S0) {
+               acpi_status status;
+
                acpi_evaluate_integer(handle, acpi_method, NULL, &d_min);
 
+               if (device_may_wakeup(dev)) {
+                       acpi_method[3] = 'W';
+                       status = acpi_evaluate_integer(handle, acpi_method,
+                                                      NULL, &d_max);
+                       if (ACPI_FAILURE(status))
+                               d_max = d_min;
+               }
+       }

it will do something like this: if the device is wakeup-capable, get d_max
from _SxW, unless it fails.  However, the code just below in that function:

	if (acpi_target_sleep_state == ACPI_STATE_S0 ||
	    (device_may_wakeup(dev) &&
	     adev->wakeup.sleep_state <= acpi_target_sleep_state)) {
		acpi_status status;

		acpi_method[3] = 'W';
		status = acpi_evaluate_integer(handle, acpi_method, NULL,
						&d_max);
		if (ACPI_FAILURE(status)) {
			if (acpi_target_sleep_state != ACPI_STATE_S0 ||
			    status != AE_NOT_FOUND)
				d_max = d_min;
		} else if (d_max < d_min) {
			/* Warn the user of the broken DSDT */
			printk(KERN_WARNING "ACPI: Wrong value from %s\n",
				acpi_method);
			/* Sanitize it */
			d_min = d_max;
		}
	}

does _exactly_ the same thing (it only has a more sophisticated error code path).

It might check adev->wakeup.flags.valid instead of device_may_wakeup(dev),
but that's a different story.

So the only difference made by the patch is te hunk in pci_target_state().

Thanks,
Rafael
