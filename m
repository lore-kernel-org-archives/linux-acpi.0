From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/4] Introduce pci_slot
Date: Fri, 28 Mar 2008 03:39:39 -0700
Message-ID: <20080328033939.5ef5ab7b.akpm@linux-foundation.org>
References: <20080325041314.GA29666@ldl.fc.hp.com>
	<20080325041700.GD29666@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59911 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751345AbYC1Kq0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Mar 2008 06:46:26 -0400
In-Reply-To: <20080325041700.GD29666@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Greg KH <gregkh@suse.de>, Gary Hade <garyhade@us.ibm.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Matthew Wilcox <matthew@wil.cx>, warthog19@eaglescrag.net, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org

On Mon, 24 Mar 2008 22:17:00 -0600 Alex Chiang <achiang@hp.com> wrote:

> Currently, /sys/bus/pci/slots/ only exposes hotplug attributes
> when a hotplug driver is loaded, but PCI slots have attributes
> such as address, speed, width, etc. that are not related to
> hotplug at all.
> 
> Introduce pci_slot as the primary data structure and kobject
> model. Hotplug attributes described in hotplug_slot become a
> secondary structure associated with the pci_slot.
> 
> This patch only creates the infrastructure that allows the
> separation of PCI slot attributes and hotplug attributes.
> In this patch, the PCI hotplug core remains the only user of this
> infrastructure, and thus, /sys/bus/pci/slots/ will still only
> become populated when a hotplug driver is loaded.
> 

I've so far fixed four compile errors in this patch.  It's your turn:

drivers/pci/hotplug/rpaphp_slot.c: In function 'rpaphp_deregister_slot':
drivers/pci/hotplug/rpaphp_slot.c:139: error: 'struct hotplug_slot' has no member named 'kobj'
drivers/pci/hotplug/rpaphp_slot.c: In function 'rpaphp_register_slot':
drivers/pci/hotplug/rpaphp_slot.c:173: error: 'struct hotplug_slot' has no member named 'kobj'
