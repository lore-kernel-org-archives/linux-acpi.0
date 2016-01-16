From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4] acpi, apei: add Boot Error Record Table (BERT) support
Date: Sat, 16 Jan 2016 20:16:04 +0100
Message-ID: <20160116191604.GE31869@pd.tnic>
References: <1452260742-13625-1-git-send-email-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:35921 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752469AbcAPTQ0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 16 Jan 2016 14:16:26 -0500
Content-Disposition: inline
In-Reply-To: <1452260742-13625-1-git-send-email-fu.wei@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: fu.wei@linaro.org
Cc: tony.luck@intel.com, gong.chen@intel.com, ying.huang@intel.com, tomasz.nowicki@linaro.org, tn@semihalf.com, tbaicar@codeaurora.org, rruigrok@codeaurora.org, harba@qti.qualcomm.com, graeme.gregory@linaro.org, al.stone@linaro.org, hanjun.guo@linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, jcm@redhat.com, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net, "Chen, Gong" <gong.chen@linux.intel.com>

On Fri, Jan 08, 2016 at 09:45:42PM +0800, fu.wei@linaro.org wrote:
> From: Huang Ying <ying.huang@intel.com>
> 
> ACPI/APEI is designed to verifiy/report H/W errors, like Corrected
> Error(CE) and Uncorrected Error(UC). It contains four tables: HEST,
> ERST, EINJ and BERT. The first three tables have been merged for
> a long time, but because of lacking BIOS support for BERT, the
> support for BERT is pending until now. Recently on ARM 64 platform
> it is has been supported. So here we come.
> 
> Under normal circumstances, when a hardware error occurs, kernel will
> be notified via NMI, MCE or some other method, then kernel will
> process the error condition, report it, and recover it if possible.
> But sometime, the situation is so bad, so that firmware may choose to
> reset directly without notifying Linux kernel.
> 
> Linux kernel can use the Boot Error Record Table (BERT) to get the
> un-notified hardware errors that occurred in a previous boot. In this
> patch, the error information is reported via printk.
> 
> For more information about BERT, please refer to ACPI Specification
> version 6.0, section 18.3.1:
>   http://www.uefi.org/sites/default/files/resources/ACPI_6.0.pdf
> 
> The following log is a BERT record after system reboot because of hitting
> a fatal memory error:
> BERT: Error records from previous boot:
> [Hardware Error]: It has been corrected by h/w and requires no further action
> [Hardware Error]: event severity: corrected
> [Hardware Error]:  Error 0, type: recoverable
> [Hardware Error]:   section_type: memory error
> [Hardware Error]:   error_status: 0x0000000000000400
> [Hardware Error]:   physical_address: 0xffffffffffffffff
> [Hardware Error]:   card: 1 module: 2 bank: 3 row: 1 column: 2 bit_position: 5 
> [Hardware Error]:   error_type: 2, single-bit ECC
> 
> [Tomasz Nowicki: Clear error status at the end of error handling]
> [Tony: Applied some cleanups suggested by Fu Wei]
> [Fu Wei: delete EXPORT_SYMBOL_GPL(bert_disable), improve the code]
> 
> Signed-off-by: Huang Ying <ying.huang@intel.com>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
> Tested-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
> ---
> Changelog:
> v4: fix the "#undef" bug
>     Improve the instruction of "bert_disable",
>     delete the useless declaration in include/acpi/apei.h.
> 
> v3: https://lkml.org/lkml/2016/1/7/214
>     Merge the two patches
>     Do some improvements according to Borislav's suggestion.
> 
> v2: https://lkml.org/lkml/2015/8/18/336
>     Delete EXPORT_SYMBOL_GPL(bert_disable), because "bert_disable" is only
>     used in bert.c for now.
>     Do some code-style cleanups.
> 
> v1: The first upstream version submitted in linux-acpi mailing list:
>     http://www.spinics.net/lists/linux-acpi/msg57384.html
> 
>  Documentation/kernel-parameters.txt |   6 ++
>  drivers/acpi/apei/Makefile          |   2 +-
>  drivers/acpi/apei/bert.c            | 158 ++++++++++++++++++++++++++++++++++++
>  include/acpi/apei.h                 |   1 +
>
>  4 files changed, 166 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/acpi/apei/bert.c
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 742f69d..2c527a9 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -555,6 +555,12 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  
>  	bootmem_debug	[KNL] Enable bootmem allocator debug messages.
>  
> +	bert_disable	[ACPI]
> +			Disable Boot Error Record Table (BERT) support.
> +			Use this if to workaround buggy firmware which produces
> +			the malformed BERT table or incorrect error status
> +			block.

