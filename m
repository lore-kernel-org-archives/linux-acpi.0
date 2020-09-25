Return-Path: <SRS0=EjMF=DC=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6681C4363D
	for <linux-acpi@archiver.kernel.org>; Fri, 25 Sep 2020 10:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 969CC221EB
	for <linux-acpi@archiver.kernel.org>; Fri, 25 Sep 2020 10:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601031081;
	bh=WqKIKp1fZGykreOugPIXzFj0k+sBgqGevsSfIAszxN4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=a81KGmCufI8lM8c5u07/wnoOt9TstHIwoT19PREUqcAljs2jmmmwAwYZyORHS3YKr
	 PFAtv0dWgx703RQkqxMQVy8a0OwHqMvZVkAUnGlEk9iLWQYA/Z7ZmYKN8yCfhqQz0k
	 qRJ4s8pQUzj/HSnC6QauQhM0F6R+p6c4F85WM4b0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbgIYKvU (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 25 Sep 2020 06:51:20 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:42131 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgIYKvU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2020 06:51:20 -0400
Received: by mail-oo1-f65.google.com with SMTP id g26so629678ooa.9
        for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2020 03:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=adACVDPHRu/Yg38C0a5zyi7dpcpUGCaMsMqCMseDBuU=;
        b=sHtCLLJ6LriQlLYNdPveaoxsV05MQiSwUHNqV1eQJX7+Hpei3YFY1Lntlk2E1gnztO
         THKzgx9QtFoBMxRaA1LSsjILjRASEEmPmBtnqDlbJa9zOYMBu1+R//rs+uINRRPAFizr
         G/v4bZ8EWlQ/Y2OrK+FE8otiYIX0bD0ZlYQKazCTHgF5jRarV3UevsOHMip56M69gEY/
         93yMdyTkFwS1L89/QYrB+q73LpA4mUjFaFyxiW9oHXj+7kb1WRXYxS7dG4oPRnACqYb1
         UpxS/MoQo7thbFbOab+PnXzJPU7tuTu+dw/5AN1dr1v+C14vXDO/k3Ltkndsu4juQmrm
         L8Wg==
X-Gm-Message-State: AOAM530fuaMLQvBouJ4fTLZlTxRQrlSw8M7nvmd5axyb2akrdPhfTXP2
        H5fyPfGVEpqzPq0JkKaLh41fDG4tIzZZn5KI0n4=
X-Google-Smtp-Source: ABdhPJw9jGI5MYE1z0V59xGpD0ocJo+6BSyso6T03h1u8cag9xlaHc+oKfzwz3U0V3mPgoBMox0Ojz7hEHYuLJx9E0A=
X-Received: by 2002:a4a:e946:: with SMTP id v6mr380823ood.38.1601031080113;
 Fri, 25 Sep 2020 03:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <1599483453-26635-1-git-send-email-guohanjun@huawei.com>
In-Reply-To: <1599483453-26635-1-git-send-email-guohanjun@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Sep 2020 12:51:09 +0200
Message-ID: <CAJZ5v0iivuJYz3S-eGbRJM9EAJLSjn24XvjM12UY-N4QDgV7tA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Cleanups for ACPI APD driver
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>, Ken Xue <Ken.Xue@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 7, 2020 at 7:46 PM Hanjun Guo <guohanjun@huawei.com> wrote:
>
> ACPI APD driver has some unused code and some mis-behaved
> kernel doc, make a cleanup for this driver.
>
> Tested on Hisilicon ARM64, and compile tested on Intel x86.
>
> v1->v2:
>  - Fix the compile warning reported by kernel test robot.
>
> Hanjun Guo (5):
>   ACPI / APD: Add kernel doc for the properties in struct
>     apd_device_desc
>   ACPI / APD: Remove the flags in struct apd_device_desc
>   ACPI / APD: Remove ACPI_MODULE_NAME()
>   ACPI / APD: Remove the unneeded APD_ADDR(desc) macro define
>   ACPI / APD: Head file including cleanups

All applied as 5.10 material with edited subjects and changelogs, thanks!
