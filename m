Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57535C433E0
	for <linux-acpi@archiver.kernel.org>; Mon,  8 Feb 2021 20:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05B3464E74
	for <linux-acpi@archiver.kernel.org>; Mon,  8 Feb 2021 20:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbhBHUsw (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 8 Feb 2021 15:48:52 -0500
Received: from smtprelay0124.hostedemail.com ([216.40.44.124]:59598 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233439AbhBHUqi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Feb 2021 15:46:38 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id C66FA18484D83;
        Mon,  8 Feb 2021 20:45:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rice92_5b00f7527601
X-Filterd-Recvd-Size: 1747
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Mon,  8 Feb 2021 20:45:32 +0000 (UTC)
Message-ID: <337f970b0643d2f67f9a388ff8bbddcf673a1c6b.camel@perches.com>
Subject: Re: [PATCH v1 2/2] ACPI: OSL: Clean up printing messages
From:   Joe Perches <joe@perches.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hanjun Gou <gouhanjun@huawei.com>
Date:   Mon, 08 Feb 2021 12:45:31 -0800
In-Reply-To: <3297462.0emgCRZMdL@kreacher>
References: <4653881.kBYL0eE9gL@kreacher> <3297462.0emgCRZMdL@kreacher>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2021-02-08 at 19:59 +0100, Rafael J. Wysocki wrote:
> Replace the ACPI_DEBUG_PRINT() instance in osl.c unrelated to the
> ACPICA debug with acpi_handle_debug(), add a pr_fmt() definition
> to osl.c and replace direct printk() usage in that file with the
> suitable pr_*() calls.
[]
> ===================================================================
> --- linux-pm.orig/drivers/acpi/osl.c
> +++ linux-pm/drivers/acpi/osl.c
[]
> @@ -528,13 +531,13 @@ acpi_os_predefined_override(const struct
>  
> 
>  	*new_val = NULL;
>  	if (!memcmp(init_val->name, "_OS_", 4) && strlen(acpi_os_name)) {
> -		printk(KERN_INFO PREFIX "Overriding _OS definition to '%s'\n",
> +		pr_info("Overriding _OS definition to '%s'\n",
>  		       acpi_os_name);

If you do more of these, perhaps rewrap lines to 80 columns when possible.

		pr_info("Overriding _OS definition to '%s'\n", acpi_os_name);

etc...


