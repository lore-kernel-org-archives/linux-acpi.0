From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 0/3, v10] PCI, ACPI: Physical PCI slot objects
Date: Wed, 19 Mar 2008 11:24:54 +0900
Message-ID: <47E07976.3040007@jp.fujitsu.com>
References: <20080318210539.GA30421@ldl.fc.hp.com> <20080319005535.GB424@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail9.fujitsu.co.jp ([192.51.44.39]:42700 "EHLO
	fgwmail9.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbYCTD6J (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Mar 2008 23:58:09 -0400
In-Reply-To: <20080319005535.GB424@parisc-linux.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Alex Chiang <achiang@hp.com>, Greg KH <gregkh@suse.de>, Gary Hade <garyhade@us.ibm.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, warthog19@eaglescrag.net, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org

Matthew Wilcox wrote:
> On Tue, Mar 18, 2008 at 03:05:39PM -0600, Alex Chiang wrote:
>> Also, v10 should fix the "pci_slot module changes the sysfs name"
>> issue that Kenji-san was seeing.
> 
> I thought we agreed that the current names are wrong, and we shouldn't
> consider this 'different name' an issue.
> 

I also think that the current names are wrong. But even if we fix the
slot name of shpchp/pciehp, it doesn't ensure that slot names are same
among pci_slot.ko and the other hotplug dirvers.

BTW, I'm planning to suggest the patch for shpchp/pciehp to use slot
number as a slot name (as they used to do), and add a module option
to use the combination of bus number and slot number as a slot name
as a workaround for problematic platforms.

Thanks,
Kenji Kaneshige

