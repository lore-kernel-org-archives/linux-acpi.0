Return-Path: <SRS0=BwYj=DG=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9377FC4727F
	for <linux-acpi@archiver.kernel.org>; Tue, 29 Sep 2020 20:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E7762076B
	for <linux-acpi@archiver.kernel.org>; Tue, 29 Sep 2020 20:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oJ/mbaWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbgI2UNc (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 29 Sep 2020 16:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgI2UNb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Sep 2020 16:13:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D164C061755;
        Tue, 29 Sep 2020 13:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=VetbJwcz0VNdIFVz9bDquQz2/ocvbi7sDHTKjwhn2Ok=; b=oJ/mbaWPjH3HiEvlKlB/S35Yal
        3qKIXH3Uqtw5+zbECOw1RNNvCJAxrKJ5INRdfyu49e5VWecxkPOmJd7dnEC6448hL4AlEJ3Tc84bd
        euL/xd2mT34xFU9BifEcP4oFHsD5PONKvTdjQiW3LF+85qrQM1Qfos3bPzJ8UkJLjp5fgaVuNisQ9
        OVPFFnhiRLyuPqcyirdsK8LbgHq3Hs5Q+J/qyAEfiFLLwDdJHeIvHXQyzt2F0IKse1HmMhcroA9VY
        xfbGagYuwYhwenlxBRL+xq4IEzodRLsYZFbd324lv+6iOrf0VZMoOU/dbeFtITJ6WRQUWhnZz+G9e
        7mCJ6CMA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNM08-0000jV-JT; Tue, 29 Sep 2020 20:13:29 +0000
Subject: Re: [PATCH] ACPI / NUMA: Add stub function for pxm_to_node
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org
References: <20200928194554.3423466-1-natechancellor@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c313dcd3-7fab-00eb-15f2-65a3a51f7bd5@infradead.org>
Date:   Tue, 29 Sep 2020 13:13:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200928194554.3423466-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 9/28/20 12:45 PM, Nathan Chancellor wrote:
> After commit 01feba590cd6 ("ACPI: Do not create new NUMA domains from
> ACPI static tables that are not SRAT"):
> 
> $ scripts/config --file arch/x86/configs/x86_64_defconfig -d NUMA -e ACPI_NFIT
> 
> $ make -skj"$(nproc)" distclean defconfig drivers/acpi/nfit/
> drivers/acpi/nfit/core.c: In function ‘acpi_nfit_register_region’:
> drivers/acpi/nfit/core.c:3010:27: error: implicit declaration of
> function ‘pxm_to_node’; did you mean ‘xa_to_node’?
> [-Werror=implicit-function-declaration]
>  3010 |   ndr_desc->target_node = pxm_to_node(spa->proximity_domain);
>       |                           ^~~~~~~~~~~
>       |                           xa_to_node
> cc1: some warnings being treated as errors
> ...
> 
> Add a stub function like acpi_map_pxm_to_node had so that the build
> continues to work.
> 
> Fixes: 01feba590cd6 ("ACPI: Do not create new NUMA domains from ACPI static tables that are not SRAT")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> I am not sure if this is the right place or value for this. It looks
> like there is going to be another stub function added here, which is
> going through -mm:
> 
> https://lkml.kernel.org/r/159643094925.4062302.14979872973043772305.stgit@dwillia2-desk3.amr.corp.intel.com
> 
>  include/acpi/acpi_numa.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
> index fdebcfc6c8df..09eb3bc20ff5 100644
> --- a/include/acpi/acpi_numa.h
> +++ b/include/acpi/acpi_numa.h
> @@ -22,5 +22,10 @@ extern int acpi_numa __initdata;
>  extern void bad_srat(void);
>  extern int srat_disabled(void);
>  
> +#else				/* CONFIG_ACPI_NUMA */
> +static inline int pxm_to_node(int pxm)
> +{
> +	return 0;
> +}
>  #endif				/* CONFIG_ACPI_NUMA */
>  #endif				/* __ACP_NUMA_H */
> 
> base-commit: eb6335b68ce3fc85a93c4c6cd3bb6bc5ac490efe

OK, that works/builds. It doesn't quite apply cleanly to linux-next-20200929
but that's a minor detail and easy to get around.

Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

-- 
~Randy
