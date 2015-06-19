From: Fu Wei <fu.wei@linaro.org>
Subject: Re: [PATCH 1/2] ACPI, APEI, Boot Error Record Table (BERT) support
Date: Fri, 19 Jun 2015 16:48:55 +0800
Message-ID: <CADyBb7t8Xrq0beA6=qBdTP_oWmpVAzpgNF9QQd5fxqRoqV5aOQ@mail.gmail.com>
References: <1431010651-23117-2-git-send-email-gong.chen@linux.intel.com>
	<5581ACE3.1020007@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36460 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754739AbbFSIs4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jun 2015 04:48:56 -0400
Received: by oigb199 with SMTP id b199so33847296oig.3
        for <linux-acpi@vger.kernel.org>; Fri, 19 Jun 2015 01:48:55 -0700 (PDT)
In-Reply-To: <5581ACE3.1020007@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chen Gong <gong.chen@linux.intel.com>, "Zhang, Jonathan Zhixiong" <zjzhang@codeaurora.org>
Cc: Huang Ying <ying.huang@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org

Hi Chen Gong,

I have tested this patchset on ARMv8 Foundation model, it works fine.
there some very little comments inline below

Please add:

Tested-by: Fu Wei <fu.wei@linaro.org>

On 18 June 2015 at 01:22, Zhang, Jonathan Zhixiong
<zjzhang@codeaurora.org> wrote:
>
>
>
> -------- Forwarded Message --------
> Return-Path: <linux-acpi-owner@vger.kernel.org>
> Received: from smtp.codeaurora.org by pdx-caf-smtp.dmz.codeaurora.org
> (Dovecot) with LMTP id eYL9ICnS11RZFgAAdocmOQ ; Thu, 07 May 2015 02:03:39
> +0000
> Received: from smtp.codeaurora.org (localhost [127.0.0.1]) by
> smtp.codeaurora.org (Postfix) with ESMTP id 46BB2140754; Thu,  7 May 2015
> 02:03:39 +0000 (UTC)
> Received: by smtp.codeaurora.org (Postfix, from userid 486) id 3A6B1140A33;
> Thu,  7 May 2015 02:03:39 +0000 (UTC)
> X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
> pdx-caf-smtp.dmz.codeaurora.org
> X-Spam-Level:
> X-Spam-Status: No, score=-3.7 required=2.0
> tests=BAYES_00,DATE_IN_FUTURE_12_24, RCVD_IN_DNSWL_HI autolearn=ham
> version=3.3.1
> Received: from vger.kernel.org (vger.kernel.org [209.132.180.67]) by
> smtp.codeaurora.org (Postfix) with ESMTP id 7E2B2140754 for
> <zjzhang@codeaurora.org>; Thu,  7 May 2015 02:03:38 +0000 (UTC)
> Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
> S1751162AbbEGCDi (ORCPT <rfc822;zjzhang@codeaurora.org>); Wed, 6 May 2015
> 22:03:38 -0400
> Received: from mga03.intel.com ([134.134.136.65]:35907 "EHLO
> mga03.intel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
> S1751109AbbEGCDh (ORCPT <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 May
> 2015 22:03:37 -0400
> Received: from fmsmga001.fm.intel.com ([10.253.24.23])  by
> orsmga103.jf.intel.com with ESMTP; 06 May 2015 19:03:36 -0700
> X-ExtLoop1: 1
> X-IronPort-AV: E=Sophos;i="5.13,382,1427785200"; d="scan'208";a="706444110"
> Received: from gchen-sby.bj.intel.com (HELO localhost) ([10.238.158.211])
> by fmsmga001.fm.intel.com with ESMTP; 06 May 2015 19:03:34 -0700
> From: Chen, Gong <gong.chen@linux.intel.com>
> To: linux-acpi@vger.kernel.org
> Cc: Huang Ying <ying.huang@intel.com>, Tomasz Nowicki
> <tomasz.nowicki@linaro.org>, Chen, Gong <gong.chen@linux.intel.com>, Tony
> Luck <tony.luck@intel.com>
> Subject: [PATCH 1/2] ACPI, APEI, Boot Error Record Table (BERT) support
> Date: Thu,  7 May 2015 10:57:30 -0400
> Message-Id: <1431010651-23117-2-git-send-email-gong.chen@linux.intel.com>
> X-Mailer: git-send-email 2.3.2
> In-Reply-To: <1431010651-23117-1-git-send-email-gong.chen@linux.intel.com>
> References: <1431010651-23117-1-git-send-email-gong.chen@linux.intel.com>
> Sender: linux-acpi-owner@vger.kernel.org
> Precedence: bulk
> List-ID: <linux-acpi.vger.kernel.org>
> X-Mailing-List: linux-acpi@vger.kernel.org
> X-Virus-Scanned: ClamAV using ClamSMTP
>
> From: Huang Ying <ying.huang@intel.com>
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
> For more information about ERST, please refer to ACPI Specification
> version 5.0, section 18.3.1
>
> Signed-off-by: Huang Ying <ying.huang@intel.com>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
> Tested-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
> Cc: Tony Luck <tony.luck@intel.com>
> ---
>  Documentation/kernel-parameters.txt |   3 +
>  drivers/acpi/apei/Makefile          |   2 +-
>  drivers/acpi/apei/bert.c            | 160
> ++++++++++++++++++++++++++++++++++++
>  include/acpi/apei.h                 |   1 +
>  4 files changed, 165 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/acpi/apei/bert.c
>
> diff --git a/Documentation/kernel-parameters.txt
> b/Documentation/kernel-parameters.txt
> index 61ab1628a057..9766fb86cb7e 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -548,6 +548,9 @@ bytes respectively. Such letter suffixes can also be
> entirely omitted.
>
>         bootmem_debug   [KNL] Enable bootmem allocator debug messages.
>
> +       bert_disable    [ACPI]
> +                       Disable Boot Error Record Table (BEST) support.
> +
>         bttv.card=      [HW,V4L] bttv (bt848 + bt878 based grabber cards)
>         bttv.radio=     Most important insmod options are available as
>                         kernel args too.
> diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
> index 5d575a955940..e50573de25f1 100644
> --- a/drivers/acpi/apei/Makefile
> +++ b/drivers/acpi/apei/Makefile
> @@ -3,4 +3,4 @@ obj-$(CONFIG_ACPI_APEI_GHES)    += ghes.o
>  obj-$(CONFIG_ACPI_APEI_EINJ)   += einj.o
>  obj-$(CONFIG_ACPI_APEI_ERST_DEBUG) += erst-dbg.o
>
> -apei-y := apei-base.o hest.o erst.o
> +apei-y := apei-base.o hest.o erst.o bert.o
> diff --git a/drivers/acpi/apei/bert.c b/drivers/acpi/apei/bert.c
> new file mode 100644
> index 000000000000..c35a748a2be5
> --- /dev/null
> +++ b/drivers/acpi/apei/bert.c
> @@ -0,0 +1,160 @@
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
> + *
> + * For more information about ERST, please refer to ACPI Specification
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
> +
> +#define BERT_PFX "BERT: "
> +
> +int bert_disable;
> +EXPORT_SYMBOL_GPL(bert_disable);
> +
> +static void __init bert_print_all(struct acpi_hest_generic_status *region,
> +                                 unsigned int region_len)
> +{
> +       int remain, first = 1;
> +       u32 estatus_len;
> +       struct acpi_hest_generic_status *estatus;
> +
> +       remain = region_len;
> +       estatus = region;
> +       while (remain > sizeof(struct acpi_hest_generic_status)) {
> +               /* No more error record */
> +               if (!estatus->block_status)
> +                       break;
> +
> +               estatus_len = cper_estatus_len(estatus);
> +               if (estatus_len < sizeof(struct acpi_hest_generic_status) ||
> +                   remain < estatus_len) {
> +                       pr_err(FW_BUG BERT_PFX "Invalid error status block
> with length %u\n",

do a word-wrap after "BERT_PFX" ??

> +                              estatus_len);
> +                       return;
> +               }
> +
> +               if (cper_estatus_check(estatus)) {
> +                       pr_err(FW_BUG BERT_PFX "Invalid Error status
> block\n");

s/Error/error

or why this "e" have to be capitalized?


> +                       goto next;
> +               }
> +
> +               if (first) {
> +                       pr_info(HW_ERR "Error record from previous
> boot:\n");
> +                       first = 0;
> +               }
> +               cper_estatus_print(KERN_INFO HW_ERR, estatus);
> +next:
> +               estatus = (void *)estatus + estatus_len;
> +               remain -= estatus_len;
> +       }
> +}
> +
> +static int __init setup_bert_disable(char *str)
> +{
> +       bert_disable = 1;

I think there should be a blank line

> +       return 0;
> +}
> +__setup("bert_disable", setup_bert_disable);
> +
> +static int __init bert_check_table(struct acpi_table_bert *bert_tab)
> +{
> +       if (bert_tab->header.length < sizeof(struct acpi_table_bert))
> +               return -EINVAL;
> +       if (bert_tab->region_length != 0 &&

I think "bert_tab->region_length" should be enough.

> +           bert_tab->region_length < sizeof(struct acpi_bert_region))
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +static int __init bert_init(void)
> +{
> +       acpi_status status;
> +       struct acpi_table_bert *bert_tab;
> +       struct resource *r;
> +       struct acpi_hest_generic_status *bert_region;
> +       unsigned int region_len;
> +       int rc = -EINVAL;
> +
> +       if (acpi_disabled)
> +               goto out;
> +
> +       if (bert_disable) {
> +               pr_info(BERT_PFX "Boot Error Record Table (BERT) support is
> disabled.\n");
> +               goto out;
> +       }
> +
> +       status = acpi_get_table(ACPI_SIG_BERT, 0,
> +                               (struct acpi_table_header **)&bert_tab);
> +       if (status == AE_NOT_FOUND) {
> +               pr_err(BERT_PFX "Table is not found!\n");
> +               goto out;
> +       } else if (ACPI_FAILURE(status)) {
> +               const char *msg = acpi_format_exception(status);
> +
> +               pr_err(BERT_PFX "Failed to get table, %s\n", msg);
> +               goto out;
> +       }
> +
> +       rc = bert_check_table(bert_tab);
> +       if (rc) {
> +               pr_err(FW_BUG BERT_PFX "BERT table is invalid\n");
> +               goto out;
> +       }
> +
> +       region_len = bert_tab->region_length;
> +       if (!region_len) {
> +               rc = 0;
> +               goto out;
> +       }
> +
> +       r = request_mem_region(bert_tab->address, region_len, "APEI BERT");
> +       if (!r) {
> +               pr_err(BERT_PFX "Can not request iomem region
> <%016llx-%016llx> for BERT.\n",

"Can't request iomem region <%016llx-%016llx>.\n",
maybe shorter?

we already have "BERT_PFX", don't need "for BERT"

> +                      (unsigned long long)bert_tab->address,
> +                      (unsigned long long)bert_tab->address + region_len);

I thinks this should be
(unsigned long long)bert_tab->address + region_len - 1

right?

> +               rc = -EIO;
> +               goto out;
> +       }
> +
> +       bert_region = ioremap_cache(bert_tab->address, region_len);
> +       if (!bert_region) {
> +               rc = -ENOMEM;
> +               goto out_release;
> +       }
> +
> +       bert_print_all(bert_region, region_len);
> +
> +       iounmap(bert_region);
> +
> +out_release:
> +       release_mem_region(bert_tab->address, region_len);
> +out:
> +       if (rc)
> +               bert_disable = 1;
> +
> +       return rc;
> +}
> +late_initcall(bert_init);
> diff --git a/include/acpi/apei.h b/include/acpi/apei.h
> index 76284bb560a6..284801ac7042 100644
> --- a/include/acpi/apei.h
> +++ b/include/acpi/apei.h
> @@ -23,6 +23,7 @@ extern bool ghes_disable;
>  #else
>  #define ghes_disable 1
>  #endif
> +extern int bert_disable;
>
>  #ifdef CONFIG_ACPI_APEI
>  void __init acpi_hest_init(void);
> --
> 2.3.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
