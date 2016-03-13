From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/2] Use acpi_dev_present()
Date: Sun, 13 Mar 2016 02:50:14 +0100
Message-ID: <CAJZ5v0inUHCPgfZ7VKLHvehOKbDcAgpdu9un1t3+zk_iPpCBxw@mail.gmail.com>
References: <cover.1453060661.git.lukas@wunner.de>
	<20160119211229.GB3253@malice.jf.intel.com>
	<5367662.pAQ7mO39ru@vostro.rjw.lan>
	<20160211183157.GA15803@wunner.de>
	<CAJZ5v0gRYiWDSd-hgMPiBEAOEif8sdc-W=Ot5fibPUMv_EE+Jg@mail.gmail.com>
	<20160312173135.GA27059@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20160312173135.GA27059@wunner.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Darren Hart <dvhart@infradead.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, platform-driver-x86@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Corentin Chary <corentin.chary@gmail.com>, acpi4asus-user@lists.sourceforge.net, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Mar 12, 2016 at 6:31 PM, Lukas Wunner <lukas@wunner.de> wrote:
> Hi Rafael,
>
> I've noticed only now that the PCI core has 2 separate functions
> for detecting presence of a device, pci_dev_present() which only
> searches the list of enumerated devices, and pci_device_is_present(),
> which tests actual presence by reading from the device's config space.
>
> Thus it would actually be consistent to have acpi_dev_present()
> (only searches namespace) and acpi_device_is_present() (calls _STA).
>
> But I assume you still want it renamed, right?

Right.

Thanks,
Rafael
