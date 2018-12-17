From: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RFC PATCH 2/2] PCI/portdrv Hisilicon PCIe transport layer Port
 PMU driver.
Date: Mon, 17 Dec 2018 11:34:39 -0700
Message-ID: <5bbd3740-0a25-a5a8-bd88-9e29dffdc4d3@deltatee.com>
References: <20181214131055.52253-1-Jonathan.Cameron@huawei.com>
 <20181214131055.52253-3-Jonathan.Cameron@huawei.com>
 <20181214235505.GI20725@google.com> <20181217110906.0000003f@huawei.com>
 <20181217181915.GL20725@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181217181915.GL20725@google.com>
Content-Language: en-CA
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bjorn Helgaas <helgaas@kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Shaokun Zhang <zhangshaokun@hisilicon.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linuxarm@huawei.com, linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>, linux-acpi@vger.kernel.org, Zhou Wang <wangzhou1@hisilicon.com>, alex.umansky@huawei.com, Eric.Wehage@huawei.com, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org



On 2018-12-17 11:19 a.m., Bjorn Helgaas wrote:
> I *think* drivers/pci/switch/switchtec.c is for a type 0 endpoint that
> happens to be built into the switch, e.g., the type 1 bridge is
> function 0 and the type 0 management endpoint is function 1.  Logan,
> can you confirm/deny?

Yes, that's correct. The upstream port has multiple functions: one for
the bridge and one for the management/NTB endpoint. In the driver, we
have absolutely no reason to touch, or even know about, the bridge
endpoint. This is all very configurable and you can disable either of
the endpoints in the switch's configuration. And the NTB endpoint can
have all the BARS configured with any reasonable amount of BAR space for
memory windows. In the NTB world, there are never enough BARs or address
space within them.

The upstream device, with both functions, looks like this on my system:

02:00.0 PCI bridge: PMC-Sierra Inc. Device 8543 (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0, NUMA node 0
	Bus: primary=02, secondary=03, subordinate=0c, sec-latency=0
	I/O behind bridge: 00002000-00006fff
	Memory behind bridge: f7100000-f78fffff
	Prefetchable memory behind bridge: 0000381f80000000-0000381fc3ffffff
	Capabilities: [40] Express Upstream Port, MSI 00
	Capabilities: [7c] MSI: Enable- Count=1/8 Maskable- 64bit+
	Capabilities: [8c] Power Management version 3
	Capabilities: [94] Subsystem: PMC-Sierra Inc. Device beef
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [138] Power Budgeting <?>
	Capabilities: [148] #12
	Capabilities: [178] #19
	Capabilities: [1a4] Device Serial Number 50-0e-00-4a-00-00-00-01
	Capabilities: [1b0] Latency Tolerance Reporting
	Capabilities: [1b8] Access Control Services
	Capabilities: [7f8] Vendor Specific Information: ID=ffff Rev=1 Len=808 <?>
	Kernel driver in use: pcieport

02:00.1 Memory controller: PMC-Sierra Inc. Device 8543
	Subsystem: PMC-Sierra Inc. Device 8543
	Flags: bus master, fast devsel, latency 0, NUMA node 0
	Memory at 381fc4000000 (64-bit, prefetchable) [size=4M]
	Capabilities: [40] MSI: Enable- Count=1/4 Maskable- 64bit+
	Capabilities: [50] MSI-X: Enable+ Count=4 Masked-
	Capabilities: [5c] Power Management version 3
	Capabilities: [64] Express Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [138] Device Serial Number 50-0e-00-4a-00-00-00-01
	Capabilities: [144] Access Control Services
	Kernel driver in use: switchtec
	Kernel modules: switchtec


Logan
