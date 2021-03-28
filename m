Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89202C433E4
	for <linux-acpi@archiver.kernel.org>; Sun, 28 Mar 2021 08:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B3BA61974
	for <linux-acpi@archiver.kernel.org>; Sun, 28 Mar 2021 08:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhC1Iog (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Sun, 28 Mar 2021 04:44:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231195AbhC1Iob (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 28 Mar 2021 04:44:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9EC8D61981;
        Sun, 28 Mar 2021 08:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616921071;
        bh=9iA0Fqaobm4hPttfxCPtNbvNPPihLXVA80e3fWrhemo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qAUh4mlxE/hfHTJzyS3Mo84LwxIt4IX5SlRsylYWdlJyeTd49ULvoFNO8oYZNaFCS
         Sxko+Ik6bfbSCLajL0Ifp/9bdcLNp0z24FIhDApdAoZKshqDQHZHHyOdvQcVFvd0oh
         na4YS+tbwu4wy7gNNKvwvUA1TWDCKGmq9ycCbDZg=
Date:   Sun, 28 Mar 2021 10:44:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Daniel Scally <djrscally@gmail.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 6/8] software node: Simplify swnode_register() a bit
Message-ID: <YGBB7D98tNxYsTXo@kroah.com>
References: <20210327222012.54103-1-andriy.shevchenko@linux.intel.com>
 <20210327222012.54103-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210327222012.54103-6-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Mar 28, 2021 at 12:20:10AM +0200, Andy Shevchenko wrote:
> By introducing two temporary variables simplify swnode_register() a bit.
> No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/swnode.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index ae53c48f84b1..1e81aaf5f6a1 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -894,6 +894,8 @@ static struct fwnode_handle *
>  swnode_register(const struct software_node *node, struct swnode *parent,
>  		unsigned int allocated)
>  {
> +	struct ida *ids = parent ? &parent->child_ids : &swnode_root_ids;
> +	struct kobject *kobj_parent = parent ? &parent->kobj : NULL;

?: operations are horrid.  Please spell this out in real if statements
so that we can properly understand and maintain them for the next 20+
years.

thanks,

greg k-h
