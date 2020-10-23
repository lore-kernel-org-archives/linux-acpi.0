Return-Path: <SRS0=VabV=D6=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED6FC4363A
	for <linux-acpi@archiver.kernel.org>; Fri, 23 Oct 2020 12:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F2D524182
	for <linux-acpi@archiver.kernel.org>; Fri, 23 Oct 2020 12:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463843AbgJWMeS (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 23 Oct 2020 08:34:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:35893 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S463842AbgJWMeS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Oct 2020 08:34:18 -0400
IronPort-SDR: Gfx6C6CHcXORjkVP2AEjqb5z06hzZLdL15Wh5ZcshN/EZYeJloRBcxd32S+ngQj77pyZxrALm5
 rxUP7t6EK75Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="229302035"
X-IronPort-AV: E=Sophos;i="5.77,408,1596524400"; 
   d="scan'208";a="229302035"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2020 05:34:15 -0700
IronPort-SDR: /JhG9GG4mzmBtFC5AWkpnGIbrUXNrnzLDBmwLTyoOXav3oJW1sfl3FuDSNiFqiyN2mJ7mF4ZEU
 FtXN8wThjtDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,408,1596524400"; 
   d="scan'208";a="423415563"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 23 Oct 2020 05:34:12 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 23 Oct 2020 15:34:12 +0300
Date:   Fri, 23 Oct 2020 15:34:12 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v1 1/2] device property: Keep secondary firmware node
 secondary by type
Message-ID: <20201023123412.GA614478@kuha.fi.intel.com>
References: <20201022184100.71659-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022184100.71659-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 22, 2020 at 09:40:59PM +0300, Andy Shevchenko wrote:
> Behind primary and secondary we understand the type of the nodes
> which might define their ordering. However, if primary node gone,
> we can't maintain the ordering by definition of the linked list.
> Thus, by ordering secondary node becomes first in the list.
> But in this case the meaning of it is still secondary (or auxiliary).
> The type of the node is maintained by the secondary pointer in it:
> 
> 	secondary pointer		Meaning
> 	NULL or valid			primary node
> 	ERR_PTR(-ENODEV)		secondary node
> 
> So, if by some reason we do the following sequence of calls
> 
> 	set_primary_fwnode(dev, NULL);
> 	set_primary_fwnode(dev, primary);
> 
> we should preserve secondary node.
> 
> This concept is supported by the description of set_primary_fwnode()
> along with implementation of set_secondary_fwnode(). Hence, fix
> the commit c15e1bdda436 to follow this as well.
> 
> Fixes: c15e1bdda436 ("device property: Fix the secondary firmware node handling in set_primary_fwnode()")
> Cc: Ferry Toth <fntoth@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/base/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index c852f16c111b..41feab679fa1 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4278,7 +4278,7 @@ void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
>  	} else {
>  		if (fwnode_is_primary(fn)) {
>  			dev->fwnode = fn->secondary;
> -			fn->secondary = NULL;
> +			fn->secondary = ERR_PTR(-ENODEV);
>  		} else {
>  			dev->fwnode = NULL;
>  		}
> -- 
> 2.28.0

-- 
heikki
