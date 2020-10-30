Return-Path: <SRS0=fqph=EF=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7590EC4363A
	for <linux-acpi@archiver.kernel.org>; Fri, 30 Oct 2020 14:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 190D6206D4
	for <linux-acpi@archiver.kernel.org>; Fri, 30 Oct 2020 14:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604068436;
	bh=xZ9yHsuB2hPXuy3JqC/OE4gG5VHhflemNQJjmVCIeog=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=05wge475flLJN2HzswcX6YFe2omRxZhPzoWqstJPqt6DjpLWwWtCg3vrTpP/rVxib
	 YwLbJhEd0s5m7VZK62Godc35vRPvzJ/y6me3LnvIR3v6SLa/Ml20HtLb1bLckKU705
	 I+RcSrH6rzYZnfnTDnGV9qRnkwOTu8qXn5tUe47k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgJ3Odu (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 30 Oct 2020 10:33:50 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44320 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgJ3Odu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Oct 2020 10:33:50 -0400
Received: by mail-oi1-f196.google.com with SMTP id k27so6810445oij.11;
        Fri, 30 Oct 2020 07:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7uDnmH/1wuwyzpYaFsPZUp73EW9NEF1HmJXwYciKPjU=;
        b=i1cqH6JZn+iFmtl8lmxDn/teyQwqlESAKOQYnnYGVjEEVdI7HvUJKRPofbSQjShlN8
         3XBF+qgafdUiNteawUvQxZdhjw8FEU+0MMWALaQLZp2CLXMeqi3P/sNWWY7MmIJsWKxw
         7Yd0LiRcuWgr78+aATrGfYGI3a4Fq5GHDCyZGuTwSAQqxivTH90ZeoOiecOh1plD2AAn
         JWMeFPlzX5Mi5kuwFC3j6LMnW5y9kR7iIYmu6espu1k34KieKigNyHHbJ3KqpKp42Lbc
         WWaRjUWEjpjCsePfw5ASbDp79bJOwgcxbEwjFIpMiE40XliAv4+7CimYi1UdYbnQZ5uZ
         Ge/g==
X-Gm-Message-State: AOAM532wvMzrmue83sYJg7LI77ptOEsYsg9dmJshDwcyClraMxKTpvEm
        TxEel1qCnEfv2LdEgVkikDZGkzSToRjUvT4ivVQ=
X-Google-Smtp-Source: ABdhPJwoigk8hKZ9PUi2XNypHmQ2bImzkHi3fJBeQ7mfChhlYaxX/LbtQsfYuKpRTsGfxrIrOtNC9ztZDCv9sX0Z5hE=
X-Received: by 2002:aca:30d7:: with SMTP id w206mr1833906oiw.69.1604068428127;
 Fri, 30 Oct 2020 07:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1604042072.git.mchehab+huawei@kernel.org> <f56daf94b80f1051438e8c787ba04552adb66e67.1604042072.git.mchehab+huawei@kernel.org>
In-Reply-To: <f56daf94b80f1051438e8c787ba04552adb66e67.1604042072.git.mchehab+huawei@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Oct 2020 15:33:36 +0100
Message-ID: <CAJZ5v0jM7Q-kozwSp9-EoZv8BUqbys2SmFoCizOJOSHbE-Bfeg@mail.gmail.com>
Subject: Re: [PATCH v2 27/39] docs: ABI: convert testing/configfs-acpi to ReST
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 30, 2020 at 8:42 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> There are some problems with this file when a ReST content
> is produced. Fix it.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and I assume this to go in via the documentation tree.

> ---
>  Documentation/ABI/testing/configfs-acpi | 34 ++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/ABI/testing/configfs-acpi b/Documentation/ABI/testing/configfs-acpi
> index 4ab4e99aa863..c09b640c3cb1 100644
> --- a/Documentation/ABI/testing/configfs-acpi
> +++ b/Documentation/ABI/testing/configfs-acpi
> @@ -14,7 +14,8 @@ Description:
>                 This group contains the configuration for user defined ACPI
>                 tables. The attributes of a user define table are:
>
> -               aml             - a binary attribute that the user can use to
> +               aml
> +                             - a binary attribute that the user can use to
>                                 fill in the ACPI aml definitions. Once the aml
>                                 data is written to this file and the file is
>                                 closed the table will be loaded and ACPI devices
> @@ -26,11 +27,26 @@ Description:
>                 The rest of the attributes are read-only and are valid only
>                 after the table has been loaded by filling the aml entry:
>
> -               signature       - ASCII table signature
> -               length          - length of table in bytes, including the header
> -               revision        - ACPI Specification minor version number
> -               oem_id          - ASCII OEM identification
> -               oem_table_id    - ASCII OEM table identification
> -               oem_revision    - OEM revision number
> -               asl_compiler_id - ASCII ASL compiler vendor ID
> -               asl_compiler_revision - ASL compiler version
> +               signature
> +                               - ASCII table signature
> +
> +               length
> +                               - length of table in bytes, including the header
> +
> +               revision
> +                               - ACPI Specification minor version number
> +
> +               oem_id
> +                               - ASCII OEM identification
> +
> +               oem_table_id
> +                               - ASCII OEM table identification
> +
> +               oem_revision
> +                               - OEM revision number
> +
> +               asl_compiler_id
> +                               - ASCII ASL compiler vendor ID
> +
> +               asl_compiler_revision
> +                               - ASL compiler version
> --
> 2.26.2
>
