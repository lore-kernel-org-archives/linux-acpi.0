From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 69/70] ACPI : Create "idle=nomwait" bootparam
Date: Fri, 20 Jun 2008 08:02:09 -0700
Message-ID: <20080620080209.56ccd618.randy.dunlap@oracle.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
	<5ffc8862cc917ae5107049f3c5fd549fb6c19cac.1213947350.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:28407 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756167AbYFTPLt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 11:11:49 -0400
In-Reply-To: <5ffc8862cc917ae5107049f3c5fd549fb6c19cac.1213947350.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>, Li Shaohua <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>

On Fri, 20 Jun 2008 03:44:11 -0400 Len Brown wrote:

> From: Zhao Yakui <yakui.zhao@intel.com>
> 
> Add the boot option of "idle=nomwait" to disable Mwait for CPU C-states.
> If the boot option of "idle=nomwait" is added , Linux should not
> use mwait for cpu idle even when the mwait is supported. In such case the
> C2C3_FFH access mode will be disabled.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=10807
> 
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> Signed-off-by: Li Shaohua <shaohua.li@intel.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  Documentation/kernel-parameters.txt |    4 +++-
>  arch/ia64/kernel/process.c          |    2 ++
>  arch/x86/kernel/process.c           |   14 ++++++++++++++
>  drivers/acpi/processor_core.c       |   12 ++++++++++++
>  include/asm-ia64/processor.h        |    1 +
>  include/asm-x86/processor.h         |    1 +
>  6 files changed, 33 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 1623c2f..39baaba 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -785,7 +785,7 @@ and is between 256 and 4096 characters. It is defined in the file
>  			See Documentation/ide/ide.txt.
>  
>  	idle=		[X86]
> -			Format: idle=poll or idle=mwait, idle = halt
> +			Format: idle=poll or idle=mwait, idle = halt, idle=nomwait

			                                 idle=halt  [no spaces]

>  			Poll forces a polling idle loop that can slightly improves the performance
>  			of waking up a idle CPU, but will use a lot of power and make the system
>  			run hot. Not recommended.
> @@ -795,6 +795,8 @@ and is between 256 and 4096 characters. It is defined in the file
>  			as idle=poll.
>  			idle = halt . Halt is forced to be used for CPU idle.

			idle=halt .
(no spaces allowed in command line parsing AFAIK)

>  			In such case C2/C3 won't be used again.
> +			idle = nomwait. disable Mwait for CPU C-state.
> +			In such case C2C3_FFH access mode will be disabled.
>  
>  	ide-pci-generic.all-generic-ide [HW] (E)IDE subsystem
>  			Claim all unknown PCI IDE storage controllers.


---
~Randy
Linux Plumbers Conference, 17-19 September 2008, Portland, Oregon USA
http://linuxplumbersconf.org/
