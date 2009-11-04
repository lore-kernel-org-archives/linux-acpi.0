From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH v2] PCI hotplug: move IOAPIC support from acpiphp to
 ioapic driver
Date: Wed, 4 Nov 2009 09:41:35 -0800
Message-ID: <20091104094135.0f2fba05@jbarnes-piketon>
References: <20091026172015.22955.77484.stgit@bob.kio>
	<20091026172047.22955.33883.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20091026172047.22955.33883.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pci@vger.kernel.org, Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 26 Oct 2009 11:20:47 -0600
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> This patch moves PCI I/O APIC support from acpiphp to a separate
> driver.
> 
> Like pciehp and shpchp, acpiphp handles PCI hotplug, i.e., addition
> and removal of PCI adapters.  But in addition, acpiphp handles some
> ACPI hotplug, such as the addition of new host bridges, and the I/O
> APIC support was tangled up with that.
> 
> I don't think the I/O APIC support needs to be in acpiphp; PCI I/O
> APICs usually appear as a function on a PCI host bridge, and we'll
> enumerate the APIC before any of the devices behind the bridge that
> use it.
> 
> As far as I know, nobody actually uses I/O APIC hotplug.  It depends
> on acpi_register_ioapic(), which is only implemented for ia64, and I
> don't think any vendors have supported I/O chassis hotplug yet.

Applied to linux-next, thanks.

-- 
Jesse Barnes, Intel Open Source Technology Center
