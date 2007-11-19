From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [PATCH 0/4, v3] Physical PCI slot objects
Date: Mon, 19 Nov 2007 09:43:07 -0800
Message-ID: <20071119094307.517411a2@appleyard>
References: <20071117182954.GA25003@ldl.fc.hp.com>
Reply-To: kristen.c.accardi@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56300 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753819AbXKSRoo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Nov 2007 12:44:44 -0500
In-Reply-To: <20071117182954.GA25003@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: Gary Hade <garyhade@us.ibm.com>, Matthew Wilcox <matthew@wil.cx>, gregkh@suse.de, achiang@hp.com, lenb@kernel.org, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, kaneshige.kenji@jp.fujitsu.com, pcihpd-discuss@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Sat, 17 Nov 2007 11:29:54 -0700
Alex Chiang <achiang@hp.com> wrote:

> I have done quite a bit more testing, and verified that this
> series plays nicely with acpiphp during all stages of the series.
> Notably, you can modprobe/rmmod acpiphp repeatedly no matter
> where you are in the series, and no matter whether you have
> CONFIG_ACPI_PCI_SLOT turned on. The correct entries in
> /sys/bus/pci/slots/ will appear and disappear, and we correctly
> register/deregister ACPI slots with the pci_hp core. 

Hi Alex,
How does this patch play with non-acpi based hotplug such as the pciehp
driver or the shpchp driver for example?

Thanks,
Kristen
