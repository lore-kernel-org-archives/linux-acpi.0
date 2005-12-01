From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 5/9] ACPI should depend on, not select PCI
Date: Wed, 30 Nov 2005 20:58:22 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B300549CF57@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751367AbVLADIg@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@osdl.org, bunk@stusta.de
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

No, I can't apply this -- it allows
Kconfig to create IA64 configs without PCI,
which do not build.

there must be a better way.

-Len 

>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Friday, October 28, 2005 6:00 PM
>To: Brown, Len
>Cc: acpi-devel@lists.sourceforge.net; akpm@osdl.org; bunk@stusta.de
>Subject: [patch 5/9] ACPI should depend on, not select PCI
>
>
>From: Adrian Bunk <bunk@stusta.de>
>
>ACPI should depend on, not select PCI.
>
>The practical differences should be nearly zero except that it avoids 
>the illegal configuration PCI=y, X86_VOYAGER=y.
>
>Signed-off-by: Adrian Bunk <bunk@stusta.de>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> drivers/acpi/Kconfig |    2 +-
> 1 files changed, 1 insertion(+), 1 deletion(-)
>
>diff -puN 
>drivers/acpi/Kconfig~acpi-should-depend-on-not-select-pci 
>drivers/acpi/Kconfig
>--- 
>25/drivers/acpi/Kconfig~acpi-should-depend-on-not-select-pci	
>Fri Oct 28 14:59:08 2005
>+++ 25-akpm/drivers/acpi/Kconfig	Fri Oct 28 14:59:21 2005
>@@ -10,8 +10,8 @@ menu "ACPI (Advanced Configuration and P
> config ACPI
> 	bool "ACPI Support"
> 	depends on IA64 || X86
>+	depends on PCI
> 	select PM
>-	select PCI
> 
> 	default y
> 	---help---
>_
>
