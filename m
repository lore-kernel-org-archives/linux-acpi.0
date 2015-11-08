From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: lock-up on boot with x86/PCI/ACPI: Use common interface to
 support PCI host bridge
Date: Sun, 8 Nov 2015 21:03:27 +0800
Message-ID: <563F481F.4080507@linux.intel.com>
References: <563DAE9A.5050904@internode.on.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <563DAE9A.5050904@internode.on.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Arthur Marsh <arthur.marsh@internode.on.net>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 2015/11/7 15:56, Arthur Marsh wrote:
> Hi, I've run into a situation where I've been getting a lock-up a few
> seconds into the boot process on a machine with an ASUS A8V-MX
> motherboard, BIOS 0503    12/06/2005 with AMD Athlon(tm) 64 Processor
> 3200+ (single core) with kernel compiled in 32 bit mode (config attached
> was used for both the problem kernel and kernel with the patch reverted,
> dmesg attached was for the kernel with the patch reverted).
> 
> A git bisect traced the problem back to:
> 
> git bisect good
> 4d6b4e69a245e9df4b84dba387596086cb66887d is the first bad commit
> commit 4d6b4e69a245e9df4b84dba387596086cb66887d
> Author: Jiang Liu <jiang.liu@linux.intel.com>
> Date:   Wed Oct 14 14:29:41 2015 +0800
> 
>      x86/PCI/ACPI: Use common interface to support PCI host bridge
> 
>      Use common interface to simplify ACPI PCI host bridge implementation.
> 
>      Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>      Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
>      Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>      Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> :040000 040000 a3447eea376b5a3e6f57deb35cf064c5481b45e3
> f64d8e49fd87b776933dfa3dfefcb33509004d3f M      arch
> 
> From the boot-up I get the message as shown in the images at:
> http://www.users.on.net/~arthur.marsh/20151107601.jpg and
> http://www.users.on.net/~arthur.marsh/20151107602.jpg
> 
> The boot-up suggests trying rebooting with pci=alloc but that didn't help.
> 
> The errors shown include
> "BAR 0: trying firmware assignment [io  size 0x0020]"
> "BAR 0: [io  size 0x0020] conflicts with PCI Bus #00 [io  0x0000-0xffff]
> "BAR 0: failed to assign [io  size 0x0020]
> 
> After reverting the patch and installing the resulting kernel I was able
> to boot normally.
> 
> I'd be happy to provide any further information and run further tests to
> help identify and resolve the proble.
Hi Arthur,
	Sorry for the regression. Could you please also help to
provide the ACPI tables from the affected system? You may get
ACPI tables by installing acpidump and then 'acpidump > acpitables.bin'.
Thanks,
Gerry


> 
> Arthur.
> 
> 