Simply:
			"Disable BERT OS support on buggy BIOSes"

> +
>  	bttv.card=	[HW,V4L] bttv (bt848 + bt878 based grabber cards)
>  	bttv.radio=	Most important insmod options are available as
>  			kernel args too.
> diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
> index 5d575a9..e50573d 100644
> --- a/drivers/acpi/apei/Makefile
> +++ b/drivers/acpi/apei/Makefile
> @@ -3,4 +3,4 @@ obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o
>  obj-$(CONFIG_ACPI_APEI_EINJ)	+= einj.o
>  obj-$(CONFIG_ACPI_APEI_ERST_DEBUG) += erst-dbg.o
>  
> -apei-y := apei-base.o hest.o erst.o
> +apei-y := apei-base.o hest.o erst.o bert.o
> diff --git a/drivers/acpi/apei/bert.c b/drivers/acpi/apei/bert.c
> new file mode 100644
> index 0000000..ffcbf4b
> --- /dev/null
> +++ b/drivers/acpi/apei/bert.c
> @@ -0,0 +1,158 @@
> +/*
> + * APEI Boot Error Record Table (BERT) support
> + *
> + * Copyright 2011 Intel Corp.
> + *   Author: Huang Ying <ying.huang@intel.com>
> + *
> + * Under normal circumstances, when a hardware error occurs, kernel
> + * will be notified via NMI, MCE or some other method, then kernel
> + * will process the error condition, report it, and recover it if
> + * possible. But sometime, the situation is so bad, so that firmware
> + * may choose to reset directly without notifying Linux kernel.
> + *
> + * Linux kernel can use the Boot Error Record Table (BERT) to get the
> + * un-notified hardware errors that occurred in a previous boot.

Rewrite this:

"Under normal circumstances, when a hardware error occurs, the kernel
gets notified via an NMI, MCE or some other method. When the error
severity is critical such that the kernel cannot allow itself to do any
error recovery due to risk of data corruption, the machine resets. Some
implementations trigger the reset directly in hardware and do not even
return to the OS.

The Boot Error Record Table is a means of reporting such critical errors
after the machine reset, i.e. upon the next boot."

> + *
> + * For more information about BERT, please refer to ACPI Specification
> + * version 4.0, section 17.3.1
> + *
> + * This file is licensed under GPLv2.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/acpi.h>
> +#include <linux/io.h>
> +
> +#include "apei-internal.h"

Btw, while you're at it, this header has:

/*
 * apei-internal.h - ACPI Platform Error Interface internal
 * definations.
 */

please fix "definations" to "definitions" in your next submission.

