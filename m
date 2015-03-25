From: Will Deacon <will.deacon@arm.com>
Subject: Request for additional arm64 branch in linux-next
Date: Wed, 25 Mar 2015 17:20:03 +0000
Message-ID: <20150325172002.GN24636@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51274 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753004AbbCYRUH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Mar 2015 13:20:07 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: sfr@canb.auug.org.au
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, grant.likely@linaro.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, hanjun.guo@linaro.org, al.stone@linaro.org, graeme.gregory@linaro.org, msalter@redhat.com

Hi Stephen,

We've got a series of patches introducing ACPI support for arm64 that
are tentatively targetting the 4.1 merge window. Whilst there are
face-to-face discussions set to happen in the next day or so around this
topic, could you please pull this into linux-next under the assumption
that we decide to go ahead for mainline inclusion?

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/acpi

I've kept the series separate from the usual arm64 branch (for-next/core)
but they merge without conflicts. Merging with today's next, I see two
trivial Kconfig conflicts (resolution below).

I'll let you know when the branch is no longer needed.

Thanks,

Will

--->8

diff --cc arch/arm64/Kconfig
index 4085df18e558,0659db374731..0eae06cdac27
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@@ -1,7 -1,9 +1,9 @@@
  config ARM64
  	def_bool y
+ 	select ACPI_GENERIC_GSI if ACPI
+ 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 -	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
  	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 +	select ARCH_HAS_ELF_RANDOMIZE
  	select ARCH_HAS_GCOV_PROFILE_ALL
  	select ARCH_HAS_SG_CHAIN
  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
diff --cc drivers/xen/Kconfig
index afc39ca5cc4f,a31cd29b68a8..31347cd8c046
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@@ -253,10 -253,8 +253,14 @@@ config XEN_EF
  	def_bool y
  	depends on X86_64 && EFI
  
 +config XEN_AUTO_XLATE
 +	def_bool y
 +	depends on ARM || ARM64 || XEN_PVHVM
 +	help
 +	  Support for auto-translated physmap guests.
 +
+ config XEN_ACPI
+ 	def_bool y
+ 	depends on X86 && ACPI
+ 
  endmenu
