From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 1/2] ACPI / EC: Fix broken big-endian 64bit platforms using 'global_lock'
Date: Wed, 23 Sep 2015 11:39:14 +0200
Message-ID: <3821285.7cLYDZsCsX@wuerfel>
References: <9b705747a138c96c26faee5218f7b47403195b28.1442305897.git.viresh.kumar@linaro.org> <56026DBE.3090603@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <56026DBE.3090603@arm.com>
Sender: stable-owner@vger.kernel.org
To: linaro-kernel@lists.linaro.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Rafael Wysocki <rjw@rjwysocki.net>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, open list <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 23 September 2015 10:15:42 Sudeep Holla wrote:
> On 15/09/15 09:34, Viresh Kumar wrote:
> > global_lock is defined as an unsigned long and accessing only its lower
> > 32 bits from sysfs is incorrect, as we need to consider other 32 bits
> > for big endian 64 bit systems.
> >
> > Fix that by making global_lock an u32 instead.
> >
> > Cc: <stable@vger.kernel.org>  # v4.1+
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
> > ---
> > Its marked just for # v4.1+, because arm64 has the first 64 big-endian
> > platform with ACPI. And ACPI support for that is mainlined recently
> > only (Arnd Bergmann).
> >
> 
> Just to clarify, we don't support big-endian with ACPI on ARM64.
> We mandate use of EFI for ACPI on ARM64 and EFI spec mandates only
> little endian.
> 

EFI doesn't care what endianess the kernel has, as long as the
data structures are interpreted in the same way that the firmware
defines them, and I thought that at least UEFI on ARM64 with big-endian
is working in principle (if not, that is a bug that should be fixed).

If ACPI is broken with big-endian kernels, we should probably add a
Kconfig statement to forbid it, like this:

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 5d1015c26ff4..06cacc13e3d2 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -6,6 +6,7 @@ menuconfig ACPI
 	bool "ACPI (Advanced Configuration and Power Interface) Support"
 	depends on !IA64_HP_SIM
 	depends on IA64 || X86 || (ARM64 && EXPERT)
+	depends on !ARM64 || !CPU_BIG_ENDIAN || BROKEN
 	depends on PCI
 	select PNP
 	default y


	Arnd
