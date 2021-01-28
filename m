Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4232C43332
	for <linux-acpi@archiver.kernel.org>; Thu, 28 Jan 2021 23:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAB2664E00
	for <linux-acpi@archiver.kernel.org>; Thu, 28 Jan 2021 23:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhA1X5V (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 28 Jan 2021 18:57:21 -0500
Received: from smtprelay0108.hostedemail.com ([216.40.44.108]:53636 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229530AbhA1X5V (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 28 Jan 2021 18:57:21 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id E910418014495;
        Thu, 28 Jan 2021 23:56:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: glass70_2c03527275a3
X-Filterd-Recvd-Size: 2803
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Thu, 28 Jan 2021 23:56:38 +0000 (UTC)
Message-ID: <955a079a3d15228ce9aeba8720dccae2dc7dfb7c.camel@perches.com>
Subject: Re: [PATCH -next] acpi: fpdt: drop errant comma in pr_info()
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>
Date:   Thu, 28 Jan 2021 15:56:37 -0800
In-Reply-To: <20210128232528.21117-1-rdunlap@infradead.org>
References: <20210128232528.21117-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 2021-01-28 at 15:25 -0800, Randy Dunlap wrote:
> Drop a mistaken comma in the pr_info() args to prevent the
> build warning.
> 
> ../drivers/acpi/acpi_fpdt.c: In function 'acpi_init_fpdt':
> ../include/linux/kern_levels.h:5:18: warning: too many arguments for format [-Wformat-extra-args]
> ../drivers/acpi/acpi_fpdt.c:255:4: note: in expansion of macro 'pr_info'
>     pr_info(FW_BUG, "Invalid subtable type %d found.\n",
[]
> --- linux-next-20210128.orig/drivers/acpi/acpi_fpdt.c
> +++ linux-next-20210128/drivers/acpi/acpi_fpdt.c
> @@ -252,7 +252,7 @@ void acpi_init_fpdt(void)
>  					      subtable->type);
>  			break;
>  		default:
> -			pr_info(FW_BUG, "Invalid subtable type %d found.\n",
> +			pr_info(FW_BUG "Invalid subtable type %d found.\n",
>  			       subtable->type);

Another question would be why is the pr_info when all the other
FW_BUG uses in this file are pr_err

One would think it's at least a defect of some time.
I would think it should at least be pr_notice or pr_warn

Documentation/admin-guide/kernel-parameters.txt-                        1 (KERN_ALERT)          action must be taken immediately
Documentation/admin-guide/kernel-parameters.txt-                        2 (KERN_CRIT)           critical conditions
Documentation/admin-guide/kernel-parameters.txt-                        3 (KERN_ERR)            error conditions
Documentation/admin-guide/kernel-parameters.txt-                        4 (KERN_WARNING)        warning conditions
Documentation/admin-guide/kernel-parameters.txt-                        5 (KERN_NOTICE)         normal but significant condition
Documentation/admin-guide/kernel-parameters.txt:                        6 (KERN_INFO)           informational
Documentation/admin-guide/kernel-parameters.txt-                        7 (KERN_DEBUG)          debug-level messages


