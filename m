From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC][PATCH 0/3] PCI PM: Rework pci_set_power_state
Date: Fri, 20 Jun 2008 01:45:28 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806200143250.22284@localhost.localdomain>
References: <200806170206.26616.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:41801 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbYFTFqI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 01:46:08 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K2Q0034AYOJ7FI2@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 00:45:56 -0500 (CDT)
In-reply-to: <200806170206.26616.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>



> I've recently discovered that pci_set_power_state() calls the platform
> callback intended for changing the state of the device after it has done
> that using the native PCI mechanism.  In my opinion this is not correct,
> because, for example, if the device is being put into D0 from a low power
> state, it may require some platform-controlled power resources to be turned
> on before that (in theory).
> 
> The following series of patches changes this function so that the platform
> callback is performed first and then the native mechanism is used.
> Additionally, however, it checks if the devices is power manageable by the
> platform and only in that case the platform callback is invoked.  For this
> purpose, I needed to add an ACPI function allowing PCI to check the power
> manageability of given device.

We have 3 cases
1. device has PCI PM only
2. device has ACPI PM only
3. device has both PCI and ACPI PM

For #1 and #2, order is moot.
For #3, how can we be sure that the new order is better than the old 
order?  Is this a theoretical patch, or is there a failure case?

thanks,
-Len


