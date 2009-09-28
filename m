From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH v1] PCI hotplug: move IOAPIC support from acpiphp to ioapic
 driver
Date: Mon, 28 Sep 2009 10:21:17 +0900
Message-ID: <4AC00F8D.7000008@jp.fujitsu.com>
References: <20090926032424.30285.4832.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20090926032424.30285.4832.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

Bjorn Helgaas wrote:
> This patch moves PCI I/O APIC support from acpiphp to a separate driver.
> 
> Like pciehp and shpchp, acpiphp handles PCI hotplug, i.e., addition and
> removal of PCI adapters.  But in addition, acpiphp handles some ACPI
> hotplug, such as the addition of new host bridges, and the I/O APIC
> support was tangled up with that.
> 
> I don't think the I/O APIC support needs to be in acpiphp; PCI I/O APICs
> usually appear as a function on a PCI host bridge, and we'll enumerate the
> APIC before any of the devices behind the bridge that use it.
> 
> As far as I know, nobody actually uses I/O APIC hotplug.  It depends on
> acpi_register_ioapic(), which is only implemented for ia64, and I don't
> think any vendors have supported I/O chassis hotplug yet.
> 
> Kenji-san, I think this new file needs a Fujitsu copyright, but there
> wasn't one in acpiphp_glue to copy.  If you send me one, I'll put it
> in the next version of this patch.
> 

Looks good to me. 

Reviewed-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

And here is Fujitsu copyright (thank you for asking me about that).

Copyright (C) 2009 Fujitsu Limited.

Thanks,
Kenji Kaneshige
