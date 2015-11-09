From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: lock-up on boot with x86/PCI/ACPI: Use common interface to
 support PCI host bridge
Date: Mon, 9 Nov 2015 15:52:31 +0800
Message-ID: <564050BF.8060606@linux.intel.com>
References: <563DAE9A.5050904@internode.on.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060703010204090809000407"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:36536 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833AbbKIHwf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 9 Nov 2015 02:52:35 -0500
In-Reply-To: <563DAE9A.5050904@internode.on.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arthur Marsh <arthur.marsh@internode.on.net>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060703010204090809000407
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

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
	Could you please help to try the attached test patch?
Thanks,
Gerry

> 
> Arthur.
> 
> 

--------------060703010204090809000407
Content-Type: text/x-patch;
 name="0001-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-.patch"

>From 02818ba34bfa76d93f2a29c85660da0323b0b457 Mon Sep 17 00:00:00 2001
From: Liu Jiang <jiang.liu@linux.intel.com>
Date: Mon, 9 Nov 2015 13:36:48 +0800
Subject: [PATCH]


Signed-off-by: Liu Jiang <jiang.liu@linux.intel.com>
---
 arch/x86/pci/bus_numa.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/pci/bus_numa.c b/arch/x86/pci/bus_numa.c
index 7bcf06a7cd12..022d83158cdb 100644
--- a/arch/x86/pci/bus_numa.c
+++ b/arch/x86/pci/bus_numa.c
@@ -51,6 +51,8 @@ void x86_pci_root_bus_resources(int bus, struct list_head *resources)
 		pci_add_resource(resources, &info->busn);
 
 	list_for_each_entry(root_res, &info->resources, list) {
+		pci_add_resource(resources, &root_res->res);
+#if 0
 		struct resource *res;
 		struct resource *root;
 
@@ -61,6 +63,7 @@ void x86_pci_root_bus_resources(int bus, struct list_head *resources)
 		else
 			root = &iomem_resource;
 		insert_resource(root, res);
+#endif
 	}
 	return;
 
-- 
1.7.10.4


--------------060703010204090809000407--
