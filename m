From: Will Deacon <will.deacon@arm.com>
Subject: Re: [Patch v2 18/22] PCI: Use common resource list management code
 instead of private implementation
Date: Wed, 28 Jan 2015 13:46:39 +0000
Message-ID: <20150128134639.GN1569@arm.com>
References: <1422442660-455-1-git-send-email-jiang.liu@linux.intel.com>
 <1422442660-455-19-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1422442660-455-19-git-send-email-jiang.liu@linux.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Lv Zheng <lv.zheng@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Yijing Wang <wangyijing@huawei.com>, Russell King <linux@arm.linux.org.uk>, "x86@kernel.org" <x86@kernel.org>, Michal Simek <michal.simek@xilinx.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Murali Karicheri <m-karicheri2@ti.com>, =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Srikanth Thokala <sthokal@xilinx.com>, Borislav Petkov <bp@alien8.de>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>, Ingo Molnar <mingo@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>"linux-kernel@vger.kernel.org" <linux->
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 28, 2015 at 10:57:36AM +0000, Jiang Liu wrote:
> Use common resource list management data structure and interfaces
> instead of private implementation.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  arch/arm/kernel/bios32.c            |    5 ++---
>  arch/x86/pci/bus_numa.c             |    4 ++--
>  drivers/pci/bus.c                   |   18 ++++++------------
>  drivers/pci/host-bridge.c           |    8 ++++----
>  drivers/pci/host/pci-host-generic.c |    4 ++--
>  drivers/pci/host/pci-xgene.c        |    4 ++--
>  drivers/pci/host/pcie-xilinx.c      |    4 ++--
>  drivers/pci/probe.c                 |   10 +++++-----
>  include/linux/pci.h                 |    9 ++-------
>  9 files changed, 27 insertions(+), 39 deletions(-)

The arch/arm/ and drivers/pci/host/pci-host-generic.c bits look fine to
me:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