> +
> +#undef pr_fmt
> +#define pr_fmt(fmt) "BERT: " fmt
> +
> +static int bert_disable;
> +
> +static void __init bert_print_all(struct acpi_bert_region *region,
> +				  unsigned int region_len)
> +{
> +	/*
> +	 * We use cper_estatus_* which uses struct acpi_hest_generic_status,
> +	 * struct acpi_hest_generic_status and acpi_bert_region are the same
> +	 * (Generic Error Status Block), so we declare the "estatus" here.
> +	 */

No need for that comment.

> +	struct acpi_hest_generic_status *estatus =
> +		(struct acpi_hest_generic_status *)region;
> +	int remain = region_len;
> +	u32 estatus_len;
> +
> +	/* The records have been polled*/

No need for that comment.

> +	if (!estatus->block_status)
> +		return;
> +
> +	while (remain > sizeof(struct acpi_bert_region)) {
> +		/*
> +		 * Test Generic Error Status Block first,
> +		 * if the data(Offset, Length) is invalid, we just return,
> +		 * because we can't trust the length data from this block.
> +		 */

What's with the superfluous comments? Please drop them.

> +		if (cper_estatus_check(estatus)) {
> +			pr_err(FW_BUG "Invalid error record\n");
							   ^
							   |
							   . <--- don't forget
								   the fullstop.

> +			return;
> +		}
> +
> +		estatus_len = cper_estatus_len(estatus);
> +		if (remain < estatus_len) {
> +			pr_err(FW_BUG "Invalid status block length (%u)\n",

Right, I think we should call this error message:

					"Truncated status block (length: %u).\n"

> +			       estatus_len);
> +			return;
> +		}
> +
> +		pr_info_once("Error records from previous boot:\n");
> +
> +		cper_estatus_print(KERN_INFO HW_ERR, estatus);
> +
> +		/*
> +		 * Because the boot error source is "one-time polled" type,
> +		 * clear Block Status of current Generic Error Status Block,
> +		 * once it's printed.
> +		 */

Now that's a useful comment. Good. :)

> +		estatus->block_status = 0;
> +
> +		estatus = (void *)estatus + estatus_len;
> +		if (!estatus->block_status)
> +			return;	/* No more error records */

No trailing comments please, put it over the if-line.

> +
> +		remain -= estatus_len;
> +	}
> +}
> +
> +static int __init setup_bert_disable(char *str)
> +{
> +	bert_disable = 1;
> +
> +	return 0;
> +}
> +__setup("bert_disable", setup_bert_disable);
> +
> +static int __init bert_check_table(struct acpi_table_bert *bert_tab)
> +{
> +	if (bert_tab->header.length < sizeof(struct acpi_table_bert) ||
> +	    bert_tab->region_length < sizeof(struct acpi_bert_region))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int __init bert_init(void)
> +{
> +	struct acpi_bert_region *boot_error_region;
> +	struct acpi_table_bert *bert_tab;
> +	unsigned int region_len;
> +	acpi_status status;
> +	int rc = 0;
> +
> +	if (acpi_disabled)
> +		return 0;
> +
> +	if (bert_disable) {
> +		pr_info("Boot Error Record Table support is disabled\n");
								    ^
								    |
								    . Fullstop

Also, check whether your other printk-statements end with a fullstop,
like proper sentences do.

> +		return 0;
> +	}
> +
> +	status = acpi_get_table(ACPI_SIG_BERT, 0, (struct acpi_table_header **)&bert_tab);
> +	if (status == AE_NOT_FOUND)
> +		return 0;

\n here

> +	if (ACPI_FAILURE(status)) {
> +		pr_err("get table failed, %s\n", acpi_format_exception(status));
> +		return -EINVAL;
> +	}
> +
> +	rc = bert_check_table(bert_tab);
> +	if (rc) {
> +		pr_err(FW_BUG "table invalid\n");

This comes out as:

	[    3.199512] BERT: [Firmware Bug]: table invalid

That's ugly.

	BERT: table invalid.

looks better to me.

TBH, I'm not sure we want to use that FW_BUG marker in this file at all.
I mean, AFAIR, it was added at the time with the hope that people report
those errors to BIOS vendors and they fix their crap. But I'm not sure
fixing the BERT table would be of any priority for them.

> +		return rc;
> +	}
> +
> +	region_len = bert_tab->region_length;
> +	if (!request_mem_region(bert_tab->address, region_len, "APEI BERT")) {
> +		pr_err("Can't request iomem region <%016llx-%016llx>\n",
> +		       (unsigned long long)bert_tab->address,
> +		       (unsigned long long)bert_tab->address + region_len - 1);
> +		return -EIO;
> +	}
> +
> +	boot_error_region = ioremap_cache(bert_tab->address, region_len);
> +	if (boot_error_region) {
> +		bert_print_all(boot_error_region, region_len);
> +		iounmap(boot_error_region);
> +	} else {
> +		rc = -ENOMEM;
> +	}
> +
> +	release_mem_region(bert_tab->address, region_len);
> +
> +	return rc;
> +}
> +
> +late_initcall(bert_init);
> -- 
> 2.5.0
> 
> 

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
