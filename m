Return-Path: <SRS0=MWqo=6X=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3B3C28CBC
	for <linux-acpi@archiver.kernel.org>; Sat,  9 May 2020 09:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D7AC2495C
	for <linux-acpi@archiver.kernel.org>; Sat,  9 May 2020 09:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgEIJL3 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Sat, 9 May 2020 05:11:29 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44164 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgEIJL3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 9 May 2020 05:11:29 -0400
Received: from 89-77-60-66.dynamic.chello.pl (89.77.60.66) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 4748a8dc287c25fc; Sat, 9 May 2020 11:11:27 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 7/9] ACPI: EC: Put the ACPI table after using it
Date:   Sat, 09 May 2020 11:11:26 +0200
Message-ID: <5004179.babTvPOIzi@kreacher>
In-Reply-To: <1588842561-32907-8-git-send-email-guohanjun@huawei.com>
References: <1588842561-32907-1-git-send-email-guohanjun@huawei.com> <1588842561-32907-8-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thursday, May 7, 2020 11:09:19 AM CEST Hanjun Guo wrote:
> The embedded controller boot resources table needs to be
> released after using it.
> 
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
>  drivers/acpi/ec.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index b4c0152e..281a9bf 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -1784,12 +1784,15 @@ static void __init acpi_ec_ecdt_start(void)
>  
>  	status = acpi_get_handle(NULL, ecdt_ptr->id, &handle);
>  	if (ACPI_FAILURE(status))
> -		return;
> +		goto out;
>  

So to avoid adding a new label I would prefer

if (ACPI_SUCCESS(status)) {
	boot_ec->handle = handle;

	/* Add a special ACPI device object to represent the boot EC. */
	acpi_bus_register_early_device(ACPI_BUS_TYPE_ECDT_EC);
}

>  	boot_ec->handle = handle;
>  
>  	/* Add a special ACPI device object to represent the boot EC. */
>  	acpi_bus_register_early_device(ACPI_BUS_TYPE_ECDT_EC);
> +
> +out:
> +	acpi_put_table((struct acpi_table_header *)ecdt_ptr);
>  }
>  



