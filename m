Return-Path: <SRS0=EjMF=DC=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8FBC4363D
	for <linux-acpi@archiver.kernel.org>; Fri, 25 Sep 2020 16:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C45F23718
	for <linux-acpi@archiver.kernel.org>; Fri, 25 Sep 2020 16:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601050185;
	bh=/+x4ZQ/5LHUPPdTp36ZE01WEdYq2GTgDSmqE4kOGR0U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=asD9RcwjoBHV1ympTne0u+GzrYr5O6EggoTFHmDIX013Jw9nUdl0ZL1CMIZm818di
	 Y0trTdvQfMmalEjRf9HdcfFfZmRkJMk67xD3DF3Wbmr459y+8qnHLWNeACAM3E1QUk
	 BllZNtTj77+Wlh5M8jvbQWHPRlc5t/8X1DpPR9Pk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbgIYQJo (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 25 Sep 2020 12:09:44 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44617 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbgIYQJo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2020 12:09:44 -0400
Received: by mail-oi1-f194.google.com with SMTP id 185so3271988oie.11
        for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2020 09:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KcTsuYT27Tx0H8yz8AbZhge4I4DNuL2cDRIIv3dFVFA=;
        b=hfExropzbnny0tGyKQsQLTp14WqJ7BEtgkgwQGVcXkeM0TSknq9vS3P445PI3TuDSz
         9Ea8/PJbZGKIcG/ZSn1UWvXZ8FBUjrar5czJj5P0rT/WyIbizGfJlz2YFdTuVEHoLrFL
         d/FLF4aVV5xBSl6h1gqxtK7Pu+4Qtnh23Wh0FlArIgUlAYeWDyN3hNBgPd0EqXp0tgho
         eRxaX4os57CX2EXXyRFCHoCX6ERwdeDCNf5INeLqkM+gPMQfgb7UdCxvYDJTPDWKAsRh
         dfx5QTtUWi71n3pPwqMzYLt6fJvx1+m+mM33om8/qX14mtWuWE4UZeKADgQ8r35yJe7R
         8eRQ==
X-Gm-Message-State: AOAM530uZivJmSdcvNjvbdW1KxzTsUHdtl4J2O/f+8Qc110YHr/hzD7S
        MdObPxNyYsgMUM4PXTvL/pPf8rRtSAGaHYaH92o=
X-Google-Smtp-Source: ABdhPJxdOUwn65izSi1MIbTVvcIKO0WTJzyVruW7Tf6HIOvoylfiGzEBtC+smBPolRUSHHJeZiDu9b4NbNYvPrENI/U=
X-Received: by 2002:aca:3655:: with SMTP id d82mr22491oia.75.1601050183791;
 Fri, 25 Sep 2020 09:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <1600420408-62807-1-git-send-email-guohanjun@huawei.com>
In-Reply-To: <1600420408-62807-1-git-send-email-guohanjun@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Sep 2020 18:09:32 +0200
Message-ID: <CAJZ5v0jTgt371kz=ghgOzRvpR9+1vX2E6SYH-bz+o6QGqP7ZnA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: configfs: Add the missing config_item_put() to fix
 refcount leak
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 18, 2020 at 11:21 AM Hanjun Guo <guohanjun@huawei.com> wrote:
>
> config_item_put() should be called in the drop_item callback, to
> decrement refcount for the config item.
>
> Fixes: 772bf1e2878ec ("ACPI: configfs: Unload SSDT on configfs entry removal")
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
>  drivers/acpi/acpi_configfs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
> index 88c8af4..cf91f49 100644
> --- a/drivers/acpi/acpi_configfs.c
> +++ b/drivers/acpi/acpi_configfs.c
> @@ -228,6 +228,7 @@ static void acpi_table_drop_item(struct config_group *group,
>
>         ACPI_INFO(("Host-directed Dynamic ACPI Table Unload"));
>         acpi_unload_table(table->index);
> +       config_item_put(cfg);
>  }
>
>  static struct configfs_group_operations acpi_table_group_ops = {
> --

Applied as 5.10 material with a minor edit in the subject, thanks!
