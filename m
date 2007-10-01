From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: what is writing to /sys/bus/pci/slot/<slot_no>/power really
 supposed to do?
Date: Mon, 1 Oct 2007 10:08:58 -0700
Message-ID: <20071001100858.06919a1e.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:64571 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751806AbXJAROM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 1 Oct 2007 13:14:12 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pcihpd-discuss@lists.sourceforge.net
Cc: linux-acpi@vger.kernel.org, gregkh@suse.de

Hi,
I notice in acpiphp that the code path for powering down the slot
via sysfs does not execute the _EJ0 method, but instead simply
looks for _PS3 and of couse disables all the bridges and devices.  
I suppose this could be valid depending on your definition of what 
/sys/bus/pci/slots/<slot_no>/power should do.

Is it intended to just power down the adapter that's in the slot, 
or is it intended to make the adapter in the slot able to be removed?
If it's intended to make the adapter able to be removed, shouldn't
we be calling _EJ0?

As a comparison, in pciehp when the sysfs power file is written,
we do actually go out and send the commands to the hotplug controller
to physically power off the slot.

Kristen
